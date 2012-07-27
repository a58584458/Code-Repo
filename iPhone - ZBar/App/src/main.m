//------------------------------------------------------------------------
//  Copyright 2009-2011 (c) Jeff Brown <spadix@users.sourceforge.net>
//
//  This file is part of the ZBar iPhone App.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  http://zbar.sourceforge.net/iphone
//------------------------------------------------------------------------

#import "AdController.h"
#import "FolderListController.h"
#import "BarcodeListController.h"
#import "BarcodeDetailController.h"
#import "ReaderController.h"
#import "Folder.h"
#import "Barcode.h"
#import "Action.h"
#import "Classification.h"
#import "PersistentState.h"
#import "util.h"
#import "Settings.h"

@interface AppDelegate
    : NSObject
    < UIApplicationDelegate,
      UINavigationControllerDelegate,
      UIImagePickerControllerDelegate,
      ZBarReaderDelegate,
      PersistentState >
{
    UIWindow *window;
    UINavigationController *nav;
    AdController *ad;
    FolderListController *list;
    NSManagedObjectContext *context;

    Folder *currentFolder;
    ReaderController *reader;
    AVAudioPlayer *beep;
}

- (void) save;

@end


@implementation AppDelegate

- (BOOL) migrateToSQLiteStore: (NSString*) newPath
              fromBinaryStore: (NSString*) oldPath
       withManagedObjectModel: (NSManagedObjectModel*) model
{
    NSLog(@"migrating binary store: %@", oldPath);

    // find model version for old store
    NSURL *oldURL = [NSURL fileURLWithPath: oldPath];
    NSError *error = nil;
    NSDictionary *meta =
        [NSPersistentStoreCoordinator
            metadataForPersistentStoreOfType: NSBinaryStoreType
            URL: oldURL
            error: &error];
    model = [NSManagedObjectModel
                mergedModelFromBundles: nil
                forStoreMetadata: meta];
    if(!model) {
        [error logWithMessage: @"loading old model"];
        return(NO);
    }
    // reset entity classes
    for(NSEntityDescription *entity in model.entities)
        [entity setManagedObjectClassName: @"NSManagedObject"];

    NSPersistentStoreCoordinator *stores =
        [[NSPersistentStoreCoordinator alloc]
            initWithManagedObjectModel: model];

    // open old store
    error = nil;
    NSPersistentStore *oldStore =
        [stores addPersistentStoreWithType: NSBinaryStoreType
                configuration: nil
                URL: oldURL
                options: nil
                error: &error];
    if(!oldStore) {
        [error logWithMessage: @"opening old binary storage"];
        [stores release];
        return(NO);
    }

    // migrate to new store
    error = nil;
    NSPersistentStore *newStore =
        [stores migratePersistentStore: oldStore
                toURL: [NSURL fileURLWithPath: newPath]
                options: nil
                withType: NSSQLiteStoreType
                error: &error];
    if(!newStore) {
        [error logWithMessage: @"migrating to SQLite storage"];
        [stores release];
        return(NO);
    }
    [stores release];
    NSLog(@"successfully migrated to SQLite store: %@", newPath);

    error = nil;
    NSFileManager *filer = [NSFileManager defaultManager];
    if(![filer removeItemAtURL: oldURL
               error: &error])
        NSLog(@"WARNING failed to remove old binary store");
    return(YES);
}

- (void) initContext
{
    NSArray *docPaths =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask, YES);
    if(!docPaths.count) {
        NSLog(@"ERROR: no access to application directory");
        return;
    }

    NSURL *modelURL = [[NSBundle mainBundle]
                          URLForResource: @"zbarapp"
                          withExtension: @"momd"];
    NSManagedObjectModel *model =
        [[NSManagedObjectModel alloc]
            initWithContentsOfURL: modelURL];
    NSPersistentStoreCoordinator *stores =
        [[NSPersistentStoreCoordinator alloc]
            initWithManagedObjectModel: model];

    NSString *docPath = [docPaths objectAtIndex: 0];
    NSString *sqlitePath =
        [docPath stringByAppendingPathComponent: @"Barcodes.sqlite"];
    NSFileManager *filer = [NSFileManager defaultManager];
    NSInteger fromVersion = -1;
    if([filer fileExistsAtPath: sqlitePath])
        fromVersion = 1;
    if(fromVersion < 1) {
        NSString *binPath =
            [docPath stringByAppendingPathComponent: @"Barcodes.data"];
        if([filer fileExistsAtPath: binPath] &&
           [self migrateToSQLiteStore: sqlitePath
                     fromBinaryStore: binPath
                     withManagedObjectModel: model])
            fromVersion = 0;
    }
    [model release];

    NSDictionary *options =
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool: YES],
            NSMigratePersistentStoresAutomaticallyOption,
            nil];
    NSError *error = nil;
    if(![stores addPersistentStoreWithType: NSSQLiteStoreType
                configuration: nil
                URL: [NSURL fileURLWithPath: sqlitePath]
                options: options
                error: &error])
    {
        [error logWithMessage: @"opening storage"];
        if(![stores addPersistentStoreWithType: NSInMemoryStoreType
                    configuration: nil
                    URL: nil
                    options: nil
                    error: &error])
            [error logWithMessage: @"opening fallback in-memory storage"];
    }

    context = [NSManagedObjectContext new];
    [context setUndoManager: nil];
    [context setPersistentStoreCoordinator: stores];
    [stores release];

    if(fromVersion < 1) {
        DBLog(@"upgraded from version %d", fromVersion);

        Folder *folder;
        if(fromVersion < 0)
            folder = [Folder addDefaultFolderInContext: context];
        else
            folder = [Folder defaultFolderInContext: context];

        [folder addInfoBarcodes];

        NSString *path =
            [[NSBundle mainBundle]
                pathForResource: @"actions"
                ofType: @"plist"];
        NSArray *newActions =
            [[NSDictionary dictionaryWithContentsOfFile: path]
                objectForKey: @"actions"];
        [Action mergeActions: newActions];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults performSelector: @selector(synchronize)
                  withObject: nil
                  afterDelay: 0.1];
        [UIApplication saveAfterDelay: .1];
    }
}

- (void) initWindow
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    window = [[UIWindow alloc]
                 initWithFrame: frame];
    window.backgroundColor = [UIColor whiteColor];
    window.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                               UIViewAutoresizingFlexibleHeight);

    list = [FolderListController new];
    list.context = context;

    nav = [[UINavigationController alloc]
               initWithRootViewController: list];
    nav.toolbarHidden = NO;
    nav.delegate = self;

#ifdef DISABLE_IAD
    window.rootViewController = nav;
#else
    ad = [[AdController alloc]
             initWithContentController: nav];
    window.rootViewController = ad;
#endif

    UIImageView *launch =
        [[[UIImageView alloc]
             initWithFrame: CGRectMake(0, 0, 320, 480)]
            autorelease];
    launch.image = [UIImage imageNamed: @"Default"];
    [window addSubview: launch];

    [UIView beginAnimations: @"LaunchAnimation"
            context: launch];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:
                @selector(launchAnimationDidStop:finished:context:)];
    [UIView setAnimationDuration: 0.25];
    launch.alpha = 0;
    [UIView commitAnimations];

    [window makeKeyAndVisible];
}

- (void) initReader: (NSInteger) src
{
    if(reader)
        [reader release];

    if(src == UIImagePickerControllerSourceTypeCamera) {
        reader = [ReaderController new];
        reader.readerDelegate = self;
    }
    else {
        ZBarReaderController *imageReader = [ZBarReaderController new];
        imageReader.delegate = self;
        reader = (id)imageReader;
    }

#ifndef DISABLE_IAD
    // keep the status bar.  ideally we would get rid of it, but it's difficult
    // to track its state and nearly impossible to make the nav controller
    // behave correctly
    reader.wantsFullScreenLayout = NO;
#endif
}

- (void) initAudio
{
    if(beep)
        return;
    NSError *error = nil;
    beep = [[AVAudioPlayer alloc]
               initWithContentsOfURL:
                   [[NSBundle mainBundle]
                       URLForResource: @"scan"
                       withExtension: @"wav"]
               error: &error];
    if(!beep)
        [error logWithMessage: @"loading sound"];
    else {
        beep.volume = .5f;
        [beep prepareToPlay];
    }
}

- (void) playBeep
{
    if(!beep)
        [self initAudio];
    [beep play];
}

- (void) launchAnimationDidStop: (NSString*) id
                       finished: (NSNumber*) finished
                        context: (void*) ctx
{
    UIImageView *launch = ctx;
    [launch removeFromSuperview];
}

- (BOOL)            application: (UIApplication*) app
  didFinishLaunchingWithOptions: (NSDictionary*) options
{
    [self initContext];
    [self initWindow];

    id state = [[NSUserDefaults standardUserDefaults]
                   objectForKey: @"State"];
    [self restoreState: state];

    (void)[Settings globalSettings];
    return(YES);
}

- (void) cleanup: (BOOL) force
{
    if(force || !reader.parentViewController) {
        [reader release];
        reader = nil;
        [beep release];
        beep = nil;
    }
}

- (void) applicationDidEnterBackground: (UIApplication*) app
{
    [self save];
    [Action saveActions];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: [self saveState]
              forKey: @"State"];

    // force changes to disk in case app is terminated
    [defaults synchronize];

    // minimize memory footprint to avoid being ousted
    [self cleanup: NO];
}

- (void) applicationDidReceiveMemoryWarning:  (UIApplication*) app
{
    [self cleanup: NO];
}

- (void) applicationWillTerminate: (UIApplication*) app
{
    [self cleanup: YES];
}

- (void) dealloc
{
    [self cleanup: YES];
    [list release];
    list = nil;
    [nav release];
    nav = nil;
    [ad release];
    ad = nil;
    [window release];
    window = nil;
    [context release];
    context = nil;
    [super dealloc];
}

- (void) scanFromSource: (NSInteger) src
{
    if(!reader || (reader.sourceType != src))
        [self initReader: src];
    if(!beep)
        [self initAudio];

    // setup scaner
    Settings *settings = [Settings globalSettings];
    ZBarImageScanner *scanner = reader.scanner;
    BOOL haveLongLinear = NO;
    for(NSString *str in settings.enabledSymbologies) {
        NSNumber *value = [settings.enabledSymbologies objectForKey: str];
        BOOL enable = value.boolValue;
        zbar_symbol_type_t sym = [str integerValue];

        [scanner setSymbology: sym
                 config: ZBAR_CFG_ENABLE
                 to: enable];

        if(sym == ZBAR_EAN13) {
            // show EAN variants as such
            [scanner setSymbology: ZBAR_UPCA
                     config: ZBAR_CFG_ENABLE
                     to: enable];
            [scanner setSymbology: ZBAR_UPCE
                     config: ZBAR_CFG_ENABLE
                     to: enable];
            [scanner setSymbology: ZBAR_ISBN13
                     config: ZBAR_CFG_ENABLE
                     to: enable];
        }

        haveLongLinear |= enable && sym > ZBAR_COMPOSITE && sym != ZBAR_QRCODE;
    }

    if([reader isKindOfClass: [ReaderController class]])
        reader.optimizeLandscape = haveLongLinear;

    if([[reader class] isSourceTypeAvailable: src]) {
        reader.sourceType = src;
        [window.rootViewController
            adPresentModalViewController: reader
            animated: YES];
    }
    else {
        NSString *title, *message;
        if(src == UIImagePickerControllerSourceTypeCamera) {
            title = @"Camera Unavailable";
            message = @"Unable to access the camera";
        }
        else {
            title = @"Image Library Unavailable";
            message = @"Unable to access the image library";
        }
        UIAlertView *alert =
            [[UIAlertView alloc]
                initWithTitle: title
                message: message
                delegate: nil
                cancelButtonTitle: @"Cancel"
                otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void) scanFromCamera
{
    [self scanFromSource: UIImagePickerControllerSourceTypeCamera];
}

- (void) scanFromPhoto
{
    [self scanFromSource: UIImagePickerControllerSourceTypePhotoLibrary];
}


// ZBarReaderDelegate

- (void)  imagePickerController: (UIImagePickerController*) picker
  didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    UIImage *image =
        [info objectForKey: UIImagePickerControllerOriginalImage];
    id <NSFastEnumeration> results =
        [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *sym = nil;
    for(sym in results)
        break;
    assert(sym);
    assert(image);
    if(!sym || !image)
        return;

    Barcode *barcode =
        [NSEntityDescription insertNewObjectForEntityForName: @"Barcode"
                             inManagedObjectContext: context];
    assert(barcode);
    if(!barcode)
        return;

    assert(currentFolder);
    barcode.folder = currentFolder;
    barcode.date = [NSDate date];
    barcode.image = image;

    barcode.symbol = sym;
    barcode.type = [NSNumber numberWithInteger: sym.type];
    barcode.data = sym.data;

    barcode.name = nil;
    barcode.thumb = nil;

    NSArray *stack = nav.viewControllers;
    BarcodeListController *_list = nil;
    if(stack.count > 1) {
        _list = [stack objectAtIndex: 1];
        if(![_list isKindOfClass: [BarcodeListController class]] ||
           _list.folder != currentFolder)
            _list = nil;
    }

    if(_list)
        [nav popToViewController: _list
             animated: NO];
    else {
        [nav popToRootViewControllerAnimated: NO];
        _list = [[[BarcodeListController alloc]
                     initWithFolder: currentFolder]
                    autorelease];
        [nav pushViewController: _list
             animated: NO];
    }

    UIViewController *detail =
        [[BarcodeDetailController alloc]
            initWithBarcode: barcode];
    [nav pushViewController: detail
         animated: NO];
    [detail release];

    Settings *settings = [Settings globalSettings];
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera &&
       settings.enableBeep)
            [self performSelector: @selector(playBeep)
                  withObject: nil
                  afterDelay: 0.001];

    if(settings.autoLink)
        [self performSelector: @selector(autoLink:)
              withObject: barcode
              afterDelay: 0.25];

    [window.rootViewController
        adDismissModalViewController: picker
        animated: YES];

    [self performSelector: @selector(genThumb:)
          withObject: barcode
          afterDelay: .5];
}

- (void) autoLink: (Barcode*) barcode
{
    NSArray *actions = [barcode applyActions];
    if(actions && actions.count) {
        Action *action = [actions objectAtIndex: 0];
        if(action.canAutoLink)
            [action activateWithNavigationController: nav
                    animated: YES];
    }
}

- (void) genThumb: (Barcode*) barcode
{
    UIImage *image = barcode.image;
    assert(image);
    if(!image)
        return;

    ZBarSymbol *sym = barcode.symbol;
    // convert symbol orientation to rotation quadrant
    int sorient;
    switch(sym.orientation)
    {
    case ZBAR_ORIENT_LEFT: sorient = 1; break;
    case ZBAR_ORIENT_DOWN: sorient = 2; break;
    case ZBAR_ORIENT_RIGHT: sorient = -1; break;
    case ZBAR_ORIENT_UP:
    default:
        sorient = 0;
        break;
    }

    CGRect bounds = sym.bounds;
    CGSize isize = image.size;
    // transform symbol location/orientation to image coordinates
    UIImageOrientation iorient = image.imageOrientation;
    switch(iorient)
    {
    case UIImageOrientationDown:
        sorient -= 2;
        bounds.origin =
            CGPointMake(isize.width - bounds.size.width - bounds.origin.x,
                        isize.height - bounds.size.height - bounds.origin.y);
        break;
    case UIImageOrientationLeft:
        sorient += 1;
        bounds.origin =
            CGPointMake(bounds.origin.y,
                        isize.height - bounds.size.width - bounds.origin.x);
        bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);
        break;
    case UIImageOrientationRight:
        sorient -= 1;
        bounds.origin =
            CGPointMake(isize.width - bounds.size.height - bounds.origin.y,
                        bounds.origin.x);
        bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);
        break;
    }

    // select crop area based on symbol location
    CGRect crop;
    crop.origin = CGPointMake(0, 0);
    crop.size = isize;
    if(bounds.size.width > isize.width * .0625) {
        CGFloat b = bounds.size.width * .125;
        crop.origin.x = bounds.origin.x - b;
        crop.size.width = bounds.size.width + 2 * b;
    }
    if(bounds.size.height > isize.height * .0625) {
        CGFloat b = bounds.size.height * .125;
        crop.origin.y = bounds.origin.y - b;
        crop.size.height = bounds.size.height + 2 * b;
    }
    crop = CGRectIntersection(crop,
                              CGRectMake(0, 0, isize.width, isize.height));

    CGRect thumb = CGRectMake(0, 0, 64, 64);
    CGFloat scale = thumb.size.width / crop.size.width;
    CGFloat scaley = thumb.size.height / crop.size.height;
    if(scale > scaley) {
        scale = scaley;
        CGFloat minscale = thumb.size.width / image.size.width;
        if(scale < minscale) {
            scale = minscale;
            crop.origin.x = 0;
            crop.size.width = image.size.width;
        }
    }
    else {
        CGFloat minscale = thumb.size.height / image.size.height;
        if(scale < minscale) {
            scale = minscale;
            crop.origin.y = 0;
            crop.size.height = image.size.height;
        }
    }

    DBLog(@"genThumb: img=%@(%d) sym=%@(%d) scale=%g pre-crop=%@",
          NSStringFromCGSize(isize), iorient,
          NSStringFromCGRect(bounds), sorient,
          scale, NSStringFromCGRect(crop));

    crop.origin.x *= -scale;
    crop.origin.y *= -scale;
    crop.origin.x += (thumb.size.width - crop.size.width * scale) * 0.5f;
    crop.origin.y += (thumb.size.height - crop.size.height * scale) * 0.5f;

    crop.size.width = isize.width * scale;
    crop.size.height = isize.height * scale;

    assert(thumb.size.width <= crop.size.width);
    assert(thumb.size.height <= crop.size.height);

    if(crop.origin.x > 0)
        crop.origin.x = 0;
    else {
        CGFloat x = thumb.size.width - crop.size.width;
        if(crop.origin.x < x)
            crop.origin.x = x;
    }
    if(crop.origin.y > 0)
        crop.origin.y = 0;
    else {
        CGFloat y = thumb.size.height - crop.size.height;
        if(crop.origin.y < y)
            crop.origin.y = y;
    }

    DBLog(@"genThumb: thumb=%@ crop=%@ (%@)",
          NSStringFromCGSize(thumb.size), NSStringFromCGRect(crop),
          NSStringFromCGRect(
              CGRectMake(crop.origin.x / scale, crop.origin.y / scale,
                         crop.size.width / scale, crop.size.height / scale)));

    UIGraphicsBeginImageContextWithOptions(thumb.size, YES, 0.0);
#ifndef NDEBUG
    [[UIColor redColor]  // highlight bug
        setFill];
#else
    [[UIColor grayColor]  // hide bug :)
        setFill];
#endif
    UIRectFill(thumb);

    // rotate symbol to upright orientation
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGSize trans = thumb.size;
    trans.width *= 0.5;
    trans.height *= 0.5;
    CGContextTranslateCTM(ctx, trans.width, trans.height);
    CGContextRotateCTM(ctx, sorient * M_PI_2);
    CGContextTranslateCTM(ctx, -trans.width, -trans.height);

    [image drawInRect: crop];
    barcode.thumb = UIGraphicsGetImageFromCurrentImageContext();
    barcode.image = nil;
    UIGraphicsEndImageContext();

    [UIApplication saveAfterDelay: .5];
}

- (void) save
{
    @try {
        NSError *error;
        if(![context save: &error])
            [error logWithMessage: @"saving data"];
    }
    @catch(...) { }
}

// PersistentState

- (id) saveState
{
    NSArray *stack = nav.viewControllers;
    NSMutableArray *state =
        [NSMutableArray arrayWithCapacity: stack.count];

    for(UIViewController<PersistentState> *view in stack) {
        if(![view respondsToSelector: @selector(saveState)])
            // stop at the first view that cannot save
            break;
        [state addObject: [view saveState]];
    }
    DBLog(@"saveState=%@", state);
    return(state);
}

- (BOOL) restoreState: (id) _state
{
    NSArray *state = _state;
    DBLog(@"restoreState=%@", state);
    if(state && ![state isKindOfClass: [NSArray class]])
        state = nil;

    NSMutableArray *stack =
        [[nav.viewControllers mutableCopy]
            autorelease];
    assert(stack.count);
    assert([stack objectAtIndex: 0] == list);

    int i = 0;
    for(NSDictionary *next in state) {
        if(!next || ![next isKindOfClass: [NSDictionary class]])
            break;

        UIViewController *view = nil;
        if(i < stack.count)
            view = [stack objectAtIndex: i];

        NSString *clsname = [next objectForKey: @"class"];
        if(!clsname)
            break;

        Class cls = NSClassFromString(clsname);
        if(!cls ||
           ![cls isSubclassOfClass: [UIViewController class]] ||
           (view && ![view isMemberOfClass: cls]))
            break;

        if(!view)
            view = [[cls new] autorelease];
        if(!view)
            break;

        if([view respondsToSelector: @selector(setContext:)])
            [view performSelector: @selector(setContext:)
                  withObject: context];

        if(![view respondsToSelector: @selector(restoreState:)] ||
           ![view performSelector: @selector(restoreState:)
                  withObject: next])
            break;

        if(i >= stack.count)
            [stack addObject: view];
        i++;
    }

    if(!state || i < state.count || i < stack.count)
        // start with default folder
        stack = [NSArray arrayWithObjects:
                    [stack objectAtIndex: 0],
                    [[[BarcodeListController alloc]
                         initWithFolder:
                             [Folder defaultFolderInContext: context]]
                     autorelease],
                    nil];

    // delay and animate transition from start image
    DBLog(@"restoring view stack: %@", stack);
    [self performSelector: @selector(animateRestore:)
          withObject: stack
          afterDelay: 0.25];
    return(YES);
}

- (void) animateRestore: (NSArray*) stack
{
    // this replaces setViewControllers:animated:
    // which is evil and broken
    assert(nav.viewControllers.count);
    assert([nav.viewControllers objectAtIndex: 0] == list);
    assert([stack objectAtIndex: 0] == list);

    [nav popToRootViewControllerAnimated: NO];
    UIViewController *last = [stack lastObject];
    for(UIViewController *view in stack) {
        if(view == list)
            continue;
        [nav pushViewController: view
             animated: (view == last)];
    }
}


// UINavigationControllerDelegate

- (void) navigationController: (UINavigationController*) _nav
       willShowViewController: (UIViewController*) controller
                     animated: (BOOL) animated
{
    BOOL haveToolbar = (controller.toolbarItems != nil);
    [_nav setToolbarHidden: !haveToolbar || controller.editing
          animated: animated];

    // track current folder
    NSArray *stack = _nav.viewControllers;
    NSInteger n = stack.count;
    Folder *folder = nil;
    if(n == 1)
        folder = [Folder defaultFolderInContext: context];
    else if(n > 1) {
        BarcodeListController *l = [stack objectAtIndex: 1];
        if([l isKindOfClass: [BarcodeListController class]])
            folder = l.folder;
    }
    else
        assert(0);

    if(folder != currentFolder) {
        [currentFolder release];
        currentFolder = [folder retain];
    }
}

@end


#define VALGRIND "/usr/local/bin/valgrind"

int main (int argc, char *argv[])
{
#if 0
    if(argc < 2 || (argc >= 2 && strcmp(argv[1], "-valgrind")))
        execl(VALGRIND, VALGRIND,
              "--log-file=/tmp/memcheck.log", "--leak-check=full",
              "--suppressions=/tmp/memcheck.suppress",
              //"--track-origins=yes",
              "--gen-suppressions=all",
              argv[0], "-valgrind",
              NULL);
#endif

    NSAutoreleasePool *pool = [NSAutoreleasePool new];
    int rc = UIApplicationMain(argc, argv, nil, @"AppDelegate");
    [pool release];
    return(rc);
}

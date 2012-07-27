//
//  iOSTrainingAppDelegate.h
//  iOSTraining
//
//  Created by Derek Neely on 10/12/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iOSTrainingAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

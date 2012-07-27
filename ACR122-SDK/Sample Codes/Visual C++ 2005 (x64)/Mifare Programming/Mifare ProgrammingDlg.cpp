// Mifare ProgrammingDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Mifare Programming.h"
#include "Mifare ProgrammingDlg.h"
#include "acr122.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//Defines
#define BLACK RGB(0, 0, 0)
#define RED RGB(255, 0, 0)
#define GREEN RGB(0, 0x99, 0)

//Global Variables
int retCode;
HANDLE hReader;
CMifareProgrammingDlg *pThis = NULL;
BYTE SendBuff[255];
BYTE RecvBuff[255];
DWORD SendLen, RecvLen;



//Function Prototypes
void DisplayOut( CString str, COLORREF color );
void ClearBuffers();
int SendAPDU();
int HexCheck( char data1, char data2 );

//Error checking for inputs that needs to be in hex format
int HexCheck( char data1, char data2 )
{

	int retval = 1;
	bool state1, state2;

	if( data1 == '0' ||
		data1 == '1' ||
		data1 == '2' ||
		data1 == '3' ||
		data1 == '4' ||
		data1 == '5' ||
		data1 == '6' ||
		data1 == '7' ||
		data1 == '8' ||
		data1 == '9' ||
		data1 == 'A' ||
		data1 == 'B' ||
		data1 == 'C' ||
		data1 == 'D' ||
		data1 == 'E' ||
		data1 == 'F' ||
		data1 == 'a' ||
		data1 == 'b' ||
		data1 == 'c' ||
		data1 == 'd' ||
		data1 == 'e' ||
		data1 == 'f' )
	{
	
		state1 = true;
	
	}
	else
	{
	
		state1 = false;
	
	}

	if( data2 == '0' ||
		data2 == '1' ||
		data2 == '2' ||
		data2 == '3' ||
		data2 == '4' ||
		data2 == '5' ||
		data2 == '6' ||
		data2 == '7' ||
		data2 == '8' ||
		data2 == '9' ||
		data2 == 'A' ||
		data2 == 'B' ||
		data2 == 'C' ||
		data2 == 'D' ||
		data2 == 'E' ||
		data2 == 'F' ||
		data1 == 'a' ||
		data1 == 'b' ||
		data1 == 'c' ||
		data1 == 'd' ||
		data1 == 'e' ||
		data1 == 'f' ||
		data2 == NULL )
	{
	
		state2 = true;
	
	}
	else
	{
	
		state2 = false;
	
	}

	if( state1 == true && state2 == true )
	{
	
		retval = 0;
	
	}
	else
	{
	
		retval = 1;
	
	}
				
	return retval;
}

void Init()
{
	pThis->btnConnect.EnableWindow( true );
	pThis->btnAuthen.EnableWindow( false );
	pThis->btnRead.EnableWindow( false );
	pThis->btnUpdate.EnableWindow( false );
	pThis->btnStoreVal.EnableWindow( false );
	pThis->btnReadVal.EnableWindow( false );
	pThis->btnInc.EnableWindow( false );
	pThis->btnDec.EnableWindow( false );
	pThis->btnCopy.EnableWindow( false );

	pThis->rbTypeA.EnableWindow( false );
	pThis->rbTypeB.EnableWindow( false );
	pThis->rbTypeA.SetCheck( true );
	pThis->rbTypeB.SetCheck( false );

	pThis->tbBlockNo.EnableWindow( false );
	pThis->tbKey1.EnableWindow( false );
	pThis->tbKey2.EnableWindow( false );
	pThis->tbKey3.EnableWindow( false );
	pThis->tbKey4.EnableWindow( false );
	pThis->tbKey5.EnableWindow( false );
	pThis->tbKey6.EnableWindow( false );
	pThis->tbData.EnableWindow( false );
	pThis->tbBinaryBlockNo.EnableWindow( false );
	pThis->tbValue.EnableWindow( false );
	pThis->tbValueBlockNo.EnableWindow( false );
	pThis->tbSource.EnableWindow( false );
	pThis->tbTarget.EnableWindow( false );

	pThis->tbBlockNo.SetWindowText( "" );
	pThis->tbKey1.SetWindowText( "" );
	pThis->tbKey2.SetWindowText( "" );
	pThis->tbKey3.SetWindowText( "" );
	pThis->tbKey4.SetWindowText( "" );
	pThis->tbKey5.SetWindowText( "" );
	pThis->tbKey6.SetWindowText( "" );
	pThis->tbData.SetWindowText( "" );
	pThis->tbBinaryBlockNo.SetWindowText( "" );
	pThis->tbValue.SetWindowText( "" );
	pThis->tbValueBlockNo.SetWindowText( "" );
	pThis->tbSource.SetWindowText( "" );
	pThis->tbTarget.SetWindowText( "" );

	pThis->tbBlockNo.SetLimitText( 2 );
	pThis->tbKey1.SetLimitText( 2 );
	pThis->tbKey2.SetLimitText( 2 );
	pThis->tbKey3.SetLimitText( 2 );
	pThis->tbKey4.SetLimitText( 2 );
	pThis->tbKey5.SetLimitText( 2 );
	pThis->tbKey6.SetLimitText( 2 );
	pThis->tbBinaryBlockNo.SetLimitText( 2 );
	pThis->tbValue.SetLimitText( 7 );
	pThis->tbValueBlockNo.SetLimitText( 2 );
	pThis->tbSource.SetLimitText( 2 );
	pThis->tbTarget.SetLimitText( 2 );

}

//Sets SendBuff and RecvBuff to zero
void ClearBuffers()
{
	memset( SendBuff, 0x00, 255 );
	memset( RecvBuff, 0x00, 255 );
}

//Displays the message in the rich edit box with the respective color
void DisplayOut( CString str, COLORREF color )
{
	int nOldLines = 0,
		nNewLines = 0,
		nScroll = 0;
	long nInsertPoint = 0;
	CHARFORMAT cf;

	//Save number of lines before insertion of new text
	nOldLines = pThis->mMsg.GetLineCount();

	//Initialize character format structure
	cf.cbSize		= sizeof( CHARFORMAT );
	cf.dwMask		= CFM_COLOR;
	cf.dwEffects	= 0;	// To disable CFE_AUTOCOLOR
	cf.crTextColor	= color;

	//Set insertion point to end of text
	nInsertPoint = pThis->mMsg.GetWindowTextLength();
	pThis->mMsg.SetSel( nInsertPoint, -1 );
	
	//Set the character format
	pThis->mMsg.SetSelectionCharFormat( cf );

	//Insert string at the current caret poisiton
	pThis->mMsg.ReplaceSel( str );

	nNewLines = pThis->mMsg.GetLineCount();
	nScroll	= nNewLines - nOldLines;
	pThis->mMsg.LineScroll( 1 );
}

//Sends APDU through ACR122_DirectTransmit() command
int SendAPDU()
{
	UINT i;
	char tempstr[255];

	sprintf( tempstr, "< " );
	for( i = 0; i < SendLen; i++ )
	{
		sprintf( tempstr, "%s %02X", tempstr, SendBuff[i] );
	}
	sprintf( tempstr, "%s\n", tempstr );
	DisplayOut( tempstr, BLACK );

	retCode = ACR122_DirectTransmit( hReader, SendBuff, SendLen, RecvBuff, &RecvLen );
	if( retCode != 0 )
	{
		return retCode;
	}

	sprintf( tempstr, "> " );
	for( i = 0; i < RecvLen; i++ )
	{
		sprintf( tempstr, "%s %02X", tempstr, RecvBuff[i] );
	}
	sprintf( tempstr, "%s\n", tempstr );
	DisplayOut( tempstr, BLACK );

	return retCode;
}

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMifareProgrammingDlg dialog

CMifareProgrammingDlg::CMifareProgrammingDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CMifareProgrammingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CMifareProgrammingDlg)
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIconBig   = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_hIconSmall = AfxGetApp()->LoadIcon(IDR_SMALLICON);
}

void CMifareProgrammingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CMifareProgrammingDlg)
	DDX_Control(pDX, IDC_BUTTON12, btnQuit);
	DDX_Control(pDX, IDC_BUTTON11, btnReset);
	DDX_Control(pDX, IDC_BUTTON9, btnClear);
	DDX_Control(pDX, IDC_BUTTON10, btnCopy);
	DDX_Control(pDX, IDC_BUTTON8, btnDec);
	DDX_Control(pDX, IDC_BUTTON7, btnInc);
	DDX_Control(pDX, IDC_BUTTON6, btnReadVal);
	DDX_Control(pDX, IDC_BUTTON5, btnStoreVal);
	DDX_Control(pDX, IDC_EDIT13, tbTarget);
	DDX_Control(pDX, IDC_EDIT12, tbSource);
	DDX_Control(pDX, IDC_EDIT11, tbValueBlockNo);
	DDX_Control(pDX, IDC_EDIT10, tbValue);
	DDX_Control(pDX, IDC_BUTTON3, btnUpdate);
	DDX_Control(pDX, IDC_BUTTON2, btnRead);
	DDX_Control(pDX, IDC_EDIT1, tbData);
	DDX_Control(pDX, IDC_EDIT9, tbBinaryBlockNo);
	DDX_Control(pDX, IDC_BUTTON4, btnAuthen);
	DDX_Control(pDX, IDC_EDIT8, tbKey6);
	DDX_Control(pDX, IDC_EDIT7, tbKey5);
	DDX_Control(pDX, IDC_EDIT6, tbKey4);
	DDX_Control(pDX, IDC_EDIT5, tbKey3);
	DDX_Control(pDX, IDC_EDIT4, tbKey2);
	DDX_Control(pDX, IDC_EDIT3, tbKey1);
	DDX_Control(pDX, IDC_EDIT2, tbBlockNo);
	DDX_Control(pDX, IDC_RADIO2, rbTypeB);
	DDX_Control(pDX, IDC_RADIO1, rbTypeA);
	DDX_Control(pDX, IDC_RICHEDIT1, mMsg);
	DDX_Control(pDX, IDC_BUTTON1, btnConnect);
	DDX_Control(pDX, IDC_COMBO1, cbPort);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CMifareProgrammingDlg, CDialog)
	//{{AFX_MSG_MAP(CMifareProgrammingDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, OnConnect)
	ON_BN_CLICKED(IDC_RADIO1, OnTypeA)
	ON_BN_CLICKED(IDC_RADIO2, OnTypeB)
	ON_BN_CLICKED(IDC_BUTTON4, OnAuthen)
	ON_BN_CLICKED(IDC_BUTTON3, OnUpdate)
	ON_BN_CLICKED(IDC_BUTTON2, OnRead)
	ON_BN_CLICKED(IDC_BUTTON5, OnStoreVal)
	ON_BN_CLICKED(IDC_BUTTON6, OnReadVal)
	ON_BN_CLICKED(IDC_BUTTON7, OnInc)
	ON_BN_CLICKED(IDC_BUTTON8, OnDec)
	ON_BN_CLICKED(IDC_BUTTON9, OnRestore)
	ON_BN_CLICKED(IDC_BUTTON10, OnCopy)
	ON_BN_CLICKED(IDC_BUTTON11, OnReset)
	ON_BN_CLICKED(IDC_BUTTON12, OnQuit)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CMifareProgrammingDlg message handlers

BOOL CMifareProgrammingDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	// Set the icon for this dialog.  The framework does this automatically
	//  when the application's main window is not a dialog
	SetIcon(m_hIconBig,	TRUE);		// Set big icon
	SetIcon(m_hIconSmall,	FALSE);		// Set small icon
	
	// TODO: Add extra initialization here
	for( int i = 1; i < 10; i++ )
	{
		CString tempstr;
		tempstr.Format( "COM%d", i );
		cbPort.AddString( tempstr );
	}

	cbPort.SetCurSel( 0 );
	pThis = this;

	try
	{
		DisplayOut( "Program Started\n", GREEN );
	}
	catch( char *str )
	{
		AfxMessageBox( str );	
	}

	Init();

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CMifareProgrammingDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CMifareProgrammingDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIconSmall);
	}
	else
	{
		CDialog::OnPaint();
	}
}

// The system calls this to obtain the cursor to display while the user drags
//  the minimized window.
HCURSOR CMifareProgrammingDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIconSmall;
}

void CMifareProgrammingDlg::OnConnect() 
{
	char tempstr[10], port[10];
	DWORD FWLEN = 255;

	sprintf( port, "" );
	cbPort.GetWindowText( port, 5 );

	retCode = ACR122_OpenA( port, &hReader );
	if( retCode != 0 )
	{
		try
		{
			sprintf( tempstr, "Connection to %s failed\n", port );
			DisplayOut( tempstr, RED );
			return;
		}
		catch( char *str )
		{
			AfxMessageBox( str );	
			return;
		}
	}
	else
	{
		sprintf( tempstr, "Connection to %s success\n", port );
		DisplayOut( tempstr, GREEN );
	}

	sprintf( tempstr, "" );
	retCode = ACR122_GetFirmwareVersion( hReader, 0, tempstr, &FWLEN );
	if( retCode != 0 )
	{
		DisplayOut( "Unable to obtain Firmware version\n", RED );
		return;
	}
	else
	{
		DisplayOut( "Firmware Version: ", BLACK );
		DisplayOut( tempstr, BLACK );
		DisplayOut( "\n", BLACK );
	}

	pThis->btnConnect.EnableWindow( false );
	pThis->btnAuthen.EnableWindow( true );
	pThis->btnRead.EnableWindow( true );
	pThis->btnUpdate.EnableWindow( true );
	pThis->btnStoreVal.EnableWindow( true );
	pThis->btnReadVal.EnableWindow( true );
	pThis->btnInc.EnableWindow( true );
	pThis->btnDec.EnableWindow( true );
	pThis->btnCopy.EnableWindow( true );

	pThis->rbTypeA.EnableWindow( true );
	pThis->rbTypeB.EnableWindow( true );

	pThis->tbBlockNo.EnableWindow( true );
	pThis->tbKey1.EnableWindow( true );
	pThis->tbKey2.EnableWindow( true );
	pThis->tbKey3.EnableWindow( true );
	pThis->tbKey4.EnableWindow( true );
	pThis->tbKey5.EnableWindow( true );
	pThis->tbKey6.EnableWindow( true );
	pThis->tbData.EnableWindow( true );
	pThis->tbBinaryBlockNo.EnableWindow( true );
	pThis->tbValue.EnableWindow( true );
	pThis->tbValueBlockNo.EnableWindow( true );
	pThis->tbSource.EnableWindow( true );
	pThis->tbTarget.EnableWindow( true );
}


void CMifareProgrammingDlg::OnTypeA() 
{
	rbTypeB.SetCheck( false );
}

void CMifareProgrammingDlg::OnTypeB() 
{
	rbTypeA.SetCheck( false );
}

void CMifareProgrammingDlg::OnAuthen() 
{
	char tempstr[255], holder[4];
	BYTE UID[4];
	int tempval;

	tbBlockNo.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbBlockNo.SetFocus();
		return;
	
	}

	tbKey1.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbKey1.SetFocus();
		return;
	
	}

	tbKey2.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbKey2.SetFocus();
		return;
	
	}

	tbKey3.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbKey3.SetFocus();
		return;
	
	}

	tbKey4.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbKey4.SetFocus();
		return;
	
	}

	tbKey5.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbKey5.SetFocus();
		return;
	
	}

	tbKey6.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbKey6.SetFocus();
		return;
	
	}

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x4A;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0x00;

	SendLen = 4;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Authentication failed\n", RED );
		return;
	}
	else
	{
		sprintf( tempstr, "UID: " );
		for( int i = 8; i < RecvBuff[7] + 8; i++ )
		{
			UID[i - 8] = RecvBuff[i];
		}
	}

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;

	if( rbTypeA.GetCheck() )
	{
		SendBuff[3] = 0x60;
	}
	else
	{
		SendBuff[3] = 0x61;
	}

	tbBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[4] = tempval;

	tbKey1.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[5] = tempval;

	tbKey2.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[6] = tempval;

	tbKey3.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[7] = tempval;

	tbKey4.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[8] = tempval;

	tbKey5.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[9] = tempval;

	tbKey6.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[10] = tempval;

	memcpy( &SendBuff[11], UID, 4 );

	SendLen = 15;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Authentication Failed\n", RED );
		return;
	}
	else
	{
		if( RecvBuff[2] != 0x00 )
		{
			DisplayOut( "Authentication Failed\n", RED );
			return;
		}

		DisplayOut( "Authentication Success\n", GREEN );
	}
}

void CMifareProgrammingDlg::OnUpdate() 
{
	CString tempstr;
	char holder[4];
	int tempval;

	tbBinaryBlockNo.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbBinaryBlockNo.SetFocus();
		return;
	
	}

	tbBinaryBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	if( tempval < 0x80 )
	{
		if( tempval % 4 == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if( res  == IDCANCEL )
			{
				return;
			}
		}
	}
	else
	{
		if( ( ( tempval - 128 ) % 4 ) == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if(res == IDCANCEL)
			{
				return;
			}
		}
	}

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0xA0;

	tbBinaryBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[4] = tempval;

	tbData.GetWindowText( tempstr );

	for( int i = 0; i < tempstr.GetLength(); i++ )
	{
		SendBuff[i + 5] = tempstr.GetAt( i );
	}

	SendLen = 21;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Update Block Failed\n", RED );
		return;
	}
	else
	{
		DisplayOut( "Update Block Success\n", GREEN );
	}
	
}

void CMifareProgrammingDlg::OnRead() 
{

	CString tempstr;
	char holder[4];
	int tempval;

	tbBinaryBlockNo.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbBinaryBlockNo.SetFocus();
		return;
	
	}

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0x30;

	tbBinaryBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[4] = tempval;

	SendLen = 5;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Read Block Failed\n", RED );
		return;
	}
	else
	{
		if( RecvLen < 4 )
		{
			DisplayOut( "Read Block Failed\n", RED );
			return;
		}

		DisplayOut( "Read Block Success\n", GREEN );
		for( UINT i = 3; i < RecvLen; i++ )
		{
			tempstr.Insert( i - 3, _T(RecvBuff[i]) );
		}
		tbData.SetWindowText( tempstr );
	}
}

void CMifareProgrammingDlg::OnStoreVal() 
{
	char tempstr[255], holder[20];
	int tempval, pVal;
	
	tbValueBlockNo.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbValueBlockNo.SetFocus();
		return;
	
	}

	tbValueBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	if( tempval < 0x80 )
	{
		if( tempval % 4 == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if( res  == IDCANCEL )
			{
				return;
			}
		}
	}
	else
	{
		if( ( ( tempval - 128 ) % 4 ) == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if(res == IDCANCEL)
			{
				return;
			}
		}
	}

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0xA0;

	memset( holder, 0x00, 20 );	
	tbValueBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[4] = tempval;

	memset( holder, 0x00, 20 );	
	tbValue.GetWindowText( holder, 20 );
	sscanf( holder, "%d", &tempval );

	pVal = tempval;

	if( pVal >= 0 )
	{
		//Computation of pVal
		tempval = pVal % 256;
		SendBuff[5] = tempval;

		tempval = pVal / 256;
		tempval = tempval % 256;
		SendBuff[6] = tempval;

		tempval = pVal / 256;
		tempval = tempval / 256;
		tempval = tempval % 256;
		SendBuff[7] = tempval;

		tempval = pVal / 256;
		tempval = tempval / 256;
		tempval = tempval / 256;
		tempval = tempval % 256;
		SendBuff[8] = tempval;

		//Get complemet of pVal
		SendBuff[9] = 255 - SendBuff[5];
		SendBuff[10] = 255 - SendBuff[6];
		SendBuff[11] = 255 - SendBuff[7];
		SendBuff[12] = 255 - SendBuff[8];
	}
	else
	{
		long temp = abs( pVal );

		//Computation of pVal
		SendBuff[5] = ~tempval + 1;
		SendBuff[9] = tempval - 1;
		
		tempval = temp / 256;
		tempval = tempval % 256;
		SendBuff[6] = ~tempval;
		SendBuff[10] = tempval;

		tempval = temp / 256;
		tempval = tempval / 256;
		tempval = tempval % 256;
		SendBuff[7] = ~tempval;
		SendBuff[11] = tempval;

		tempval = temp / 256;
		tempval = tempval / 256;
		tempval = tempval / 256;
		tempval = tempval % 256;
		SendBuff[8] = ~tempval;
		SendBuff[12] = tempval;
	}

	SendBuff[13] = SendBuff[5];
	SendBuff[14] = SendBuff[6];
	SendBuff[15] = SendBuff[7];
	SendBuff[16] = SendBuff[8];

	SendBuff[17] = SendBuff[4];
	SendBuff[18] = 255 - SendBuff[4];
	SendBuff[19] = SendBuff[4];
	SendBuff[20] = 255 - SendBuff[4];

	SendLen = 21;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Store value to block failed\n", RED );
		return;
	}
	else
	{
		sprintf( tempstr, "Written to block %02X success\n", SendBuff[4] );
		DisplayOut( tempstr, GREEN );
	}
}

void CMifareProgrammingDlg::OnReadVal() 
{
	char tempstr[255], holder[4];
	int tempval;

	tbValueBlockNo.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbValueBlockNo.SetFocus();
		return;
	
	}

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0x30;
	
	tbValueBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[4] = tempval;

	SendLen = 5;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Read value from block failed\n", RED );
		return;
	}
	else
	{
		char temp[8];
		long x;

		if( RecvLen < 4 )
		{
			DisplayOut( "Read value from block failed\n", RED );
			return;
		}

		sprintf( temp, "" );
		for( int i = 6; i >= 3; i-- )
		{
			sprintf( temp, "%s%02x", temp, RecvBuff[i] );
		}
		
		x = strtoul( temp, 0, 16 );
		itoa( x, temp, 10 );
		tbValue.SetWindowText( temp );

		sprintf( tempstr, "Read value block %02X success\n", SendBuff[4] );
		DisplayOut( tempstr, GREEN );
	}
}

void CMifareProgrammingDlg::OnInc() 
{
	char tempstr[255], holder[4];
	int tempval;
	ULONG val, valBuff[4];

	tbValueBlockNo.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbValueBlockNo.SetFocus();
		return;
	
	}

	tbValueBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	if( tempval < 0x80 )
	{
		if( tempval % 4 == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if( res  == IDCANCEL )
			{
				return;
			}
		}
	}
	else
	{
		if( ( ( tempval - 128 ) % 4 ) == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if(res == IDCANCEL)
			{
				return;
			}
		}
	}

	tbValue.GetWindowText( holder, 4 );
	sscanf( holder, "%d", &tempval );

	//Computation of the increment value
	val = tempval;

	val = tempval % 256;
	valBuff[0] = val;

	val = tempval / 256;
	val = val % 256;
	valBuff[1] = val;

	val = tempval / 256;
	val = val / 256;
	val = val % 256;
	valBuff[2] = val;

	val = tempval / 256;
	val = val / 256;
	val = val / 256;
	val = val % 256;
	valBuff[3] = val;

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0xC1;

	tbValueBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[4] = tempval;

	for( int i = 0; i < 4; i++ )
	{
		SendBuff[i + 5] = (unsigned char) valBuff[i];
	}

	SendLen = 9;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Increment value of block failed\n", RED );
		return;
	}
	else
	{
		ClearBuffers();
		SendBuff[0] = 0xD4;
		SendBuff[1] = 0x40;
		SendBuff[2] = 0x01;
		SendBuff[3] = 0xB0;

		tbValueBlockNo.GetWindowText( holder, 4 );
		sscanf( holder, "%02X", &tempval );
		SendBuff[4] = tempval;

		SendLen = 5;
		RecvLen = 255;

		retCode = SendAPDU();
		if( retCode != 0 )
		{
			DisplayOut( "Increment value of block failed\n", RED );
			return;
		}
		else
		{
			sprintf( tempstr, "Increment value of block %02X success\n", SendBuff[4] );
			DisplayOut( tempstr, GREEN );
		}
	}
}

void CMifareProgrammingDlg::OnDec() 
{
	char tempstr[255], holder[4];
	int tempval;
	ULONG val, valBuff[4];

	tbValueBlockNo.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbValueBlockNo.SetFocus();
		return;
	
	}

	tbValueBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	if( tempval < 0x80 )
	{
		if( tempval % 4 == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if( res  == IDCANCEL )
			{
				return;
			}
		}
	}
	else
	{
		if( ( ( tempval - 128 ) % 4 ) == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if(res == IDCANCEL)
			{
				return;
			}
		}
	}

	tbValue.GetWindowText( holder, 4 );
	sscanf( holder, "%d", &tempval );

	//Computation of the increment value
	val = tempval;

	val = tempval % 256;
	valBuff[0] = val;

	val = tempval / 256;
	val = val % 256;
	valBuff[1] = val;

	val = tempval / 256;
	val = val / 256;
	val = val % 256;
	valBuff[2] = val;

	val = tempval / 256;
	val = val / 256;
	val = val / 256;
	val = val % 256;
	valBuff[3] = val;

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0xC0;

	tbValueBlockNo.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[4] = tempval;

	for( int i = 0; i < 4; i++ )
	{
		SendBuff[i + 5] = (unsigned char) valBuff[i];
	}

	SendLen = 9;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Decrement value of block failed\n", RED );
		return;
	}
	else
	{
		ClearBuffers();
		SendBuff[0] = 0xD4;
		SendBuff[1] = 0x40;
		SendBuff[2] = 0x01;
		SendBuff[3] = 0xB0;

		tbValueBlockNo.GetWindowText( holder, 4 );
		sscanf( holder, "%02X", &tempval );
		SendBuff[4] = tempval;

		SendLen = 5;
		RecvLen = 255;

		retCode = SendAPDU();
		if( retCode != 0 )
		{
			DisplayOut( "Decrement value of block failed\n", RED );
			return;
		}
		else
		{
			sprintf( tempstr, "Decrement value of block %02X success\n", SendBuff[4] );
			DisplayOut( tempstr, GREEN );
		}
	}	
}

void CMifareProgrammingDlg::OnRestore() 
{
	mMsg.SetWindowText( "" );
}

void CMifareProgrammingDlg::OnCopy() 
{
	char tempstr[255], holder[4];
	int tempval;

	tbSource.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbSource.SetFocus();
		return;
	
	}

	tbTarget.GetWindowText( holder, 3 );
	if( strcmp( holder, "" ) == 0 || HexCheck( holder[0], holder[1] ) != 0 )
	{
	
		tbTarget.SetFocus();
		return;
	
	}

	tbTarget.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );

	if( tempval < 0x80 )
	{
		if( tempval % 4 == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if( res  == IDCANCEL )
			{
				return;
			}
		}
	}
	else
	{
		if( ( ( tempval - 128 ) % 4 ) == 3 )
		{
			int res = MessageBox( "Critical block chosen to be written. Continue?", "", MB_OKCANCEL);
			if(res == IDCANCEL)
			{
				return;
			}
		}
	}

	//Copy from source block
	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0xC2;

	tbSource.GetWindowText( holder, 4 );
	sscanf( holder, "%02X", &tempval );
	SendBuff[4] = tempval;

	SendLen = 5;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Copy block failed\n", RED );
		return;
	}
	else
	{
		ClearBuffers();
		SendBuff[0] = 0xD4;
		SendBuff[1] = 0x40;
		SendBuff[2] = 0x01;
		SendBuff[3] = 0xB0;

		tbTarget.GetWindowText( holder, 4 );
		sscanf( holder, "%02X", &tempval );
		SendBuff[4] = tempval;
		
		SendLen = 5;
		RecvLen = 255;

		retCode = SendAPDU();
		if( retCode != 0 )
		{
			DisplayOut( "Copy block failed\n", RED );
			return;
		}
		else
		{
			sprintf( tempstr, "Copying value to block %02X success\n", SendBuff[4] );
			DisplayOut( tempstr, GREEN );
		}
	}

}

void CMifareProgrammingDlg::OnReset() 
{
	ACR122_Close( hReader );
	pThis->OnRestore();
	DisplayOut( "Program Started\n", GREEN );
	Init();
}

void CMifareProgrammingDlg::OnQuit() 
{
	ACR122_Close( hReader );
	CDialog::OnCancel();
}

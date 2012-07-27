// Device ProgrammingDlg.cpp : implementation file
//

#include "stdafx.h"
#include "Device Programming.h"
#include "Device ProgrammingDlg.h"
#include "acr122.h"
#include "TimeOut.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//Global Variables
int retCode;
HANDLE hReader;
CDeviceProgrammingDlg *pThis = NULL;
BYTE SendBuff[255];
BYTE RecvBuff[255];
DWORD SendLen, RecvLen;

//Function Prototypes
void ClearBuffers();
int SendAPDU();

//Sets SendBuff and RecvBuff to zero
void ClearBuffers()
{
	memset( SendBuff, 0x00, 255 );
	memset( RecvBuff, 0x00, 255 );
}

//Displays the message in the rich edit box with the respective color
void CDeviceProgrammingDlg::DisplayOut( CString str, COLORREF color )
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
	pThis->DisplayOut( tempstr, BLACK );

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
	pThis->DisplayOut( tempstr, BLACK );

	return retCode;
}

void Init()
{
	pThis->btnConnect.EnableWindow( true );
	pThis->btnBaud.EnableWindow( false );
	pThis->btnTimeout.EnableWindow( false );
	pThis->btnSetLEDBuzz.EnableWindow( false );

	pThis->tbT1.EnableWindow( false );
	pThis->tbT2.EnableWindow( false );
	pThis->tbNum.EnableWindow( false );
	pThis->cT1.EnableWindow( false );
	pThis->cT2.EnableWindow( false );
	pThis->rbL0BlinkStateOff.EnableWindow( false );
	pThis->rbL0BlinkStateOn.EnableWindow( false );
	pThis->rbL0fStateOff.EnableWindow( false );
	pThis->rbL0fStateOn.EnableWindow( false );
	pThis->cL0Blink.EnableWindow( false );
	pThis->cL0Update.EnableWindow( false );
	pThis->rbL1BlinkStateOff.EnableWindow( false );
	pThis->rbL1BlinkStateOn.EnableWindow( false );
	pThis->rbL1fStateOff.EnableWindow( false );
	pThis->rbL1fStateOn.EnableWindow( false );
	pThis->cL1Blink.EnableWindow( false );
	pThis->cL1Update.EnableWindow( false );

	pThis->tbT1.SetWindowText( "" );
	pThis->tbT2.SetWindowText( "" );
	pThis->tbNum.SetWindowText( "" );
	pThis->cT1.SetCheck( 1 );
	pThis->cT2.SetCheck( 1 );
	pThis->rbL0BlinkStateOff.SetCheck( 0 );
	pThis->rbL0BlinkStateOn.SetCheck( 1 );
	pThis->rbL0fStateOff.SetCheck( 0 );
	pThis->rbL0fStateOn.SetCheck( 1 );
	pThis->cL0Blink.SetCheck( 0 );
	pThis->cL0Update.SetCheck( 0 );
	pThis->rbL1BlinkStateOff.SetCheck( 0 );
	pThis->rbL1BlinkStateOn.SetCheck( 1 );
	pThis->rbL1fStateOff.SetCheck( 0 );
	pThis->rbL1fStateOn.SetCheck( 1 );
	pThis->cL1Blink.SetCheck( 0 );
	pThis->cL1Update.SetCheck( 0 );
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
// CDeviceProgrammingDlg dialog

CDeviceProgrammingDlg::CDeviceProgrammingDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDeviceProgrammingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CDeviceProgrammingDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIconBig   = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_hIconSmall = AfxGetApp()->LoadIcon(IDR_SMALLICON);
}

void CDeviceProgrammingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CDeviceProgrammingDlg)
	DDX_Control(pDX, IDC_BUTTON7, btnQuit);
	DDX_Control(pDX, IDC_BUTTON6, btnReset);
	DDX_Control(pDX, IDC_BUTTON5, btnClear);
	DDX_Control(pDX, IDC_BUTTON4, btnSetLEDBuzz);
	DDX_Control(pDX, IDC_BUTTON3, btnTimeout);
	DDX_Control(pDX, IDC_RADIO8, rbL1BlinkStateOff);
	DDX_Control(pDX, IDC_RADIO7, rbL1BlinkStateOn);
	DDX_Control(pDX, IDC_RADIO6, rbL1fStateOff);
	DDX_Control(pDX, IDC_RADIO5, rbL1fStateOn);
	DDX_Control(pDX, IDC_CHECK6, cL1Blink);
	DDX_Control(pDX, IDC_CHECK5, cL1Update);
	DDX_Control(pDX, IDC_CHECK4, cL0Blink);
	DDX_Control(pDX, IDC_CHECK3, cL0Update);
	DDX_Control(pDX, IDC_RADIO4, rbL0BlinkStateOff);
	DDX_Control(pDX, IDC_RADIO3, rbL0BlinkStateOn);
	DDX_Control(pDX, IDC_RADIO2, rbL0fStateOff);
	DDX_Control(pDX, IDC_RADIO1, rbL0fStateOn);
	DDX_Control(pDX, IDC_CHECK2, cT2);
	DDX_Control(pDX, IDC_CHECK1, cT1);
	DDX_Control(pDX, IDC_EDIT3, tbNum);
	DDX_Control(pDX, IDC_EDIT2, tbT2);
	DDX_Control(pDX, IDC_EDIT1, tbT1);
	DDX_Control(pDX, IDC_RICHEDIT1, mMsg);
	DDX_Control(pDX, IDC_BUTTON2, btnBaud);
	DDX_Control(pDX, IDC_BUTTON1, btnConnect);
	DDX_Control(pDX, IDC_COMBO2, cbBaud);
	DDX_Control(pDX, IDC_COMBO1, cbPort);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CDeviceProgrammingDlg, CDialog)
	//{{AFX_MSG_MAP(CDeviceProgrammingDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_RADIO1, OnLed0FStateOn)
	ON_BN_CLICKED(IDC_RADIO2, OnLed0FStateOff)
	ON_BN_CLICKED(IDC_RADIO3, OnLed0BlinkStateOn)
	ON_BN_CLICKED(IDC_RADIO4, OnLed0BlinkStateOff)
	ON_BN_CLICKED(IDC_RADIO5, OnLed1fStateOn)
	ON_BN_CLICKED(IDC_RADIO6, OnLed1fStateOff)
	ON_BN_CLICKED(IDC_RADIO7, OnLed1BlinkStateOn)
	ON_BN_CLICKED(IDC_RADIO8, OnLed1BlinkStateOff)
	ON_BN_CLICKED(IDC_BUTTON1, OnConnect)
	ON_BN_CLICKED(IDC_BUTTON2, OnBaudRate)
	ON_BN_CLICKED(IDC_BUTTON4, OnLEDBUZZ)
	ON_BN_CLICKED(IDC_BUTTON3, OnTimeOut)
	ON_BN_CLICKED(IDC_BUTTON5, OnClear)
	ON_BN_CLICKED(IDC_BUTTON6, OnReset)
	ON_WM_CLOSE()
	ON_BN_CLICKED(IDC_BUTTON7, OnQuit)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CDeviceProgrammingDlg message handlers

BOOL CDeviceProgrammingDlg::OnInitDialog()
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

	cbBaud.AddString( "9600" );
	cbBaud.AddString( "115200" );

	cbBaud.SetCurSel( 0 );

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

void CDeviceProgrammingDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CDeviceProgrammingDlg::OnPaint() 
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
HCURSOR CDeviceProgrammingDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIconSmall;
}

void CDeviceProgrammingDlg::OnLed0FStateOn() 
{
	rbL0fStateOff.SetCheck( 0 );	
}

void CDeviceProgrammingDlg::OnLed0FStateOff() 
{
	rbL0fStateOn.SetCheck( 0 );
}

void CDeviceProgrammingDlg::OnLed0BlinkStateOn() 
{
	rbL0BlinkStateOff.SetCheck( 0 );	
}

void CDeviceProgrammingDlg::OnLed0BlinkStateOff() 
{
	rbL0BlinkStateOn.SetCheck( 0 );	
}

void CDeviceProgrammingDlg::OnLed1fStateOn() 
{
	rbL1fStateOff.SetCheck( 0 );	
}

void CDeviceProgrammingDlg::OnLed1fStateOff() 
{
	rbL1fStateOn.SetCheck( 0 );	
}

void CDeviceProgrammingDlg::OnLed1BlinkStateOn() 
{
	rbL1BlinkStateOff.SetCheck( 0 );	
}

void CDeviceProgrammingDlg::OnLed1BlinkStateOff() 
{
	rbL1BlinkStateOn.SetCheck( 0 );		
}

void CDeviceProgrammingDlg::OnConnect() 
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
	pThis->btnBaud.EnableWindow( true );
	pThis->btnTimeout.EnableWindow( true );
	pThis->btnSetLEDBuzz.EnableWindow( true );

	pThis->tbT1.EnableWindow( true );
	pThis->tbT2.EnableWindow( true );
	pThis->tbNum.EnableWindow( true );
	pThis->cT1.EnableWindow( true );
	pThis->cT2.EnableWindow( true );
	pThis->rbL0BlinkStateOff.EnableWindow( true );
	pThis->rbL0BlinkStateOn.EnableWindow( true );
	pThis->rbL0fStateOff.EnableWindow( true );
	pThis->rbL0fStateOn.EnableWindow( true );
	pThis->cL0Blink.EnableWindow( true );
	pThis->cL0Update.EnableWindow( true );
	pThis->rbL1BlinkStateOff.EnableWindow( true );
	pThis->rbL1BlinkStateOn.EnableWindow( true );
	pThis->rbL1fStateOff.EnableWindow( true );
	pThis->rbL1fStateOn.EnableWindow( true );
	pThis->cL1Blink.EnableWindow( true );
	pThis->cL1Update.EnableWindow( true );
}

void CDeviceProgrammingDlg::OnBaudRate() 
{
	if( cbBaud.GetCurSel() == 0 )
	{
		retCode = ACR122_SetBaudRate( hReader, 9600 );
	}
	else
	{
		retCode = ACR122_SetBaudRate( hReader, 115200 );
	}

	if( retCode != 0 )
	{
		DisplayOut( "Set baud rate failed\n", RED );
		return;
	}
	else
	{
		DisplayOut( "Set baud rate success\n", GREEN );
	}
}

void CDeviceProgrammingDlg::OnLEDBUZZ() 
{
	ACR122_LED_CONTROL ledCtrl[2];
	char holder[5];
	int t1, t2, num;
	DWORD buzzmode;

	if( rbL0fStateOn.GetCheck() == 1 )
	{
		ledCtrl[0].finalState = ACR122_LED_STATE_ON;
	}
	else
	{
		ledCtrl[0].finalState = ACR122_LED_STATE_OFF;
	}

	if( rbL0BlinkStateOn.GetCheck() == 1 )
	{
		ledCtrl[0].initialBlinkingState = ACR122_LED_STATE_ON;
	}
	else
	{
		ledCtrl[0].initialBlinkingState = ACR122_LED_STATE_OFF;
	}

	if( rbL1fStateOn.GetCheck() == 1 )
	{
		ledCtrl[1].finalState = ACR122_LED_STATE_ON;
	}
	else
	{
		ledCtrl[1].finalState = ACR122_LED_STATE_OFF;
	}

	if( rbL1BlinkStateOn.GetCheck() == 1 )
	{
		ledCtrl[1].initialBlinkingState = ACR122_LED_STATE_ON;
	}
	else
	{
		ledCtrl[1].initialBlinkingState = ACR122_LED_STATE_OFF;
	}

	if( cL0Blink.GetCheck() == 1 )
	{
		ledCtrl[0].blinkEnabled = true;
	}
	else
	{
		ledCtrl[0].blinkEnabled = false;
	}

	if( cL0Update.GetCheck() == 1 )
	{
		ledCtrl[0].updateEnabled = true;
	}
	else
	{
		ledCtrl[0].updateEnabled = false;
	}

	if( cL1Blink.GetCheck() == 1 )
	{
		ledCtrl[1].blinkEnabled = true;
	}
	else
	{
		ledCtrl[1].blinkEnabled = false;
	}

	if( cL1Update.GetCheck() == 1 )
	{
		ledCtrl[1].updateEnabled = true;
	}
	else
	{
		ledCtrl[1].updateEnabled = false;
	}

	tbT1.GetWindowText( holder, 6 );
	sscanf( holder, "%d", &t1 );
	if( t1 > 25500 )
	{
		tbT1.SetWindowText( "25500" );
		tbT1.SetFocus();
		return;
	}

	tbT2.GetWindowText( holder, 6 );
	sscanf( holder, "%d", &t2 );
	if( t2 > 25500 )
	{
		tbT2.SetWindowText( "25500" );
		tbT2.SetFocus();
		return;
	}

	tbNum.GetWindowText( holder, 6 );
	sscanf( holder, "%d", &num );
	if( num > 255 )
	{
		tbNum.SetWindowText( "255" );
		tbNum.SetFocus();
		return;
	}

	if( cT1.GetCheck() == 1 )
	{
		buzzmode = ACR122_BUZZER_MODE_ON_T1;
	}
	
	if( cT2.GetCheck() == 1 )
	{
		buzzmode = ACR122_BUZZER_MODE_ON_T2;
	}
	
	if( cT1.GetCheck() == 1 && cT2.GetCheck() == 1 )
	{
		buzzmode = ACR122_BUZZER_MODE_ON_T1 | ACR122_BUZZER_MODE_ON_T2;
	}

	retCode = ACR122_SetLedStatesWithBeep( hReader, ledCtrl, 2, t1, t2, num, buzzmode );
	if( retCode != 0 )
	{
		DisplayOut( "Set LED States with Beep failed\n", RED );
		return;
	}
	else
	{
		DisplayOut( "Set LED States with Beep success\n", GREEN );
	}
}

void CDeviceProgrammingDlg::OnTimeOut() 
{
	TimeOut dlg;

	dlg.DoModal();
}

void CDeviceProgrammingDlg::OnClear() 
{
	mMsg.SetWindowText( "" );	
}

void CDeviceProgrammingDlg::OnReset() 
{
	pThis->OnClear();
	ACR122_Close( hReader );
	Init();
	DisplayOut( "Program Started\n", GREEN );
}

void CDeviceProgrammingDlg::OnClose() 
{
	ACR122_Close( hReader );
	CDialog::OnClose();
}

void CDeviceProgrammingDlg::OnQuit() 
{
	ACR122_Close( hReader );
	CDialog::OnOK();
}

//  Copyright(C):      Advanced Card Systems Ltd
//
//
//  Description:       This sample program outlines on how
//					   to get the ATR of a card
//
//  Author:            Wazer Emmanuel R. Benal
//
//  Date:              November 11, 2009
//
//
//======================================================================

#include "stdafx.h"
#include "GetATR.h"
#include "GetATRDlg.h"
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
CGetATRDlg *pThis = NULL;
BYTE SendBuff[255];
BYTE RecvBuff[255];
DWORD SendLen, RecvLen;

//Function Prototypes
void ClearBuffers();
void DisplayOut( CString str, COLORREF color );
int SendAPDU();

void Init()
{
	pThis->btnConnect.EnableWindow( true );
	pThis->btnGetATR.EnableWindow( false );
	pThis->cbPort.SetCurSel( 0 );
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
// CGetATRDlg dialog

CGetATRDlg::CGetATRDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CGetATRDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CGetATRDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIconBig   = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_hIconSmall = AfxGetApp()->LoadIcon(IDR_SMALLICON);
}

void CGetATRDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CGetATRDlg)
	DDX_Control(pDX, IDC_BUTTON5, btnQuit);
	DDX_Control(pDX, IDC_BUTTON4, btnReset);
	DDX_Control(pDX, IDC_BUTTON3, btnClear);
	DDX_Control(pDX, IDC_BUTTON2, btnGetATR);
	DDX_Control(pDX, IDC_RICHEDIT1, mMsg);
	DDX_Control(pDX, IDC_BUTTON1, btnConnect);
	DDX_Control(pDX, IDC_COMBO1, cbPort);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CGetATRDlg, CDialog)
	//{{AFX_MSG_MAP(CGetATRDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, OnConnect)
	ON_BN_CLICKED(IDC_BUTTON2, OnGetATR)
	ON_BN_CLICKED(IDC_BUTTON3, OnClear)
	ON_BN_CLICKED(IDC_BUTTON4, OnReset)
	ON_BN_CLICKED(IDC_BUTTON5, OnQuit)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CGetATRDlg message handlers

BOOL CGetATRDlg::OnInitDialog()
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

void CGetATRDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CGetATRDlg::OnPaint() 
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
HCURSOR CGetATRDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIconSmall;
}

void CGetATRDlg::OnConnect() 
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
	pThis->btnGetATR.EnableWindow( true );
}

void CGetATRDlg::OnGetATR() 
{
	BYTE CardType;
	CString tempstr;

	ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x60;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0x01;
	SendBuff[4] = 0x20;
	SendBuff[5] = 0x23;
	SendBuff[6] = 0x11;
	SendBuff[7] = 0x04;
	SendBuff[8] = 0x10;

	SendLen = 9;
	RecvLen = 255;

	retCode = SendAPDU();
	if( retCode != 0 )
	{
		DisplayOut( "Get ATR failed\n", RED );
		return;
	}
	else
	{
		if( RecvLen > 3 )
		{
			CardType = RecvBuff[8];
			switch( CardType )
			{
				case 0x18:
					tempstr = "Mifare 4K ";
					break;
				case 0x00:
					tempstr = "Mifare Ultralight ";
					break;
				case 0x28:
					tempstr = "ISO 14443-4 Type A ";
					break;
				case 0x08:
					tempstr = "Mifare 1K ";
					break;
				case 0x09:
					tempstr = "Mifare Mini ";
					break;
				case 0x20:
					tempstr = "Mifare DesFire ";
					break;
				case 0x98:
					tempstr = "Gemplus MPCOS ";
					break;
				default:
					CardType = RecvBuff[3];
					switch( CardType )
					{
						case 0x23:
							tempstr = "ISO 14443-4 Type B ";
							break;
						case 0x11:
							tempstr = "FeliCa 212K ";
							break;
						case 0x04:
							tempstr = "Topaz ";
							break;
						default:
							tempstr = "Unknown contactless card ";
							break;

					}
			}
		}
		else
		{
			tempstr = "No contactless card ";
		}

		tempstr = tempstr + "detected\n";

		DisplayOut( tempstr, GREEN );
	}
}

void CGetATRDlg::OnClear() 
{
	mMsg.SetWindowText( "" );
}

void CGetATRDlg::OnReset() 
{
	pThis->OnClear();
	DisplayOut( "Program Started\n", GREEN );
	Init();
	ACR122_Close( hReader );
}

void CGetATRDlg::OnQuit() 
{
	ACR122_Close( hReader );
	CDialog::OnCancel();
}

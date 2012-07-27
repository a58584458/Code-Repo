//  Copyright(C):      Advanced Card Systems Ltd
//
//
//  Description:       This sample program outlines on how
//					   to poll for a contactless card
//
//  Author:            Wazer Emmanuel R. Benal
//
//  Date:              November 11, 2009
//
//
//======================================================================

#include "stdafx.h"
#include "Polling.h"
#include "PollingDlg.h"
#include "acr122.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

//Global Variables
int retCode;
HANDLE hReader;
CPollingDlg *pThis = NULL;
BYTE SendBuff[255];
BYTE RecvBuff[255];
DWORD SendLen, RecvLen;
BOOL detect = false;

//Initializers for the status bar
static UINT BASED_CODE indicators[] =
{
    ID_INDICATOR_PANE1,
    ID_INDICATOR_PANE2
};

//Sets SendBuff and RecvBuff to zero
void ClearBuffers()
{
	memset( SendBuff, 0x00, 255 );
	memset( RecvBuff, 0x00, 255 );
}

//Sends APDU through ACR122_DirectTransmit() command
int SendAPDU()
{
	retCode = ACR122_DirectTransmit( hReader, SendBuff, SendLen, RecvBuff, &RecvLen );
	if( retCode != 0 )
	{
		return retCode;
	}

	return retCode;
}

void CALLBACK Polling ( HWND, UINT, UINT, DWORD )
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
		pThis->m_bar.SetPaneText( 1, ERROR );
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
							tempstr = "Unknown card ";
							break;

					}
			}
		}
		else
		{
			tempstr = "";
		}
		pThis->m_bar.SetPaneText( 1, tempstr );
	}
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
// CPollingDlg dialog

CPollingDlg::CPollingDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CPollingDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CPollingDlg)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	// Note that LoadIcon does not require a subsequent DestroyIcon in Win32
	m_hIconBig   = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
	m_hIconSmall = AfxGetApp()->LoadIcon(IDR_SMALLICON);
}

void CPollingDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CPollingDlg)
	DDX_Control(pDX, IDC_BUTTON3, btnQuit);
	DDX_Control(pDX, IDC_BUTTON2, btnPolling);
	DDX_Control(pDX, IDC_BUTTON1, btnConnect);
	DDX_Control(pDX, IDC_COMBO1, cbPort);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CPollingDlg, CDialog)
	//{{AFX_MSG_MAP(CPollingDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(IDC_BUTTON1, OnConnect)
	ON_BN_CLICKED(IDC_BUTTON2, OnPolling)
	ON_BN_CLICKED(IDC_BUTTON3, OnQuit)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CPollingDlg message handlers

BOOL CPollingDlg::OnInitDialog()
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

	m_bar.Create( this );
	m_bar.SetIndicators( indicators, 2 );
	CRect rect;
	GetClientRect( &rect );
	m_bar.SetPaneInfo( 0, ID_INDICATOR_PANE1, SBPS_NORMAL, 50 );
	m_bar.SetPaneInfo( 1, ID_INDICATOR_PANE2, SBPS_NORMAL, 200 );
	RepositionBars( AFX_IDW_CONTROLBAR_FIRST, AFX_IDW_CONTROLBAR_LAST,
					ID_INDICATOR_PANE2 );

	m_bar.SetPaneText( 0, "Card Type" );
	//m_bar.SetPaneText( 2, "Card Status" );
	
	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CPollingDlg::OnSysCommand(UINT nID, LPARAM lParam)
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

void CPollingDlg::OnPaint() 
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
HCURSOR CPollingDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIconSmall;
}

void CPollingDlg::OnConnect() 
{
	char port[10];
	DWORD FWLEN = 255;

	sprintf( port, "" );
	cbPort.GetWindowText( port, 5 );

	retCode = ACR122_OpenA( port, &hReader );
	if( retCode != 0 )
	{
		AfxMessageBox( "Connection Failed" );
		return;
	}
	else
	{
		AfxMessageBox( "Connection Success" );
	}	
}

void CPollingDlg::OnPolling() 
{
	if( detect )
	{
		detect = false;
		btnPolling.SetWindowText( "Start Polling" );
		KillTimer( 1 );
	}
	else
	{
		detect = true;
		btnPolling.SetWindowText( "End Polling" );
		SetTimer(1, 250, Polling );
		m_bar.SetPaneText( 1, "" );
		return;
	}	
}

void CPollingDlg::OnQuit() 
{
	ACR122_Close( hReader );
	KillTimer( 1 );
	CDialog::OnCancel();
}

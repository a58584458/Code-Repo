// TimeOut.cpp : implementation file
//

#include "stdafx.h"
#include "Device Programming.h"
#include "Device ProgrammingDlg.h"
#include "TimeOut.h"
#include "acr122.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

extern int retCode;
extern HANDLE hReader;
extern BYTE SendBuff[255];
extern BYTE RecvBuff[255];
extern DWORD SendLen, RecvLen;
TimeOut *pThis = NULL;
CDeviceProgrammingDlg *pParent;

//Displays the message in the rich edit box with the respective color
void DisplayOut( CString str, COLORREF color )
{
	int nOldLines = 0,
		nNewLines = 0,
		nScroll = 0;
	long nInsertPoint = 0;
	CHARFORMAT cf;

	//Save number of lines before insertion of new text
	nOldLines = pParent->mMsg.GetLineCount();

	//Initialize character format structure
	cf.cbSize		= sizeof( CHARFORMAT );
	cf.dwMask		= CFM_COLOR;
	cf.dwEffects	= 0;	// To disable CFE_AUTOCOLOR
	cf.crTextColor	= color;

	//Set insertion point to end of text
	nInsertPoint = pParent->mMsg.GetWindowTextLength();
	pParent->mMsg.SetSel( nInsertPoint, -1 );
	
	//Set the character format
	pParent->mMsg.SetSelectionCharFormat( cf );

	//Insert string at the current caret poisiton
	pParent->mMsg.ReplaceSel( str );

	nNewLines = pParent->mMsg.GetLineCount();
	nScroll	= nNewLines - nOldLines;
	pParent->mMsg.LineScroll( 1 );
}

/////////////////////////////////////////////////////////////////////////////
// TimeOut dialog


TimeOut::TimeOut(CWnd* pParent /*=NULL*/)
	: CDialog(TimeOut::IDD, pParent)
{
	//{{AFX_DATA_INIT(TimeOut)
		// NOTE: the ClassWizard will add member initialization here
	//}}AFX_DATA_INIT
	
}


void TimeOut::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(TimeOut)
	DDX_Control(pDX, IDC_EDIT4, tbRespRe);
	DDX_Control(pDX, IDC_EDIT3, tbRespTO);
	DDX_Control(pDX, IDC_EDIT2, tbStatRe);
	DDX_Control(pDX, IDC_EDIT1, tbStatTO);
	DDX_Control(pDX, IDCANCEL, btnCancel);
	DDX_Control(pDX, IDOK, btnOK);
	//}}AFX_DATA_MAP
}

BOOL TimeOut::OnInitDialog()
{
	CDialog::OnInitDialog();

	tbStatTO.SetWindowText( "2000" );
	tbStatRe.SetWindowText( "1" );
	tbRespTO.SetWindowText( "10000" );
	tbRespRe.SetWindowText( "1" );

	pThis = this;
	pParent = (CDeviceProgrammingDlg *)pThis->GetParent();

	return TRUE;  // return TRUE  unless you set the focus to a control
}


BEGIN_MESSAGE_MAP(TimeOut, CDialog)
	//{{AFX_MSG_MAP(TimeOut)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// TimeOut message handlers

void TimeOut::OnOK() 
{
	ACR122_TIMEOUTS to;
	char holder[7];
	DWORD tempval;

	tbStatTO.GetWindowText( holder, 7 );
	sscanf( holder, "%d", &tempval );
	to.statusTimeout = tempval;

	tbStatRe.GetWindowText( holder, 7 );
	sscanf( holder, "%d", &tempval );
	to.numStatusRetries = tempval;

	tbRespTO.GetWindowText( holder, 7 );
	sscanf( holder, "%d", &tempval );
	to.responseTimeout = tempval;

	tbRespRe.GetWindowText( holder, 7 );
	sscanf( holder, "%d", &tempval );
	to.numResponseRetries = tempval;

	retCode = ACR122_SetTimeouts( hReader, &to );
	if( retCode != 0 )
	{
		DisplayOut( "Set Timeouts failed\n", RED );
	}
	else
	{
		DisplayOut( "Set Timeouts success\n", GREEN );
	}
	
	CDialog::OnOK();
}

// SAM_INIT.cpp : implementation file
//

#include "stdafx.h"
#include "Key Management.h"
#include "SAM_INIT.h"
#include "Key ManagementDlg.h"
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
extern BYTE Buffer[256];
SAM_INIT *pSAM = NULL;
CKeyManagementDlg *pParent;

void ClearBuffers()
{
	memset( SendBuff, 0x00, 255 );
	memset( RecvBuff, 0x00, 255 );
}

/////////////////////////////////////////////////////////////////////////////
// SAM_INIT dialog


SAM_INIT::SAM_INIT(CWnd* pParent /*=NULL*/)
	: CDialog(SAM_INIT::IDD, pParent)
{
	//{{AFX_DATA_INIT(SAM_INIT)
	//}}AFX_DATA_INIT
}


void SAM_INIT::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(SAM_INIT)
	DDX_Control(pDX, IDC_EDIT8, tbRevoke);
	DDX_Control(pDX, IDC_EDIT7, tbCert);
	DDX_Control(pDX, IDC_EDIT6, tbCredit);
	DDX_Control(pDX, IDC_EDIT5, tbDebit);
	DDX_Control(pDX, IDC_EDIT4, tbTerm);
	DDX_Control(pDX, IDC_EDIT3, tbCard);
	DDX_Control(pDX, IDC_EDIT2, tbIssuer);
	DDX_Control(pDX, IDOK, btnOK);
	DDX_Control(pDX, IDCANCEL, btnCancel);
	DDX_Control(pDX, IDC_EDIT1, tbGlobal);
	//}}AFX_DATA_MAP
}

BOOL SAM_INIT::OnInitDialog()
{
	CDialog::OnInitDialog();

	pSAM = this;
	pParent = (CKeyManagementDlg *)pSAM->GetParent();

	tbGlobal.SetWindowText( "" );
	tbIssuer.SetWindowText( "" );
	tbCard.SetWindowText( "" );
	tbTerm.SetWindowText( "" );
	tbDebit.SetWindowText( "" );
	tbCredit.SetWindowText( "" );
	tbCert.SetWindowText( "" );
	tbRevoke.SetWindowText( "" );
	
	tbGlobal.SetLimitText( 16 );
	tbIssuer.SetLimitText( 16 );
	tbCard.SetLimitText( 16 );
	tbTerm.SetLimitText( 16 );
	tbDebit.SetLimitText( 16 );
	tbCredit.SetLimitText( 16 );
	tbCert.SetLimitText( 16 );
	tbRevoke.SetLimitText( 16 );

	return TRUE;  // return TRUE  unless you set the focus to a control
}


BEGIN_MESSAGE_MAP(SAM_INIT, CDialog)
	//{{AFX_MSG_MAP(SAM_INIT)
	ON_BN_CLICKED(IDOK, OnInit)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// SAM_INIT message handlers

void SAM_INIT::OnInit() 
{
	//char tempstr[255];
	CString port, tempstr, tempstr2, PINBuff;
	int count, i;

	tbGlobal.GetWindowText( tempstr );
	if( tempstr.GetLength() < 16 )
	{
		AfxMessageBox( "Please enter 8 bytes of keys for Global PIN" );
		tbGlobal.SetFocus();
		return;
	}
	tbIssuer.GetWindowText( tempstr );
	if( tempstr.GetLength() < 16 )
	{
		AfxMessageBox( "Please enter 8 bytes of keys for Issuer Code" );
		tbIssuer.SetFocus();
		return;
	}
	tbCard.GetWindowText( tempstr );
	if( tempstr.GetLength() < 16 )
	{
		AfxMessageBox( "Please enter 8 bytes of keys for Card Key" );
		tbCard.SetFocus();
		return;
	}
	tbTerm.GetWindowText( tempstr );
	if( tempstr.GetLength() < 16 )
	{
		AfxMessageBox( "Please enter 8 bytes of keys for Terminal Key" );
		tbTerm.SetFocus();
		return;
	}
	tbDebit.GetWindowText( tempstr );
	if( tempstr.GetLength() < 16 )
	{
		AfxMessageBox( "Please enter 8 bytes of keys for Debit Key" );
		tbDebit.SetFocus();
		return;
	}
	tbCredit.GetWindowText( tempstr );
	if( tempstr.GetLength() < 16 )
	{
		AfxMessageBox( "Please enter 8 bytes of keys for Credit Key" );
		tbCredit.SetFocus();
		return;
	}
	tbCert.GetWindowText( tempstr );
	if( tempstr.GetLength() < 16 )
	{
		AfxMessageBox( "Please enter 8 bytes of keys for Certify Key" );
		tbCert.SetFocus();
		return;
	}
	tbRevoke.GetWindowText( tempstr );
	if( tempstr.GetLength() < 16 )
	{
		AfxMessageBox( "Please enter 8 bytes of keys for Revoke Debit Key" );
		tbRevoke.SetFocus();
		return;
	}

	pParent->ClearBuffers();
	//Clear card
	SendBuff[0] = 0x80;
	SendBuff[1] = 0x30;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x00;

	SendLen = 5;
	RecvLen = 255;

	retCode = pParent->SendAPDU( 1 );
	
	//Reset SAM
	retCode = ACR122_PowerOffIcc( hReader, 0 );
	retCode = ACR122_Close( hReader );
	pParent->cbPort.GetWindowText( port );
	retCode = ACR122_Open( port, &hReader );
	RecvLen = 255;
	retCode = ACR122_PowerOnIcc( hReader, 0, RecvBuff, &RecvLen );
	if( retCode != 0 )
	{
		pParent->DisplayOut( "Reset Failed\n", RED );
		//pParent->OnReset();
		pSAM->EndDialog(IDOK);
		return;
	}
	
	pParent->ClearBuffers();
	//Create Master File
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE0;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x0F;
	SendBuff[5] = 0x62;
	SendBuff[6] = 0x0D;
	SendBuff[7] = 0x82;
	SendBuff[8] = 0x01;
	SendBuff[9] = 0x3F;
	SendBuff[10] = 0x83;
	SendBuff[11] = 0x02;
	SendBuff[12] = 0x3F;
	SendBuff[13] = 0x00;
	SendBuff[14] = 0x8A;
	SendBuff[15] = 0x01;
	SendBuff[16] = 0x01;
	SendBuff[17] = 0x8C;
	SendBuff[18] = 0x01;
	SendBuff[19] = 0x00;

	SendLen = 20;
	RecvLen = 255;

	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Creating master file failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	pParent->ClearBuffers();
	//Create EF1 to Store PIN
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE0;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x1B;
	SendBuff[5] = 0x62;
	SendBuff[6] = 0x19;
	SendBuff[7] = 0x83;
	SendBuff[8] = 0x02;
	SendBuff[9] = 0xFF;
	SendBuff[10] = 0x0A;
	SendBuff[11] = 0x88;
	SendBuff[12] = 0x01;
	SendBuff[13] = 0x01;
	SendBuff[14] = 0x82;
	SendBuff[15] = 0x06;
	SendBuff[16] = 0x0C;
	SendBuff[17] = 0x00;
	SendBuff[18] = 0x00;
	SendBuff[19] = 0x0A;
	SendBuff[20] = 0x00;
	SendBuff[21] = 0x01;
	SendBuff[22] = 0x8C;
	SendBuff[23] = 0x08;
	SendBuff[24] = 0x7F;
	SendBuff[25] = 0xFF;
	SendBuff[26] = 0xFF;
	SendBuff[27] = 0xFF;
	SendBuff[28] = 0xFF;
	SendBuff[29] = 0x27;
	SendBuff[30] = 0x27;
	SendBuff[31] = 0xFF;

	SendLen = 32;
	RecvLen = 255;

	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Creating EF1 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	pParent->ClearBuffers();
	//Set Global PIN
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xDC;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0x04;
	SendBuff[4] = 0x0A;
	SendBuff[5] = 0x01;
	SendBuff[6] = 0x88;

	tbGlobal.GetWindowText( tempstr );
	count = 0;

	for( i = 0; i <= (int)( ( strlen( tempstr ) / 2 ) - 1 ); i++ )
	{
		PINBuff = tempstr.Mid( count, 2 );
		PINBuff = "0x" + PINBuff;
		sscanf( PINBuff, "%02X", &SendBuff[i+7] );
		count += 2;
	}

	SendLen = 15;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 )
	{
		pParent->DisplayOut( "Setting Global PIN failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	pParent->ClearBuffers();
	//Create DF
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE0;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x2B;
	SendBuff[5] = 0x62;
	SendBuff[6] = 0x29;
	SendBuff[7] = 0x82;
	SendBuff[8] = 0x01;
	SendBuff[9] = 0x38;
	SendBuff[10] = 0x83;
	SendBuff[11] = 0x02;
	SendBuff[12] = 0x11;
	SendBuff[13] = 0x00;
	SendBuff[14] = 0x8A;
	SendBuff[15] = 0x01;
	SendBuff[16] = 0x01;
	SendBuff[17] = 0x8C;
	SendBuff[18] = 0x08;
	SendBuff[19] = 0x7F;
	SendBuff[20] = 0x03;
	SendBuff[21] = 0x03;
	SendBuff[22] = 0x03;
	SendBuff[23] = 0x03;
	SendBuff[24] = 0x03;
	SendBuff[25] = 0x03;
	SendBuff[26] = 0x03;
	SendBuff[27] = 0x8D;
	SendBuff[28] = 0x02;
	SendBuff[29] = 0x41;
	SendBuff[30] = 0x03;
	SendBuff[31] = 0x80;
	SendBuff[32] = 0x02;
	SendBuff[33] = 0x03;
	SendBuff[34] = 0x20;
	SendBuff[35] = 0xAB;
	SendBuff[36] = 0x0B;
	SendBuff[37] = 0x84;
	SendBuff[38] = 0x01;
	SendBuff[39] = 0x88;
	SendBuff[40] = 0xA4;
	SendBuff[41] = 0x06;
	SendBuff[42] = 0x83;
	SendBuff[43] = 0x01;
	SendBuff[44] = 0x81;
	SendBuff[45] = 0x95;
	SendBuff[46] = 0x01;
	SendBuff[47] = 0xFF;

	SendLen = 48;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Creating DF failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	pParent->ClearBuffers();
	//Create Key File EF2
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE0;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x1D;
	SendBuff[5] = 0x62;
	SendBuff[6] = 0x1B;
	SendBuff[7] = 0x82;
	SendBuff[8] = 0x05;
	SendBuff[9] = 0x0C;
	SendBuff[10] = 0x41;
	SendBuff[11] = 0x00;
	SendBuff[12] = 0x16;
	SendBuff[13] = 0x08;
	SendBuff[14] = 0x83;
	SendBuff[15] = 0x02;
	SendBuff[16] = 0x11;
	SendBuff[17] = 0x01;
	SendBuff[18] = 0x88;
	SendBuff[19] = 0x01;
	SendBuff[20] = 0x02;
	SendBuff[21] = 0x8A;
	SendBuff[22] = 0x01;
	SendBuff[23] = 0x01;
	SendBuff[24] = 0x8C;
	SendBuff[25] = 0x08;
	SendBuff[26] = 0x7F;
	SendBuff[27] = 0x03;
	SendBuff[28] = 0x03;
	SendBuff[29] = 0x03;
	SendBuff[30] = 0x03;
	SendBuff[31] = 0x03;
	SendBuff[32] = 0x03;
	SendBuff[33] = 0x03;

	SendLen = 34;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Creating EF2 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	//Acquires the Global SAM PIN and assigns to Global array
	tbGlobal.GetWindowText( tempstr );
	count = 0;
	for (i = 0; i <= (int)( ( strlen( tempstr ) / 2 ) - 1 ); i++)
	{
		tempstr2 = tempstr.Mid(count, 2);
		tempstr2 = "0x" + tempstr2;

		sscanf(tempstr2, "%02X", &Buffer[i]);
		count = count + 2;
	}

	//Append Record To EF2, Define 8 Key Records in EF2 - Master Keys
    //1st Master key, key ID=81, key type=03, int/ext authenticate, usage counter = FF FF
	pParent->ClearBuffers();
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE2;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x16;
	SendBuff[5] = 0x81; //KeyID
	SendBuff[6] = 0x03;
	SendBuff[7] = 0xFF;
	SendBuff[8] = 0xFF;
	SendBuff[9] = 0x88;
	SendBuff[10] = 0x00;

	tbIssuer.GetWindowText( tempstr );
	count = 0;
	for (i = 0; i <= (int)((strlen(tempstr)/2)-1); i++)
	{
        tempstr2 = tempstr.Mid(count, 2);
		tempstr2 = "0x" + tempstr2;

		sscanf(tempstr2, "%02X", &SendBuff[i+11]);
		count = count + 2;
	}

	SendLen = 19;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Appending Issuer Key to EF2 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	//2nd Master key, key ID=82, key type=03, int/ext authenticate, usage counter = FF FF
	pParent->ClearBuffers();
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE2;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x16;
	SendBuff[5] = 0x82; //KeyID
	SendBuff[6] = 0x03;
	SendBuff[7] = 0xFF;
	SendBuff[8] = 0xFF;
	SendBuff[9] = 0x88;
	SendBuff[10] = 0x00;

	tbCard.GetWindowText( tempstr );
	count = 0;
	for (i = 0; i <= (int)((strlen(tempstr)/2)-1); i++)
	{
        tempstr2 = tempstr.Mid(count, 2);
		tempstr2 = "0x" + tempstr2;

		sscanf(tempstr2, "%02X", &SendBuff[i+11]);
		count = count + 2;
	}

	SendLen = 19;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Appending Card Key to EF2 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	//3rd Master key, key ID=83, key type=03, int/ext authenticate, usage counter = FF FF
	pParent->ClearBuffers();
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE2;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x16;
	SendBuff[5] = 0x83; //KeyID
	SendBuff[6] = 0x03;
	SendBuff[7] = 0xFF;
	SendBuff[8] = 0xFF;
	SendBuff[9] = 0x88;
	SendBuff[10] = 0x00;

	tbTerm.GetWindowText( tempstr );
	count = 0;
	for (i = 0; i <= (int)((strlen(tempstr)/2)-1); i++)
	{
        tempstr2 = tempstr.Mid(count, 2);
		tempstr2 = "0x" + tempstr2;

		sscanf(tempstr2, "%02X", &SendBuff[i+11]);
		count = count + 2;
	}

	SendLen = 19;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Appending Terminal Key to EF2 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	//4th Master key, key ID=84, key type=03, int/ext authenticate, usage counter = FF FF
	pParent->ClearBuffers();
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE2;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x16;
	SendBuff[5] = 0x84; //KeyID
	SendBuff[6] = 0x03;
	SendBuff[7] = 0xFF;
	SendBuff[8] = 0xFF;
	SendBuff[9] = 0x88;
	SendBuff[10] = 0x00;

	tbDebit.GetWindowText( tempstr );
	count = 0;
	for (i = 0; i <= (int)((strlen(tempstr)/2)-1); i++)
	{
        tempstr2 = tempstr.Mid(count, 2);
		tempstr2 = "0x" + tempstr2;

		sscanf(tempstr2, "%02X", &SendBuff[i+11]);
		count = count + 2;
	}

	SendLen = 19;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Appending Debit Key to EF2 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	//5th Master key, key ID=85, key type=03, int/ext authenticate, usage counter = FF FF
	pParent->ClearBuffers();
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE2;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x16;
	SendBuff[5] = 0x85; //KeyID
	SendBuff[6] = 0x03;
	SendBuff[7] = 0xFF;
	SendBuff[8] = 0xFF;
	SendBuff[9] = 0x88;
	SendBuff[10] = 0x00;

	tbCredit.GetWindowText( tempstr );
	count = 0;
	for (i = 0; i <= (int)((strlen(tempstr)/2)-1); i++)
	{
        tempstr2 = tempstr.Mid(count, 2);
		tempstr2 = "0x" + tempstr2;

		sscanf(tempstr2, "%02X", &SendBuff[i+11]);
		count = count + 2;
	}

	SendLen = 19;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Appending Credit Key to EF2 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	//'6th Master key, key ID=86, key type=03, int/ext authenticate, usage counter = FF FF
	pParent->ClearBuffers();
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE2;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x16;
	SendBuff[5] = 0x86; //KeyID
	SendBuff[6] = 0x03;
	SendBuff[7] = 0xFF;
	SendBuff[8] = 0xFF;
	SendBuff[9] = 0x88;
	SendBuff[10] = 0x00;

	tbCert.GetWindowText( tempstr );
	count = 0;
	for (i = 0; i <= (int)((strlen(tempstr)/2)-1); i++)
	{
        tempstr2 = tempstr.Mid(count, 2);
		tempstr2 = "0x" + tempstr2;

		sscanf(tempstr2, "%02X", &SendBuff[i+11]);
		count = count + 2;
	}

	SendLen = 19;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Appending Certify Key to EF2 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	//'7th Master key, key ID=87, key type=03, int/ext authenticate, usage counter = FF FF
	pParent->ClearBuffers();
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xE2;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x16;
	SendBuff[5] = 0x87; //KeyID
	SendBuff[6] = 0x03;
	SendBuff[7] = 0xFF;
	SendBuff[8] = 0xFF;
	SendBuff[9] = 0x88;
	SendBuff[10] = 0x00;

	tbRevoke.GetWindowText( tempstr );
	count = 0;
	for (i = 0; i <= (int)((strlen(tempstr)/2)-1); i++)
	{
        tempstr2 = tempstr.Mid(count, 2);
		tempstr2 = "0x" + tempstr2;

		sscanf(tempstr2, "%02X", &SendBuff[i+11]);
		count = count + 2;
	}

	SendLen = 19;
	RecvLen = 255;
	retCode = pParent->SendAPDU( 1 );
	if( retCode != 0 || RecvBuff[0] != 0x90 )
	{
		pParent->DisplayOut( "Appending Revoke Debit Key to EF2 failed\n", RED );
		pSAM->EndDialog(IDOK);
		return;
	}

	pParent->DisplayOut( "Initializing SAM Success\n", GREEN );
	pSAM->EndDialog(IDOK);
}

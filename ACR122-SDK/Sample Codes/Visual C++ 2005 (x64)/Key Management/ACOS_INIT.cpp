// ACOS_INIT.cpp : implementation file
//

#include "stdafx.h"
#include "Key Management.h"
#include "Key ManagementDlg.h"
#include "ACOS_INIT.h"

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
BYTE UID[4];
ACOS_INIT *pINIT = NULL;
CKeyManagementDlg *pPar;

/////////////////////////////////////////////////////////////////////////////
// ACOS_INIT dialog


ACOS_INIT::ACOS_INIT(CWnd* pParent /*=NULL*/)
	: CDialog(ACOS_INIT::IDD, pParent)
{
	//{{AFX_DATA_INIT(ACOS_INIT)
	//}}AFX_DATA_INIT
}


void ACOS_INIT::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(ACOS_INIT)
	DDX_Control(pDX, IDC_RADIO2, rbB);
	DDX_Control(pDX, IDC_RADIO1, rbA);
	DDX_Control(pDX, IDC_EDIT15, tb6);
	DDX_Control(pDX, IDC_EDIT14, tb5);
	DDX_Control(pDX, IDC_EDIT13, tb4);
	DDX_Control(pDX, IDC_EDIT12, tb3);
	DDX_Control(pDX, IDC_EDIT11, tb2);
	DDX_Control(pDX, IDC_EDIT10, tb1);
	DDX_Control(pDX, IDC_CHECK6, cb6);
	DDX_Control(pDX, IDC_CHECK5, cb5);
	DDX_Control(pDX, IDC_CHECK4, cb4);
	DDX_Control(pDX, IDC_CHECK3, cb3);
	DDX_Control(pDX, IDC_CHECK2, cb2);
	DDX_Control(pDX, IDC_CHECK1, cb1);
	DDX_Control(pDX, IDC_BUTTON5, btnSave);
	DDX_Control(pDX, IDC_BUTTON1, btnGen);
	DDX_Control(pDX, IDC_EDIT8, tbKrd);
	DDX_Control(pDX, IDC_EDIT7, tbKcf);
	DDX_Control(pDX, IDC_EDIT6, tbKcr);
	DDX_Control(pDX, IDC_EDIT5, tbKd);
	DDX_Control(pDX, IDC_EDIT4, tbKt);
	DDX_Control(pDX, IDC_EDIT3, tbKc);
	DDX_Control(pDX, IDC_EDIT2, tbIC);
	DDX_Control(pDX, IDC_EDIT1, tbSerial);
	//}}AFX_DATA_MAP
}

BOOL ACOS_INIT::OnInitDialog()
{
	CDialog::OnInitDialog();

	pINIT = this;
	pPar = (CKeyManagementDlg *)pINIT->GetParent();

	tbSerial.SetWindowText( "" );
	tbIC.SetWindowText( "" );
	tbKc.SetWindowText( "" );
	tbKt.SetWindowText( "" );
	tbKd.SetWindowText( "" );
	tbKcr.SetWindowText( "" );
	tbKcf.SetWindowText( "" );
	tbKrd.SetWindowText( "" );

	rbA.SetCheck( 1 );
	rbB.SetCheck( 0 );

	return TRUE;  // return TRUE  unless you set the focus to a control
}

BEGIN_MESSAGE_MAP(ACOS_INIT, CDialog)
	//{{AFX_MSG_MAP(ACOS_INIT)
	ON_BN_CLICKED(IDC_BUTTON1, OnGenKeys)
	ON_BN_CLICKED(IDC_BUTTON5, OnSaveKeys)
	ON_BN_CLICKED(IDC_RADIO1, OnKeyA)
	ON_BN_CLICKED(IDC_RADIO2, OnKeyB)
	ON_BN_CLICKED(IDC_BUTTON2, OnCancel)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// ACOS_INIT message handlers

//Read block selected from mifare
void SaveKey( BYTE BlockNo, int keytype )
{
	char tempstr[255], keyin[255], tempkey[255];
	UINT i, k, tempval;

	BlockNo = ( BlockNo * 4 ) + 3;

	pPar->ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0x60;
	SendBuff[4] = BlockNo;
	SendBuff[5] = 0xFF;
	SendBuff[6] = 0xFF;
	SendBuff[7] = 0xFF;
	SendBuff[8] = 0xFF;
	SendBuff[9] = 0xFF;
	SendBuff[10] = 0xFF;
	
	memcpy( &SendBuff[11], UID, 4 );

	SendLen = 15;
	RecvLen = 255;

	retCode = pPar->SendAPDU( 0 );
	if( retCode != 0 )
	{
		pPar->DisplayOut( "Error in saving Key\n", RED );
		pINIT->EndDialog(IDOK);
	}
	else
	{
		if( RecvBuff[2] != 0x00 )
		{
			pPar->DisplayOut( "Error in saving Key\n", RED );
			pINIT->EndDialog(IDOK);
		}
	}

	pPar->ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0x30;
	SendBuff[4] = BlockNo;

	SendLen = 5;
	RecvLen = 255;

	retCode = pPar->SendAPDU( 0 );
	if( retCode != 0 )
	{
		pPar->DisplayOut( "Error in saving Key\n", RED );
		pINIT->EndDialog(IDOK);
	}
	else
	{
		if( RecvLen < 4 )
		{
			pPar->DisplayOut( "Error in saving Key\n", RED );
			pINIT->EndDialog(IDOK);
		}

		sprintf( tempstr, "" );

		for( i = 3; i < RecvLen; i++ )
		{
			sprintf( tempstr, "%s%02X", tempstr, RecvBuff[i] );
		}
	}

	switch( keytype )
	{
		case 1:
			pINIT->tbKc.GetWindowText( keyin, 20 );
			break;
		case 2:
			pINIT->tbKt.GetWindowText( keyin, 20 );
			break;
		case 3:
			pINIT->tbKd.GetWindowText( keyin, 20 );
			break;
		case 4:
			pINIT->tbKcr.GetWindowText( keyin, 20 );
			break;
		case 5:
			pINIT->tbKcf.GetWindowText( keyin, 20 );
			break;
		case 6:
			pINIT->tbKrd.GetWindowText( keyin, 20 );
			break;
		default:
			pPar->DisplayOut( "Error in saving Key\n", RED );
			pINIT->EndDialog(IDOK);
			break;
	}

	if( pINIT->rbA.GetCheck() )
	{
		for( i = 0, k = 0; i < 32; i+=2, k++ )
		{
			memset( tempkey, 0x00, 20 );

			if( i < 12 )
			{
				sprintf( tempkey, "%c", keyin[i] );
				sprintf( tempkey, "%s%c", tempkey, keyin[i+1] );
			}
			else
			{
				sprintf( tempkey, "%c", tempstr[i] );
				sprintf( tempkey, "%s%c", tempkey, tempstr[i+1] );
			}
			sscanf( tempkey, "%02X", &tempval );
			RecvBuff[k] = tempval;
		}
	}
	else
	{
		for( i = 0, k = 0; i < 32; i+=2, k++ )
		{
			memset( tempkey, 0x00, 20 );

			if( i < 20 )
			{
				sprintf( tempkey, "%c", tempstr[i] );
				sprintf( tempkey, "%s%c", tempkey, tempstr[i+1] );
			}
			else
			{
				sprintf( tempkey, "%c", keyin[i-20] );
				sprintf( tempkey, "%s%c", tempkey, keyin[i-19] );
			}
			sscanf( tempkey, "%02X", &tempval );
			RecvBuff[k] = tempval;
		}
	}

	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x40;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0xA0;
	SendBuff[4] = BlockNo;

	memcpy( &SendBuff[5], RecvBuff, 16 );

	SendLen = 21;
	RecvLen = 255;

	retCode = pPar->SendAPDU( 0 );
	if( retCode != 0 )
	{
		pPar->DisplayOut( "Error in saving Key\n", RED );
		pINIT->EndDialog(IDOK);
	}
}

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

CString GenerateSAMKey( BYTE KeyId )
{
	int i;
	char buff[20];

	pPar->ClearBuffers();
	SendBuff[0] = 0x80;
    SendBuff[1] = 0x88;
    SendBuff[2] = 0x00;
    SendBuff[3] = KeyId; //KeyID
    SendBuff[4] = 0x08;

	for( i = 0; i < 4; i++ )
	{
		SendBuff[i+5] = UID[i];
	}

	SendLen = 13;
	RecvLen = 255;

	retCode = pPar->SendAPDU( 1 );
	if( retCode != 0 )
	{
		pPar->DisplayOut( "Error in generating Key\n", RED );
		pINIT->EndDialog(IDOK);
	}

	pPar->ClearBuffers();
	SendBuff[0] = 0x00;
    SendBuff[1] = 0xC0;
    SendBuff[2] = 0x00;
    SendBuff[3] = 0x00;
    SendBuff[4] = 0x08;

	SendLen = 5;
	RecvLen = 255;

	retCode = pPar->SendAPDU( 1 );
	if( retCode != 0 )
	{
		pPar->DisplayOut( "Error in generating Key\n", RED );
		pINIT->EndDialog(IDOK);
	}
	else
	{
		sprintf( buff, "" );
		if( RecvBuff[RecvLen-2] == 0x90 && RecvBuff[RecvLen-1] == 0x00 )
		{
			//Get only 1st 6 bytes as key
			for( i = 0; i < 6; i++ )
			{
				sprintf( buff, "%s%02X", buff, RecvBuff[i] );
			}
		}
	}
	
	return buff;
}

void ACOS_INIT::OnGenKeys() 
{
	char serial[10];
	int i;
	CString key;

	pPar->ClearBuffers();
	SendBuff[0] = 0xD4;
	SendBuff[1] = 0x4A;
	SendBuff[2] = 0x01;
	SendBuff[3] = 0x00;

	SendLen = 4;
	RecvLen = 255;

	retCode = pPar->SendAPDU( 0 );
	if( retCode != 0 )
	{
		pPar->DisplayOut( "Failed to get card serial number\n", RED );
		CDialog::OnOK();
	}
	else
	{
		for( i = 8; i < RecvBuff[7] + 8; i++ )
		{
			UID[i - 8] = RecvBuff[i];
		}

		sprintf( serial, "" );
		for( i = 0; i < 4; i++ )
		{
			sprintf( serial, "%s %02X", serial, UID[i] );
		}
	}

	pINIT->tbSerial.SetWindowText( serial );

	//Select Issuer DF
	SendBuff[0] = 0x00;
	SendBuff[1] = 0xA4;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x00;
	SendBuff[4] = 0x02;
	SendBuff[5] = 0x11;
	SendBuff[6] = 0x00;

	SendLen = 7;
	RecvLen = 255;

	retCode = pPar->SendAPDU( 1 );
	if( retCode != 0 )
	{
		pPar->DisplayOut( "Failed to select issuer DF\n", RED );
		CDialog::OnOK();
	}

	//Submit Issuer PIN 
	SendBuff[0] = 0x00;
	SendBuff[1] = 0x20;
	SendBuff[2] = 0x00;
	SendBuff[3] = 0x01;
	SendBuff[4] = 0x08;

	for( i = 0; i < 8; i++ )
	{
		SendBuff[i+4] = Buffer[i];
	}

	SendLen = 13;
	RecvLen = 255;

	retCode = pPar->SendAPDU( 1 );
	if( retCode != 0 )
	{
		pPar->DisplayOut( "Failed to submit issuer PIN\n", RED );
		CDialog::OnOK();
	}

	//Generate Key 
    //Generate IC Using 1st SAM Master Key (KeyID=81)    
	key = GenerateSAMKey( 0x81 );
	if ( strcmp( key, "" ) == 0 )
	{
		pPar->DisplayOut( "Failed to obtain IC Key\n", RED );
		CDialog::OnOK();
	}
	else
	{
		pINIT->tbIC.SetWindowText( key );
	}

	//Generate Card Key Using 2nd SAM Master Key (KeyID=82)    
	key = GenerateSAMKey( 0x82 );
	if ( strcmp( key, "" ) == 0 )
	{
		pPar->DisplayOut( "Failed to obtain Card Key\n", RED );
		CDialog::OnOK();
	}
	else
	{
		pINIT->tbKc.SetWindowText( key );
	}

	//Generate Terminal Key Using 3rd SAM Master Key (KeyID=83)    
	key = GenerateSAMKey( 0x83 );
	if ( strcmp( key, "" ) == 0 )
	{
		pPar->DisplayOut( "Failed to obtain Terminal Key\n", RED );
		CDialog::OnOK();
	}
	else
	{
		pINIT->tbKt.SetWindowText( key );
	}

	//Generate Debit Key Using 4th SAM Master Key (KeyID=84)    
	key = GenerateSAMKey( 0x84 );
	if ( strcmp( key, "" ) == 0 )
	{
		pPar->DisplayOut( "Failed to obtain Debit Key\n", RED );
		CDialog::OnOK();
	}
	else
	{
		pINIT->tbKd.SetWindowText( key );
	}

	//Generate Credit Key Using 5th SAM Master Key (KeyID=85)    
	key = GenerateSAMKey( 0x85 );
	if ( strcmp( key, "" ) == 0 )
	{
		pPar->DisplayOut( "Failed to obtain Credit Key\n", RED );
		CDialog::OnOK();
	}
	else
	{
		pINIT->tbKcr.SetWindowText( key );
	}

	//Generate Certify Key Using 6th SAM Master Key (KeyID=86)    
	key = GenerateSAMKey( 0x86 );
	if ( strcmp( key, "" ) == 0 )
	{
		pPar->DisplayOut( "Failed to obtain Certify Key\n", RED );
		CDialog::OnOK();
	}
	else
	{
		pINIT->tbKcf.SetWindowText( key );
	}

	//Generate Revoke Debit Key Using 7th SAM Master Key (KeyID=87)    
	key = GenerateSAMKey( 0x87 );
	if ( strcmp( key, "" ) == 0 )
	{
		pPar->DisplayOut( "Failed to obtain Revoke Debit Key\n", RED );
		CDialog::OnOK();
	}
	else
	{
		pINIT->tbKrd.SetWindowText( key );
	}
}

void ACOS_INIT::OnSaveKeys() 
{
	CString tempstr;
	BYTE Block;

	retCode = MessageBox( "Saving keys to Mifare assumes that the keys stored is \"FF FF FF FF FF FF\". Continue?", "", MB_OKCANCEL);
	if( retCode == IDCANCEL )
	{
		return;
	}
	
	if( cb1.GetCheck() )
	{
		tbKc.GetWindowText( tempstr );
		if( tempstr.IsEmpty() )
		{
			AfxMessageBox( "No Card Key generated" );
			return;
		}

		tb1.GetWindowText( tempstr );
		if( tempstr.IsEmpty() || HexCheck( tempstr.GetAt(0), tempstr.GetAt(1) ) != 0 )
		{
			AfxMessageBox( "Enter valid value for block number" );
			tb1.SetFocus();
			return;
		}
	}

	if( cb2.GetCheck() )
	{
		tbKt.GetWindowText( tempstr );
		if( tempstr.IsEmpty() )
		{
			AfxMessageBox( "No Terminal Key generated" );
			return;
		}

		tb2.GetWindowText( tempstr );
		if( tempstr.IsEmpty() || HexCheck( tempstr.GetAt(0), tempstr.GetAt(1) ) != 0 )
		{
			AfxMessageBox( "Enter valid value for block number" );
			tb1.SetFocus();
			return;
		}
	}

	if( cb3.GetCheck() )
	{
		tbKd.GetWindowText( tempstr );
		if( tempstr.IsEmpty() )
		{
			AfxMessageBox( "No Debit Key generated" );
			return;
		}

		tb3.GetWindowText( tempstr );
		if( tempstr.IsEmpty() || HexCheck( tempstr.GetAt(0), tempstr.GetAt(1) ) != 0 )
		{
			AfxMessageBox( "Enter valid value for block number" );
			tb1.SetFocus();
			return;
		}
	}

	if( cb4.GetCheck() )
	{
		tbKcr.GetWindowText( tempstr );
		if( tempstr.IsEmpty() )
		{
			AfxMessageBox( "No Credit Key generated" );
			return;
		}

		tb4.GetWindowText( tempstr );
		if( tempstr.IsEmpty() || HexCheck( tempstr.GetAt(0), tempstr.GetAt(1) ) != 0 )
		{
			AfxMessageBox( "Enter valid value for block number" );
			tb1.SetFocus();
			return;
		}
	}

	if( cb5.GetCheck() )
	{
		tbKcf.GetWindowText( tempstr );
		if( tempstr.IsEmpty() )
		{
			AfxMessageBox( "No Certify Key generated" );
			return;
		}

		tb5.GetWindowText( tempstr );
		if( tempstr.IsEmpty() || HexCheck( tempstr.GetAt(0), tempstr.GetAt(1) ) != 0 )
		{
			AfxMessageBox( "Enter valid value for block number" );
			tb1.SetFocus();
			return;
		}
	}

	if( cb6.GetCheck() )
	{
		tbKrd.GetWindowText( tempstr );
		if( tempstr.IsEmpty() )
		{
			AfxMessageBox( "No Revoke Debit Key generated" );
			return;
		}

		tb6.GetWindowText( tempstr );
		if( tempstr.IsEmpty() || HexCheck( tempstr.GetAt(0), tempstr.GetAt(1) ) != 0 )
		{
			AfxMessageBox( "Enter valid value for block number" );
			tb1.SetFocus();
			return;
		}
	}

	if( cb1.GetCheck() )
	{
		tb1.GetWindowText( tempstr );
		sscanf( tempstr, "%02X", &Block );
		SaveKey( Block, 1 );
	}

	if( cb2.GetCheck() )
	{
		tb2.GetWindowText( tempstr );
		sscanf( tempstr, "%02X", &Block );
		SaveKey( Block, 2 );
	}

	if( cb3.GetCheck() )
	{
		tb3.GetWindowText( tempstr );
		sscanf( tempstr, "%02X", &Block );
		SaveKey( Block, 3 );
	}

	if( cb4.GetCheck() )
	{
		tb4.GetWindowText( tempstr );
		sscanf( tempstr, "%02X", &Block );
		SaveKey( Block, 4 );
	}

	if( cb5.GetCheck() )
	{
		tb5.GetWindowText( tempstr );
		sscanf( tempstr, "%02X", &Block );
		SaveKey( Block, 5 );
	}

	if( cb6.GetCheck() )
	{
		tb6.GetWindowText( tempstr );
		sscanf( tempstr, "%02X", &Block );
		SaveKey( Block, 6 );
	}

	pPar->DisplayOut( "Save keys success\n",GREEN );
	CDialog::OnOK();
}

void ACOS_INIT::OnKeyA() 
{
	rbB.SetCheck( 0 );	
}

void ACOS_INIT::OnKeyB() 
{
	rbA.SetCheck( 0 );	
}

void ACOS_INIT::OnCancel() 
{
	CDialog::OnCancel();	
}

// Key ManagementDlg.h : header file
//

#if !defined(AFX_KEYMANAGEMENTDLG_H__160F6196_28A0_4C81_A59B_05C52B8F66E0__INCLUDED_)
#define AFX_KEYMANAGEMENTDLG_H__160F6196_28A0_4C81_A59B_05C52B8F66E0__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CKeyManagementDlg dialog

class CKeyManagementDlg : public CDialog
{
// Construction
public:
	CKeyManagementDlg(CWnd* pParent = NULL);	// standard constructor
	void DisplayOut( CString str, COLORREF color );
	int SendAPDU( int type );
	void ClearBuffers();

// Dialog Data
	//{{AFX_DATA(CKeyManagementDlg)
	enum { IDD = IDD_KEYMANAGEMENT_DIALOG };
	CButton	btnGen;
	CButton	btnInitSAM;
	CButton	btnICCon;
	CRichEditCtrl	mMsg;
	CComboBox	cbPort;
	CButton	btnConnect;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CKeyManagementDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON 	m_hIconBig,
		m_hIconSmall;

	// Generated message map functions
	//{{AFX_MSG(CKeyManagementDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnConnect();
	afx_msg void OnICCon();
	afx_msg void OnInitSAM();
	afx_msg void OnGen();
	afx_msg void OnClear();
	afx_msg void OnReset();
	afx_msg void OnQuit();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//Defines
#define BLACK RGB(0, 0, 0)
#define RED RGB(255, 0, 0)
#define GREEN RGB(0, 0x99, 0)

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_KEYMANAGEMENTDLG_H__160F6196_28A0_4C81_A59B_05C52B8F66E0__INCLUDED_)

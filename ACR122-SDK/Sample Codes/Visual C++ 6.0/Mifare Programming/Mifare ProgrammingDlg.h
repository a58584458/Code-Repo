// Mifare ProgrammingDlg.h : header file
//

#if !defined(AFX_MIFAREPROGRAMMINGDLG_H__0EDDAF1F_B0A9_4D55_8B94_6CAA71048618__INCLUDED_)
#define AFX_MIFAREPROGRAMMINGDLG_H__0EDDAF1F_B0A9_4D55_8B94_6CAA71048618__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CMifareProgrammingDlg dialog

class CMifareProgrammingDlg : public CDialog
{
// Construction
public:
	CMifareProgrammingDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CMifareProgrammingDlg)
	enum { IDD = IDD_MIFAREPROGRAMMING_DIALOG };
	CButton	btnQuit;
	CButton	btnReset;
	CButton	btnClear;
	CButton	btnCopy;
	CButton	btnDec;
	CButton	btnInc;
	CButton	btnReadVal;
	CButton	btnStoreVal;
	CEdit	tbTarget;
	CEdit	tbSource;
	CEdit	tbValueBlockNo;
	CEdit	tbValue;
	CButton	btnUpdate;
	CButton	btnRead;
	CEdit	tbData;
	CEdit	tbBinaryBlockNo;
	CButton	btnAuthen;
	CEdit	tbKey6;
	CEdit	tbKey5;
	CEdit	tbKey4;
	CEdit	tbKey3;
	CEdit	tbKey2;
	CEdit	tbKey1;
	CEdit	tbBlockNo;
	CButton	rbTypeB;
	CButton	rbTypeA;
	CButton	btnLoad;
	CEdit	tbLoadKey6;
	CEdit	tbLoadKey5;
	CEdit	tbLoadKey4;
	CEdit	tbLoadKey3;
	CEdit	tbLoadKey2;
	CEdit	tbLoadKey1;
	CEdit	tbLoadKeyStore;
	CRichEditCtrl	mMsg;
	CButton	btnConnect;
	CComboBox	cbPort;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CMifareProgrammingDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON 	m_hIconBig,
		m_hIconSmall;

	// Generated message map functions
	//{{AFX_MSG(CMifareProgrammingDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnConnect();
	afx_msg void OnLoadKeys();
	afx_msg void OnTypeA();
	afx_msg void OnTypeB();
	afx_msg void OnAuthen();
	afx_msg void OnUpdate();
	afx_msg void OnRead();
	afx_msg void OnStoreVal();
	afx_msg void OnReadVal();
	afx_msg void OnInc();
	afx_msg void OnDec();
	afx_msg void OnRestore();
	afx_msg void OnCopy();
	afx_msg void OnReset();
	afx_msg void OnQuit();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_MIFAREPROGRAMMINGDLG_H__0EDDAF1F_B0A9_4D55_8B94_6CAA71048618__INCLUDED_)

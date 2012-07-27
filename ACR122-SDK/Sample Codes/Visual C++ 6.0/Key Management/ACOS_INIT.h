#if !defined(AFX_ACOS_INIT_H__A5FE421C_FDDB_4FB7_8F7C_67D506FDB600__INCLUDED_)
#define AFX_ACOS_INIT_H__A5FE421C_FDDB_4FB7_8F7C_67D506FDB600__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// ACOS_INIT.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// ACOS_INIT dialog

class ACOS_INIT : public CDialog
{
// Construction
public:
	ACOS_INIT(CWnd* pParent = NULL);   // standard constructor
	BOOL OnInitDialog();

// Dialog Data
	//{{AFX_DATA(ACOS_INIT)
	enum { IDD = IDD_MIFARE_INIT_DIALOG };
	CButton	rbB;
	CButton	rbA;
	CEdit	tb6;
	CEdit	tb5;
	CEdit	tb4;
	CEdit	tb3;
	CEdit	tb2;
	CEdit	tb1;
	CButton	cb6;
	CButton	cb5;
	CButton	cb4;
	CButton	cb3;
	CButton	cb2;
	CButton	cb1;
	CButton	btnSave;
	CButton	btnGen;
	CEdit	tbKrd;
	CEdit	tbKcf;
	CEdit	tbKcr;
	CEdit	tbKd;
	CEdit	tbKt;
	CEdit	tbKc;
	CEdit	tbIC;
	CEdit	tbSerial;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(ACOS_INIT)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(ACOS_INIT)
	afx_msg void OnGenKeys();
	afx_msg void OnSaveKeys();
	afx_msg void OnKeyA();
	afx_msg void OnKeyB();
	afx_msg void OnCancel();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_ACOS_INIT_H__A5FE421C_FDDB_4FB7_8F7C_67D506FDB600__INCLUDED_)

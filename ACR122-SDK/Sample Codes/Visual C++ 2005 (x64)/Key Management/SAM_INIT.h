#if !defined(AFX_SAM_INIT_H__261C6D0B_85B5_446B_9CC8_DF677A41D587__INCLUDED_)
#define AFX_SAM_INIT_H__261C6D0B_85B5_446B_9CC8_DF677A41D587__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// SAM_INIT.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// SAM_INIT dialog

class SAM_INIT : public CDialog
{
// Construction
public:
	SAM_INIT(CWnd* pParent = NULL);   // standard constructor
	BOOL OnInitDialog();

// Dialog Data
	//{{AFX_DATA(SAM_INIT)
	enum { IDD = IDD_SAM_INIT_DIALOG };
	CEdit	tbRevoke;
	CEdit	tbCert;
	CEdit	tbCredit;
	CEdit	tbDebit;
	CEdit	tbTerm;
	CEdit	tbCard;
	CEdit	tbIssuer;
	CButton	btnOK;
	CButton	btnCancel;
	CEdit	tbGlobal;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(SAM_INIT)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(SAM_INIT)
	afx_msg void OnInit();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_SAM_INIT_H__261C6D0B_85B5_446B_9CC8_DF677A41D587__INCLUDED_)

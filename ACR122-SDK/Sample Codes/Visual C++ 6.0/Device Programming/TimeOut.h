#if !defined(AFX_TIMEOUT_H__161023A4_899D_4C81_9BA8_7FA4FA2EFD5D__INCLUDED_)
#define AFX_TIMEOUT_H__161023A4_899D_4C81_9BA8_7FA4FA2EFD5D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
// TimeOut.h : header file
//

/////////////////////////////////////////////////////////////////////////////
// TimeOut dialog

class TimeOut : public CDialog
{
// Construction
public:
	TimeOut(CWnd* pParent = NULL);   // standard constructor
	BOOL OnInitDialog();

// Dialog Data
	//{{AFX_DATA(TimeOut)
	enum { IDD = IDD_DIALOG1 };
	CEdit	tbRespRe;
	CEdit	tbRespTO;
	CEdit	tbStatRe;
	CEdit	tbStatTO;
	CButton	btnCancel;
	CButton	btnOK;
	//}}AFX_DATA


// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(TimeOut)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:

	// Generated message map functions
	//{{AFX_MSG(TimeOut)
	virtual void OnOK();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_TIMEOUT_H__161023A4_899D_4C81_9BA8_7FA4FA2EFD5D__INCLUDED_)

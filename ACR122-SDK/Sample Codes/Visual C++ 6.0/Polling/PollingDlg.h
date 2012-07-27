// PollingDlg.h : header file
//

#if !defined(AFX_POLLINGDLG_H__C0CFB42C_7980_4364_A64B_C73E9093E82D__INCLUDED_)
#define AFX_POLLINGDLG_H__C0CFB42C_7980_4364_A64B_C73E9093E82D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CPollingDlg dialog

class CPollingDlg : public CDialog
{
// Construction
public:
	CPollingDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(CPollingDlg)
	enum { IDD = IDD_POLLING_DIALOG };
	CButton	btnQuit;
	CButton	btnPolling;
	CButton	btnConnect;
	CComboBox	cbPort;
	CStatusBar m_bar;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPollingDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON 	m_hIconBig,
		m_hIconSmall;

	// Generated message map functions
	//{{AFX_MSG(CPollingDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnConnect();
	afx_msg void OnPolling();
	afx_msg void OnQuit();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_POLLINGDLG_H__C0CFB42C_7980_4364_A64B_C73E9093E82D__INCLUDED_)

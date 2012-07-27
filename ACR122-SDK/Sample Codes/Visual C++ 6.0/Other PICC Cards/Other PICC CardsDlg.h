// Other PICC CardsDlg.h : header file
//

#if !defined(AFX_OTHERPICCCARDSDLG_H__2FCF66DF_2478_4894_A4B8_65572F86A34D__INCLUDED_)
#define AFX_OTHERPICCCARDSDLG_H__2FCF66DF_2478_4894_A4B8_65572F86A34D__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// COtherPICCCardsDlg dialog

class COtherPICCCardsDlg : public CDialog
{
// Construction
public:
	COtherPICCCardsDlg(CWnd* pParent = NULL);	// standard constructor

// Dialog Data
	//{{AFX_DATA(COtherPICCCardsDlg)
	enum { IDD = IDD_OTHERPICCCARDS_DIALOG };
	CButton	btnQuit;
	CButton	btnReset;
	CButton	btnClear;
	CRichEditCtrl	mMsg;
	CEdit	tbCommand;
	CButton	btnSend;
	CComboBox	cbPort;
	CButton	btnConnect;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(COtherPICCCardsDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON 	m_hIconBig,
		m_hIconSmall;

	// Generated message map functions
	//{{AFX_MSG(COtherPICCCardsDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnConnect();
	afx_msg void OnSend();
	afx_msg void OnClear();
	afx_msg void OnReset();
	afx_msg void OnQuit();
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_OTHERPICCCARDSDLG_H__2FCF66DF_2478_4894_A4B8_65572F86A34D__INCLUDED_)

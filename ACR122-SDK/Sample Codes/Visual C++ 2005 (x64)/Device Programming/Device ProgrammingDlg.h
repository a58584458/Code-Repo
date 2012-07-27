// Device ProgrammingDlg.h : header file
//
#include "acr122.h"
#if !defined(AFX_DEVICEPROGRAMMINGDLG_H__DEFCE61C_9ED9_4428_A651_FD5F669D9345__INCLUDED_)
#define AFX_DEVICEPROGRAMMINGDLG_H__DEFCE61C_9ED9_4428_A651_FD5F669D9345__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

/////////////////////////////////////////////////////////////////////////////
// CDeviceProgrammingDlg dialog

class CDeviceProgrammingDlg : public CDialog
{
// Construction
public:
	CDeviceProgrammingDlg(CWnd* pParent = NULL);	// standard constructor
	void DisplayOut( CString Str, COLORREF Color );	// outputs logs to richedit

// Dialog Data
	//{{AFX_DATA(CDeviceProgrammingDlg)
	enum { IDD = IDD_DEVICEPROGRAMMING_DIALOG };
	CButton	btnQuit;
	CButton	btnReset;
	CButton	btnClear;
	CButton	btnSetLEDBuzz;
	CButton	btnTimeout;
	CButton	rbL1BlinkStateOff;
	CButton	rbL1BlinkStateOn;
	CButton	rbL1fStateOff;
	CButton	rbL1fStateOn;
	CButton	cL1Blink;
	CButton	cL1Update;
	CButton	cL0Blink;
	CButton	cL0Update;
	CButton	rbL0BlinkStateOff;
	CButton	rbL0BlinkStateOn;
	CButton	rbL0fStateOff;
	CButton	rbL0fStateOn;
	CButton	cT2;
	CButton	cT1;
	CEdit	tbNum;
	CEdit	tbT2;
	CEdit	tbT1;
	CRichEditCtrl	mMsg;
	CButton	btnBaud;
	CButton	btnConnect;
	CComboBox	cbBaud;
	CComboBox	cbPort;
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CDeviceProgrammingDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);	// DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	HICON 	m_hIconBig,
		m_hIconSmall;

	// Generated message map functions
	//{{AFX_MSG(CDeviceProgrammingDlg)
	virtual BOOL OnInitDialog();
	afx_msg void OnSysCommand(UINT nID, LPARAM lParam);
	afx_msg void OnPaint();
	afx_msg HCURSOR OnQueryDragIcon();
	afx_msg void OnLed0FStateOn();
	afx_msg void OnLed0FStateOff();
	afx_msg void OnLed0BlinkStateOn();
	afx_msg void OnLed0BlinkStateOff();
	afx_msg void OnLed1fStateOn();
	afx_msg void OnLed1fStateOff();
	afx_msg void OnLed1BlinkStateOn();
	afx_msg void OnLed1BlinkStateOff();
	afx_msg void OnConnect();
	afx_msg void OnBaudRate();
	afx_msg void OnLEDBUZZ();
	afx_msg void OnTimeOut();
	afx_msg void OnClear();
	afx_msg void OnReset();
	afx_msg void OnClose();
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

#endif // !defined(AFX_DEVICEPROGRAMMINGDLG_H__DEFCE61C_9ED9_4428_A651_FD5F669D9345__INCLUDED_)

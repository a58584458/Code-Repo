// GetATR.h : main header file for the GETATR application
//

#if !defined(AFX_GETATR_H__86A97753_23BF_40CF_9D03_E5FEE5380B30__INCLUDED_)
#define AFX_GETATR_H__86A97753_23BF_40CF_9D03_E5FEE5380B30__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CGetATRApp:
// See GetATR.cpp for the implementation of this class
//

class CGetATRApp : public CWinApp
{
public:
	CGetATRApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CGetATRApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CGetATRApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_GETATR_H__86A97753_23BF_40CF_9D03_E5FEE5380B30__INCLUDED_)

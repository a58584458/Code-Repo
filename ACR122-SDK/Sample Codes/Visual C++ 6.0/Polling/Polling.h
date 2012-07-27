// Polling.h : main header file for the POLLING application
//

#if !defined(AFX_POLLING_H__B2617531_01D0_4058_B9D0_271871AF1EF5__INCLUDED_)
#define AFX_POLLING_H__B2617531_01D0_4058_B9D0_271871AF1EF5__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// main symbols

/////////////////////////////////////////////////////////////////////////////
// CPollingApp:
// See Polling.cpp for the implementation of this class
//

class CPollingApp : public CWinApp
{
public:
	CPollingApp();

// Overrides
	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CPollingApp)
	public:
	virtual BOOL InitInstance();
	//}}AFX_VIRTUAL

// Implementation

	//{{AFX_MSG(CPollingApp)
		// NOTE - the ClassWizard will add and remove member functions here.
		//    DO NOT EDIT what you see in these blocks of generated code !
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};


/////////////////////////////////////////////////////////////////////////////

//{{AFX_INSERT_LOCATION}}
// Microsoft Visual C++ will insert additional declarations immediately before the previous line.

#endif // !defined(AFX_POLLING_H__B2617531_01D0_4058_B9D0_271871AF1EF5__INCLUDED_)

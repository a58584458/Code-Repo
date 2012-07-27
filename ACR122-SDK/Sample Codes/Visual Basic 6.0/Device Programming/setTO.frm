VERSION 5.00
Begin VB.Form setTO 
   Caption         =   "Set Timeout"
   ClientHeight    =   2340
   ClientLeft      =   8490
   ClientTop       =   6150
   ClientWidth     =   3165
   Icon            =   "setTO.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2340
   ScaleWidth      =   3165
   Begin VB.CommandButton bCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1680
      TabIndex        =   9
      Top             =   1800
      Width           =   1215
   End
   Begin VB.CommandButton bOk 
      Caption         =   "OK"
      Height          =   375
      Left            =   240
      TabIndex        =   8
      Top             =   1800
      Width           =   1215
   End
   Begin VB.TextBox tRespRetries 
      Height          =   285
      Left            =   1920
      TabIndex        =   7
      Top             =   1320
      Width           =   1095
   End
   Begin VB.TextBox tRespTO 
      Height          =   285
      Left            =   1920
      TabIndex        =   6
      Top             =   960
      Width           =   1095
   End
   Begin VB.TextBox tStatRetries 
      Height          =   285
      Left            =   1920
      TabIndex        =   5
      Top             =   600
      Width           =   1095
   End
   Begin VB.TextBox tStatTO 
      Height          =   285
      Left            =   1920
      TabIndex        =   4
      Top             =   240
      Width           =   1095
   End
   Begin VB.Label lblRespRetries 
      Caption         =   "Response Rtries: "
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   1320
      Width           =   1695
   End
   Begin VB.Label lblRespTO 
      Caption         =   "Response Timeout (ms): "
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   960
      Width           =   2055
   End
   Begin VB.Label lblStatRetries 
      Caption         =   "Status Retries: "
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   1695
   End
   Begin VB.Label lblStatTO 
      Caption         =   "Status Timeout (ms): "
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   1695
   End
End
Attribute VB_Name = "setTO"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===============================================================================
'
' Company       : Advanced Card Systems, Ltd
'
' File          : setTO.frm
'
' Description   : Demonstrates Device Functions in ACR122S.
'
' Author        : M.J.E.Castillo
'
' Date          : 23 / 10 / 2009
'
' Revision Trail: (Date/Author/Description)
'
'===============================================================================


Private Sub bCancel_Click()
    devProg.Enabled = True
    Unload Me
End Sub


Private Sub bOk_Click()

Dim timeOut As ACR122_TIMEOUTS
    
    'validate input
    If tStatTO.Text = "" Then
        tStatTO.SetFocus
        Exit Sub
    End If
    
    If tStatRetries.Text = "" Then
        tStatRetries.SetFocus
        Exit Sub
    End If
    
    If tRespTO.Text = "" Then
        tRespTO.SetFocus
        Exit Sub
    End If
    
    If tRespRetries.Text = "" Then
        tRespRetries.SetFocus
        Exit Sub
    End If
    
    'place value in structure
    timeOut.statusTimeout = CLng(tStatTO.Text)
    timeOut.numStatusRetries = CLng(tStatRetries.Text)
    timeOut.responseTimeout = CLng(tRespTO.Text)
    timeOut.numResponseRetries = CLng(tRespRetries.Text)
    
    Call DisplayMsg(0, 0, "Saving Timeout Setting...")
    
    ret = ACR122_SetTimeouts(hReader, timeOut)
    
    If ret <> 0 Then
           Call DisplayMsg(1, ret, "")
           Exit Sub
       Else
           Call DisplayMsg(0, 0, "Timeout Setting Saved.")
    End If
    
    Unload Me
    
End Sub

Private Sub Form_Load()

Dim timeOut As ACR122_TIMEOUTS

    ret = ACR122_GetTimeouts(hReader, timeOut)
    
    If ret <> 0 Then
           Call DisplayMsg(1, ret, "")
           Exit Sub
       Else
           Call DisplayMsg(0, 0, "Timeout Setting Retrieved.")
    End If
    
    tStatTO.Text = timeOut.statusTimeout
    tStatRetries.Text = timeOut.numStatusRetries
    tRespTO.Text = timeOut.responseTimeout
    tRespRetries.Text = timeOut.numResponseRetries

End Sub

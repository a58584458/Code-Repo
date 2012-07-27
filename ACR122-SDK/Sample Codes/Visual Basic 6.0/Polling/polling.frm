VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form polling 
   Caption         =   "Polling"
   ClientHeight    =   2520
   ClientLeft      =   5865
   ClientTop       =   6705
   ClientWidth     =   3150
   Icon            =   "polling.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2520
   ScaleWidth      =   3150
   Begin VB.Timer pollTimer 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   240
      Top             =   120
   End
   Begin MSComctlLib.StatusBar sbStatus 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   5
      Top             =   2145
      Width           =   3150
      _ExtentX        =   5556
      _ExtentY        =   661
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   2
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   1500
            MinWidth        =   1500
            Text            =   "Card Type"
            TextSave        =   "Card Type"
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Object.Width           =   5292
            MinWidth        =   5292
         EndProperty
      EndProperty
   End
   Begin VB.CommandButton bQuit 
      Caption         =   "Quit"
      Height          =   375
      Left            =   240
      TabIndex        =   4
      Top             =   1560
      Width           =   2775
   End
   Begin VB.CommandButton bPoll 
      Caption         =   "Start Polling"
      Height          =   375
      Left            =   240
      TabIndex        =   3
      Top             =   1080
      Width           =   2775
   End
   Begin VB.CommandButton bConnect 
      Caption         =   "Connect"
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   600
      Width           =   2775
   End
   Begin VB.ComboBox cbPort 
      Height          =   315
      Left            =   1920
      TabIndex        =   1
      Text            =   "COM1"
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label lblPort 
      Caption         =   "Select Port"
      Height          =   255
      Left            =   960
      TabIndex        =   0
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "polling"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===============================================================================
'
' Company       : Advanced Card Systems, Ltd
'
' File          : otherPICC.frm
'
' Description   : Demonstrate functions for other PICC cards in ACR122S.
'
' Author        : M.J.E.Castillo
'
' Date          : 22 / 10 / 2009
'
' Revision Trail: (Date/Author/Description)
'
'===============================================================================

Option Explicit
Dim ret, hReader, fwLen As Long
Dim fwVersion As String * 256
Dim Sendbuff(0 To 262) As Byte
Dim RecvBuff(0 To 262) As Byte
Dim SendLen, RecvLen As Long
Dim conn As Boolean

Private Sub bConnect_Click()

Dim tmpStr As String
    
    fwVersion = String(255, vbNullChar)
    fwLen = 255
    
    tmpStr = cbPort.Text
    
    If conn = True Then
        'disconnect
        ret = ACR122_Close(hReader)
        
        If ret <> 0 Then
            MsgBox "Error: " & ret, vbOKOnly, "Warning"
            Exit Sub
        Else
            conn = False
        End If
        
    Else
    
        'open ACR122 and get reader handle
        ret = ACR122_Open(tmpStr, hReader)
        
        If ret <> 0 Then
        
            MsgBox "Error: " & ret, vbOKOnly, "Warning"
            Exit Sub
            
        Else
        
            'Call DisplayMsg(0, 0, "Open Success")
            
            conn = True
            
        End If
        
        bPoll.Enabled = True
    
    End If
    
End Sub

Private Sub bPoll_Click()

If bPoll.Caption = "Start Polling" Then
    
    bPoll.Caption = "End Polling"
    pollTimer.Enabled = True

Else

    bPoll.Caption = "Start Polling"
    pollTimer.Enabled = False

End If

End Sub

Private Sub bQuit_Click()

    If conn = True Then
        'disconnect
        ret = ACR122_Close(hReader)
        
        If ret <> 0 Then
           MsgBox "Error: " & ret, vbOKOnly, "Warning"
        End If
        
    End If
    
    Unload Me
    
End Sub

Private Sub Form_Load()

    Call InitMenu
    
End Sub

Private Sub InitMenu()

Dim i As Integer
    
    For i = 1 To 9
        cbPort.AddItem ("COM" & i)
    Next i
    
    bPoll.Enabled = False
    
End Sub

Private Sub pollTimer_Timer()

    If CheckCard() Then
        'sbStatus.Panels(2).Text = "Card Inserted"
    Else
        sbStatus.Panels(2).Text = "No Card Detected"
    End If

End Sub

Private Function CheckCard() As Boolean

Dim CardType As Byte
Dim tmpStr As String

    Call ClearBuffers
    
    Sendbuff(0) = &HD4
    Sendbuff(1) = &H60
    Sendbuff(2) = &H1
    Sendbuff(3) = &H1
    Sendbuff(4) = &H20
    Sendbuff(5) = &H23
    Sendbuff(6) = &H11
    Sendbuff(7) = &H4
    Sendbuff(8) = &H10
    
    SendLen = 9
    RecvLen = 255
    
    ret = ACR122_DirectTransmit(hReader, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    tmpStr = ""
    
    If ret <> 0 Then
        sbStatus.Panels(2).Text = "Error: " & ret
        CheckCard = False
    Else
        If RecvLen > 3 Then
            CardType = RecvBuff(8)
            
            Select Case CardType
                Case &H18
                    tmpStr = "Mifare 4K "
                Case &H0
                    tmpStr = "Mifare Ultralight "
                Case &H28
                    tmpStr = "ISO 14443-4 Type A "
                Case &H8
                    tmpStr = "Mifare 1K "
                Case &H9
                    tmpStr = "Mifare Mini "
                Case &H20
                    tmpStr = "Mifare DesFire "
                Case &H98
                    tmpStr = "Gemplus MPCOS "
                Case Else
                    CardType = RecvBuff(3)
                    Select Case CardType
                        Case &H23
                            tmpStr = "ISO 14443-4 Type B "
                        Case &H11
                            tmpStr = "Felica 212K "
                        Case &H4
                            tmpStr = "Topaz "
                        Case Else
                            tmpStr = "Unknown card "
                    End Select
            End Select
        Else
            tmpStr = "No Card Detected."
            sbStatus.Panels(2).Text = tmpStr
            CheckCard = False
        End If
    End If

    sbStatus.Panels(2).Text = tmpStr
    CheckCard = True
    
End Function

Public Sub ClearBuffers()

Dim intIndx As Long
  
  For intIndx = 0 To 262
  
    RecvBuff(intIndx) = &H0
    Sendbuff(intIndx) = &H0
    
  Next intIndx

End Sub

VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form keyMgt 
   Caption         =   "Key Management"
   ClientHeight    =   4035
   ClientLeft      =   1770
   ClientTop       =   5250
   ClientWidth     =   7935
   Icon            =   "keyMgt.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4035
   ScaleWidth      =   7935
   Begin RichTextLib.RichTextBox mMsg 
      Height          =   3735
      Left            =   2760
      TabIndex        =   9
      Top             =   120
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   6588
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"keyMgt.frx":17A2
   End
   Begin VB.CommandButton bQuit 
      Caption         =   "Quit"
      Height          =   375
      Left            =   840
      TabIndex        =   7
      Top             =   3480
      Width           =   1815
   End
   Begin VB.CommandButton bReset 
      Caption         =   "Reset"
      Height          =   375
      Left            =   840
      TabIndex        =   6
      Top             =   3000
      Width           =   1815
   End
   Begin VB.CommandButton bClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   840
      TabIndex        =   5
      Top             =   2520
      Width           =   1815
   End
   Begin VB.CommandButton bGenKeys 
      Caption         =   "Generate Keys"
      Height          =   375
      Left            =   840
      TabIndex        =   4
      Top             =   2040
      Width           =   1815
   End
   Begin VB.CommandButton bInitSAM 
      Caption         =   "Initialize SAM"
      Height          =   375
      Left            =   840
      TabIndex        =   3
      Top             =   1560
      Width           =   1815
   End
   Begin VB.CommandButton bPowerOnICC 
      Caption         =   "Power On ICC"
      Height          =   375
      Left            =   840
      TabIndex        =   2
      Top             =   1080
      Width           =   1815
   End
   Begin VB.CommandButton bConnect 
      Caption         =   "Connect"
      Height          =   375
      Left            =   840
      TabIndex        =   1
      Top             =   600
      Width           =   1815
   End
   Begin VB.ComboBox cbPort 
      Height          =   315
      Left            =   1080
      TabIndex        =   0
      Text            =   "COM1"
      Top             =   120
      Width           =   1575
   End
   Begin VB.Label lblPort 
      Caption         =   "Select Port: "
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "keyMgt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===============================================================================
'
' Company       : Advanced Card Systems, Ltd
'
' File          : keyMgt.frm
'
' Description   : Demonstrates SAM Functions in ACR122S.
'
' Author        : M.J.E.Castillo
'
' Date          : 26 / 11 / 2009
'
' Revision Trail: (Date/Author/Description)
'
'===============================================================================



Private Sub bClear_Click()

    mMsg.Text = ""

End Sub

Private Sub bConnect_Click()

Dim tmpStr As String
    
    fwVersion = String(255, vbNullChar)
    fwLen = 255
    
    tmpStr = cbPort.Text
    port = tmpStr
    
    If conn = True Then
        'disconnect
        ret = ACR122_Close(hReader)
        
        If ret <> 0 Then
            Call DisplayMsg(1, ret, "")
            Exit Sub
        Else
            conn = False
        End If
        
    Else
    
        'open ACR122 and get reader handle
        ret = ACR122_Open(tmpStr, hReader)
        
        If ret <> 0 Then
        
            Call DisplayMsg(1, ret, "")
            Exit Sub
            
        Else
        
            Call DisplayMsg(0, 0, "Open Success")
            
            conn = True
            
            'get device firmware version
            ret = ACR122_GetFirmwareVersion(hReader, 0, fwVersion, fwLen)
            
            If ret <> 0 Then
                
                Call DisplayMsg(1, ret, "")
                Exit Sub
            Else
        
                Call DisplayMsg(0, 0, "Get Firmware Success")
                Call DisplayMsg(0, 0, "Firmware: " & fwVersion)
                Call DisplayMsg(0, 0, "")
                
            End If
            
            'enable buttons
            bReset.Enabled = True
            bPowerOnICC.Enabled = True
            
        End If
    
    End If
    
End Sub

Private Sub bGenKeys_Click()

    GenKey.Show
    
End Sub

Private Sub bInitSAM_Click()

    initSAM.Show
    
End Sub

Private Sub bPowerOnICC_Click()

Dim tmpStr As String
    
    Call ClearBuffers
    
    RecvLen = 255
    
    ret = ACR122_PowerOnIcc(hReader, 0, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
           Call DisplayMsg(1, ret, "")
           Exit Sub
    Else
           Call DisplayMsg(0, 0, "ICC Power On.")
           
           tmpStr = "ATR: "
           For i = 0 To RecvLen - 1
             
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
                  
           Next i
             
           Call DisplayMsg(3, 0, tmpStr)
           
           bPowerOnICC.Enabled = False
           bInitSAM.Enabled = True
           bGenKeys.Enabled = True
       
    End If

End Sub

Private Sub bQuit_Click()

    If conn = True Then
        'disconnect
        ret = ACR122_PowerOffIcc(hReader, 0)
        ret = ACR122_Close(hReader)
        
        If ret <> 0 Then
            Call DisplayMsg(1, ret, "")
        End If
        
    End If
    
    Unload Me
    
End Sub

Private Sub bReset_Click()

    ret = ACR122_PowerOffIcc(hReader, 0)
    
    ret = ACR122_Close(hReader)
    
    If ret <> 0 Then
    
        Call DisplayMsg(1, ret, "")
         
    End If
    
    Call InitMenu
    
End Sub

Private Sub Form_Load()

    Call InitMenu

End Sub


Public Sub InitMenu()

Dim i As Integer
    
    For i = 1 To 9
        cbPort.AddItem ("COM" & i)
    Next i

    bReset.Enabled = False
    bPowerOnICC.Enabled = False
    bInitSAM.Enabled = False
    bGenKeys.Enabled = False
    
    mMsg.Text = ""
    Call DisplayMsg(0, 0, "Program Ready")
    
    conn = False
    
End Sub

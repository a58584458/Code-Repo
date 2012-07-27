VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form getATR 
   Caption         =   "Get ATR"
   ClientHeight    =   3765
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6720
   Icon            =   "getATR.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3765
   ScaleWidth      =   6720
   StartUpPosition =   3  'Windows Default
   Begin RichTextLib.RichTextBox mMsg 
      Height          =   3495
      Left            =   2400
      TabIndex        =   7
      Top             =   120
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   6165
      _Version        =   393217
      TextRTF         =   $"getATR.frx":17A2
   End
   Begin VB.CommandButton bQuit 
      Caption         =   "Quit"
      Height          =   375
      Left            =   480
      TabIndex        =   6
      Top             =   3120
      Width           =   1695
   End
   Begin VB.CommandButton bReset 
      Caption         =   "Reset"
      Height          =   375
      Left            =   480
      TabIndex        =   5
      Top             =   2640
      Width           =   1695
   End
   Begin VB.CommandButton bClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   480
      TabIndex        =   4
      Top             =   2160
      Width           =   1695
   End
   Begin VB.CommandButton bGetATR 
      Caption         =   "Get ATR"
      Height          =   375
      Left            =   480
      TabIndex        =   3
      Top             =   1200
      Width           =   1695
   End
   Begin VB.CommandButton bConnect 
      Caption         =   "Connect"
      Height          =   375
      Left            =   480
      TabIndex        =   2
      Top             =   720
      Width           =   1695
   End
   Begin VB.ComboBox cbPort 
      Height          =   315
      Left            =   1080
      TabIndex        =   1
      Text            =   "COM1"
      Top             =   240
      Width           =   1095
   End
   Begin VB.Label lblPort 
      Caption         =   "Select Port:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   975
   End
End
Attribute VB_Name = "getATR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===============================================================================
'
' Company       : Advanced Card Systems, Ltd
'
' File          : getATR.frm
'
' Description   : Get ATR from card in ACR122S.
'
' Author        : M.J.E.Castillo
'
' Date          : 20 / 10 / 2009
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

Private Sub bClear_Click()

    mMsg.Text = ""

End Sub

Private Sub bConnect_Click()

    Dim tmpStr As String
    
    fwVersion = String(255, vbNullChar)
    fwLen = 255
    
    tmpStr = cbPort.Text
    
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
            bGetATR.Enabled = True
            bReset.Enabled = True
            
        End If
    
    End If
    
End Sub

Private Sub DisplayMsg(ByVal mType, ByVal msgCode As Long, ByVal PrintText As String)

    Select Case mType
        'Notification
        Case 0
            mMsg.SelColor = &H4000
        'Error Message
        Case 1
            mMsg.SelColor = vbRed
            PrintText = "Error: " & msgCode
        'input data
        Case 2
            mMsg.SelColor = vbBlack
            PrintText = "< " & PrintText
            
        'output data
        Case 3
            mMsg.SelColor = vbBlack
            PrintText = "> " & PrintText
            
    End Select
    
    mMsg.SelText = PrintText & vbCrLf
    mMsg.SelStart = Len(mMsg.Text)
    mMsg.SelColor = vbBlack

End Sub

Private Sub bGetATR_Click()

Dim cardType As Byte
Dim tmpStr As String
Dim i As Integer

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
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_DirectTransmit(hReader, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    tmpStr = ""
    For i = 0 To RecvLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(3, 0, tmpStr)
   
    If ret <> 0 Then

        Call DisplayMsg(1, ret, "")
        Exit Sub
        
    Else
    
        Call DisplayMsg(0, 0, "Get ATR Success")
        
        If RecvLen > 3 Then
            cardType = RecvBuff(8)
            
            Select Case cardType
                Case &H18
                    tmpStr = "Mifare 4K "
                Case &H0
                    tmpStr = "Mifare Ultralight "
                Case &H28
                    tmpStr = "ISO 14443-4 Type A "
                Case &H8
                    tmpStr = "Mifare 1K"
                Case Else
                    cardType = RecvBuff(3)
                    Select Case cardType
                        Case &H23
                            tmpStr = "ISO 144443-4 Type B "
                        Case &H11
                            tmpStr = "FeliCa 212K "
                        Case &H4
                            tmpStr = "Topaz"
                        Case Default
                            tmpStr = "Unknown Contactless Card "
                    End Select
            End Select
            
        Else
            tmpStr = "No Contactless Card "
        End If
        
        tmpStr = tmpStr & "detected."
        
        Call DisplayMsg(0, 0, tmpStr)
        
    End If
    

End Sub

Private Sub bQuit_Click()

    If conn = True Then
        'disconnect
        ret = ACR122_Close(hReader)
        
        If ret <> 0 Then
            Call DisplayMsg(1, ret, "")
            
        End If
        
    End If
    
    Unload Me

End Sub

Private Sub bReset_Click()

    ret = ACR122_Close(hReader)
    
    If ret <> 0 Then
    
        Call DisplayMsg(1, ret, "")
        
    End If
    
    Call InitMenu

End Sub

Public Sub ClearBuffers()
      Dim intIndx As Long
  
  For intIndx = 0 To 262
  
    RecvBuff(intIndx) = &H0
    Sendbuff(intIndx) = &H0
    
  Next intIndx
End Sub

Private Sub Form_Load()

    Call InitMenu
    
End Sub

Private Sub InitMenu()
    
    Dim i As Integer
    
    For i = 1 To 9
        cbPort.AddItem ("COM" & i)
    Next i
        
    bGetATR.Enabled = False
    bReset.Enabled = False
    
    mMsg.Text = ""
    Call DisplayMsg(0, 0, "Program Ready")
    
    conn = False
    
End Sub

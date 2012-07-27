VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form otherPICC 
   Caption         =   "Other PICC Cards"
   ClientHeight    =   2595
   ClientLeft      =   5790
   ClientTop       =   6135
   ClientWidth     =   8175
   Icon            =   "otherPICC.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   2595
   ScaleWidth      =   8175
   Begin VB.CommandButton bQuit 
      Caption         =   "Quit"
      Height          =   375
      Left            =   6840
      TabIndex        =   9
      Top             =   2040
      Width           =   1095
   End
   Begin VB.CommandButton bReset 
      Caption         =   "Reset"
      Height          =   375
      Left            =   5520
      TabIndex        =   8
      Top             =   2040
      Width           =   1095
   End
   Begin VB.CommandButton bClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   4200
      TabIndex        =   7
      Top             =   2040
      Width           =   1095
   End
   Begin RichTextLib.RichTextBox mMsg 
      Height          =   1815
      Left            =   4080
      TabIndex        =   6
      Top             =   120
      Width           =   3975
      _ExtentX        =   7011
      _ExtentY        =   3201
      _Version        =   393217
      Enabled         =   -1  'True
      TextRTF         =   $"otherPICC.frx":17A2
   End
   Begin VB.Frame fraComm 
      Caption         =   "Command"
      Height          =   1455
      Left            =   240
      TabIndex        =   3
      Top             =   960
      Width           =   3735
      Begin VB.CommandButton bSend 
         Caption         =   "Send"
         Height          =   375
         Left            =   2280
         TabIndex        =   5
         Top             =   840
         Width           =   1215
      End
      Begin VB.TextBox tCommand 
         Height          =   285
         Left            =   240
         TabIndex        =   4
         Top             =   360
         Width           =   3255
      End
   End
   Begin VB.CommandButton bConnect 
      Caption         =   "Connect"
      Height          =   375
      Left            =   2400
      TabIndex        =   2
      Top             =   240
      Width           =   1575
   End
   Begin VB.ComboBox cbPort 
      Height          =   315
      Left            =   1200
      TabIndex        =   1
      Text            =   "COM1"
      Top             =   240
      Width           =   975
   End
   Begin VB.Label lblPort 
      Caption         =   "Select Port: "
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   975
   End
End
Attribute VB_Name = "otherPICC"
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
            fraComm.Enabled = True
            bReset.Enabled = True
            
        End If
    
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

Private Sub bSend_Click()

Dim tmpData As String
Dim tmpStr As String
Dim dataLen As Integer
Dim indx, i, result As Integer

    If tCommand.Text = "" Then
        tCommand.SetFocus
        Exit Sub
    End If

    Call ClearBuffers
    tmpData = ""
    tmpData = TrimInput(0, tCommand.Text)
    tmpData = TrimInput(1, tmpData)
    
    dataLen = Len(tmpData) / 2
    
    If (dataLen Mod 2) = 0 Then
        result = MsgBox("Enter Even Number of APDU", vbOKOnly, "Warning!")
        tCommand.SetFocus
        Exit Sub
    End If
        
    For indx = 0 To dataLen - 1
        
        Sendbuff(indx) = CInt("&H" & (Mid$(tmpData, ((indx * 2) + 1), 2)))
        
    Next indx
    
    SendLen = dataLen
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To dataLen - 1
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
        Call DisplayMsg(0, 0, "Success")
        
   End If
                
End Sub

Private Sub Form_Load()

    Call InitMenu

End Sub

Private Sub InitMenu()
    
    Dim i As Integer
    
    For i = 1 To 9
        cbPort.AddItem ("COM" & i)
    Next i
    
    fraComm.Enabled = False
    bReset.Enabled = False
    
    tCommand.Text = ""
    mMsg.Text = ""
    Call DisplayMsg(0, 0, "Program Ready")

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

Public Sub ClearBuffers()

Dim intIndx As Long
  
  For intIndx = 0 To 262
  
    RecvBuff(intIndx) = &H0
    Sendbuff(intIndx) = &H0
    
  Next intIndx

End Sub

Private Function TrimInput(trimType As Integer, strIn As String) As String

Dim indx As Integer
Dim tmpStr As String
Dim charArray(0 To 99) As String

    'place each character of string to an array
    For indx = 1 To Len(strIn)
    
        charArray(indx) = Mid$(strIn, indx, 1)
    
    Next indx

    tmpStr = ""
    strIn = Trim(strIn)

    Select Case trimType
    
        Case 0
            For indx = 1 To Len(strIn)
            
                If (charArray(indx) <> Chr(13)) And (charArray(indx) <> Chr(10)) Then
                
                    tmpStr = tmpStr + charArray(indx)
                
                End If
            
            Next indx
    
        Case 1
            For indx = 1 To Len(strIn)
            
                If charArray(indx) <> " " Then
                
                    tmpStr = tmpStr + charArray(indx)
                
                End If
            
            Next indx
    
    End Select
    
    TrimInput = tmpStr

End Function

Private Sub tCommand_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tCommand_GotFocus()
    tCommand.SelStart = 0
    tCommand.SelLength = Len(tCommand.Text)
End Sub

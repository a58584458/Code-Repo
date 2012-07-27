VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form mifareProg 
   Caption         =   "MiFare Programming"
   ClientHeight    =   5685
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8190
   Icon            =   "mifareProg.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   5685
   ScaleWidth      =   8190
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton bQuit 
      Caption         =   "Quit"
      Height          =   375
      Left            =   6720
      TabIndex        =   41
      Top             =   5160
      Width           =   1335
   End
   Begin VB.CommandButton bReset 
      Caption         =   "Reset"
      Height          =   375
      Left            =   5160
      TabIndex        =   40
      Top             =   5160
      Width           =   1335
   End
   Begin VB.CommandButton bClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   3600
      TabIndex        =   39
      Top             =   5160
      Width           =   1335
   End
   Begin RichTextLib.RichTextBox mMsg 
      Height          =   2055
      Left            =   3600
      TabIndex        =   38
      Top             =   3000
      Width           =   4455
      _ExtentX        =   7858
      _ExtentY        =   3625
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"mifareProg.frx":17A2
   End
   Begin VB.Frame fraStatic 
      Caption         =   "Static"
      Height          =   2775
      Left            =   3600
      TabIndex        =   24
      Top             =   120
      Width           =   4455
      Begin VB.CommandButton bCpyBlk 
         Caption         =   "Copy Block"
         Height          =   375
         Left            =   2880
         TabIndex        =   37
         Top             =   2160
         Width           =   1335
      End
      Begin VB.CommandButton bDec 
         Caption         =   "Decrement"
         Height          =   375
         Left            =   2880
         TabIndex        =   36
         Top             =   1680
         Width           =   1335
      End
      Begin VB.CommandButton bInc 
         Caption         =   "Increment"
         Height          =   375
         Left            =   2880
         TabIndex        =   35
         Top             =   1200
         Width           =   1335
      End
      Begin VB.CommandButton breadVal 
         Caption         =   "ReadValue"
         Height          =   375
         Left            =   2880
         TabIndex        =   34
         Top             =   720
         Width           =   1335
      End
      Begin VB.CommandButton bStoreVal 
         Caption         =   "Store Value"
         Height          =   375
         Left            =   2880
         TabIndex        =   33
         Top             =   240
         Width           =   1335
      End
      Begin VB.TextBox tTargetBlk 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   32
         Top             =   1320
         Width           =   375
      End
      Begin VB.TextBox tSrcBlk 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   31
         Top             =   960
         Width           =   375
      End
      Begin VB.TextBox tStaticBlkNo 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   30
         Top             =   600
         Width           =   375
      End
      Begin VB.TextBox tAmt 
         Height          =   285
         Left            =   1320
         MaxLength       =   10
         TabIndex        =   29
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label lblTargetBlk 
         Caption         =   "Target Block"
         Height          =   255
         Left            =   120
         TabIndex        =   28
         Top             =   1440
         Width           =   975
      End
      Begin VB.Label lblSrcBlk 
         Caption         =   "Source Block"
         Height          =   255
         Left            =   120
         TabIndex        =   27
         Top             =   1080
         Width           =   1095
      End
      Begin VB.Label lblBlkNo3 
         Caption         =   "Block No."
         Height          =   255
         Left            =   120
         TabIndex        =   26
         Top             =   720
         Width           =   1095
      End
      Begin VB.Label lblValAmt 
         Caption         =   "Value Amount"
         Height          =   255
         Left            =   120
         TabIndex        =   25
         Top             =   360
         Width           =   1215
      End
   End
   Begin VB.Frame fraBinBlkFxn 
      Caption         =   "Binary Block Functions"
      Height          =   1815
      Left            =   120
      TabIndex        =   17
      Top             =   3720
      Width           =   3375
      Begin VB.CommandButton bUpdateBlk 
         Caption         =   "Update Block"
         Height          =   375
         Left            =   1800
         TabIndex        =   23
         Top             =   1320
         Width           =   1335
      End
      Begin VB.CommandButton bReadBlk 
         Caption         =   "Read Block"
         Height          =   375
         Left            =   240
         TabIndex        =   22
         Top             =   1320
         Width           =   1335
      End
      Begin VB.TextBox tData 
         Height          =   285
         Left            =   240
         TabIndex        =   21
         Top             =   960
         Width           =   2895
      End
      Begin VB.TextBox tBlkNoBin 
         Height          =   285
         Left            =   1080
         MaxLength       =   2
         TabIndex        =   19
         Top             =   360
         Width           =   375
      End
      Begin VB.Label lblData 
         Caption         =   "Data:"
         Height          =   255
         Left            =   240
         TabIndex        =   20
         Top             =   720
         Width           =   615
      End
      Begin VB.Label lblBlkNo2 
         Caption         =   "Block No. "
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   360
         Width           =   735
      End
   End
   Begin VB.Frame fraAuth 
      Caption         =   "Authentication"
      Height          =   2415
      Left            =   120
      TabIndex        =   3
      Top             =   1200
      Width           =   3375
      Begin VB.CommandButton bAuth 
         Caption         =   "Authenticate"
         Height          =   375
         Left            =   1320
         TabIndex        =   16
         Top             =   1800
         Width           =   1815
      End
      Begin VB.TextBox tKeyVal6 
         Height          =   285
         Left            =   2880
         MaxLength       =   2
         TabIndex        =   15
         Top             =   1320
         Width           =   375
      End
      Begin VB.TextBox tKeyVal5 
         Height          =   285
         Left            =   2520
         MaxLength       =   2
         TabIndex        =   14
         Top             =   1320
         Width           =   375
      End
      Begin VB.TextBox tKeyVal4 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   13
         Top             =   1320
         Width           =   375
      End
      Begin VB.TextBox tKeyVal3 
         Height          =   285
         Left            =   1800
         MaxLength       =   2
         TabIndex        =   12
         Top             =   1320
         Width           =   375
      End
      Begin VB.TextBox tKeyVal2 
         Height          =   285
         Left            =   1440
         MaxLength       =   2
         TabIndex        =   11
         Top             =   1320
         Width           =   375
      End
      Begin VB.TextBox tKeyVal1 
         Height          =   285
         Left            =   1080
         MaxLength       =   2
         TabIndex        =   10
         Top             =   1320
         Width           =   375
      End
      Begin VB.TextBox tBlkNo 
         Height          =   285
         Left            =   1080
         MaxLength       =   2
         TabIndex        =   8
         Top             =   960
         Width           =   375
      End
      Begin VB.Frame fraKey 
         Caption         =   "Key Type"
         Height          =   615
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   2655
         Begin VB.OptionButton rbTypeB 
            Caption         =   "Type B"
            Height          =   255
            Left            =   1440
            TabIndex        =   6
            Top             =   240
            Width           =   1095
         End
         Begin VB.OptionButton rbTypeA 
            Caption         =   "Type A"
            Height          =   255
            Left            =   240
            TabIndex        =   5
            Top             =   240
            Width           =   1095
         End
      End
      Begin VB.Label lblKeyVal 
         Caption         =   "Key Value"
         Height          =   255
         Left            =   240
         TabIndex        =   9
         Top             =   1440
         Width           =   855
      End
      Begin VB.Label lblBlkNo 
         Caption         =   "Block No. "
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   1080
         Width           =   735
      End
   End
   Begin VB.CommandButton bConnect 
      Caption         =   "Connect"
      Height          =   375
      Left            =   1800
      TabIndex        =   2
      Top             =   720
      Width           =   1695
   End
   Begin VB.ComboBox cbPort 
      Height          =   315
      Left            =   2280
      TabIndex        =   1
      Text            =   "COM1"
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label lblPort 
      Caption         =   "Select Port: "
      Height          =   255
      Left            =   1080
      TabIndex        =   0
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "mifareProg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===============================================================================
'
' Company       : Advanced Card Systems, Ltd
'
' File          : mifareProg.frm
'
' Description   : Demonstrate Mifare functions in ACR122S.
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

Private Sub bAuth_Click()

Dim i As Integer
Dim tmpStr As String
Dim UID(0 To 3) As Byte

   'check values
   If tBlkNo.Text = "" Then
        tBlkNo.SetFocus
        Exit Sub
   End If

    If tKeyVal1.Text = "" Then
        tKeyVal1.SetFocus
        Exit Sub
   End If
   
   If tKeyVal2.Text = "" Then
        tKeyVal2.SetFocus
        Exit Sub
   End If
   
   If tKeyVal3.Text = "" Then
        tKeyVal3.SetFocus
        Exit Sub
   End If
   
   If tKeyVal4.Text = "" Then
        tKeyVal4.SetFocus
        Exit Sub
   End If
   
   If tKeyVal5.Text = "" Then
        tKeyVal5.SetFocus
        Exit Sub
   End If
   
   If tKeyVal6.Text = "" Then
        tKeyVal6.SetFocus
        Exit Sub
   End If
   
   Call ClearBuffers
   
   Sendbuff(0) = &HD4
   Sendbuff(1) = &H4A
   Sendbuff(2) = &H1
   Sendbuff(3) = &H0
   
   SendLen = 4
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
    
        tmpStr = ""
        For i = 8 To RecvBuff(7) + 7
        
             UID(i - 8) = RecvBuff(i)
             
        Next i
   
   End If
   
   Call ClearBuffers
   
   Sendbuff(0) = &HD4
   Sendbuff(1) = &H40
   Sendbuff(2) = &H1
   
   If rbTypeA.Value = True Then
        Sendbuff(3) = &H60
   Else
        Sendbuff(3) = &H61
   End If
   
   Sendbuff(4) = CInt("&H" & tBlkNo.Text)
   Sendbuff(5) = CInt("&H" & tKeyVal1.Text)
   Sendbuff(6) = CInt("&H" & tKeyVal2.Text)
   Sendbuff(7) = CInt("&H" & tKeyVal3.Text)
   Sendbuff(8) = CInt("&H" & tKeyVal4.Text)
   Sendbuff(9) = CInt("&H" & tKeyVal5.Text)
   Sendbuff(10) = CInt("&H" & tKeyVal6.Text)
   
   For i = 0 To 3
        Sendbuff(11 + i) = UID(i)
   Next i
   
   SendLen = 15
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
        Call DisplayMsg(0, 0, "Authentication Success")
   End If

End Sub

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
            fraAuth.Enabled = True
            fraBinBlkFxn.Enabled = True
            fraStatic.Enabled = True
            bReset.Enabled = True
            
        End If
    
    End If
    
End Sub

Private Sub bCpyBlk_Click()

Dim i, result As Integer
Dim tmpStr As String
Dim tmp, tmpVal, val As Long
Dim target As Byte

   'validate input
   If tSrcBlk.Text = "" Then
        tSrcBlk.SetFocus
        Exit Sub
   End If
   
   If tTargetBlk.Text = "" Then
        tTargetBlk.SetFocus
        Exit Sub
   End If

    tmpVal = CInt(tTargetBlk.Text)
    
    If tmpVal < &H80 Then
        If (tmpVal Mod 4) = 3 Then
            
            result = MsgBox("Critical Block Chosen to be written. Continue?", vbCritical + vbOKCancel, "Warning!")
            
            If result = vbCancel Then
                Exit Sub
            End If
            
        End If
    Else
        If ((tmpVal - 128) Mod 4) = 3 Then
            
            result = MsgBox("Critical Block Chosen to be written. Continue?", vbCritical + vbOKCancel, "Warning!")
            
            If result = vbCancel Then
                Exit Sub
            End If
            
        End If
    End If
    
    'copy from souce block
    Call ClearBuffers
    Sendbuff(0) = &HD4
    Sendbuff(1) = &H40
    Sendbuff(2) = &H1
    Sendbuff(3) = &HC2
    Sendbuff(4) = CInt("&H" & tSrcBlk.Text)
    
    SendLen = 5
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
        
        Call ClearBuffers
        Sendbuff(0) = &HD4
        Sendbuff(1) = &H40
        Sendbuff(2) = &H1
        Sendbuff(3) = &HB0
        Sendbuff(4) = CInt("&H" & tTargetBlk.Text)
        
        SendLen = 5
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
             Call DisplayMsg(0, 0, "Copy Value Success")
        End If
        
   End If
    

End Sub

Private Sub bDec_Click()

Dim i As Integer
Dim tmpStr As String
Dim tmp, tmpVal, val As Long

   'validate input
   If tAmt.Text = "" Then
        tAmt.SetFocus
        Exit Sub
   End If
   
   If tStaticBlkNo.Text = "" Then
        tStaticBlkNo.SetFocus
        Exit Sub
   End If
   
   Call ClearBuffers
   Sendbuff(0) = &HD4
   Sendbuff(1) = &H40
   Sendbuff(2) = &H1
   Sendbuff(3) = &HC0
   Sendbuff(4) = CInt("&H" & tStaticBlkNo.Text)
     
   'get value in Data
   tmpVal = CLng(tAmt)
   val = tmpVal
    
   val = tmpVal Mod 256
   Sendbuff(5) = val
    
   val = tmpVal \ 256
   val = val Mod 256
   Sendbuff(6) = val
    
   val = tmpVal \ 256
   val = val \ 256
   val = val Mod 256
   Sendbuff(7) = val
    
   val = tmpVal \ 256
   val = val \ 256
   val = val \ 256
   val = val Mod 256
   Sendbuff(8) = val
   
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
        
        Call ClearBuffers
        Sendbuff(0) = &HD4
        Sendbuff(1) = &H40
        Sendbuff(2) = &H1
        Sendbuff(3) = &HB0
        Sendbuff(4) = CInt("&H" & tStaticBlkNo.Text)
        
        SendLen = 5
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
             Call DisplayMsg(0, 0, "Decrement Value Success")
        End If
        
   End If
End Sub

Private Sub bInc_Click()

Dim i As Integer
Dim tmpStr As String
Dim tmp, tmpVal, val As Long

   'validate input
   If tAmt.Text = "" Then
        tAmt.SetFocus
        Exit Sub
   End If
   
   If tStaticBlkNo.Text = "" Then
        tStaticBlkNo.SetFocus
        Exit Sub
   End If
   
   Call ClearBuffers
   Sendbuff(0) = &HD4
   Sendbuff(1) = &H40
   Sendbuff(2) = &H1
   Sendbuff(3) = &HC1
   Sendbuff(4) = CInt("&H" & tStaticBlkNo.Text)
     
   'get value in Data
   tmpVal = CLng(tAmt)
   val = tmpVal
    
   val = tmpVal Mod 256
   Sendbuff(5) = val
    
   val = tmpVal \ 256
   val = val Mod 256
   Sendbuff(6) = val
    
   val = tmpVal \ 256
   val = val \ 256
   val = val Mod 256
   Sendbuff(7) = val
    
   val = tmpVal \ 256
   val = val \ 256
   val = val \ 256
   val = val Mod 256
   Sendbuff(8) = val
   
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
        
        Call ClearBuffers
        Sendbuff(0) = &HD4
        Sendbuff(1) = &H40
        Sendbuff(2) = &H1
        Sendbuff(3) = &HB0
        Sendbuff(4) = CInt("&H" & tStaticBlkNo.Text)
        
        SendLen = 5
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
             Call DisplayMsg(0, 0, "Increment Value Success")
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

Private Sub bReadBlk_Click()

Dim i As Integer
Dim tmpStr As String

   'validate input
   If tBlkNoBin.Text = "" Then
        tBlkNoBin.SetFocus
        Exit Sub
   End If
   
   Call ClearBuffers
   
   Sendbuff(0) = &HD4
   Sendbuff(1) = &H40
   Sendbuff(2) = &H1
   Sendbuff(3) = &H30
   Sendbuff(4) = CInt("&H" & tBlkNoBin.Text)
   
   SendLen = 5
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
        If RecvLen < 5 Then
            Call DisplayMsg(3, 0, "Invalid Return Length")
            Exit Sub
        End If
        
        Call DisplayMsg(0, 0, "Read Block Success")
        
        tmpStr = ""
        For i = 3 To RecvLen - 1
            tmpStr = tmpStr & Chr(RecvBuff(i))
            
        Next i
        
        tData.Text = tmpStr
        
        
   End If

End Sub

Private Sub breadVal_Click()

Dim i As Integer
Dim tmpStr As String
Dim tmp, tmpVal, amt, x As Long

   'validate input
   
   If tStaticBlkNo.Text = "" Then
        tStaticBlkNo.SetFocus
        Exit Sub
   End If

   Call ClearBuffers
   
   Sendbuff(0) = &HD4
   Sendbuff(1) = &H40
   Sendbuff(2) = &H1
   Sendbuff(3) = &H30
   Sendbuff(4) = CInt("&H" & tStaticBlkNo.Text)
   
   SendLen = 5
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
        Call DisplayMsg(0, 0, "Read Block Success")
        
        tmpStr = ""
        For i = 6 To 3 Step -1
            tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2)
        Next i
        
        x = val("&H" & tmpStr)
        tmpStr = CStr(x)
        
        tAmt.Text = tmpStr
        
   End If
   
End Sub

Private Sub bReset_Click()

    ret = ACR122_Close(hReader)
    
    If ret <> 0 Then

        Call DisplayMsg(1, ret, "")
        
    End If
    
    Call InitMenu

End Sub

Private Sub bStoreVal_Click()

Dim i As Integer
Dim tmpStr As String
Dim tmp, tmpVal, amt As Long

   'validate input
   If tAmt.Text = "" Then
        tAmt.SetFocus
        Exit Sub
   End If
   
   If tStaticBlkNo.Text = "" Then
        tStaticBlkNo.SetFocus
        Exit Sub
   End If

   Call ClearBuffers
   
   Sendbuff(0) = &HD4
   Sendbuff(1) = &H40
   Sendbuff(2) = &H1
   Sendbuff(3) = &HA0
   Sendbuff(4) = CInt("&H" & tStaticBlkNo.Text)
   
   'get value in Data
   tmpVal = CLng(tAmt.Text)
   amt = tmpVal
   
   If amt >= 0 Then
        
        tmpVal = amt Mod 256
        Sendbuff(5) = tmpVal
        
        tmpVal = amt \ 256
        tmpVal = tmpVal Mod 256
        Sendbuff(6) = tmpVal

        
        tmpVal = amt \ 256
        tmpVal = tmpVal \ 256
        tmpVal = tmpVal Mod 256
        Sendbuff(7) = tmpVal

        
        tmpVal = amt \ 256
        tmpVal = tmpVal \ 256
        tmpVal = tmpVal \ 256
        tmpVal = tmpVal Mod 256
        Sendbuff(8) = tmpVal
        
        'get complement of amt
        Sendbuff(9) = 255 - Sendbuff(5)
        Sendbuff(10) = 255 - Sendbuff(6)
        Sendbuff(11) = 255 - Sendbuff(7)
        Sendbuff(12) = 255 - Sendbuff(8)
        
   Else
   
        tmp = Abs(amt)
        
        Sendbuff(5) = Not tmpVal + 1
        Sendbuff(9) = tmpVal - 1
        
        tmpVal = tmp \ 256
        tmpVal = tmpVal Mod 256
        Sendbuff(6) = Not tmpVal
        Sendbuff(10) = tmpVal
        
        tmpVal = tmp \ 256
        tmpVal = tmpVal \ 256
        tmpVal = tmpVal Mod 256
        Sendbuff(7) = Not tmpVal
        Sendbuff(11) = tmpVal
        
        tmpVal = tmp \ 256
        tmpVal = tmpVal \ 256
        tmpVal = tmpVal \ 256
        tmpVal = tmpVal Mod 256
        Sendbuff(8) = Not tmpVal
        Sendbuff(12) = tmpVal
        
   End If
   
   Sendbuff(13) = Sendbuff(5)
   Sendbuff(14) = Sendbuff(6)
   Sendbuff(15) = Sendbuff(7)
   Sendbuff(16) = Sendbuff(8)
   
   Sendbuff(17) = Sendbuff(4)
   Sendbuff(18) = 255 - Sendbuff(4)
   Sendbuff(19) = Sendbuff(4)
   Sendbuff(20) = 255 - Sendbuff(4)
   
   SendLen = 21
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
        Call DisplayMsg(0, 0, "Value Stored")
        
   End If

End Sub

Private Sub bUpdateBlk_Click()

Dim i As Integer
Dim tmpStr As String
Dim charArray(0 To 99) As String

   'validate input
   If tBlkNoBin.Text = "" Then
        tBlkNoBin.SetFocus
        Exit Sub
   End If
   
   If tData.Text = "" Then
        tData.SetFocus
        Exit Sub
   End If
   
   Call ClearBuffers
   
   Sendbuff(0) = &HD4
   Sendbuff(1) = &H40
   Sendbuff(2) = &H1
   Sendbuff(3) = &HA0
   Sendbuff(4) = CInt("&H" & tBlkNoBin.Text)
   
   'get value in Data
   tmpStr = tData.Text
   
   'place each character in string to an array
   For i = 1 To Len(tmpStr)
    charArray(i) = Mid$(tmpStr, i, 1)
   Next i
   
   For i = 0 To Len(tmpStr) - 1
        Sendbuff(i + 5) = Asc(charArray(i + 1))
   Next i
   
   SendLen = 21
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
        Call DisplayMsg(0, 0, "Update Block Success")
        
        tData.Text = ""
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
    
    fraAuth.Enabled = False
    rbTypeA.Value = True
    fraBinBlkFxn.Enabled = False
    fraStatic.Enabled = False
    bReset.Enabled = False
    
    tBlkNo.Text = ""
    tKeyVal1.Text = ""
    tKeyVal2.Text = ""
    tKeyVal3.Text = ""
    tKeyVal4.Text = ""
    tKeyVal5.Text = ""
    tKeyVal6.Text = ""
    tBlkNoBin.Text = ""
    tData.Text = ""
    tAmt.Text = ""
    tStaticBlkNo.Text = ""
    tSrcBlk.Text = ""
    tTargetBlk.Text = ""
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

Private Sub tAmt_GotFocus()
    
    tAmt.SelStart = 0
    tAmt.SelLength = Len(tAmt.Text)
    
End Sub

Private Sub tAmt_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tBlkNo_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tBlkNoBin_GotFocus()

    tBlkNoBin.SelStart = 0
    tBlkNoBin.SelLength = Len(tBlkNoBin.Text)
    
End Sub

Private Sub tBlkNoBin_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tData_GotFocus()

    tData.SelStart = 0
    tData.SelLength = Len(tData.Text)
    
End Sub

Private Sub tKeyVal1_Change()

    If Len(tKeyVal1.Text) = tKeyVal1.MaxLength Then
    
       tKeyVal2.SetFocus
    
    End If

End Sub

Private Sub tKeyVal2_Change()

    If Len(tKeyVal2.Text) = tKeyVal2.MaxLength Then
    
       tKeyVal3.SetFocus
    
    End If

End Sub

Private Sub tKeyVal3_Change()

    If Len(tKeyVal3.Text) = tKeyVal3.MaxLength Then
    
       tKeyVal4.SetFocus
    
    End If

End Sub

Private Sub tKeyVal4_Change()

    If Len(tKeyVal4.Text) = tKeyVal4.MaxLength Then
    
       tKeyVal5.SetFocus
    
    End If

End Sub

Private Sub tKeyVal5_Change()

    If Len(tKeyVal5.Text) = tKeyVal5.MaxLength Then
    
       tKeyVal6.SetFocus
    
    End If

End Sub

Private Sub tKeyVal6_Change()

    If Len(tKeyVal6.Text) = tKeyVal6.MaxLength Then
    
       tKeyVal1.SetFocus
    
    End If

End Sub

Private Sub tKeyVal1_GotFocus()

    tKeyVal1.SelStart = 0
    tKeyVal1.SelLength = Len(tKeyVal1.Text)

End Sub

Private Sub tKeyVal2_GotFocus()

    tKeyVal2.SelStart = 0
    tKeyVal2.SelLength = Len(tKeyVal2.Text)

End Sub

Private Sub tKeyVal3_GotFocus()

    tKeyVal3.SelStart = 0
    tKeyVal3.SelLength = Len(tKeyVal3.Text)

End Sub

Private Sub tKeyVal4_GotFocus()

    tKeyVal4.SelStart = 0
    tKeyVal4.SelLength = Len(tKeyVal4.Text)

End Sub

Private Sub tKeyVal5_GotFocus()

    tKeyVal5.SelStart = 0
    tKeyVal5.SelLength = Len(tKeyVal5.Text)

End Sub

Private Sub tKeyVal6_GotFocus()

    tKeyVal6.SelStart = 0
    tKeyVal6.SelLength = Len(tKeyVal6.Text)

End Sub

Private Sub tBlkNo_GotFocus()

    tBlkNo.SelStart = 0
    tBlkNo.SelLength = Len(tBlkNo.Text)

End Sub

Private Sub tKeyVal1_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKeyVal2_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKeyVal3_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKeyVal4_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKeyVal5_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKeyVal6_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tSrcBlk_GotFocus()

    tSrcBlk.SelStart = 0
    tSrcBlk.SelLength = Len(tSrcBlk.Text)
    
End Sub

Private Sub tSrcBlk_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tStaticBlkNo_GotFocus()

    tStaticBlkNo.SelStart = 0
    tStaticBlkNo.SelLength = Len(tStaticBlkNo.Text)
    
End Sub

Private Sub tStaticBlkNo_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tTargetBlk_GotFocus()

    tTargetBlk.SelStart = 0
    tTargetBlk.SelLength = Len(tTargetBlk.Text)
    
End Sub

Private Sub tTargetBlk_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

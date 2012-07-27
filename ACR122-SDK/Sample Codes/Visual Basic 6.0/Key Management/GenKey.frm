VERSION 5.00
Begin VB.Form GenKey 
   Caption         =   "Generate Keys for MiFare"
   ClientHeight    =   4545
   ClientLeft      =   9795
   ClientTop       =   5115
   ClientWidth     =   7455
   Icon            =   "GenKey.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4545
   ScaleWidth      =   7455
   Begin VB.CommandButton bCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   5880
      TabIndex        =   8
      Top             =   4080
      Width           =   1455
   End
   Begin VB.Frame SaveKeysFra 
      Caption         =   "Save Keys"
      Height          =   3855
      Left            =   4440
      TabIndex        =   27
      Top             =   120
      Width           =   2895
      Begin VB.TextBox tsaveKc 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   1
         Top             =   1080
         Width           =   495
      End
      Begin VB.CommandButton bSaveKeys 
         Caption         =   "Save Keys"
         Height          =   375
         Left            =   1440
         TabIndex        =   7
         Top             =   3360
         Width           =   1215
      End
      Begin VB.TextBox tSaveKrd 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   6
         Top             =   2880
         Width           =   495
      End
      Begin VB.TextBox tSaveKcf 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   5
         Top             =   2520
         Width           =   495
      End
      Begin VB.TextBox tSaveKcr 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   4
         Top             =   2160
         Width           =   495
      End
      Begin VB.TextBox tSaveKd 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   3
         Top             =   1800
         Width           =   495
      End
      Begin VB.TextBox tSaveKt 
         Height          =   285
         Left            =   2160
         MaxLength       =   2
         TabIndex        =   2
         Top             =   1440
         Width           =   495
      End
      Begin VB.CheckBox chkSaveKrd 
         Caption         =   "Save to Sector No."
         Height          =   255
         Left            =   240
         TabIndex        =   9
         Top             =   2880
         Width           =   1815
      End
      Begin VB.CheckBox chkSaveKcf 
         Caption         =   "Save to Sector No."
         Height          =   255
         Left            =   240
         TabIndex        =   35
         Top             =   2520
         Width           =   1815
      End
      Begin VB.CheckBox chkSaveKcr 
         Caption         =   "Save to Sector No."
         Height          =   255
         Left            =   240
         TabIndex        =   34
         Top             =   2160
         Width           =   1815
      End
      Begin VB.CheckBox chkSaveKd 
         Caption         =   "Save to Sector No."
         Height          =   255
         Left            =   240
         TabIndex        =   33
         Top             =   1800
         Width           =   1815
      End
      Begin VB.CheckBox chkSaveKt 
         Caption         =   "Save to Sector No."
         Height          =   255
         Left            =   240
         TabIndex        =   32
         Top             =   1440
         Width           =   1815
      End
      Begin VB.CheckBox chkSaveKc 
         Caption         =   "Save to Sector No."
         Height          =   255
         Left            =   240
         TabIndex        =   31
         Top             =   1080
         Width           =   1815
      End
      Begin VB.OptionButton optTypeB 
         Caption         =   "Key Type B"
         Height          =   255
         Left            =   1440
         TabIndex        =   30
         Top             =   600
         Width           =   1215
      End
      Begin VB.OptionButton optTypeA 
         Caption         =   "Key Type A"
         Height          =   255
         Left            =   120
         TabIndex        =   29
         Top             =   600
         Value           =   -1  'True
         Width           =   1215
      End
      Begin VB.Label lblSaveAs 
         Caption         =   "Save as:"
         Height          =   255
         Left            =   120
         TabIndex        =   28
         Top             =   360
         Width           =   735
      End
   End
   Begin VB.Frame genKeyFra 
      Caption         =   "Generate Keys"
      Height          =   3855
      Left            =   120
      TabIndex        =   10
      Top             =   120
      Width           =   4215
      Begin VB.CommandButton bGenKeys 
         Caption         =   "Generate keys"
         Height          =   375
         Left            =   2040
         TabIndex        =   0
         Top             =   3360
         Width           =   1935
      End
      Begin VB.TextBox tKrd 
         Height          =   285
         Left            =   1920
         Locked          =   -1  'True
         TabIndex        =   26
         Top             =   2880
         Width           =   2055
      End
      Begin VB.TextBox tKcf 
         Height          =   285
         Left            =   1920
         Locked          =   -1  'True
         TabIndex        =   25
         Top             =   2520
         Width           =   2055
      End
      Begin VB.TextBox tKcr 
         Height          =   285
         Left            =   1920
         Locked          =   -1  'True
         TabIndex        =   24
         Top             =   2160
         Width           =   2055
      End
      Begin VB.TextBox tKd 
         Height          =   285
         Left            =   1920
         Locked          =   -1  'True
         TabIndex        =   23
         Top             =   1800
         Width           =   2055
      End
      Begin VB.TextBox tKt 
         Height          =   285
         Left            =   1920
         Locked          =   -1  'True
         TabIndex        =   22
         Top             =   1440
         Width           =   2055
      End
      Begin VB.TextBox tKc 
         Height          =   285
         Left            =   1920
         Locked          =   -1  'True
         TabIndex        =   21
         Top             =   1080
         Width           =   2055
      End
      Begin VB.TextBox tIC 
         Height          =   285
         Left            =   1920
         Locked          =   -1  'True
         TabIndex        =   20
         Top             =   720
         Width           =   2055
      End
      Begin VB.TextBox tSN 
         Height          =   285
         Left            =   1920
         Locked          =   -1  'True
         TabIndex        =   19
         Top             =   360
         Width           =   2055
      End
      Begin VB.Label lblKrd 
         Caption         =   "Revoke Debit Key (Krd):"
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   2880
         Width           =   1815
      End
      Begin VB.Label lblKcf 
         Caption         =   "Certify Key (Kcf):"
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   2520
         Width           =   1575
      End
      Begin VB.Label lblKcr 
         Caption         =   "Credit Key (Kcr):"
         Height          =   255
         Left            =   120
         TabIndex        =   16
         Top             =   2160
         Width           =   1575
      End
      Begin VB.Label lblKd 
         Caption         =   "Debit Key (Kd):"
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Top             =   1800
         Width           =   1575
      End
      Begin VB.Label lblKt 
         Caption         =   "Terminal Key (Kt):"
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   1440
         Width           =   1575
      End
      Begin VB.Label lblKc 
         Caption         =   "Card Key (Kc):"
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   1080
         Width           =   1575
      End
      Begin VB.Label lblIC 
         Caption         =   "Issuer Code (IC):"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   720
         Width           =   1575
      End
      Begin VB.Label lblSN 
         Caption         =   "Card Serial Number:"
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   360
         Width           =   1575
      End
   End
End
Attribute VB_Name = "GenKey"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub bCancel_Click()

    Unload Me
    
End Sub

Private Sub bGenKeys_Click()

Dim tmpStr As String
Dim i As Integer
Dim key As String

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
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Failed to Get Card Serial Number")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        
        For i = 8 To RecvBuff(7) + 7
   
            UID(i - 8) = RecvBuff(i)
            
        Next i
        
        tmpStr = ""
         For i = 0 To 3
   
            tmpStr = tmpStr & Right$("00" & Hex(UID(i)), 2) & " "
        
        Next i
        
        tSN.Text = tmpStr
   
        tmpStr = ""
        For i = 0 To RecvLen - 1
   
            tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
        Next i
        
        Call DisplayMsg(3, 0, tmpStr)
        Call DisplayMsg(0, 0, "Generate Serial Number Success")
    
    End If
    
    'Select Issuer DF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HA4
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H2
    Sendbuff(5) = &H11
    Sendbuff(6) = &H0
    
    SendLen = 7
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Failed to Select Issuer DF")
        Call DisplayMsg(1, ret, "")
    
    Else
   
        tmpStr = ""
        For i = 0 To RecvLen - 1
   
            tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
        Next i
        
        Call DisplayMsg(3, 0, tmpStr)
        Call DisplayMsg(0, 0, "Select Issuer DF Success")
    
    End If
    
    'Submit Issuer PIN
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &H20
    Sendbuff(2) = &H0
    Sendbuff(3) = &H1
    Sendbuff(4) = &H8
    
    For i = 0 To 7
        Sendbuff(5 + i) = GlobalPIN(i)
    Next i
    
    SendLen = 13
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Failed to Submit Issuer PIN")
        Call DisplayMsg(1, ret, "")
    
    Else
   
        tmpStr = ""
        For i = 0 To RecvLen - 1
   
            tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
        Next i
        
        Call DisplayMsg(3, 0, tmpStr)
        Call DisplayMsg(0, 0, "Submit Issuer PIN Success")
    
    End If
    
    'Generate Key
    'Generate IC Using 1st SAM Master Key (KeyID=81)
    key = GenerateSAMKey(&H81)
    If key = "" Then
        Call DisplayMsg(0, 0, "Failed to Obtain IC Key")
    Else
        tIC.Text = key
    End If
    
    'Generate Card Key Using 2nd SAM Master Key (KeyID=82)
    key = GenerateSAMKey(&H82)
    If key = "" Then
        Call DisplayMsg(0, 0, "Failed to Obtain Card Key")
    Else
        tKc.Text = key
    End If
    
    'Generate Terminal Key Using 3rd SAM Master Key (KeyID=83)
    key = GenerateSAMKey(&H83)
    If key = "" Then
        Call DisplayMsg(0, 0, "Failed to Obtain Terminal Key")
    Else
        tKt.Text = key
    End If
    
    'Generate Debit Key Using 2nd SAM Master Key (KeyID=84)
    key = GenerateSAMKey(&H84)
    If key = "" Then
        Call DisplayMsg(0, 0, "Failed to Obtain Debit Key")
    Else
        tKd.Text = key
    End If
    
    'Generate Credit Key Using 2nd SAM Master Key (KeyID=85)
    key = GenerateSAMKey(&H85)
    If key = "" Then
        Call DisplayMsg(0, 0, "Failed to Obtain Credit Key")
    Else
        tKcr.Text = key
    End If
    
    'Generate Certify Key Using 2nd SAM Master Key (KeyID=86)
    key = GenerateSAMKey(&H86)
    If key = "" Then
        Call DisplayMsg(0, 0, "Failed to Obtain Certify Key")
    Else
        tKcf.Text = key
    End If
    
    'Generate Revoke Debit Key Using 2nd SAM Master Key (KeyID=87)
    key = GenerateSAMKey(&H87)
    If key = "" Then
        Call DisplayMsg(0, 0, "Failed to Obtain Revoke Debit Key")
    Else
        tKrd.Text = key
    End If
    
    
    
End Sub

Private Function GenerateSAMKey(keyID As Byte) As String

Dim i As Integer
Dim tmpStr As String
Dim tmpStr2 As String

    Call ClearBuffers
    Sendbuff(0) = &H80
    Sendbuff(1) = &H88
    Sendbuff(2) = &H0
    Sendbuff(3) = keyID
    Sendbuff(4) = &H8

    For i = 0 To 3
        Sendbuff(i + 5) = UID(i)
    Next i
    
    SendLen = 13
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Error in Generating Key")
        Call DisplayMsg(1, ret, "")
    
    Else
   
        tmpStr = ""
        For i = 0 To RecvLen - 1
   
            tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
        Next i
        
        Call DisplayMsg(3, 0, tmpStr)
        Call DisplayMsg(0, 0, "Generate Key Success")
    
    End If
    
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HC0
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H8
    
    SendLen = 5
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Error in Generating Key")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        For i = 0 To RecvLen - 1
    
             tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
         
         
         Next i
         
         Call DisplayMsg(3, 0, tmpStr)
        
        If Right("00" & Hex(RecvBuff(RecvLen - 2)), 2) & Right("00" & Hex(RecvBuff(RecvLen - 1)), 2) <> "9000" Then
            Call DisplayMsg(0, 0, "Error in Generating Key")
        Else
        
         tmpStr2 = ""
         'Get only 1st 6 bytes as key
         For i = 0 To 5
    
             tmpStr2 = tmpStr2 & Right$("00" & Hex(RecvBuff(i)), 2)
         
         Next i
         
         Call DisplayMsg(0, 0, "Generate Key Success ")
         
        End If
    
    End If
    
    GenerateSAMKey = tmpStr2

End Function


Private Sub bSaveKeys_Click()

Dim result As Integer
Dim blk As Byte
    
    'check values
    If chkSaveKc.Value = vbChecked Then
        If tKc.Text = "" Then
            result = MsgBox("No Card Key Generated.", vbOKOnly & vbExclamation, "Error")
            Exit Sub
        End If
        
        If tsaveKc.Text = "" Then
            tsaveKc.SetFocus
            Exit Sub
        End If
    End If
    
    If chkSaveKt.Value = vbChecked Then
        If tKt.Text = "" Then
            result = MsgBox("No Terminal Key Generated.", vbOKOnly & vbExclamation, "Error")
            Exit Sub
        End If
        
        If tSaveKt.Text = "" Then
            tSaveKt.SetFocus
            Exit Sub
        End If
    End If

    If chkSaveKd.Value = vbChecked Then
        If tKd.Text = "" Then
            result = MsgBox("No Debit Key Generated.", vbOKOnly & vbExclamation, "Error")
            Exit Sub
        End If
        
        If tSaveKd.Text = "" Then
            tSaveKd.SetFocus
            Exit Sub
        End If
    End If
        
    If chkSaveKcr.Value = vbChecked Then
        If tKcr.Text = "" Then
            result = MsgBox("No Credit Key Generated.", vbOKOnly & vbExclamation, "Error")
            Exit Sub
        End If
        
        If tSaveKcr.Text = "" Then
            tSaveKcr.SetFocus
            Exit Sub
        End If
    End If
        
    If chkSaveKcf.Value = vbChecked Then
        If tKcf.Text = "" Then
            result = MsgBox("No Certify Key Generated.", vbOKOnly & vbExclamation, "Error")
            Exit Sub
        End If
        
        If tSaveKcf.Text = "" Then
            tSaveKcf.SetFocus
            Exit Sub
        End If
    End If
        
    If chkSaveKrd.Value = vbChecked Then
        If tKrd.Text = "" Then
            result = MsgBox("No Revoke Debit Key Generated.", vbOKOnly & vbExclamation, "Error")
            Exit Sub
        End If
        
        If tSaveKrd.Text = "" Then
            tSaveKrd.SetFocus
            Exit Sub
        End If
    End If
    
    'save selected values
    If chkSaveKc.Value = vbChecked Then
        blk = CInt("&H" & tsaveKc.Text)
        Call DisplayMsg(2, 0, "Saving Card Key...")
        Call SaveKey(blk, 1)
    End If
    
    If chkSaveKt.Value = vbChecked Then
        blk = CInt("&H" & tSaveKt.Text)
        Call DisplayMsg(2, 0, "Saving Terminal Key...")
        Call SaveKey(blk, 2)
    End If
    
    If chkSaveKd.Value = vbChecked Then
        blk = CInt("&H" & tSaveKd.Text)
        Call DisplayMsg(2, 0, "Saving Debit Key...")
        Call SaveKey(blk, 3)
    End If
    
    If chkSaveKcr.Value = vbChecked Then
        blk = CInt("&H" & tSaveKcr.Text)
        Call DisplayMsg(2, 0, "Saving Credit Key...")
        Call SaveKey(blk, 4)
    End If
    
    If chkSaveKcf.Value = vbChecked Then
        blk = CInt("&H" & tSaveKcf.Text)
        Call DisplayMsg(2, 0, "Saving Certify Key...")
        Call SaveKey(blk, 5)
    End If
    
    If chkSaveKrd.Value = vbChecked Then
        blk = CInt("&H" & tSaveKrd.Text)
        Call DisplayMsg(2, 0, "Saving Revoke Debit Key...")
        Call SaveKey(blk, 6)
    End If

End Sub

Public Sub SaveKey(blkNo As Byte, keyType As Integer)

Dim i As Integer
Dim tmpStr As String
Dim keyIn As String
Dim KeyInVal(0 To 10) As Byte
Dim tmpKey(0 To 100) As Byte
Dim tmpRcvBuff(0 To 255) As Byte

    blkNo = (blkNo * 4) + 3
    
    Call ClearBuffers
    Sendbuff(0) = &HD4
    Sendbuff(1) = &H40
    Sendbuff(2) = &H1
    Sendbuff(3) = &H60
    Sendbuff(4) = blkNo
    Sendbuff(5) = &HFF
    Sendbuff(6) = &HFF
    Sendbuff(7) = &HFF
    Sendbuff(8) = &HFF
    Sendbuff(9) = &HFF
    Sendbuff(10) = &HFF
    
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
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Error in Saving Key")
        Call DisplayMsg(1, ret, "")
    
    Else
   
        If RecvBuff(2) <> &H0 Then
            Call DisplayMsg(0, 0, "Error in Saving Key")
            Exit Sub
        Else
        
             tmpStr = ""
             For i = 0 To RecvLen - 1
        
                 tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
             
             Next i
             
             Call DisplayMsg(3, 0, tmpStr)
             Call DisplayMsg(0, 0, "Save Key Success")
             
        End If
    
    End If
    
    Call ClearBuffers
    Sendbuff(0) = &HD4
    Sendbuff(1) = &H40
    Sendbuff(2) = &H1
    Sendbuff(3) = &H30
    Sendbuff(4) = blkNo
    
    SendLen = 5
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_DirectTransmit(hReader, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Error in Saving Key")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        If RecvLen < 4 Then
            Call DisplayMsg(0, 0, "Error in Saving Key")
            Exit Sub
        Else
        
             For i = 3 To RecvLen - 1
        
                 tmpRcvBuff(i - 3) = RecvBuff(i)
             
             Next i
        
        End If
        
    End If
    
    'place generated keys in varable
    Select Case keyType
        Case 1
            keyIn = tKc.Text
        Case 2
            keyIn = tKt.Text
        Case 3
            keyIn = tKd.Text
        Case 4
            keyIn = tKcr.Text
        Case 5
            keyIn = tKcf.Text
        Case 6
            keyIn = tKrd.Text
        Case Else
            Call DisplayMsg(0, 0, "Error in Saving Key")
            Exit Sub
    End Select
    
    'change string to hex
    KeyInVal(0) = CInt("&H" & Mid(keyIn, 1, 2))
    KeyInVal(1) = CInt("&H" & Mid(keyIn, 3, 2))
    KeyInVal(2) = CInt("&H" & Mid(keyIn, 5, 2))
    KeyInVal(3) = CInt("&H" & Mid(keyIn, 7, 2))
    KeyInVal(4) = CInt("&H" & Mid(keyIn, 9, 2))
    KeyInVal(5) = CInt("&H" & Mid(keyIn, 11, 2))
    
    
    'check type
    If optTypeA.Value = True Then 'change left side with the generated key
        
        For i = 0 To 5
            tmpKey(i) = KeyInVal(i)
        Next i
        
        For i = 6 To 15
            tmpKey(i) = tmpRcvBuff(i)
        Next i
    
    Else    'change right side with the generated key
    
        For i = 0 To 9
            tmpKey(i) = tmpRcvBuff(i)
        Next i
        
        For i = 10 To 15
            tmpKey(i) = KeyInVal(i - 10)
        Next i
    
    End If
     
    'save the values in the card
     Call ClearBuffers
     Sendbuff(0) = &HD4
     Sendbuff(1) = &H40
     Sendbuff(2) = &H1
     Sendbuff(3) = &HA0
     Sendbuff(4) = blkNo
     
     For i = 0 To 15
        Sendbuff(5 + i) = tmpKey(i)
     Next i
     
     SendLen = 21
     RecvLen = 255
     
     tmpStr = ""
     For i = 0 To SendLen - 1
   
         tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
     Next i
   
     Call DisplayMsg(2, 0, tmpStr)
   
     ret = ACR122_DirectTransmit(hReader, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Saving Key Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
                
         tmpStr = ""
         For i = 0 To RecvLen - 1

             tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
     
         Next i

         Call DisplayMsg(3, 0, tmpStr)
         Call DisplayMsg(0, 0, "Save Key Success")
        
    End If
             
End Sub

Private Sub tsaveKc_Change()

    If Len(tsaveKc.Text) = tsaveKc.MaxLength Then
    
       tsaveKc.SetFocus
    
    End If
    
End Sub

Private Sub tsaveKc_GotFocus()

    tsaveKc.SelStart = 0
    tsaveKc.SelLength = Len(tsaveKc.Text)
    
End Sub

Private Sub tsaveKc_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tSaveKcf_Change()

    If Len(tSaveKcf.Text) = tSaveKcf.MaxLength Then
    
       tSaveKcf.SetFocus
    
    End If
    
End Sub

Private Sub tSaveKcf_GotFocus()

    tSaveKcf.SelStart = 0
    tSaveKcf.SelLength = Len(tSaveKcf.Text)
    
End Sub

Private Sub tSaveKcf_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tSaveKcr_Change()

    If Len(tSaveKcr.Text) = tSaveKcr.MaxLength Then
    
       tSaveKcr.SetFocus
    
    End If
    
End Sub

Private Sub tSaveKcr_GotFocus()

    tSaveKcr.SelStart = 0
    tSaveKcr.SelLength = Len(tSaveKcr.Text)
    
End Sub

Private Sub tSaveKcr_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tSaveKd_Change()

    If Len(tSaveKd.Text) = tSaveKd.MaxLength Then
    
       tSaveKd.SetFocus
    
    End If
    
End Sub

Private Sub tSaveKd_GotFocus()

    tSaveKd.SelStart = 0
    tSaveKd.SelLength = Len(tSaveKd.Text)
    
End Sub

Private Sub tSaveKd_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tSaveKrd_Change()

    If Len(tSaveKrd.Text) = tSaveKrd.MaxLength Then
    
       tSaveKrd.SetFocus
    
    End If
    
End Sub

Private Sub tSaveKrd_GotFocus()

    tSaveKrd.SelStart = 0
    tSaveKrd.SelLength = Len(tSaveKrd.Text)
    
End Sub

Private Sub tSaveKrd_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tSaveKt_Change()

    If Len(tSaveKt.Text) = tSaveKt.MaxLength Then
    
       tSaveKt.SetFocus
    
    End If
    
End Sub

Private Sub tSaveKt_GotFocus()

    tSaveKt.SelStart = 0
    tSaveKt.SelLength = Len(tSaveKt.Text)
    
End Sub

Private Sub tSaveKt_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

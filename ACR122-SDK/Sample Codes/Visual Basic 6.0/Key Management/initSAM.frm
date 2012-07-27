VERSION 5.00
Begin VB.Form initSAM 
   Caption         =   "Initialize SAM"
   ClientHeight    =   4080
   ClientLeft      =   9930
   ClientTop       =   5115
   ClientWidth     =   4455
   Icon            =   "initSAM.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4080
   ScaleWidth      =   4455
   Begin VB.CommandButton bCancel 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   2280
      TabIndex        =   9
      Top             =   3600
      Width           =   1695
   End
   Begin VB.CommandButton bInitSAM 
      Caption         =   "Initialize SAM"
      Height          =   375
      Left            =   480
      TabIndex        =   8
      Top             =   3600
      Width           =   1695
   End
   Begin VB.Frame MasterLeyFra 
      Caption         =   "SAM Master Keys"
      Height          =   3375
      Left            =   120
      TabIndex        =   10
      Top             =   120
      Width           =   4215
      Begin VB.TextBox tSAMGlobalPIN 
         Height          =   285
         Left            =   1920
         MaxLength       =   16
         TabIndex        =   0
         Top             =   360
         Width           =   2055
      End
      Begin VB.TextBox tKrd 
         Height          =   285
         Left            =   1920
         MaxLength       =   16
         TabIndex        =   7
         Top             =   2880
         Width           =   2055
      End
      Begin VB.TextBox tKcf 
         Height          =   285
         Left            =   1920
         MaxLength       =   16
         TabIndex        =   6
         Top             =   2520
         Width           =   2055
      End
      Begin VB.TextBox tKcr 
         Height          =   285
         Left            =   1920
         MaxLength       =   16
         TabIndex        =   5
         Top             =   2160
         Width           =   2055
      End
      Begin VB.TextBox tKd 
         Height          =   285
         Left            =   1920
         MaxLength       =   16
         TabIndex        =   4
         Top             =   1800
         Width           =   2055
      End
      Begin VB.TextBox tKt 
         Height          =   285
         Left            =   1920
         MaxLength       =   16
         TabIndex        =   3
         Top             =   1440
         Width           =   2055
      End
      Begin VB.TextBox tKc 
         Height          =   285
         Left            =   1920
         MaxLength       =   16
         TabIndex        =   2
         Top             =   1080
         Width           =   2055
      End
      Begin VB.TextBox tIC 
         Height          =   285
         Left            =   1920
         MaxLength       =   16
         TabIndex        =   1
         Top             =   720
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
      Begin VB.Label lblGlobalPIN 
         Caption         =   "SAM Global PIN:"
         Height          =   255
         Left            =   120
         TabIndex        =   11
         Top             =   360
         Width           =   1695
      End
   End
End
Attribute VB_Name = "initSAM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub bCancel_Click()

    Unload Me
    
End Sub

Private Sub bInitSAM_Click()

Dim tmpsStr As String
Dim i As Integer

    'check input
    If (tSAMGlobalPIN.Text = "") Or (Len(tSAMGlobalPIN.Text) < 16) Then
        tSAMGlobalPIN.SetFocus
        Exit Sub
    End If

    If (tIC.Text = "") Or (Len(tIC.Text) < 16) Then
        tIC.SetFocus
        Exit Sub
    End If
    
    If (tKc.Text = "") Or (Len(tKc.Text) < 16) Then
        tKc.SetFocus
        Exit Sub
    End If
    
    If (tKt.Text = "") Or (Len(tKt.Text) < 16) Then
        tKt.SetFocus
        Exit Sub
    End If
    
    If (tKd.Text = "") Or (Len(tKd.Text) < 16) Then
        tKd.SetFocus
        Exit Sub
    End If
    
    If (tKcr.Text = "") Or (Len(tKcr.Text) < 16) Then
        tKcr.SetFocus
        Exit Sub
    End If
    
    If (tKcf.Text = "") Or (Len(tKcf.Text) < 16) Then
        tKcf.SetFocus
        Exit Sub
    End If
    
    If (tKrd.Text = "") Or (Len(tKrd.Text) < 16) Then
        tKrd.SetFocus
        Exit Sub
    End If
    
    'clear card
    Call ClearBuffers
    Sendbuff(0) = &H80
    Sendbuff(1) = &H30
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H0
    
    SendLen = 5
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Clear Card Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        tmpStr = ""
        For i = 0 To RecvLen - 1
   
            tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
        Next i
   
        Call DisplayMsg(3, 0, tmpStr)
        Call DisplayMsg(0, 0, "Clear Card Success")
    
    End If
    
    'Reset SAM
    ret = ACR122_PowerOffIcc(hReader, 0)
    
    If ret <> 0 Then
    
        Call DisplayMsg(0, 0, "Power Off ICC Failed")
        Call DisplayMsg(1, ret, "")
        

    Else
    
        Call DisplayMsg(0, 0, "Power Off ICC.")
        
    End If
    
    ret = ACR122_Close(hReader)
    
    If ret <> 0 Then
    
        Call DisplayMsg(0, 0, "Close Port Failed")
        Call DisplayMsg(1, ret, "")

    Else
    
        Call DisplayMsg(0, 0, "Close Port.")
        
    End If
    
    ret = ACR122_Open(port, hReader)
        
    If ret <> 0 Then
    
        Call DisplayMsg(0, 0, "Open Port Failed")
        Call DisplayMsg(1, ret, "")

    Else
    
        Call DisplayMsg(0, 0, "Open Port.")
        
    End If
    
    Call ClearBuffers
    RecvLen = 255
    
    ret = ACR122_PowerOnIcc(hReader, 0, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
    
        Call DisplayMsg(0, 0, "Power On ICC Failed")
        Call DisplayMsg(1, ret, "")
       
    Else
    
        Call DisplayMsg(0, 0, "Power On ICC.")
        
    End If
    
    Call DisplayMsg(0, 0, "Reset Success.")
    
    'Create Master File
    Call ClearBuffers
    
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE0
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &HF
    Sendbuff(5) = &H62
    Sendbuff(6) = &HD
    Sendbuff(7) = &H82
    Sendbuff(8) = &H1
    Sendbuff(9) = &H3F
    Sendbuff(10) = &H83
    Sendbuff(11) = &H2
    Sendbuff(12) = &H3F
    Sendbuff(13) = &H0
    Sendbuff(14) = &H8A
    Sendbuff(15) = &H1
    Sendbuff(16) = &H1
    Sendbuff(17) = &H8C
    Sendbuff(18) = &H1
    Sendbuff(19) = &H0
    
    SendLen = 20
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
   
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Create Master File Failed")
        Call DisplayMsg(1, ret, "")
        
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Create Master File Failed")
            
        Else
        
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
            
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Create Master File Success")
            
        End If

    End If
    
    'Create EF1 to Store PIN
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE0
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H1B
    Sendbuff(5) = &H62
    Sendbuff(6) = &H19
    Sendbuff(7) = &H83
    Sendbuff(8) = &H2
    Sendbuff(9) = &HFF
    Sendbuff(10) = &HA
    Sendbuff(11) = &H88
    Sendbuff(12) = &H1
    Sendbuff(13) = &H1
    Sendbuff(14) = &H82
    Sendbuff(15) = &H6
    Sendbuff(16) = &HC
    Sendbuff(17) = &H0
    Sendbuff(18) = &H0
    Sendbuff(19) = &HA
    Sendbuff(20) = &H0
    Sendbuff(21) = &H1
    Sendbuff(22) = &H8C
    Sendbuff(23) = &H8
    Sendbuff(24) = &H7F
    Sendbuff(25) = &HFF
    Sendbuff(26) = &HFF
    Sendbuff(27) = &HFF
    Sendbuff(28) = &HFF
    Sendbuff(29) = &H27
    Sendbuff(30) = &H27
    Sendbuff(31) = &HFF
    
    SendLen = 32
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)

   
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "ICreate EF1 Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "ICreate EF1 Failed")
        
        Else
            
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Create EF1 Success")
            
        End If
        
    End If
    
    'Set Global PIN
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HDC
    Sendbuff(2) = &H1
    Sendbuff(3) = &H4
    Sendbuff(4) = &HA
    Sendbuff(5) = &H1
    Sendbuff(6) = &H88
    Sendbuff(7) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 1, 2))
    Sendbuff(8) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 3, 2))
    Sendbuff(9) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 5, 2))
    Sendbuff(10) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 7, 2))
    Sendbuff(11) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 9, 2))
    Sendbuff(12) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 11, 2))
    Sendbuff(13) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 13, 2))
    Sendbuff(14) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 15, 2))
    
    SendLen = 15
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Setting Global PIN Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Setting Global PIN Failed")
        
        Else
        
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Setting Global PIN Success")
            
        End If
        
    End If
    
    'Create DF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE0
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H2B
    Sendbuff(5) = &H62
    Sendbuff(6) = &H29
    Sendbuff(7) = &H82
    Sendbuff(8) = &H1
    Sendbuff(9) = &H38
    Sendbuff(10) = &H83
    Sendbuff(11) = &H2
    Sendbuff(12) = &H11
    Sendbuff(13) = &H0
    Sendbuff(14) = &H8A
    Sendbuff(15) = &H1
    Sendbuff(16) = &H1
    Sendbuff(17) = &H8C
    Sendbuff(18) = &H8
    Sendbuff(19) = &H7F
    Sendbuff(20) = &H3
    Sendbuff(21) = &H3
    Sendbuff(22) = &H3
    Sendbuff(23) = &H3
    Sendbuff(24) = &H3
    Sendbuff(25) = &H3
    Sendbuff(26) = &H3
    Sendbuff(27) = &H8D
    Sendbuff(28) = &H2
    Sendbuff(29) = &H41
    Sendbuff(30) = &H3
    Sendbuff(31) = &H80
    Sendbuff(32) = &H2
    Sendbuff(33) = &H3
    Sendbuff(34) = &H20
    Sendbuff(35) = &HAB
    Sendbuff(36) = &HB
    Sendbuff(37) = &H84
    Sendbuff(38) = &H1
    Sendbuff(39) = &H88
    Sendbuff(40) = &HA4
    Sendbuff(41) = &H6
    Sendbuff(42) = &H83
    Sendbuff(43) = &H1
    Sendbuff(44) = &H81
    Sendbuff(45) = &H95
    Sendbuff(46) = &H1
    Sendbuff(47) = &HFF
    
    SendLen = 48
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Create DF Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Create DF Failed")
        
        Else
        
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Creating DF Success")
            
        End If
        
    End If
    
    'Create Key File EF2
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE0
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H1D
    Sendbuff(5) = &H62
    Sendbuff(6) = &H1B
    Sendbuff(7) = &H82
    Sendbuff(8) = &H5
    Sendbuff(9) = &HC
    Sendbuff(10) = &H41
    Sendbuff(11) = &H0
    Sendbuff(12) = &H16
    Sendbuff(13) = &H8
    Sendbuff(14) = &H83
    Sendbuff(15) = &H2
    Sendbuff(16) = &H11
    Sendbuff(17) = &H1
    Sendbuff(18) = &H88
    Sendbuff(19) = &H1
    Sendbuff(20) = &H2
    Sendbuff(21) = &H8A
    Sendbuff(22) = &H1
    Sendbuff(23) = &H1
    Sendbuff(24) = &H8C
    Sendbuff(25) = &H8
    Sendbuff(26) = &H7F
    Sendbuff(27) = &H3
    Sendbuff(28) = &H3
    Sendbuff(29) = &H3
    Sendbuff(30) = &H3
    Sendbuff(31) = &H3
    Sendbuff(32) = &H3
    Sendbuff(33) = &H3
    
    SendLen = 34
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Create EF2 Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Create EF2 Failed")
        
        Else
            
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Creating EF2 Success")
        
        End If
        
    End If
    
    'Acquires the Global SAM PIN and assigns to Global array
    For i = 0 To 8
        GlobalPIN(i) = &H0
    Next i
    
    GlobalPIN(0) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 1, 2))
    GlobalPIN(1) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 3, 2))
    GlobalPIN(2) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 5, 2))
    GlobalPIN(3) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 7, 2))
    GlobalPIN(4) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 9, 2))
    GlobalPIN(5) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 11, 2))
    GlobalPIN(6) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 13, 2))
    GlobalPIN(7) = CInt("&H" & Mid(tSAMGlobalPIN.Text, 15, 2))
    
    'Append Record To EF2, Define 8 Key Records in EF2 - Master Keys
    '1st Master key, key ID=81, key type=03, int/ext authenticate, usage counter = FF FF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE2
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H16
    Sendbuff(5) = &H81  'key ID
    Sendbuff(6) = &H3
    Sendbuff(7) = &HFF
    Sendbuff(8) = &HFF
    Sendbuff(9) = &H88
    Sendbuff(10) = &H0
    Sendbuff(11) = CInt("&H" & Mid(tIC.Text, 1, 2))
    Sendbuff(12) = CInt("&H" & Mid(tIC.Text, 3, 2))
    Sendbuff(13) = CInt("&H" & Mid(tIC.Text, 5, 2))
    Sendbuff(14) = CInt("&H" & Mid(tIC.Text, 7, 2))
    Sendbuff(15) = CInt("&H" & Mid(tIC.Text, 9, 2))
    Sendbuff(16) = CInt("&H" & Mid(tIC.Text, 11, 2))
    Sendbuff(17) = CInt("&H" & Mid(tIC.Text, 13, 2))
    Sendbuff(18) = CInt("&H" & Mid(tIC.Text, 15, 2))
    
    SendLen = 19
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Appending IC Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Appending IC Failed")
        
        Else
        
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Appending IC Success")
            
        End If
        
    End If
    
    '2nd Master key, key ID=82, key type=03, int/ext authenticate, usage counter = FF FF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE2
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H16
    Sendbuff(5) = &H82  'key ID
    Sendbuff(6) = &H3
    Sendbuff(7) = &HFF
    Sendbuff(8) = &HFF
    Sendbuff(9) = &H88
    Sendbuff(10) = &H0
    Sendbuff(11) = CInt("&H" & Mid(tKc.Text, 1, 2))
    Sendbuff(12) = CInt("&H" & Mid(tKc.Text, 3, 2))
    Sendbuff(13) = CInt("&H" & Mid(tKc.Text, 5, 2))
    Sendbuff(14) = CInt("&H" & Mid(tKc.Text, 7, 2))
    Sendbuff(15) = CInt("&H" & Mid(tKc.Text, 9, 2))
    Sendbuff(16) = CInt("&H" & Mid(tKc.Text, 11, 2))
    Sendbuff(17) = CInt("&H" & Mid(tKc.Text, 13, 2))
    Sendbuff(18) = CInt("&H" & Mid(tKc.Text, 15, 2))
    
    SendLen = 19
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Appending Card Key Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Appending Card Key Failed")
        
        Else
        
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Appending Card Key Success")
        
        End If
        
    End If
    
    '3rd Master key, key ID=83, key type=03, int/ext authenticate, usage counter = FF FF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE2
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H16
    Sendbuff(5) = &H83  'key ID
    Sendbuff(6) = &H3
    Sendbuff(7) = &HFF
    Sendbuff(8) = &HFF
    Sendbuff(9) = &H88
    Sendbuff(10) = &H0
    Sendbuff(11) = CInt("&H" & Mid(tKt.Text, 1, 2))
    Sendbuff(12) = CInt("&H" & Mid(tKt.Text, 3, 2))
    Sendbuff(13) = CInt("&H" & Mid(tKt.Text, 5, 2))
    Sendbuff(14) = CInt("&H" & Mid(tKt.Text, 7, 2))
    Sendbuff(15) = CInt("&H" & Mid(tKt.Text, 9, 2))
    Sendbuff(16) = CInt("&H" & Mid(tKt.Text, 11, 2))
    Sendbuff(17) = CInt("&H" & Mid(tKt.Text, 13, 2))
    Sendbuff(18) = CInt("&H" & Mid(tKt.Text, 15, 2))
    
    SendLen = 19
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Appending Terminal Key Failed")
        Call DisplayMsg(1, ret, "")
    
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Appending Terminal Key Failed")
        
        Else
            
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
    
            Call DisplayMsg(0, 0, "Appending Terminal Key Success")
            
        End If
        
    End If
    
    '4th Master key, key ID=84, key type=03, int/ext authenticate, usage counter = FF FF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE2
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H16
    Sendbuff(5) = &H84  'key ID
    Sendbuff(6) = &H3
    Sendbuff(7) = &HFF
    Sendbuff(8) = &HFF
    Sendbuff(9) = &H88
    Sendbuff(10) = &H0
    Sendbuff(11) = CInt("&H" & Mid(tKd.Text, 1, 2))
    Sendbuff(12) = CInt("&H" & Mid(tKd.Text, 3, 2))
    Sendbuff(13) = CInt("&H" & Mid(tKd.Text, 5, 2))
    Sendbuff(14) = CInt("&H" & Mid(tKd.Text, 7, 2))
    Sendbuff(15) = CInt("&H" & Mid(tKd.Text, 9, 2))
    Sendbuff(16) = CInt("&H" & Mid(tKd.Text, 11, 2))
    Sendbuff(17) = CInt("&H" & Mid(tKd.Text, 13, 2))
    Sendbuff(18) = CInt("&H" & Mid(tKd.Text, 15, 2))
    
    SendLen = 19
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Appending Debit Key Failed")
        Call DisplayMsg(1, ret, "")
        
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Appending Debit Key Failed")
        
        Else
        
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Appending Debit Key Success")
        End If
        
    End If
    
    '5th Master key, key ID=85, key type=03, int/ext authenticate, usage counter = FF FF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE2
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H16
    Sendbuff(5) = &H85  'key ID
    Sendbuff(6) = &H3
    Sendbuff(7) = &HFF
    Sendbuff(8) = &HFF
    Sendbuff(9) = &H88
    Sendbuff(10) = &H0
    Sendbuff(11) = CInt("&H" & Mid(tKcr.Text, 1, 2))
    Sendbuff(12) = CInt("&H" & Mid(tKcr.Text, 3, 2))
    Sendbuff(13) = CInt("&H" & Mid(tKcr.Text, 5, 2))
    Sendbuff(14) = CInt("&H" & Mid(tKcr.Text, 7, 2))
    Sendbuff(15) = CInt("&H" & Mid(tKcr.Text, 9, 2))
    Sendbuff(16) = CInt("&H" & Mid(tKcr.Text, 11, 2))
    Sendbuff(17) = CInt("&H" & Mid(tKcr.Text, 13, 2))
    Sendbuff(18) = CInt("&H" & Mid(tKcr.Text, 15, 2))
    
    SendLen = 19
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Appending Credit Key Failed")
        Call DisplayMsg(1, ret, "")
        
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Appending Credit Key Failed")
        
        Else
        
            tmpStr = ""
            For i = 0 To RecvLen - 1
   
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
        
            Next i
   
            Call DisplayMsg(3, 0, tmpStr)
    
            Call DisplayMsg(0, 0, "Appending Credit Key Success")
        End If
        
    End If
    
    '6th Master key, key ID=86, key type=03, int/ext authenticate, usage counter = FF FF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE2
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H16
    Sendbuff(5) = &H86  'key ID
    Sendbuff(6) = &H3
    Sendbuff(7) = &HFF
    Sendbuff(8) = &HFF
    Sendbuff(9) = &H88
    Sendbuff(10) = &H0
    Sendbuff(11) = CInt("&H" & Mid(tKcf.Text, 1, 2))
    Sendbuff(12) = CInt("&H" & Mid(tKcf.Text, 3, 2))
    Sendbuff(13) = CInt("&H" & Mid(tKcf.Text, 5, 2))
    Sendbuff(14) = CInt("&H" & Mid(tKcf.Text, 7, 2))
    Sendbuff(15) = CInt("&H" & Mid(tKcf.Text, 9, 2))
    Sendbuff(16) = CInt("&H" & Mid(tKcf.Text, 11, 2))
    Sendbuff(17) = CInt("&H" & Mid(tKcf.Text, 13, 2))
    Sendbuff(18) = CInt("&H" & Mid(tKcf.Text, 15, 2))
    
    SendLen = 19
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
    
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Appending Certify Key Failed")
        Call DisplayMsg(1, ret, "")
        
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Appending Certify Key Failed")
        
        Else
            
            tmpStr = ""
            For i = 0 To RecvLen - 1
            
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
                 
            Next i
            
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Appending Certify Key Success")
        
        End If
        
    End If
    
    '7th Master key, key ID=87, key type=03, int/ext authenticate, usage counter = FF FF
    Call ClearBuffers
    Sendbuff(0) = &H0
    Sendbuff(1) = &HE2
    Sendbuff(2) = &H0
    Sendbuff(3) = &H0
    Sendbuff(4) = &H16
    Sendbuff(5) = &H87  'key ID
    Sendbuff(6) = &H3
    Sendbuff(7) = &HFF
    Sendbuff(8) = &HFF
    Sendbuff(9) = &H88
    Sendbuff(10) = &H0
    Sendbuff(11) = CInt("&H" & Mid(tKrd.Text, 1, 2))
    Sendbuff(12) = CInt("&H" & Mid(tKrd.Text, 3, 2))
    Sendbuff(13) = CInt("&H" & Mid(tKrd.Text, 5, 2))
    Sendbuff(14) = CInt("&H" & Mid(tKrd.Text, 7, 2))
    Sendbuff(15) = CInt("&H" & Mid(tKrd.Text, 9, 2))
    Sendbuff(16) = CInt("&H" & Mid(tKrd.Text, 11, 2))
    Sendbuff(17) = CInt("&H" & Mid(tKrd.Text, 13, 2))
    Sendbuff(18) = CInt("&H" & Mid(tKrd.Text, 15, 2))
    
    SendLen = 19
    RecvLen = 255
    
    tmpStr = ""
    For i = 0 To SendLen - 1
   
        tmpStr = tmpStr & Right$("00" & Hex(Sendbuff(i)), 2) & " "
        
    Next i
   
    Call DisplayMsg(2, 0, tmpStr)
   
    ret = ACR122_ExchangeApdu(hReader, 0, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)
       
    If ret <> 0 Then
        
        Call DisplayMsg(0, 0, "Appending Revoke Debit Key Failed")
        Call DisplayMsg(1, ret, "")
        
    Else
        
        If Right("00" & Hex(RecvBuff(0)), 2) & Right("00" & Hex(RecvBuff(1)), 2) <> "9000" Then
            
            Call DisplayMsg(0, 0, "Appending Revoke Debit Key Failed")
        
        Else
            
            tmpStr = ""
            For i = 0 To RecvLen - 1
            
                tmpStr = tmpStr & Right$("00" & Hex(RecvBuff(i)), 2) & " "
                 
            Next i
            
            Call DisplayMsg(3, 0, tmpStr)
            Call DisplayMsg(0, 0, "Appending Revoke Debit Key Success")
        
        End If
        
    End If
    
    Unload Me
    
End Sub

Private Sub tIC_Change()

    If Len(tIC.Text) = tIC.MaxLength Then
    
       tKc.SetFocus
    
    End If
    
End Sub

Private Sub tIC_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKc_Change()

    If Len(tKc.Text) = tKc.MaxLength Then
    
       tKt.SetFocus
    
    End If


End Sub

Private Sub tKc_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
End Sub

Private Sub tKcf_Change()

    If Len(tKcf.Text) = tKcf.MaxLength Then
    
       tKrd.SetFocus
    
    End If


End Sub

Private Sub tKcf_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKcr_Change()

    If Len(tKcr.Text) = tKcr.MaxLength Then
    
       tKcf.SetFocus
    
    End If


End Sub

Private Sub tKcr_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKd_Change()

    If Len(tKd.Text) = tKd.MaxLength Then
    
       tKcr.SetFocus
    
    End If


End Sub

Private Sub tKd_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKrd_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tKt_Change()

    If Len(tKt.Text) = tKt.MaxLength Then
    
       tKd.SetFocus
    
    End If


End Sub

Private Sub tKt_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

Private Sub tSAMGlobalPIN_Change()

    If Len(tSAMGlobalPIN.Text) = tSAMGlobalPIN.MaxLength Then
    
       tIC.SetFocus
    
    End If
    
End Sub

Private Sub tSAMGlobalPIN_KeyPress(KeyAscii As Integer)

    If KeyAscii > 96 And KeyAscii < 103 Then
            
            KeyAscii = KeyAscii - 32
            
    End If
    
    If KeyAscii < 32 Or InStr("0123456789ABCDEF", Chr$(KeyAscii)) > 0 Then
        'do nothing
    Else
        KeyAscii = 0
    End If
    
End Sub

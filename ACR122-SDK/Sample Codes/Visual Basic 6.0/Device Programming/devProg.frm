VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form devProg 
   Caption         =   "ACR122S Device Programming"
   ClientHeight    =   7950
   ClientLeft      =   5865
   ClientTop       =   3390
   ClientWidth     =   8400
   Icon            =   "devProg.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   7950
   ScaleWidth      =   8400
   Begin VB.Frame fraSetLED 
      Caption         =   "Set LED States with Beep"
      Height          =   6135
      Left            =   120
      TabIndex        =   11
      Top             =   1680
      Width           =   3615
      Begin VB.CommandButton bSetLed 
         Caption         =   "Set LED and Buzzer"
         Height          =   375
         Left            =   600
         TabIndex        =   28
         Top             =   5640
         Width           =   2415
      End
      Begin VB.Frame fraLED1 
         Caption         =   "LED 0"
         Height          =   1695
         Left            =   120
         TabIndex        =   25
         Top             =   3840
         Width           =   3375
         Begin VB.Frame fraInitBlinkLED1 
            BorderStyle     =   0  'None
            Height          =   375
            Left            =   240
            TabIndex        =   41
            Top             =   720
            Width           =   2895
            Begin VB.OptionButton optInitBlinkOffLED1 
               Caption         =   "Off"
               Height          =   255
               Left            =   2160
               TabIndex        =   43
               Top             =   0
               Width           =   615
            End
            Begin VB.OptionButton optInitBlinkOnLED1 
               Caption         =   "On"
               Height          =   255
               Left            =   1560
               TabIndex        =   42
               Top             =   0
               Width           =   615
            End
            Begin VB.Label lblInitBlinkLED1 
               Caption         =   "Initial Blinking State:"
               Height          =   255
               Left            =   0
               TabIndex        =   44
               Top             =   0
               Width           =   1935
            End
         End
         Begin VB.Frame fraFinStateLED1 
            BorderStyle     =   0  'None
            Height          =   255
            Left            =   240
            TabIndex        =   37
            Top             =   360
            Width           =   3015
            Begin VB.OptionButton optFinStateOffLED1 
               Caption         =   "Off"
               Height          =   255
               Left            =   2160
               TabIndex        =   39
               Top             =   0
               Width           =   615
            End
            Begin VB.OptionButton optFinStateOnLED1 
               Caption         =   "On"
               Height          =   255
               Left            =   1560
               TabIndex        =   38
               Top             =   0
               Width           =   615
            End
            Begin VB.Label lblFinStateLED1 
               Caption         =   "Final State:"
               Height          =   255
               Left            =   0
               TabIndex        =   40
               Top             =   0
               Width           =   1095
            End
         End
         Begin VB.CheckBox chkEnableUpdateLED1 
            Caption         =   "Enable Update"
            Height          =   255
            Left            =   240
            TabIndex        =   27
            Top             =   1200
            Width           =   1575
         End
         Begin VB.CheckBox chkEnableBlinkLED1 
            Caption         =   "Enable Blink"
            Height          =   255
            Left            =   1800
            TabIndex        =   26
            Top             =   1200
            Width           =   1335
         End
      End
      Begin VB.Frame fraLED0 
         Height          =   1695
         Left            =   120
         TabIndex        =   22
         Top             =   2040
         Width           =   3375
         Begin VB.Frame fraInitBlinkLED0 
            BorderStyle     =   0  'None
            Height          =   255
            Left            =   240
            TabIndex        =   33
            Top             =   720
            Width           =   2775
            Begin VB.OptionButton optInitBlinkOnLED0 
               Caption         =   "On"
               Height          =   255
               Left            =   1560
               TabIndex        =   35
               Top             =   0
               Width           =   615
            End
            Begin VB.OptionButton optInitBlinkOffLED0 
               Caption         =   "Off"
               Height          =   255
               Left            =   2160
               TabIndex        =   34
               Top             =   0
               Width           =   615
            End
            Begin VB.Label lblInitBlinkLED0 
               Caption         =   "Initial Blinking State:"
               Height          =   255
               Left            =   0
               TabIndex        =   36
               Top             =   0
               Width           =   1935
            End
         End
         Begin VB.Frame fraFinStateLED0 
            BorderStyle     =   0  'None
            Height          =   255
            Left            =   240
            TabIndex        =   29
            Top             =   360
            Width           =   2775
            Begin VB.OptionButton optFinStateOnLED0 
               Caption         =   "On"
               Height          =   255
               Left            =   1560
               TabIndex        =   31
               Top             =   0
               Width           =   615
            End
            Begin VB.OptionButton optFinStateOffLED0 
               Caption         =   "Off"
               Height          =   255
               Left            =   2160
               TabIndex        =   30
               Top             =   0
               Width           =   615
            End
            Begin VB.Label lblFinStateLED0 
               Caption         =   "Final State:"
               Height          =   255
               Left            =   0
               TabIndex        =   32
               Top             =   0
               Width           =   1095
            End
         End
         Begin VB.CheckBox chkEnableBlinkLED0 
            Caption         =   "Enable Blink"
            Height          =   255
            Left            =   1800
            TabIndex        =   24
            Top             =   1200
            Width           =   1335
         End
         Begin VB.CheckBox chkEnableUpdateLED0 
            Caption         =   "Enable Update"
            Height          =   255
            Left            =   240
            TabIndex        =   23
            Top             =   1200
            Width           =   1575
         End
      End
      Begin VB.Frame fraBuzzer 
         Caption         =   "Buzzer"
         Height          =   1575
         Left            =   120
         TabIndex        =   12
         Top             =   360
         Width           =   3375
         Begin VB.CheckBox chkOnT2 
            Caption         =   "On - T2"
            Height          =   255
            Left            =   1920
            TabIndex        =   21
            Top             =   960
            Width           =   855
         End
         Begin VB.CheckBox chkOnT1 
            Caption         =   "On - T1"
            Height          =   255
            Left            =   1920
            TabIndex        =   20
            Top             =   600
            Width           =   855
         End
         Begin VB.TextBox tTimes 
            Height          =   285
            Left            =   960
            TabIndex        =   18
            Text            =   "1"
            Top             =   1080
            Width           =   495
         End
         Begin VB.TextBox tT2 
            Height          =   285
            Left            =   960
            TabIndex        =   17
            Text            =   "100"
            Top             =   720
            Width           =   495
         End
         Begin VB.TextBox tT1 
            Height          =   285
            Left            =   960
            TabIndex        =   16
            Text            =   "100"
            Top             =   360
            Width           =   495
         End
         Begin VB.Label lblBuzzMode 
            Caption         =   "Buzzer Mode"
            Height          =   255
            Left            =   1920
            TabIndex        =   19
            Top             =   240
            Width           =   1095
         End
         Begin VB.Label lblTimes 
            Caption         =   "Times"
            Height          =   255
            Left            =   240
            TabIndex        =   15
            Top             =   1080
            Width           =   855
         End
         Begin VB.Label lblT2 
            Caption         =   "T2 (ms)"
            Height          =   255
            Left            =   240
            TabIndex        =   14
            Top             =   720
            Width           =   735
         End
         Begin VB.Label lblT1 
            Caption         =   "T1 (ms)"
            Height          =   255
            Left            =   240
            TabIndex        =   13
            Top             =   360
            Width           =   735
         End
      End
   End
   Begin VB.CommandButton bSetTO 
      Caption         =   "Set Timeouts"
      Height          =   375
      Left            =   2400
      TabIndex        =   10
      Top             =   1200
      Width           =   1335
   End
   Begin VB.CommandButton bBaudRate 
      Caption         =   "Set Baud Rate"
      Height          =   375
      Left            =   2400
      TabIndex        =   9
      Top             =   720
      Width           =   1335
   End
   Begin VB.ComboBox cbBaudRate 
      Height          =   315
      Left            =   1080
      TabIndex        =   8
      Text            =   "9600"
      Top             =   720
      Width           =   1215
   End
   Begin RichTextLib.RichTextBox mMsg 
      Height          =   7215
      Left            =   3840
      TabIndex        =   6
      Top             =   120
      Width           =   4455
      _ExtentX        =   7858
      _ExtentY        =   12726
      _Version        =   393217
      TextRTF         =   $"devProg.frx":17A2
   End
   Begin VB.CommandButton bQuit 
      Caption         =   "Quit"
      Height          =   375
      Left            =   6960
      TabIndex        =   5
      Top             =   7440
      Width           =   1335
   End
   Begin VB.CommandButton bReset 
      Caption         =   "Reset"
      Height          =   375
      Left            =   5400
      TabIndex        =   4
      Top             =   7440
      Width           =   1335
   End
   Begin VB.CommandButton bClear 
      Caption         =   "Clear"
      Height          =   375
      Left            =   3840
      TabIndex        =   3
      Top             =   7440
      Width           =   1335
   End
   Begin VB.CommandButton bConnect 
      Caption         =   "Connect"
      Height          =   375
      Left            =   2400
      TabIndex        =   2
      Top             =   240
      Width           =   1335
   End
   Begin VB.ComboBox cbPort 
      Height          =   315
      Left            =   1080
      TabIndex        =   1
      Text            =   "COM1"
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label lblBaudRate 
      Caption         =   "Baud Rate: "
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   840
      Width           =   975
   End
   Begin VB.Label lblPort 
      Caption         =   "Select Port:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   1095
   End
End
Attribute VB_Name = "devProg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'===============================================================================
'
' Company       : Advanced Card Systems, Ltd
'
' File          : devProg.frm
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



Private Sub bBaudRate_Click()

    Call DisplayMsg(0, 0, "Set Baud Rate to " & cbBaudRate.Text & "...")
    
    If cbBaudRate.Text = "9600" Then
    
        ret = ACR122_SetBaudRate(hReader, 9600)
    
    Else
        
        ret = ACR122_SetBaudRate(hReader, 115200)
        
    End If
    
    If ret <> 0 Then
           Call DisplayMsg(1, ret, "")
           Exit Sub
       Else
           Call DisplayMsg(0, 0, "Set Baud Rate Success.")
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
            bReset.Enabled = True
            fraSetLED.Enabled = True
            cbBaudRate.Enabled = True
            bBaudRate.Enabled = True
            bSetTO.Enabled = True
            
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

Private Sub bSetLed_Click()

Dim LEDCtrl(0 To 1) As ACR122_LED_CONTROL
Dim buzzMode, t1, t2 As Long
Dim num As Integer

    If tT1.Text = "" Then
        tT1.SetFocus
        Exit Sub
    End If
    
    If tT2.Text = "" Then
        tT2.SetFocus
        Exit Sub
    End If
    
    If tTimes.Text = "" Then
        tTimes.SetFocus
        Exit Sub
    End If
    
    If CInt(tT1.Text) > 25500 Then
        tT1.Text = "25500"
        Exit Sub
    End If
    
    If CInt(tT2.Text) > 25500 Then
        tT2.Text = "25500"
        Exit Sub
    End If
    
    If CInt(tTimes.Text) > 255 Then
        tTimes.Text = "255"
        Exit Sub
    End If
    
    num = CInt(tTimes.Text)
    t1 = CLng(tT1.Text)
    t2 = CLng(tT2.Text)
    
    'LED Control Values
    If optFinStateOnLED0.Value = True Then
        LEDCtrl(0).finalState = ACR122_LED_STATE_ON
    Else
        LEDCtrl(0).finalState = ACR122_LED_STATE_OFF
    End If
    
    If optInitBlinkOnLED0.Value = True Then
        LEDCtrl(0).initialBlinkingState = ACR122_LED_STATE_ON
    Else
        LEDCtrl(0).initialBlinkingState = ACR122_LED_STATE_OFF
    End If
    
    If chkEnableBlinkLED0.Value = vbChecked Then
        LEDCtrl(0).blinkEnabled = True
    Else
        LEDCtrl(0).blinkEnabled = False
    End If
    
    If chkEnableUpdateLED0.Value = vbChecked Then
        LEDCtrl(0).updateEnables = True
    Else
        LEDCtrl(0).updateEnables = False
    End If
    
    If optFinStateOnLED1.Value = True Then
        LEDCtrl(1).finalState = ACR122_LED_STATE_ON
    Else
        LEDCtrl(1).finalState = ACR122_LED_STATE_OFF
    End If
    
    If optInitBlinkOnLED1.Value = True Then
        LEDCtrl(1).initialBlinkingState = ACR122_LED_STATE_ON
    Else
        LEDCtrl(1).initialBlinkingState = ACR122_LED_STATE_OFF
    End If
    
    If chkEnableBlinkLED1.Value = vbChecked Then
        LEDCtrl(1).blinkEnabled = True
    Else
        LEDCtrl(1).blinkEnabled = False
    End If
    
    If chkEnableUpdateLED1.Value = vbChecked Then
        LEDCtrl(1).updateEnables = True
    Else
        LEDCtrl(1).updateEnables = False
    End If
    
    If chkOnT1.Value = vbChecked Then
        buzzMode = ACR122_BUZZER_MODE_T1
    End If
    
    If chkOnT2.Value = vbChecked Then
        buzzMode = ACR122_BUZZER_MODE_T2
    End If
    
    If chkOnT1.Value = vbChecked And chkOnT2.Value = vbChecked Then
        buzzMode = ACR122_BUZZER_MODE_T1 Or ACR122_BUZZER_MODE_T2
    End If
    
    If chkOnT1.Value = vbUnchecked And chkOnT2.Value = vbUnchecked Then
        buzzMode = ACR122_BUZZER_MODE_OFF
    End If
    
    Call DisplayMsg(0, 0, "Setting LED and Buzzer...")
    
    ret = ACR122_SetLedStatesWithBeep(hReader, LEDCtrl(0), 2, t1, t2, num, buzzMode)
    
    If ret <> 0 Then
           Call DisplayMsg(1, ret, "")
           Exit Sub
       Else
           Call DisplayMsg(0, 0, "Set LED and Buzzer Success.")
    End If
    
End Sub

Private Sub bSetTO_Click()
    setTO.Show
    Me.Enabled = False
End Sub

Private Sub Form_Load()

    Call InitMenu
        
End Sub

Private Sub InitMenu()

    Dim i As Integer
    
    For i = 1 To 9
        cbPort.AddItem ("COM" & i)
    Next i
    
    cbBaudRate.AddItem (9600)
    cbBaudRate.AddItem (115200)
        
    tT1.Text = ""
    tT2.Text = ""
    tTimes.Text = ""
    chkOnT1.Value = vbChecked
    chkOnT2.Value = vbChecked
    chkEnableUpdateLED0.Value = vbUnchecked
    chkEnableUpdateLED1.Value = vbUnchecked
    chkEnableBlinkLED0.Value = vbUnchecked
    chkEnableBlinkLED1.Value = vbUnchecked
    optFinStateOnLED0.Value = True
    optFinStateOnLED1.Value = True
    optInitBlinkOnLED0.Value = True
    optInitBlinkOnLED1.Value = True
    optFinStateOffLED0.Value = False
    optFinStateOffLED1.Value = False
    optInitBlinkOffLED0.Value = False
    optInitBlinkOffLED1.Value = False
    
    fraSetLED.Enabled = False
    cbBaudRate.Enabled = False
    bBaudRate.Enabled = False
    bSetTO.Enabled = False
    bReset.Enabled = False
    
    mMsg.Text = ""
    Call DisplayMsg(0, 0, "Program Ready")
    
    conn = False

End Sub






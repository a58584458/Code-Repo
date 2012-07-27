Public Class DeviceProgramming
    Public retCode As Integer
    Public hReader As Integer
    Dim connActive As Boolean

    Private Sub GroupBox3_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GroupBox3.Enter

    End Sub

    Private Sub RadioButton2_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbOff1.CheckedChanged

    End Sub

    Private Sub DeviceProgramming_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        InitMenu()
    End Sub
    Private Sub InitMenu()
        Dim i As Integer

        mMsg.Text = ""

        DisplayMsg(0, 0, "Program Ready")

        For i = 1 To 10
            cbPort.Items.Add("COM" & i)
        Next i
        cbPort.SelectedIndex = 0

        cbBaudRate.Items.Add("9600")
        cbBaudRate.Items.Add("115200")

        cbBaudRate.SelectedIndex = 0

        bConn.Enabled = True

        cT1.Checked = True
        cT2.Checked = True

        rbOn1.Checked = True
        rbOn2.Checked = True
        rbOn3.Checked = True
        rbOn4.Checked = True


        EnableAll(False)

        connActive = False

    End Sub
    Private Sub EnableAll(ByVal opt As Boolean)

        bSetBaud.Enabled = opt
        bSetTimeout.Enabled = opt
        bSetLedBuzz.Enabled = opt
        bReset.Enabled = opt

        tbT1.Enabled = opt
        tbT2.Enabled = opt
        tbTimes.Enabled = opt

        cT1.Enabled = opt
        cT2.Enabled = opt
        cbUpdate1.Enabled = opt
        cbUpdate2.Enabled = opt
        cbBlink1.Enabled = opt
        cbBlink2.Enabled = opt

        rbOn1.Enabled = opt
        rbOn2.Enabled = opt
        rbOn3.Enabled = opt
        rbOn4.Enabled = opt
        rbOff1.Enabled = opt
        rbOff2.Enabled = opt
        rbOff3.Enabled = opt
        rbOff4.Enabled = opt


    End Sub
    Public Sub DisplayMsg(ByVal mType As Object, ByVal msgCode As Integer, ByVal PrintText As String)

        Select Case mType
            'Notification
            Case 0
                mMsg.SelectionColor = System.Drawing.ColorTranslator.FromOle(&H4000)
                'Error Message
            Case 1
                mMsg.SelectionColor = System.Drawing.Color.Red
                'input data
            Case 2
                mMsg.SelectionColor = System.Drawing.Color.Black
                PrintText = "< " & PrintText

                'output data
            Case 3
                mMsg.SelectionColor = System.Drawing.Color.Black
                PrintText = "> " & PrintText

        End Select

        mMsg.SelectedText = PrintText & vbCrLf
        mMsg.SelectionStart = Len(mMsg.Text)
        mMsg.SelectionColor = System.Drawing.Color.Black
        mMsg.Focus()



    End Sub

    Private Sub bConn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bConn.Click
        Dim a, tmpStr As String
        Dim fwVersion(0 To 262) As Byte
        Dim fwLen, i As Integer

        a = cbPort.Text
        fwLen = 256
        tmpStr = ""

        retCode = ACR122_Open(a, hReader)

        If retCode = 0 Then
            DisplayMsg(0, 0, "Connection to " & a & " success")
            connActive = True
            bConn.Enabled = False
            bReset.Enabled = True

            retCode = ACR122_GetFirmwareVersion(hReader, 0, fwVersion(0), fwLen)

            If retCode = 0 Then
                DisplayMsg(0, 0, "Get Firmware Success")

                For i = 0 To fwLen - 1
                    tmpStr = tmpStr & Chr(fwVersion(i))
                Next i

                DisplayMsg(0, 0, "Firmware: " & tmpStr)
                DisplayMsg(0, 0, "")
            Else
                DisplayMsg(1, 0, "Get Firmware Failed")
            End If

            EnableAll(True)

        Else
            DisplayMsg(1, 0, "Connection to " & a & " failed")
        End If
    End Sub

    Private Sub bQuit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bQuit.Click
        If connActive = True Then
            ACR122_Close(hReader)
        End If

        Me.Close()
    End Sub

    Private Sub bReset_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bReset.Click
        If connActive = True Then
            ACR122_Close(hReader)
            InitMenu()
            connActive = False
        End If
    End Sub

    Private Sub bClear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bClear.Click
        mMsg.Text = ""
    End Sub

    Private Sub bSetBaud_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bSetBaud.Click

        retCode = ACR122_SetBaudRate(hReader, Int(cbBaudRate.Text))

        If retCode = 0 Then
            Call DisplayMsg(0, 0, "Set Baud Rate " & cbBaudRate.Text & " Success.")
        Else
            Call DisplayMsg(1, 0, "Set Baud Rate " & cbBaudRate.Text & " Failed")
        End If

    End Sub

    Private Sub tbT1_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbT1.KeyPress, tbT2.KeyPress, tbTimes.KeyPress
        If InStr("0123456789", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack Then

        Else
            e.KeyChar = ""

        End If
    End Sub

    Private Sub bSetLedBuzz_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bSetLedBuzz.Click
        Dim ledCtrl(1) As ACR122_LED_CONTROL
        Dim buzzMode, t1 As Object
        Dim t2 As Integer
        Dim num As Short

        If tbT1.Text = "" Then
            tbT1.Focus()
            Exit Sub
        End If

        If tbT2.Text = "" Then
            tbT2.Focus()
            Exit Sub
        End If

        If tbTimes.Text = "" Then
            tbTimes.Focus()
            Exit Sub
        End If

        If CShort(tbT1.Text) > 25500 Then
            tbT1.Text = "25500"
            tbT1.Focus()
            Exit Sub
        End If

        If CShort(tbT2.Text) > 25500 Then
            tbT2.Text = "25500"
            tbT2.Focus()
            Exit Sub
        End If

        If CShort(tbTimes.Text) > 255 Then
            tbTimes.Text = "255"
            tbTimes.Focus()
            Exit Sub
        End If

        num = CShort(tbTimes.Text)
        t1 = CInt(tbT1.Text)
        t2 = CInt(tbT2.Text)

        'L0 Final State
        If rbOn1.Checked = True Then
            ledCtrl(0).finalState = ACR122_LED_STATE_ON
        Else
            ledCtrl(0).finalState = ACR122_LED_STATE_OFF
        End If

        'L0 Initial Blinking State
        If rbOn2.Checked = True Then
            ledCtrl(0).initialBlinkingState = ACR122_LED_STATE_ON
        Else
            ledCtrl(0).initialBlinkingState = ACR122_LED_STATE_OFF
        End If

        'L1 Final State
        If rbOn3.Checked = True Then
            ledCtrl(1).finalState = ACR122_LED_STATE_ON
        Else
            ledCtrl(1).finalState = ACR122_LED_STATE_OFF
        End If

        'L1 Initial Blinking State
        If rbOn4.Checked = True Then
            ledCtrl(1).initialBlinkingState = ACR122_LED_STATE_ON
        Else
            ledCtrl(1).initialBlinkingState = ACR122_LED_STATE_OFF
        End If

        'L0 Enable Blink
        If cbBlink1.Checked = True Then
            ledCtrl(0).blinkEnabled = True
        Else
            ledCtrl(0).blinkEnabled = False
        End If

        'L1 Enable Blink
        If cbBlink2.Checked = True Then
            ledCtrl(1).blinkEnabled = True
        Else
            ledCtrl(1).blinkEnabled = False
        End If

        'L0 Enable Update
        If cbUpdate1.Checked = True Then
            ledCtrl(0).updateEnabled = True
        Else
            ledCtrl(0).updateEnabled = False
        End If

        'L1 Enable Update
        If cbUpdate2.Checked = True Then
            ledCtrl(1).updateEnabled = True
        Else
            ledCtrl(1).updateEnabled = False
        End If


        If cT1.Checked = True Then
            buzzMode = ACR122_BUZZER_MODE_T1
        End If

        If cT2.Checked = True Then
            buzzMode = ACR122_BUZZER_MODE_T2
        End If

        If cT1.Checked = True And cT2.Checked = True Then
            buzzMode = ACR122_BUZZER_MODE_T1 Or ACR122_BUZZER_MODE_T2
        End If

        If cT1.Checked = False And cT2.Checked = False Then
            buzzMode = ACR122_BUZZER_MODE_OFF
        End If

        retCode = ACR122_SetLedStatesWithBeep(hReader, ledCtrl(0), 2, t1, t2, num, buzzMode)

        If retCode = 0 Then
            DisplayMsg(0, 0, "Set LED States with Beep success")
        Else
            DisplayMsg(1, 0, "Set LED States with Beep failed")
        End If



    End Sub

    Private Sub Label2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label2.Click

    End Sub

    Private Sub GroupBox1_Enter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GroupBox1.Enter

    End Sub

    Private Sub bSetTimeout_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bSetTimeout.Click
        Dialog.Show()

    End Sub
End Class

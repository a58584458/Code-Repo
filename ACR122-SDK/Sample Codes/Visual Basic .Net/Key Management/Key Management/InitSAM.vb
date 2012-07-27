Public Class InitSAM

    Dim isHex As Byte

    Private Sub btnInit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnInit.Click
        Dim port As String
        Dim i, k As Integer

        If tbGlobal.Text = "" Then
            MessageBox.Show("Please enter 8 bytes of keys for Global PIN")
            tbGlobal.Focus()
            Exit Sub
        End If

        If tbIC.Text = "" Then
            MessageBox.Show("Please enter 8 bytes of keys for Issuer Code")
            tbIC.Focus()
            Exit Sub
        End If

        If tbKc.Text = "" Then
            MessageBox.Show("Please enter 8 bytes of keys for Card Key")
            tbKc.Focus()
            Exit Sub
        End If

        If tbKt.Text = "" Then
            MessageBox.Show("Please enter 8 bytes of keys for Terminal Key")
            tbKt.Focus()
            Exit Sub
        End If

        If tbKd.Text = "" Then
            MessageBox.Show("Please enter 8 bytes of keys for Debit Key")
            tbKd.Focus()
            Exit Sub
        End If

        If tbKcr.Text = "" Then
            MessageBox.Show("Please enter 8 bytes of keys for Credit Key")
            tbKcr.Focus()
            Exit Sub
        End If

        If tbKcf.Text = "" Then
            MessageBox.Show("Please enter 8 bytes of keys for Certify Key")
            tbKcf.Focus()
            Exit Sub
        End If

        If tbKrd.Text = "" Then
            MessageBox.Show("Please enter 8 bytes of keys for Revoke Debit Key")
            tbKrd.Focus()
            Exit Sub
        End If

        frmMain.ClearBuffers()
        'Clear Card
        frmMain.SendBuff(0) = &H80
        frmMain.SendBuff(1) = &H30
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H0

        frmMain.SendLen = 5
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)

        'Reset SAM
        frmMain.retCode = ACR122_PowerOffIcc(frmMain.hReader, 0)
        frmMain.retCode = ACR122_Close(frmMain.hReader)
        port = frmMain.cbPort.Text
        frmMain.retCode = ACR122_Open(port, frmMain.hReader)
        frmMain.RecvLen = 255
        frmMain.retCode = ACR122_PowerOnIcc(frmMain.hReader, 0, frmMain.RecvBuff(0), frmMain.RecvLen)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Power on ICC failed")
            Me.Close()
            Exit Sub
        End If

        'Create Master File
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE0
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &HF
        frmMain.SendBuff(5) = &H62
        frmMain.SendBuff(6) = &HD
        frmMain.SendBuff(7) = &H82
        frmMain.SendBuff(8) = &H1
        frmMain.SendBuff(9) = &H3F
        frmMain.SendBuff(10) = &H83
        frmMain.SendBuff(11) = &H2
        frmMain.SendBuff(12) = &H3F
        frmMain.SendBuff(13) = &H0
        frmMain.SendBuff(14) = &H8A
        frmMain.SendBuff(15) = &H1
        frmMain.SendBuff(16) = &H1
        frmMain.SendBuff(17) = &H8C
        frmMain.SendBuff(18) = &H1
        frmMain.SendBuff(19) = &H0

        frmMain.SendLen = 20
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Creating Master File failed")
            Me.Close()
            Exit Sub
        End If

        'Create EF1 to store PIN
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE0
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H1B
        frmMain.SendBuff(5) = &H62
        frmMain.SendBuff(6) = &H19
        frmMain.SendBuff(7) = &H83
        frmMain.SendBuff(8) = &H2
        frmMain.SendBuff(9) = &HFF
        frmMain.SendBuff(10) = &HA
        frmMain.SendBuff(11) = &H88
        frmMain.SendBuff(12) = &H1
        frmMain.SendBuff(13) = &H1
        frmMain.SendBuff(14) = &H82
        frmMain.SendBuff(15) = &H6
        frmMain.SendBuff(16) = &HC
        frmMain.SendBuff(17) = &H0
        frmMain.SendBuff(18) = &H0
        frmMain.SendBuff(19) = &HA
        frmMain.SendBuff(20) = &H0
        frmMain.SendBuff(21) = &H1
        frmMain.SendBuff(22) = &H8C
        frmMain.SendBuff(23) = &H8
        frmMain.SendBuff(24) = &H7F
        frmMain.SendBuff(25) = &HFF
        frmMain.SendBuff(26) = &HFF
        frmMain.SendBuff(27) = &HFF
        frmMain.SendBuff(28) = &HFF
        frmMain.SendBuff(29) = &H27
        frmMain.SendBuff(30) = &H27
        frmMain.SendBuff(31) = &HFF

        frmMain.SendLen = 32
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Creating EF1 failed")
            Me.Close()
            Exit Sub
        End If

        'Set Global PIN
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HDC
        frmMain.SendBuff(2) = &H1
        frmMain.SendBuff(3) = &H4
        frmMain.SendBuff(4) = &HA
        frmMain.SendBuff(5) = &H1
        frmMain.SendBuff(6) = &H88

        i = 0
        k = 0
        While i < 15
            frmMain.SendBuff(k + 7) = Convert.ToByte(tbGlobal.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        frmMain.SendLen = 15
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Setting global PIN failed")
            Me.Close()
            Exit Sub
        End If

        'Create DF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE0
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H2B
        frmMain.SendBuff(5) = &H62
        frmMain.SendBuff(6) = &H29
        frmMain.SendBuff(7) = &H82
        frmMain.SendBuff(8) = &H1
        frmMain.SendBuff(9) = &H38
        frmMain.SendBuff(10) = &H83
        frmMain.SendBuff(11) = &H2
        frmMain.SendBuff(12) = &H11
        frmMain.SendBuff(13) = &H0
        frmMain.SendBuff(14) = &H8A
        frmMain.SendBuff(15) = &H1
        frmMain.SendBuff(16) = &H1
        frmMain.SendBuff(17) = &H8C
        frmMain.SendBuff(18) = &H8
        frmMain.SendBuff(19) = &H7F
        frmMain.SendBuff(20) = &H3
        frmMain.SendBuff(21) = &H3
        frmMain.SendBuff(22) = &H3
        frmMain.SendBuff(23) = &H3
        frmMain.SendBuff(24) = &H3
        frmMain.SendBuff(25) = &H3
        frmMain.SendBuff(26) = &H3
        frmMain.SendBuff(27) = &H8D
        frmMain.SendBuff(28) = &H2
        frmMain.SendBuff(29) = &H41
        frmMain.SendBuff(30) = &H3
        frmMain.SendBuff(31) = &H80
        frmMain.SendBuff(32) = &H2
        frmMain.SendBuff(33) = &H3
        frmMain.SendBuff(34) = &H20
        frmMain.SendBuff(35) = &HAB
        frmMain.SendBuff(36) = &HB
        frmMain.SendBuff(37) = &H84
        frmMain.SendBuff(38) = &H1
        frmMain.SendBuff(39) = &H88
        frmMain.SendBuff(40) = &HA4
        frmMain.SendBuff(41) = &H6
        frmMain.SendBuff(42) = &H83
        frmMain.SendBuff(43) = &H1
        frmMain.SendBuff(44) = &H81
        frmMain.SendBuff(45) = &H95
        frmMain.SendBuff(46) = &H1
        frmMain.SendBuff(47) = &HFF

        frmMain.SendLen = 48
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Creating DF failed")
            Me.Close()
            Exit Sub
        End If

        'Create Key file
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE0
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H1D
        frmMain.SendBuff(5) = &H62
        frmMain.SendBuff(6) = &H1B
        frmMain.SendBuff(7) = &H82
        frmMain.SendBuff(8) = &H5
        frmMain.SendBuff(9) = &HC
        frmMain.SendBuff(10) = &H41
        frmMain.SendBuff(11) = &H0
        frmMain.SendBuff(12) = &H16
        frmMain.SendBuff(13) = &H8
        frmMain.SendBuff(14) = &H83
        frmMain.SendBuff(15) = &H2
        frmMain.SendBuff(16) = &H11
        frmMain.SendBuff(17) = &H1
        frmMain.SendBuff(18) = &H88
        frmMain.SendBuff(19) = &H1
        frmMain.SendBuff(20) = &H2
        frmMain.SendBuff(21) = &H8A
        frmMain.SendBuff(22) = &H1
        frmMain.SendBuff(23) = &H1
        frmMain.SendBuff(24) = &H8C
        frmMain.SendBuff(25) = &H8
        frmMain.SendBuff(26) = &H7F
        frmMain.SendBuff(27) = &H3
        frmMain.SendBuff(28) = &H3
        frmMain.SendBuff(29) = &H3
        frmMain.SendBuff(30) = &H3
        frmMain.SendBuff(31) = &H3
        frmMain.SendBuff(32) = &H3
        frmMain.SendBuff(33) = &H3

        frmMain.SendLen = 34
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Creating EF2 failed")
            Me.Close()
            Exit Sub
        End If

        'Acquires the global SAM PIN and assigns to global array
        i = 0
        k = 0
        While i < 15
            frmMain.GSAM(k) = Convert.ToByte(tbGlobal.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        'Append Record To EF2, Define 8 Key Records in EF2 - Master Keys
        '1st Master key, key ID=81, key type=03, int/ext authenticate, usage counter = FF FF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE2
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H16
        frmMain.SendBuff(5) = &H81 'KeyID
        frmMain.SendBuff(6) = &H3
        frmMain.SendBuff(7) = &HFF
        frmMain.SendBuff(8) = &HFF
        frmMain.SendBuff(9) = &H88
        frmMain.SendBuff(10) = &H0

        i = 0
        k = 0
        While i < 15
            frmMain.SendBuff(k + 11) = Convert.ToByte(tbIC.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        frmMain.SendLen = 19
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Appending Issuer Code to EF2 failed")
            Me.Close()
            Exit Sub
        End If

        '2nd Master key, key ID=82, key type=03, int/ext authenticate, usage counter = FF FF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE2
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H16
        frmMain.SendBuff(5) = &H82 'KeyID
        frmMain.SendBuff(6) = &H3
        frmMain.SendBuff(7) = &HFF
        frmMain.SendBuff(8) = &HFF
        frmMain.SendBuff(9) = &H88
        frmMain.SendBuff(10) = &H0

        i = 0
        k = 0
        While i < 15
            frmMain.SendBuff(k + 11) = Convert.ToByte(tbKc.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        frmMain.SendLen = 19
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Appending Card Key to EF2 failed")
            Me.Close()
            Exit Sub
        End If

        '3rd Master key, key ID=83, key type=03, int/ext authenticate, usage counter = FF FF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE2
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H16
        frmMain.SendBuff(5) = &H83 'KeyID
        frmMain.SendBuff(6) = &H3
        frmMain.SendBuff(7) = &HFF
        frmMain.SendBuff(8) = &HFF
        frmMain.SendBuff(9) = &H88
        frmMain.SendBuff(10) = &H0

        i = 0
        k = 0
        While i < 15
            frmMain.SendBuff(k + 11) = Convert.ToByte(tbKt.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        frmMain.SendLen = 19
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Appending Terminal Key to EF2 failed")
            Me.Close()
            Exit Sub
        End If

        '4th Master key, key ID=84, key type=03, int/ext authenticate, usage counter = FF FF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE2
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H16
        frmMain.SendBuff(5) = &H84 'KeyID
        frmMain.SendBuff(6) = &H3
        frmMain.SendBuff(7) = &HFF
        frmMain.SendBuff(8) = &HFF
        frmMain.SendBuff(9) = &H88
        frmMain.SendBuff(10) = &H0

        i = 0
        k = 0
        While i < 15
            frmMain.SendBuff(k + 11) = Convert.ToByte(tbKd.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        frmMain.SendLen = 19
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Appending Debit Key to EF2 failed")
            Me.Close()
            Exit Sub
        End If

        '5th Master key, key ID=85, key type=03, int/ext authenticate, usage counter = FF FF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE2
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H16
        frmMain.SendBuff(5) = &H85 'KeyID
        frmMain.SendBuff(6) = &H3
        frmMain.SendBuff(7) = &HFF
        frmMain.SendBuff(8) = &HFF
        frmMain.SendBuff(9) = &H88
        frmMain.SendBuff(10) = &H0

        i = 0
        k = 0
        While i < 15
            frmMain.SendBuff(k + 11) = Convert.ToByte(tbKd.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        frmMain.SendLen = 19
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Appending Credit Key to EF2 failed")
            Me.Close()
            Exit Sub
        End If

        '6th Master key, key ID=86, key type=03, int/ext authenticate, usage counter = FF FF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE2
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H16
        frmMain.SendBuff(5) = &H86 'KeyID
        frmMain.SendBuff(6) = &H3
        frmMain.SendBuff(7) = &HFF
        frmMain.SendBuff(8) = &HFF
        frmMain.SendBuff(9) = &H88
        frmMain.SendBuff(10) = &H0

        i = 0
        k = 0
        While i < 15
            frmMain.SendBuff(k + 11) = Convert.ToByte(tbKcf.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        frmMain.SendLen = 19
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Appending Certify Key to EF2 failed")
            Me.Close()
            Exit Sub
        End If

        '7th Master key, key ID=87, key type=03, int/ext authenticate, usage counter = FF FF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HE2
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H16
        frmMain.SendBuff(5) = &H87 'KeyID
        frmMain.SendBuff(6) = &H3
        frmMain.SendBuff(7) = &HFF
        frmMain.SendBuff(8) = &HFF
        frmMain.SendBuff(9) = &H88
        frmMain.SendBuff(10) = &H0

        i = 0
        k = 0
        While i < 15
            frmMain.SendBuff(k + 11) = Convert.ToByte(tbKrd.Text.Substring(i, 2), 16)
            i += 2
            k += 1
        End While

        frmMain.SendLen = 19
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 OrElse frmMain.RecvBuff(0) <> &H90 Then
            frmMain.DisplayMsg(1, "Appending Revoke Debit Key to EF2 failed")
            Me.Close()
            Exit Sub
        End If

        frmMain.DisplayMsg(0, "Initializing SAM success")
        Me.Close()
    End Sub

    Private Sub tbGlobal_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbGlobal.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tbIC_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbIC.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tbKc_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbKc.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tbKt_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbKt.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tbKd_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbKd.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tbKcr_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbKcr.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tbKcf_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbKcf.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tbKrd_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbKrd.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Me.Close()
    End Sub
End Class
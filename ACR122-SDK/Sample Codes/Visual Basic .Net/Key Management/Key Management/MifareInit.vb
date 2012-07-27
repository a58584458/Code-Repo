Public Class MifareInit

    Dim UID(0 To 3) As Byte
    Dim isHex As Byte

    Public Sub SaveKey(ByVal BlockNo As Byte, ByVal Keytype As Integer)
        Dim tempstr, keyin As String
        Dim i, k As Integer

        tempstr = ""
        keyin = ""

        BlockNo = (BlockNo * 4) + 3

        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &HD4
        frmMain.SendBuff(1) = &H40
        frmMain.SendBuff(2) = &H1
        frmMain.SendBuff(3) = &H60
        frmMain.SendBuff(4) = BlockNo
        frmMain.SendBuff(5) = &HFF
        frmMain.SendBuff(6) = &HFF
        frmMain.SendBuff(7) = &HFF
        frmMain.SendBuff(8) = &HFF
        frmMain.SendBuff(9) = &HFF
        frmMain.SendBuff(10) = &HFF

        For i = 0 To 3
            frmMain.SendBuff(i + 11) = UID(i)
        Next

        frmMain.SendLen = 15
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(0)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Error in saving key")
            Me.Close()
            Exit Sub
        Else
            If frmMain.RecvBuff(2) <> &H0 Then
                frmMain.DisplayMsg(1, "Error in saving key")
                Me.Close()
                Exit Sub
            End If
        End If

        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &HD4
        frmMain.SendBuff(1) = &H40
        frmMain.SendBuff(2) = &H1
        frmMain.SendBuff(3) = &H30
        frmMain.SendBuff(4) = BlockNo

        frmMain.SendLen = 5
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(0)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Error in saving key")
            Me.Close()
            Exit Sub
        Else
            If frmMain.RecvLen < 4 Then
                frmMain.DisplayMsg(1, "Error in saving key")
                Me.Close()
                Exit Sub
            End If

            tempstr = ""
            For i = 3 To frmMain.RecvLen - 1
                tempstr = tempstr + String.Format("{0:X2}", frmMain.RecvBuff(i))
            Next
        End If

        Select Case Keytype
            Case 1
                keyin = tbKc.Text
                Exit Select
            Case 2
                keyin = tbKt.Text
                Exit Select
            Case 3
                keyin = tbKd.Text
                Exit Select
            Case 4
                keyin = tbKcr.Text
                Exit Select
            Case 5
                keyin = tbKcf.Text
                Exit Select
            Case 6
                keyin = tbKrd.Text
                Exit Select
            Case 7
                frmMain.DisplayMsg(1, "Error in saving key")
                Me.Close()
                Exit Sub
                Exit Select
        End Select

        If rbA.Checked Then
            i = 0
            k = 0
            While i < 32
                If i < 12 Then
                    frmMain.RecvBuff(k) = Convert.ToByte(keyin.Substring(i, 2), 16)
                Else
                    frmMain.RecvBuff(k) = Convert.ToByte(tempstr.Substring(i, 2), 16)
                End If
                i += 2
                k += 1
            End While
        Else
            i = 0
            k = 0
            While i < 32
                If i < 20 Then
                    frmMain.RecvBuff(k) = Convert.ToByte(tempstr.Substring(i, 2), 16)
                Else
                    frmMain.RecvBuff(k) = Convert.ToByte(tempstr.Substring(i, 2), 16)
                End If
                i += 2
                k += 1
            End While
        End If

        frmMain.SendBuff(0) = &HD4
        frmMain.SendBuff(1) = &H40
        frmMain.SendBuff(2) = &H1
        frmMain.SendBuff(3) = &HA0
        frmMain.SendBuff(4) = BlockNo

        For i = 0 To 15
            frmMain.SendBuff(i + 5) = frmMain.RecvBuff(i)
        Next

        frmMain.SendLen = 21
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(0)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Error in saving key")
            Me.Close()
            Exit Sub
        End If
    End Sub

    Public Function GenSAMKey(ByVal KeyID As Byte) As String
        Dim i As Integer
        Dim buff As String

        buff = ""

        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H80
        frmMain.SendBuff(1) = &H88
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = KeyID 'KeyID
        frmMain.SendBuff(4) = &H8

        For i = 0 To 3
            frmMain.SendBuff(i + 5) = UID(i)
        Next

        frmMain.SendLen = 13
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Error in Generating Keys")
            Me.Close()
            Return ""
        End If

        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HC0
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H8

        frmMain.SendLen = 5
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Error in Generating Keys")
            Me.Close()
            Return ""
        Else
            If frmMain.RecvLen = 0 Then
                frmMain.DisplayMsg(1, "Error in Generating Keys")
                Me.Close()
                Return ""
            End If

            If (frmMain.RecvBuff(frmMain.RecvLen - 2) = &H90 And frmMain.RecvBuff(frmMain.RecvLen - 1) = &H0) Then
                For i = 0 To 5
                    buff = buff + String.Format("{0:X2}", frmMain.RecvBuff(i))
                Next
            End If
        End If

        Return buff
    End Function

    Private Sub button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button1.Click
        Dim i As Integer
        Dim serial, key As String

        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &HD4
        frmMain.SendBuff(1) = &H4A
        frmMain.SendBuff(2) = &H1
        frmMain.SendBuff(3) = &H0

        frmMain.SendLen = 4
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(0)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Failed to get card serial number")
            Me.Close()
        Else
            For i = 8 To frmMain.RecvBuff(7) + 7
                UID(i - 8) = frmMain.RecvBuff(i)
            Next

            serial = ""
            For i = 0 To 3
                serial = serial + String.Format("{0:X2} ", UID(i))
            Next
            tbSerial.Text = serial
        End If

        'Select Issuer DF
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &HA4
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H0
        frmMain.SendBuff(4) = &H2
        frmMain.SendBuff(5) = &H11
        frmMain.SendBuff(6) = &H0

        frmMain.SendLen = 7
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Failed to select Issuer DF")
            Me.Close()
            Exit Sub
        End If

        'Submit Issuer PIN
        frmMain.ClearBuffers()
        frmMain.SendBuff(0) = &H0
        frmMain.SendBuff(1) = &H20
        frmMain.SendBuff(2) = &H0
        frmMain.SendBuff(3) = &H1
        frmMain.SendBuff(4) = &H8

        For i = 0 To 7
            frmMain.SendBuff(i + 4) = frmMain.GSAM(i)
        Next

        frmMain.SendLen = 13
        frmMain.RecvLen = 255

        frmMain.retCode = frmMain.SendAPDUandDisplay(1)
        If frmMain.retCode <> 0 Then
            frmMain.DisplayMsg(1, "Failed to submit Issuer PIN")
            Me.Close()
            Exit Sub
        End If

        'Generate Key
        'Generate IC Using 1st SAM Master Key (KeyID=81)
        key = GenSAMKey(&H81)
        If key.Length = 0 Then
            frmMain.DisplayMsg(1, "Failed to obtain IC Key")
            Me.Close()
            Exit Sub
        Else
            tbIC.Text = key
        End If

        'Generate Card Key Using 2nd SAM Master Key (KeyID=82)    
        key = GenSAMKey(&H82)
        If key.Length = 0 Then
            frmMain.DisplayMsg(1, "Failed to obtain Card Key")
            Me.Close()
            Exit Sub
        Else
            tbKc.Text = key
        End If

        'Generate Terminal Key Using 3rd SAM Master Key (KeyID=83)
        key = GenSAMKey(&H83)
        If key.Length = 0 Then
            frmMain.DisplayMsg(1, "Failed to obtain Terminal Key")
            Me.Close()
            Exit Sub
        Else
            tbKt.Text = key
        End If

        'Generate Debit Key Using 4th SAM Master Key (KeyID=84) 
        key = GenSAMKey(&H84)
        If key.Length = 0 Then
            frmMain.DisplayMsg(1, "Failed to obtain Debit Key")
            Me.Close()
            Exit Sub
        Else
            tbKd.Text = key
        End If

        'Generate Credit Key Using 5th SAM Master Key (KeyID=85) 
        key = GenSAMKey(&H85)
        If key.Length = 0 Then
            frmMain.DisplayMsg(1, "Failed to obtain Credit Key")
            Me.Close()
            Exit Sub
        Else
            tbKcr.Text = key
        End If

        'Generate Certify Key Using 6th SAM Master Key (KeyID=86)  
        key = GenSAMKey(&H86)
        If key.Length = 0 Then
            frmMain.DisplayMsg(1, "Failed to obtain Certify Key")
            Me.Close()
            Exit Sub
        Else
            tbKcf.Text = key
        End If

        'Generate Revoke Debit Key Using 7th SAM Master Key (KeyID=87)    
        key = GenSAMKey(&H87)
        If key.Length = 0 Then
            frmMain.DisplayMsg(1, "Failed to obtain Revoke Debit Key")
            Me.Close()
            Exit Sub
        Else
            tbKrd.Text = key
        End If

        Me.Focus()
    End Sub

    Private Sub button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button2.Click
        Dim dr As DialogResult = MessageBox.Show("Saving keys to Mifare assumes that the keys stored is ""FF FF FF FF FF FF"". Continue?", "", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning)
        If dr = DialogResult.Cancel Then
            Exit Sub
        End If

        If cb1.Checked Then
            If tb1.Text.Length < 1 Then
                MessageBox.Show("Please key-in value for sector number")
                tb1.Focus()
                Exit Sub
            End If
        End If

        If cb2.Checked Then
            If tb2.Text.Length < 1 Then
                MessageBox.Show("Please key-in value for sector number")
                tb2.Focus()
                Exit Sub
            End If
        End If

        If cb3.Checked Then
            If tb3.Text.Length < 1 Then
                MessageBox.Show("Please key-in value for sector number")
                tb3.Focus()
                Exit Sub
            End If
        End If

        If cb4.Checked Then
            If tb4.Text.Length < 1 Then
                MessageBox.Show("Please key-in value for sector number")
                tb4.Focus()
                Exit Sub
            End If
        End If

        If cb5.Checked Then
            If tb5.Text.Length < 1 Then
                MessageBox.Show("Please key-in value for sector number")
                tb5.Focus()
                Exit Sub
            End If
        End If

        If cb6.Checked Then
            If tb6.Text.Length < 1 Then
                MessageBox.Show("Please key-in value for sector number")
                tb6.Focus()
                Exit Sub
            End If
        End If

        If cb1.Checked Then
            isHex = Convert.ToByte(tb1.Text, 16)
            SaveKey(isHex, 1)
        End If

        If cb2.Checked Then
            isHex = Convert.ToByte(tb2.Text, 16)
            SaveKey(isHex, 2)
        End If

        If cb3.Checked Then
            isHex = Convert.ToByte(tb3.Text, 16)
            SaveKey(isHex, 3)
        End If

        If cb4.Checked Then
            isHex = Convert.ToByte(tb4.Text, 16)
            SaveKey(isHex, 4)
        End If

        If cb5.Checked Then
            isHex = Convert.ToByte(tb5.Text, 16)
            SaveKey(isHex, 5)
        End If

        If cb6.Checked Then
            isHex = Convert.ToByte(tb6.Text, 16)
            SaveKey(isHex, 6)
        End If

        frmMain.DisplayMsg(0, "Save keys success")
        Me.Close()
    End Sub

    Private Sub tb1_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tb1.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tb2_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tb2.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tb3_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tb3.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tb4_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tb4.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tb5_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tb5.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub tb6_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tb6.KeyPress
        If Not (InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack) Then
            e.KeyChar = ""
        End If
    End Sub

    Private Sub button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button3.Click
        Me.Close()
    End Sub

    Private Sub MifareInit_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        rbA.Checked = True
    End Sub
End Class
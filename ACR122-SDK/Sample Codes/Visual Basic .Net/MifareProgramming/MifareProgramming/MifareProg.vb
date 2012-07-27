Public Class MifareProg

    Dim retCode As Integer
    Dim hReader As Integer
    Dim connActive As Boolean

    Dim SendBuff(0 To 262) As Byte
    Dim RecvBuff(0 To 262) As Byte
    Dim SendLen, RecvLen As Long
    Private Sub MifareProg_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
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

        rbTypea.Checked = True

        bConn.Enabled = True
        bReset.Enabled = False

        EnableAll(False)

        connActive = False

    End Sub
    Private Sub EnableAll(ByVal opt As Boolean)

        tBlkNo.Enabled = opt
        tKey1.Enabled = opt
        tKey2.Enabled = opt
        tKey3.Enabled = opt
        tKey4.Enabled = opt
        tKey5.Enabled = opt
        tKey6.Enabled = opt
        tBinBlk.Enabled = opt
        tData.Enabled = opt
        tValBlock.Enabled = opt
        tValue.Enabled = opt
        tSource.Enabled = opt
        tTarget.Enabled = opt

        rbTypea.Enabled = opt
        rbTypeb.Enabled = opt

        bAuth.Enabled = opt
        bRead.Enabled = opt
        bUpdate.Enabled = opt
        bValStore.Enabled = opt
        bValRead.Enabled = opt
        bValInc.Enabled = opt
        bValDec.Enabled = opt
        bValCopy.Enabled = opt

    End Sub

    Private Sub DisplayMsg(ByVal mType As Object, ByVal msgCode As Integer, ByVal PrintText As String)

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

    Private Sub bQuit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bQuit.Click
        If connActive = True Then
            ACR122_Close(hReader)
        End If

        Me.Close()
    End Sub

    Private Sub bAuth_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bAuth.Click
        Dim UID(0 To 4) As Byte
        Dim i As Integer

        retCode = CheckAuth()

        If retCode = 0 Then

            ClearBuffers()

            SendBuff(0) = &HD4
            SendBuff(1) = &H4A
            SendBuff(2) = &H1
            SendBuff(3) = &H0

            SendLen = 4
            RecvLen = 255

            retCode = SendAPDUandDisplay()

            If retCode = 0 Then

                For i = 8 To RecvBuff(7) + 8
                    UID(i - 8) = RecvBuff(i)
                Next i

                ClearBuffers()

                SendBuff(0) = &HD4
                SendBuff(1) = &H40
                SendBuff(2) = &H1

                If rbTypea.Checked = True Then
                    SendBuff(3) = &H60
                Else
                    SendBuff(3) = &H61
                End If

                SendBuff(4) = CShort("&H" & tBlkNo.Text)
                SendBuff(5) = CShort("&H" & tKey1.Text)
                SendBuff(6) = CShort("&H" & tKey2.Text)
                SendBuff(7) = CShort("&H" & tKey3.Text)
                SendBuff(8) = CShort("&H" & tKey4.Text)
                SendBuff(9) = CShort("&H" & tKey5.Text)
                SendBuff(10) = CShort("&H" & tKey6.Text)

                SendBuff(11) = UID(0)
                SendBuff(12) = UID(1)
                SendBuff(13) = UID(2)
                SendBuff(14) = UID(3)

                SendLen = 15
                RecvLen = 255

                retCode = SendAPDUandDisplay()

                If retCode = 0 Then
                    DisplayMsg(0, 0, "Authentication Success")
                Else
                    DisplayMsg(1, 0, "Authentication Failed")
                End If


            Else
                DisplayMsg(1, 0, "Authentication Failed")
            End If

        End If

    End Sub

    Private Function CheckAuth() As Integer

        If tBlkNo.Text = "" Then
            tBlkNo.Focus()
            Return 1
        End If

        If tKey1.Text = "" Then
            tKey1.Focus()
            Return 1
        End If

        If tKey2.Text = "" Then
            tKey2.Focus()
            Return 1
        End If

        If tKey3.Text = "" Then
            tKey3.Focus()
            Return 1
        End If

        If tKey4.Text = "" Then
            tKey4.Focus()
            Return 1
        End If

        If tKey5.Text = "" Then
            tKey5.Focus()
            Return 1
        End If

        If tKey6.Text = "" Then
            tKey6.Focus()
            Return 1
        End If

        Return 0

    End Function
    Private Function SendAPDUandDisplay() As Integer
        Dim i As Integer
        Dim tmpStr, tmpHex As String

        tmpStr = ""
        tmpHex = ""

        For i = 0 To SendLen - 1
            tmpHex = Hex(SendBuff(i))

            If tmpHex.Length = 1 Then
                tmpHex = "0" + tmpHex
            End If

            tmpStr = tmpStr & tmpHex & " "
        Next i

        DisplayMsg(0, 0, "Command:")
        DisplayMsg(3, 0, tmpStr)

        retCode = ACR122_DirectTransmit(hReader, SendBuff(0), SendLen, RecvBuff(0), RecvLen)

        tmpStr = ""

        If retCode = 0 Then

            For i = 0 To RecvLen - 1
                tmpHex = Hex(RecvBuff(i))

                If tmpHex.Length = 1 Then
                    tmpHex = "0" + tmpHex
                End If

                tmpStr = tmpStr & tmpHex & " "
            Next i

            DisplayMsg(0, 0, "Response:")
            DisplayMsg(2, 0, tmpStr)

        Else
            DisplayMsg(1, 0, "Send Command Failed " & retCode)
        End If

        Return retCode

    End Function
    Private Sub ClearBuffers()
        Dim i As Integer

        For i = 0 To 262
            SendBuff(i) = &H0
            RecvBuff(i) = &H0
        Next i
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

    Private Sub tBlkNo_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles tBlkNo.TextChanged

    End Sub

    Private Sub tBlkNo_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tBlkNo.KeyPress, tBinBlk.KeyPress, tValBlock.KeyPress, tSource.KeyPress, tTarget.KeyPress

        If InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack Then

            If (sender.ToString.Length > 38) Then
                e.KeyChar = ""
            End If

        Else
            e.KeyChar = ""
        End If


    End Sub

    Private Sub tKey1_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tKey1.KeyPress, tKey2.KeyPress, tKey3.KeyPress, tKey4.KeyPress, tKey5.KeyPress, tKey6.KeyPress

        If InStr("0123456789ABCDEFabcdef", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack Then

            If (sender.ToString.Length > 37) Then
                e.KeyChar = ""
            End If

        Else
            e.KeyChar = ""
        End If

    End Sub

    Private Sub tData_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tData.KeyPress

        If (sender.ToString.Length > 51) And Not e.KeyChar = Microsoft.VisualBasic.vbBack Then
            e.KeyChar = ""
        End If

    End Sub

    Private Sub tValue_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tValue.KeyPress
        If InStr("0123456789", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack Then

        Else
            e.KeyChar = ""

        End If
    End Sub

    Private Sub rbTypea_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbTypea.CheckedChanged

    End Sub

    Private Sub bRead_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bRead.Click
        Dim i As Integer
        Dim tmpStr As String

        tmpStr = ""

        If tBinBlk.Text = "" Then
            tBinBlk.Focus()
        Else

            ClearBuffers()

            SendBuff(0) = &HD4
            SendBuff(1) = &H40
            SendBuff(2) = &H1
            SendBuff(3) = &H30

            SendBuff(4) = CShort("&H" & tBinBlk.Text)

            SendLen = 5
            RecvLen = 255

            retCode = SendAPDUandDisplay()

            If retCode = 0 Then
                DisplayMsg(0, 0, "Read Block Success")

                For i = 3 To RecvLen - 1
                    tmpStr = tmpStr & Chr(RecvBuff(i))
                Next i

                tData.Text = tmpStr

            Else
                DisplayMsg(1, 0, "Read Block Failed")
            End If


        End If

    End Sub

    Private Sub bUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bUpdate.Click
        Dim tmpStr As String
        Dim i As Integer

        If tBinBlk.Text = "" Then
            tBinBlk.Focus()
            Exit Sub
        End If

        If tData.Text = "" Then
            tData.Focus()
            Exit Sub
        End If

        ClearBuffers()

        SendBuff(0) = &HD4
        SendBuff(1) = &H40
        SendBuff(2) = &H1
        SendBuff(3) = &HA0

        SendBuff(4) = CShort("&H" & tBinBlk.Text)

        SendLen = 21
        RecvLen = 255

        tmpStr = tData.Text

        For i = 0 To tmpStr.Length - 1
            SendBuff(i + 5) = Asc(Mid(tmpStr, i + 1, 1))
        Next i

        retCode = SendAPDUandDisplay()

        If retCode = 0 Then
            DisplayMsg(0, 0, "Read Block Success")
            tData.Text = ""
        Else
            DisplayMsg(1, 0, "Update Block Failed")
        End If



    End Sub

    Private Sub bValStore_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bValStore.Click

        Dim tmp, tmpVal As Object
        Dim amt As Integer

        If tValBlock.Text = "" Then
            tValBlock.Focus()
            Exit Sub
        End If

        If tValue.Text = "" Then
            tValue.Focus()
            Exit Sub
        End If

        ClearBuffers()

        SendBuff(0) = &HD4
        SendBuff(1) = &H40
        SendBuff(2) = &H1
        SendBuff(3) = &HA0

        SendBuff(4) = CShort("&H" & tValBlock.Text)

        amt = CInt(tValue.Text)

        tmpVal = amt Mod 256

        If amt >= 0 Then

            SendBuff(5) = tmpVal

            tmpVal = amt / 256
            tmpVal = tmpVal Mod 256
            SendBuff(6) = tmpVal

            tmpVal = amt / 256
            tmpVal = tmpVal / 256
            tmpVal = tmpVal Mod 256
            SendBuff(7) = tmpVal


            tmpVal = amt / 256
            tmpVal = tmpVal / 256
            tmpVal = tmpVal / 256
            tmpVal = tmpVal Mod 256
            SendBuff(8) = tmpVal

            'get complement of amt
            SendBuff(9) = 255 - SendBuff(5)
            SendBuff(10) = 255 - SendBuff(6)
            SendBuff(11) = 255 - SendBuff(7)
            SendBuff(12) = 255 - SendBuff(8)

        Else

            tmp = System.Math.Abs(amt)

            SendBuff(5) = Not tmpVal + 1
            SendBuff(9) = tmpVal - 1

            tmpVal = tmp / 256
            tmpVal = tmpVal Mod 256
            SendBuff(6) = Not tmpVal
            SendBuff(10) = tmpVal

            tmpVal = tmp / 256
            tmpVal = tmpVal / 256
            tmpVal = tmpVal Mod 256
            SendBuff(7) = Not tmpVal
            SendBuff(11) = tmpVal

            tmpVal = tmp / 256
            tmpVal = tmpVal / 256
            tmpVal = tmpVal / 256
            tmpVal = tmpVal Mod 256
            SendBuff(8) = Not tmpVal

            SendBuff(12) = tmpVal

        End If

        SendBuff(13) = SendBuff(5)
        SendBuff(14) = SendBuff(6)
        SendBuff(15) = SendBuff(7)
        SendBuff(16) = SendBuff(8)

        SendBuff(17) = SendBuff(4)
        SendBuff(18) = 255 - SendBuff(4)
        SendBuff(19) = SendBuff(4)
        SendBuff(20) = 255 - SendBuff(4)

        SendLen = 21
        RecvLen = 255

        retCode = SendAPDUandDisplay()

        If retCode = 0 Then
            DisplayMsg(0, 0, "Store Block Value Success")
        Else
            DisplayMsg(1, 0, "Store Block Value Failed")
        End If



    End Sub

    Private Sub bValRead_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bValRead.Click
        Dim tmpStr, tmpHex As String
        Dim i, x As Integer
        


        If tValBlock.Text = "" Then
            tValBlock.Focus()
            Exit Sub
        End If

        ClearBuffers()

        SendBuff(0) = &HD4
        SendBuff(1) = &H40
        SendBuff(2) = &H1
        SendBuff(3) = &H30

        SendBuff(4) = CShort("&H" & tValBlock.Text)

        SendLen = 5
        RecvLen = 255

        retCode = SendAPDUandDisplay()

        If retCode = 0 Then

            tmpStr = ""
            For i = 6 To 3 Step -1
                tmpHex = Hex(RecvBuff(i))

                If tmpHex.Length = 1 Then
                    tmpHex = "0" + tmpHex
                End If

                tmpStr = tmpStr & tmpHex & " "
            Next i

            x = Val("&h" & tmpStr)
            tmpStr = CStr(x)

            tValue.Text = tmpStr

            DisplayMsg(0, 0, "Read Block Value Success")
        Else
            DisplayMsg(1, 0, "Read Block Value Failed")
        End If

    End Sub

    Private Sub bValInc_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bValInc.Click
        Dim tmp, tmpVal As Object


        If tValBlock.Text = "" Then
            tValBlock.Focus()
            Exit Sub
        End If

        If tValue.Text = "" Then
            tValue.Focus()
            Exit Sub
        End If

        ClearBuffers()

        SendBuff(0) = &HD4
        SendBuff(1) = &H40
        SendBuff(2) = &H1
        SendBuff(3) = &HC1

        SendBuff(4) = CShort("&H" & tValBlock.Text)

        tmpVal = CInt(tValue.Text)

        tmp = tmpVal
        tmp = tmpVal Mod 256
        SendBuff(5) = tmp

        tmp = tmpVal / 256
        tmp = tmp Mod 256
        SendBuff(6) = tmp

        tmp = tmpVal / 256
        tmp = tmp / 256
        tmp = tmp Mod 256
        SendBuff(7) = tmp

        tmp = tmpVal / 256
        tmp = tmp / 256
        tmp = tmp / 256
        tmp = tmp Mod 256
        SendBuff(8) = tmp

        SendLen = 9
        RecvLen = 255

        retCode = SendAPDUandDisplay()

        If retCode = 0 Then

            ClearBuffers()
            SendBuff(0) = &HD4
            SendBuff(1) = &H40
            SendBuff(2) = &H1
            SendBuff(3) = &HB0

            SendBuff(4) = CShort("&H" & tValBlock.Text)

            SendLen = 5
            RecvLen = 255

            retCode = SendAPDUandDisplay()

            If retCode = 0 Then
                DisplayMsg(0, 0, "Increment Block Value Success")
            Else
                DisplayMsg(1, 0, "Increment Block Value Failed")
            End If

        Else
            DisplayMsg(1, 0, "Increment Block Value Failed")
        End If

    End Sub

    Private Sub bValDec_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bValDec.Click
        Dim tmp, tmpVal As Object

        If tValBlock.Text = "" Then
            tValBlock.Focus()
            Exit Sub
        End If

        If tValue.Text = "" Then
            tValue.Focus()
            Exit Sub
        End If

        ClearBuffers()

        SendBuff(0) = &HD4
        SendBuff(1) = &H40
        SendBuff(2) = &H1
        SendBuff(3) = &HC0

        SendBuff(4) = CShort("&H" & tValBlock.Text)

        tmpVal = CInt(tValue.Text)

        tmp = tmpVal
        tmp = tmpVal Mod 256
        SendBuff(5) = tmp

        tmp = tmpVal / 256
        tmp = tmp Mod 256
        SendBuff(6) = tmp

        tmp = tmpVal / 256
        tmp = tmp / 256
        tmp = tmp Mod 256
        SendBuff(7) = tmp

        tmp = tmpVal / 256
        tmp = tmp / 256
        tmp = tmp / 256
        tmp = tmp Mod 256
        SendBuff(8) = tmp

        SendLen = 9
        RecvLen = 255

        retCode = SendAPDUandDisplay()

        If retCode = 0 Then

            ClearBuffers()
            SendBuff(0) = &HD4
            SendBuff(1) = &H40
            SendBuff(2) = &H1
            SendBuff(3) = &HB0

            SendBuff(4) = CShort("&H" & tValBlock.Text)

            SendLen = 5
            RecvLen = 255

            retCode = SendAPDUandDisplay()

            If retCode = 0 Then
                DisplayMsg(0, 0, "Decrement Block Value Success")
            Else
                DisplayMsg(1, 0, "Decrement Block Value Failed")
            End If

        Else
            DisplayMsg(1, 0, "Decrement Block Value Failed")

        End If

    End Sub

    Private Sub bValCopy_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bValCopy.Click
        Dim tmpVal As Object
        Dim result As Short

        If tSource.Text = "" Then
            tSource.Focus()
            Exit Sub
        End If

        If tTarget.Text = "" Then
            tTarget.Focus()
            Exit Sub
        End If

        tmpVal = CShort(tTarget.Text)

        If tmpVal < &H80 Then
            
            If (tmpVal Mod 4) = 3 Then

                result = MsgBox("Critical Block Chosen to be written. Continue?", MsgBoxStyle.Critical + MsgBoxStyle.OkCancel, "Warning!")

                If result = MsgBoxResult.Cancel Then
                    Exit Sub
                End If

            End If
        Else
           
            If ((tmpVal - 128) Mod 4) = 3 Then

                result = MsgBox("Critical Block Chosen to be written. Continue?", MsgBoxStyle.Critical + MsgBoxStyle.OkCancel, "Warning!")

                If result = MsgBoxResult.Cancel Then
                    Exit Sub
                End If

            End If
        End If

        ClearBuffers()
        SendBuff(0) = &HD4
        SendBuff(1) = &H40
        SendBuff(2) = &H1
        SendBuff(3) = &HC2
        SendBuff(4) = CShort("&H" & tSource.Text)

        SendLen = 5
        RecvLen = 255

        retCode = SendAPDUandDisplay()

        If retCode = 0 Then

            Call ClearBuffers()
            SendBuff(0) = &HD4
            SendBuff(1) = &H40
            SendBuff(2) = &H1
            SendBuff(3) = &HB0
            SendBuff(4) = CShort("&H" & tTarget.Text)

            SendLen = 5
            RecvLen = 255

            retCode = SendAPDUandDisplay()

            If retCode = 0 Then
                DisplayMsg(0, 0, "Copy Block Value Success")
            Else
                DisplayMsg(1, 0, "Copy Block Value Failed")
            End If

        Else
            DisplayMsg(1, 0, "Copy Block Value Failed")
        End If

    End Sub
End Class

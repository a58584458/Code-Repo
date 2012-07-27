Public Class otherpicc
    Dim retCode As Object
    Dim hReader As Integer
    Dim connActive As Boolean

    Dim Sendbuff(0 To 262) As Byte
    Dim RecvBuff(0 To 262) As Byte
    Dim SendLen, RecvLen As Long

    Private Sub otherpicc_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
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

        tCommand.Text = ""

        bConn.Enabled = True
        tCommand.Enabled = False
        bReset.Enabled = False
        bSend.Enabled = False
        connActive = False

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
            bSend.Enabled = True
            bReset.Enabled = True
            tCommand.Enabled = True

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

        Else
            DisplayMsg(1, 0, "Connection to " & a & " failed")
        End If
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

    End Sub

    Private Sub bReset_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bReset.Click
        If connActive = True Then
            ACR122_Close(hReader)
            InitMenu()
            connActive = False
        End If
    End Sub

    Private Sub bQuit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bQuit.Click
        If connActive = True Then
            ACR122_Close(hReader)
        End If

        Me.Close()
    End Sub

    Private Sub bClear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bClear.Click
        mMsg.Text = ""
    End Sub

    Private Sub bSend_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bSend.Click
        Dim tmpData As String
        Dim tmpStr, tmpStr2 As String
        Dim dataLen As Integer
        Dim indx, i, result As Integer

        If tCommand.Text = "" Then
            tCommand.Focus()
            Exit Sub
        End If

        tmpData = ""
        tmpData = TrimInput(0, tCommand.Text)
        tmpData = TrimInput(1, tmpData)

        dataLen = Len(tmpData) / 2

        For indx = 0 To dataLen - 1

            Sendbuff(indx) = CInt("&H" & (Mid$(tmpData, ((indx * 2) + 1), 2)))

        Next indx

        SendLen = dataLen
        RecvLen = 255


        tmpStr = ""
        For i = 0 To dataLen - 1

            tmpStr2 = Hex(Sendbuff(i))

            If tmpStr2.Length = 1 Then
                tmpStr2 = "0" + tmpStr2
            End If

            tmpStr = tmpStr & tmpStr2 & " "
        Next i

        DisplayMsg(0, 0, "Command:")
        DisplayMsg(2, 0, tmpStr)

        retCode = ACR122_DirectTransmit(hReader, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)

        If retCode = 0 Then

            tmpStr = ""
            For i = 0 To RecvLen - 1

                tmpStr2 = Hex(RecvBuff(i))

                If tmpStr2.Length = 1 Then
                    tmpStr2 = "0" + tmpStr2
                End If

                tmpStr = tmpStr & tmpStr2 & " "
            Next i

            DisplayMsg(0, 0, "Response:")
            DisplayMsg(2, 0, tmpStr)
            DisplayMsg(0, 0, "Send Command Success")

        Else
            DisplayMsg(1, 0, "Send Command Failed")
        End If



    End Sub

    Private Function TrimInput(ByVal trimType As Integer, ByVal strIn As String) As String

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
End Class

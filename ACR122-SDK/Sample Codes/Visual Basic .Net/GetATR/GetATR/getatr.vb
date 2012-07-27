Public Class getatr

    Dim retCode As Object
    Dim hReader As Integer
    Dim connActive As Boolean

    Dim Sendbuff(0 To 262) As Byte
    Dim RecvBuff(0 To 262) As Byte
    Dim SendLen, RecvLen As Long



    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

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

        bConn.Enabled = True
        bReset.Enabled = False
        bGetATR.Enabled = False
        connActive = False

    End Sub


    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bConn.Click

        Dim a, tmpStr As String
        Dim fwVersion(0 To 262) As Byte
        Dim fwLen, i As Integer

        a = cbPort.Text
        tmpStr = ""

        retCode = ACR122_Open(a, hReader)


        fwLen = 256

        If retCode = 0 Then
            DisplayMsg(0, 0, "Connection to " & a & " success")
            connActive = True
            bConn.Enabled = False
            bGetATR.Enabled = True
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

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bGetATR.Click

        Dim i As Integer
        Dim tmpStr As String
        Dim tmpRecv As String
        Dim cardType As Byte


        Sendbuff(0) = &HD4
        Sendbuff(1) = &H60
        Sendbuff(2) = &H1
        Sendbuff(3) = &H1
        Sendbuff(4) = &H20
        Sendbuff(5) = &H23
        Sendbuff(6) = &H11
        Sendbuff(7) = &H4
        Sendbuff(8) = &H10

        SendLen = 9
        RecvLen = 255

        retCode = ACR122_DirectTransmit(hReader, Sendbuff(0), SendLen, RecvBuff(0), RecvLen)

        If retCode = 0 Then

            DisplayMsg(0, 0, "Get ATR Success")

            DisplayMsg(0, 0, "ATR")

            For i = 0 To RecvLen

                tmpRecv = Hex(RecvBuff(i))

                If tmpRecv.Length = 1 Then
                    tmpRecv = "0" + tmpRecv
                End If

                tmpStr += tmpRecv & " "
            Next i

            DisplayMsg(2, 0, tmpStr)

            If RecvLen > 3 Then
                cardType = RecvBuff(8)

                Select Case cardType
                    Case &H18
                        tmpStr = "Mifare 4K "
                    Case &H0
                        tmpStr = "Mifare Ultralight "
                    Case &H28
                        tmpStr = "ISO 14443-4 Type A "
                    Case &H8
                        tmpStr = "Mifare 1K"
                    Case Else
                        cardType = RecvBuff(3)
                        Select Case cardType
                            Case &H23
                                tmpStr = "ISO 144443-4 Type B "
                            Case &H11
                                tmpStr = "FeliCa 212K "
                            Case &H4
                                tmpStr = "Topaz"
                            Case Else
                                tmpStr = "Unknown Contactless Card "
                        End Select
                End Select

            Else
                tmpStr = "No Contactless Card "
            End If

            tmpStr = tmpStr & "detected."

            Call DisplayMsg(0, 0, tmpStr)

        Else
            DisplayMsg(1, 0, "Get ATR Failed")

        End If

    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bClear.Click
        mMsg.Text = ""
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bReset.Click
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
End Class


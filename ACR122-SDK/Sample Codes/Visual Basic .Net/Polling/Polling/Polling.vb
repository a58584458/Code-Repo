Public Class Polling
    Dim retCode As Object
    Dim hReader As Integer
    Dim connActive As Boolean
    Dim StartPoll As Boolean

    Dim Sendbuff(0 To 262) As Byte
    Dim RecvBuff(0 To 262) As Byte
    Dim SendLen, RecvLen As Long

    Private Sub Polling_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        InitMenu()
    End Sub

    Private Sub InitMenu()
        Dim i As Integer

        For i = 1 To 10
            cbPort.Items.Add("COM" & i)
        Next i
        cbPort.SelectedIndex = 0

        lCardLabel.Text = "Card Type:"
        StartPoll = True
        bConn.Enabled = True
        connActive = False

    End Sub

    Private Sub bConn_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bConn.Click
        Dim a As String

        a = cbPort.Text

        retCode = ACR122_Open(a, hReader)

        If retCode = 0 Then

            connActive = True
            bConn.Enabled = False
            bStartPoll.Enabled = True

            MsgBox("Connection to " & a & " Success!", MsgBoxStyle.Information + MsgBoxStyle.OkOnly)

        Else
            MsgBox("Connection to " & a & " Failed!", MsgBoxStyle.Information + MsgBoxStyle.OkOnly)

        End If
    End Sub

    Private Sub bQuit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bQuit.Click
        If connActive = True Then
            ACR122_Close(hReader)
        End If

        Me.Close()
    End Sub

    Private Sub bStartPoll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bStartPoll.Click

        If StartPoll = True Then
            bStartPoll.Text = "Stop Polling"
            StartPoll = False
            tPollTimer.Enabled = True
        Else
            bStartPoll.Text = "Start Polling"
            StartPoll = True
            tPollTimer.Enabled = False
        End If

    End Sub

    Private Sub bPollTimer_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles tPollTimer.Tick
        Dim CardType As Byte
        Dim tmpStr As String

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
            If RecvLen > 3 Then
                CardType = RecvBuff(8)

                Select Case CardType
                    Case &H18
                        tmpStr = "Mifare 4K "
                    Case &H0
                        tmpStr = "Mifare Ultralight "
                    Case &H28
                        tmpStr = "ISO 14443-4 Type A "
                    Case &H8
                        tmpStr = "Mifare 1K "
                    Case &H9
                        tmpStr = "Mifare Mini "
                    Case &H20
                        tmpStr = "Mifare DesFire "
                    Case &H98
                        tmpStr = "Gemplus MPCOS "
                    Case Else
                        CardType = RecvBuff(3)
                        Select Case CardType
                            Case &H23
                                tmpStr = "ISO 14443-4 Type B "
                            Case &H11
                                tmpStr = "Felica 212K "
                            Case &H4
                                tmpStr = "Topaz "
                            Case Else
                                tmpStr = "Unknown card "
                        End Select
                End Select
            Else
                tmpStr = ""
            End If

            lCardType.Text = tmpStr
        Else
            lCardType.Text = "Error: " & retCode
        End If

    End Sub
End Class

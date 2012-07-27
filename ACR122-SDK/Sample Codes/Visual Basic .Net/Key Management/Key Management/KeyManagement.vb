Public Class frmMain

    Public Shared retCode As Integer
    Public Shared hReader As Integer
    Public Shared SendBuff(0 To 262) As Byte
    Public Shared RecvBuff(0 To 262) As Byte
    Public Shared GSAM(0 To 262) As Byte
    Public Shared SendLen, RecvLen As Integer

    Private Sub frmMain_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        cbPort.SelectedIndex = 0
        Init()
    End Sub

    Public Sub DisplayMsg(ByVal mType As Object, ByVal PrintText As String)

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
            Case 4
                mMsg.SelectionColor = System.Drawing.Color.Black

        End Select

        mMsg.SelectedText = PrintText & vbCrLf
        mMsg.SelectionStart = Len(mMsg.Text)
        mMsg.SelectionColor = System.Drawing.Color.Black
        mMsg.Focus()
    End Sub

    Public Sub ClearBuffers()
        Dim i As Integer

        For i = 0 To 262
            SendBuff(i) = &H0
            RecvBuff(i) = &H0
        Next i
    End Sub

    Public Sub Init()
        mMsg.Text = ""
        DisplayMsg(0, "Program Started")

        btnConnect.Enabled = True
        btnICC.Enabled = False
        btnSAMInit.Enabled = False
        btnMifare.Enabled = False

    End Sub

    Public Function SendAPDUandDisplay(ByVal type As Integer) As Integer
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

        DisplayMsg(0, "Command:")
        DisplayMsg(3, tmpStr)

        If type = 0 Then
            retCode = ACR122_DirectTransmit(hReader, SendBuff(0), SendLen, RecvBuff(0), RecvLen)
        Else
            retCode = ACR122_ExchangeApdu(hReader, 0, SendBuff(0), SendLen, RecvBuff(0), RecvLen)
        End If


        tmpStr = ""

        If retCode = 0 Then

            For i = 0 To RecvLen - 1
                tmpHex = Hex(RecvBuff(i))

                If tmpHex.Length = 1 Then
                    tmpHex = "0" + tmpHex
                End If

                tmpStr = tmpStr & tmpHex & " "
            Next i

            DisplayMsg(0, "Response:")
            DisplayMsg(2, tmpStr)
        End If

        Return retCode

    End Function

    Private Sub btnConnect_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnConnect.Click
        Dim a, tmpStr As String
        Dim fwVersion(0 To 262) As Byte
        Dim fwLen, i As Integer

        a = cbPort.Text
        fwLen = 256
        tmpStr = ""

        retCode = ACR122_Open(a, hReader)

        If retCode = 0 Then
            DisplayMsg(0, "Connection to " & a & " success")

            retCode = ACR122_GetFirmwareVersion(hReader, 0, fwVersion(0), fwLen)

            If retCode = 0 Then
                DisplayMsg(0, "Get Firmware Success")

                For i = 0 To fwLen - 1
                    tmpStr = tmpStr & Chr(fwVersion(i))
                Next i

                DisplayMsg(0, "Firmware: " & tmpStr)
                DisplayMsg(0, "")
            Else
                DisplayMsg(1, "Get Firmware Failed")
            End If
        Else
            DisplayMsg(1, "Connection to " & a & " failed")
        End If

        btnConnect.Enabled = False
        btnICC.Enabled = True
        
    End Sub

    Private Sub btnICC_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnICC.Click
        Dim tempstr As String

        RecvLen = 255

        retCode = ACR122_PowerOnIcc(hReader, 0, RecvBuff(0), RecvLen)
        If retCode <> 0 Then
            DisplayMsg(1, "Power on ICC failed")
            Exit Sub
        Else
            DisplayMsg(0, "Power on ICC success")

            tempstr = ""

            For i = 0 To RecvLen - 1
                tempstr = tempstr + String.Format("{0:X2} ", RecvBuff(i))
            Next i

            DisplayMsg(4, "ATR: " + tempstr)
        End If

        btnSAMInit.Enabled = True
        btnMifare.Enabled = True
    End Sub

    Private Sub btnSAMInit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSAMInit.Click
        'Show Initialize SAM dialog
        InitSAM.Show()
    End Sub

    Private Sub btnMifare_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnMifare.Click
        'Show Generate Keys Dialog
        MifareInit.Show()
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        mMsg.Text = ""
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        retCode = ACR122_PowerOffIcc(hReader, 0)
        retCode = ACR122_Close(hReader)
        Init()
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        retCode = ACR122_PowerOffIcc(hReader, 0)
        retCode = ACR122_Close(hReader)
        Me.Close()
    End Sub
End Class

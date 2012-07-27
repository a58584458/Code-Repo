Imports System.Windows.Forms

Public Class Dialog

    Private Sub OK_Button_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Me.DialogResult = System.Windows.Forms.DialogResult.OK
        Me.Close()
    End Sub

    Private Sub Cancel_Button_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Me.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.Close()
    End Sub

    Private Sub Dialog_Shown(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Shown
        tbStatTO.Text = "2000"
        tbStatRe.Text = "1"
        tbRespTO.Text = "10000"
        tbRespRe.Text = "1"
    End Sub

    Private Sub bCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bCancel.Click
        Me.Close()

    End Sub

    Private Sub tbStatTO_KeyPress(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyPressEventArgs) Handles tbStatTO.KeyPress, tbStatRe.KeyPress, tbRespTO.KeyPress, tbRespRe.KeyPress
        If InStr("0123456789", e.KeyChar) > 0 Or e.KeyChar = Microsoft.VisualBasic.vbBack Then

        Else
            e.KeyChar = ""

        End If
    End Sub

    Private Sub bOk_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles bOk.Click
        Dim timeOut As ACR122_TIMEOUTS

        If tbStatTO.Text = "" Then
            tbStatTO.Focus()
            Exit Sub
        End If

        If tbStatRe.Text = "" Then
            tbStatRe.Focus()
            Exit Sub
        End If

        If tbRespTO.Text = "" Then
            tbRespTO.Focus()
            Exit Sub
        End If

        If tbRespRe.Text = "" Then
            tbRespRe.Focus()
            Exit Sub
        End If

        timeOut.statusTimeout = CInt(tbStatTO.Text)
        timeOut.numStatusRetries = CInt(tbStatRe.Text)
        timeOut.responseTimeout = CInt(tbRespTO.Text)
        timeOut.numResponseRetries = CInt(tbRespRe.Text)

        DeviceProgramming.retCode = ACR122_SetTimeouts(DeviceProgramming.hReader, timeOut)

        If DeviceProgramming.retCode = 0 Then
            DeviceProgramming.DisplayMsg(0, 0, "Set Timeouts success")
        Else
            DeviceProgramming.DisplayMsg(1, 0, "Set Timeouts failed")
        End If


    End Sub
End Class

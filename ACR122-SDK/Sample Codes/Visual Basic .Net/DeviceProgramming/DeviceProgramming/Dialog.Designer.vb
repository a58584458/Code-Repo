<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Dialog
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.tbStatTO = New System.Windows.Forms.TextBox
        Me.tbStatRe = New System.Windows.Forms.TextBox
        Me.tbRespTO = New System.Windows.Forms.TextBox
        Me.tbRespRe = New System.Windows.Forms.TextBox
        Me.bOk = New System.Windows.Forms.Button
        Me.bCancel = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(2, 28)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(103, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Status Timeout (ms):"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(2, 59)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(73, 13)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "Status Retries"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(2, 89)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(121, 13)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "Response Timeout (ms):"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(2, 118)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(91, 13)
        Me.Label4.TabIndex = 3
        Me.Label4.Text = "Response Retries"
        '
        'tbStatTO
        '
        Me.tbStatTO.Location = New System.Drawing.Point(136, 25)
        Me.tbStatTO.Name = "tbStatTO"
        Me.tbStatTO.Size = New System.Drawing.Size(85, 20)
        Me.tbStatTO.TabIndex = 4
        '
        'tbStatRe
        '
        Me.tbStatRe.Location = New System.Drawing.Point(136, 52)
        Me.tbStatRe.Name = "tbStatRe"
        Me.tbStatRe.Size = New System.Drawing.Size(85, 20)
        Me.tbStatRe.TabIndex = 5
        '
        'tbRespTO
        '
        Me.tbRespTO.Location = New System.Drawing.Point(136, 82)
        Me.tbRespTO.Name = "tbRespTO"
        Me.tbRespTO.Size = New System.Drawing.Size(85, 20)
        Me.tbRespTO.TabIndex = 6
        '
        'tbRespRe
        '
        Me.tbRespRe.Location = New System.Drawing.Point(136, 111)
        Me.tbRespRe.Name = "tbRespRe"
        Me.tbRespRe.Size = New System.Drawing.Size(85, 20)
        Me.tbRespRe.TabIndex = 7
        '
        'bOk
        '
        Me.bOk.Location = New System.Drawing.Point(30, 143)
        Me.bOk.Name = "bOk"
        Me.bOk.Size = New System.Drawing.Size(75, 23)
        Me.bOk.TabIndex = 8
        Me.bOk.Text = "Ok"
        Me.bOk.UseVisualStyleBackColor = True
        '
        'bCancel
        '
        Me.bCancel.Location = New System.Drawing.Point(123, 143)
        Me.bCancel.Name = "bCancel"
        Me.bCancel.Size = New System.Drawing.Size(75, 23)
        Me.bCancel.TabIndex = 9
        Me.bCancel.Text = "Cancel"
        Me.bCancel.UseVisualStyleBackColor = True
        '
        'Dialog
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(240, 188)
        Me.Controls.Add(Me.bCancel)
        Me.Controls.Add(Me.bOk)
        Me.Controls.Add(Me.tbRespRe)
        Me.Controls.Add(Me.tbRespTO)
        Me.Controls.Add(Me.tbStatRe)
        Me.Controls.Add(Me.tbStatTO)
        Me.Controls.Add(Me.Label4)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "Dialog"
        Me.ShowInTaskbar = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "Dialog"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents tbStatTO As System.Windows.Forms.TextBox
    Friend WithEvents tbStatRe As System.Windows.Forms.TextBox
    Friend WithEvents tbRespTO As System.Windows.Forms.TextBox
    Friend WithEvents tbRespRe As System.Windows.Forms.TextBox
    Friend WithEvents bOk As System.Windows.Forms.Button
    Friend WithEvents bCancel As System.Windows.Forms.Button

End Class

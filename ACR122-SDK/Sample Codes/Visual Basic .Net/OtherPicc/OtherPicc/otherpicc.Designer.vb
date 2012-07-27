<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class otherpicc
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(otherpicc))
        Me.cbPort = New System.Windows.Forms.ComboBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.mMsg = New System.Windows.Forms.RichTextBox
        Me.bConn = New System.Windows.Forms.Button
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.bSend = New System.Windows.Forms.Button
        Me.tCommand = New System.Windows.Forms.TextBox
        Me.Label2 = New System.Windows.Forms.Label
        Me.bClear = New System.Windows.Forms.Button
        Me.bReset = New System.Windows.Forms.Button
        Me.bQuit = New System.Windows.Forms.Button
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'cbPort
        '
        Me.cbPort.FormattingEnabled = True
        Me.cbPort.Location = New System.Drawing.Point(124, 12)
        Me.cbPort.Name = "cbPort"
        Me.cbPort.Size = New System.Drawing.Size(121, 21)
        Me.cbPort.TabIndex = 4
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(56, 15)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(62, 13)
        Me.Label1.TabIndex = 3
        Me.Label1.Text = "Select Port:"
        '
        'mMsg
        '
        Me.mMsg.Location = New System.Drawing.Point(251, 12)
        Me.mMsg.Name = "mMsg"
        Me.mMsg.Size = New System.Drawing.Size(321, 168)
        Me.mMsg.TabIndex = 8
        Me.mMsg.Text = ""
        '
        'bConn
        '
        Me.bConn.Location = New System.Drawing.Point(155, 39)
        Me.bConn.Name = "bConn"
        Me.bConn.Size = New System.Drawing.Size(90, 23)
        Me.bConn.TabIndex = 9
        Me.bConn.Text = "Connect"
        Me.bConn.UseVisualStyleBackColor = True
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.bSend)
        Me.GroupBox1.Controls.Add(Me.tCommand)
        Me.GroupBox1.Controls.Add(Me.Label2)
        Me.GroupBox1.Location = New System.Drawing.Point(2, 68)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(243, 112)
        Me.GroupBox1.TabIndex = 10
        Me.GroupBox1.TabStop = False
        '
        'bSend
        '
        Me.bSend.Location = New System.Drawing.Point(122, 67)
        Me.bSend.Name = "bSend"
        Me.bSend.Size = New System.Drawing.Size(115, 29)
        Me.bSend.TabIndex = 6
        Me.bSend.Text = "Send Command"
        Me.bSend.UseVisualStyleBackColor = True
        '
        'tCommand
        '
        Me.tCommand.Location = New System.Drawing.Point(13, 41)
        Me.tCommand.Name = "tCommand"
        Me.tCommand.Size = New System.Drawing.Size(224, 20)
        Me.tCommand.TabIndex = 5
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(10, 16)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(54, 13)
        Me.Label2.TabIndex = 4
        Me.Label2.Text = "Command"
        '
        'bClear
        '
        Me.bClear.Location = New System.Drawing.Point(251, 186)
        Me.bClear.Name = "bClear"
        Me.bClear.Size = New System.Drawing.Size(99, 23)
        Me.bClear.TabIndex = 11
        Me.bClear.Text = "Clear"
        Me.bClear.UseVisualStyleBackColor = True
        '
        'bReset
        '
        Me.bReset.Location = New System.Drawing.Point(360, 186)
        Me.bReset.Name = "bReset"
        Me.bReset.Size = New System.Drawing.Size(99, 23)
        Me.bReset.TabIndex = 12
        Me.bReset.Text = "Reset"
        Me.bReset.UseVisualStyleBackColor = True
        '
        'bQuit
        '
        Me.bQuit.Location = New System.Drawing.Point(473, 186)
        Me.bQuit.Name = "bQuit"
        Me.bQuit.Size = New System.Drawing.Size(99, 23)
        Me.bQuit.TabIndex = 13
        Me.bQuit.Text = "Quit"
        Me.bQuit.UseVisualStyleBackColor = True
        '
        'otherpicc
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(582, 219)
        Me.Controls.Add(Me.bQuit)
        Me.Controls.Add(Me.bReset)
        Me.Controls.Add(Me.bClear)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.bConn)
        Me.Controls.Add(Me.mMsg)
        Me.Controls.Add(Me.cbPort)
        Me.Controls.Add(Me.Label1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "otherpicc"
        Me.Text = "Other PICC Cards"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents cbPort As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents mMsg As System.Windows.Forms.RichTextBox
    Friend WithEvents bConn As System.Windows.Forms.Button
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents bSend As System.Windows.Forms.Button
    Friend WithEvents tCommand As System.Windows.Forms.TextBox
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents bClear As System.Windows.Forms.Button
    Friend WithEvents bReset As System.Windows.Forms.Button
    Friend WithEvents bQuit As System.Windows.Forms.Button

End Class

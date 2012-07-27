<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class getatr
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(getatr))
        Me.bConn = New System.Windows.Forms.Button
        Me.Label1 = New System.Windows.Forms.Label
        Me.cbPort = New System.Windows.Forms.ComboBox
        Me.bGetATR = New System.Windows.Forms.Button
        Me.bClear = New System.Windows.Forms.Button
        Me.bReset = New System.Windows.Forms.Button
        Me.bQuit = New System.Windows.Forms.Button
        Me.mMsg = New System.Windows.Forms.RichTextBox
        Me.SuspendLayout()
        '
        'bConn
        '
        Me.bConn.Location = New System.Drawing.Point(120, 52)
        Me.bConn.Name = "bConn"
        Me.bConn.Size = New System.Drawing.Size(90, 23)
        Me.bConn.TabIndex = 0
        Me.bConn.Text = "Connect"
        Me.bConn.UseVisualStyleBackColor = True
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 15)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(62, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Select Port:"
        '
        'cbPort
        '
        Me.cbPort.FormattingEnabled = True
        Me.cbPort.Location = New System.Drawing.Point(89, 12)
        Me.cbPort.Name = "cbPort"
        Me.cbPort.Size = New System.Drawing.Size(121, 21)
        Me.cbPort.TabIndex = 2
        '
        'bGetATR
        '
        Me.bGetATR.Location = New System.Drawing.Point(120, 81)
        Me.bGetATR.Name = "bGetATR"
        Me.bGetATR.Size = New System.Drawing.Size(90, 23)
        Me.bGetATR.TabIndex = 3
        Me.bGetATR.Text = "Get ATR"
        Me.bGetATR.UseVisualStyleBackColor = True
        '
        'bClear
        '
        Me.bClear.Location = New System.Drawing.Point(120, 194)
        Me.bClear.Name = "bClear"
        Me.bClear.Size = New System.Drawing.Size(90, 23)
        Me.bClear.TabIndex = 4
        Me.bClear.Text = "Clear Screen"
        Me.bClear.UseVisualStyleBackColor = True
        '
        'bReset
        '
        Me.bReset.Location = New System.Drawing.Point(120, 223)
        Me.bReset.Name = "bReset"
        Me.bReset.Size = New System.Drawing.Size(90, 23)
        Me.bReset.TabIndex = 5
        Me.bReset.Text = "Reset"
        Me.bReset.UseVisualStyleBackColor = True
        '
        'bQuit
        '
        Me.bQuit.Location = New System.Drawing.Point(120, 252)
        Me.bQuit.Name = "bQuit"
        Me.bQuit.Size = New System.Drawing.Size(90, 23)
        Me.bQuit.TabIndex = 6
        Me.bQuit.Text = "Quit"
        Me.bQuit.UseVisualStyleBackColor = True
        '
        'mMsg
        '
        Me.mMsg.Location = New System.Drawing.Point(216, 8)
        Me.mMsg.Name = "mMsg"
        Me.mMsg.Size = New System.Drawing.Size(397, 267)
        Me.mMsg.TabIndex = 7
        Me.mMsg.Text = ""
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(625, 291)
        Me.Controls.Add(Me.mMsg)
        Me.Controls.Add(Me.bQuit)
        Me.Controls.Add(Me.bReset)
        Me.Controls.Add(Me.bClear)
        Me.Controls.Add(Me.bGetATR)
        Me.Controls.Add(Me.cbPort)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.bConn)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Form1"
        Me.Text = "Get ATR"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents bConn As System.Windows.Forms.Button
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents cbPort As System.Windows.Forms.ComboBox
    Friend WithEvents bGetATR As System.Windows.Forms.Button
    Friend WithEvents bClear As System.Windows.Forms.Button
    Friend WithEvents bReset As System.Windows.Forms.Button
    Friend WithEvents bQuit As System.Windows.Forms.Button
    Friend WithEvents mMsg As System.Windows.Forms.RichTextBox

End Class

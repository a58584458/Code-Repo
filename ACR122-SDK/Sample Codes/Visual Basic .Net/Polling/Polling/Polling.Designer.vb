<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Polling
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
        Me.components = New System.ComponentModel.Container
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Polling))
        Me.bConn = New System.Windows.Forms.Button
        Me.cbPort = New System.Windows.Forms.ComboBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.bStartPoll = New System.Windows.Forms.Button
        Me.bQuit = New System.Windows.Forms.Button
        Me.lCardLabel = New System.Windows.Forms.Label
        Me.lCardType = New System.Windows.Forms.Label
        Me.tPollTimer = New System.Windows.Forms.Timer(Me.components)
        Me.SuspendLayout()
        '
        'bConn
        '
        Me.bConn.Location = New System.Drawing.Point(3, 39)
        Me.bConn.Name = "bConn"
        Me.bConn.Size = New System.Drawing.Size(239, 33)
        Me.bConn.TabIndex = 15
        Me.bConn.Text = "Connect"
        Me.bConn.UseVisualStyleBackColor = True
        '
        'cbPort
        '
        Me.cbPort.FormattingEnabled = True
        Me.cbPort.Location = New System.Drawing.Point(80, 12)
        Me.cbPort.Name = "cbPort"
        Me.cbPort.Size = New System.Drawing.Size(121, 21)
        Me.cbPort.TabIndex = 14
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(12, 15)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(62, 13)
        Me.Label1.TabIndex = 13
        Me.Label1.Text = "Select Port:"
        '
        'bStartPoll
        '
        Me.bStartPoll.Location = New System.Drawing.Point(3, 78)
        Me.bStartPoll.Name = "bStartPoll"
        Me.bStartPoll.Size = New System.Drawing.Size(239, 33)
        Me.bStartPoll.TabIndex = 16
        Me.bStartPoll.Text = "Start Polling"
        Me.bStartPoll.UseVisualStyleBackColor = True
        '
        'bQuit
        '
        Me.bQuit.Location = New System.Drawing.Point(3, 117)
        Me.bQuit.Name = "bQuit"
        Me.bQuit.Size = New System.Drawing.Size(239, 33)
        Me.bQuit.TabIndex = 17
        Me.bQuit.Text = "Quit"
        Me.bQuit.UseVisualStyleBackColor = True
        '
        'lCardLabel
        '
        Me.lCardLabel.AutoSize = True
        Me.lCardLabel.Location = New System.Drawing.Point(12, 187)
        Me.lCardLabel.Name = "lCardLabel"
        Me.lCardLabel.Size = New System.Drawing.Size(0, 13)
        Me.lCardLabel.TabIndex = 18
        '
        'lCardType
        '
        Me.lCardType.AutoSize = True
        Me.lCardType.Location = New System.Drawing.Point(77, 187)
        Me.lCardType.Name = "lCardType"
        Me.lCardType.Size = New System.Drawing.Size(0, 13)
        Me.lCardType.TabIndex = 19
        '
        'tPollTimer
        '
        Me.tPollTimer.Interval = 1000
        '
        'Polling
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(247, 200)
        Me.Controls.Add(Me.lCardType)
        Me.Controls.Add(Me.lCardLabel)
        Me.Controls.Add(Me.bQuit)
        Me.Controls.Add(Me.bStartPoll)
        Me.Controls.Add(Me.bConn)
        Me.Controls.Add(Me.cbPort)
        Me.Controls.Add(Me.Label1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "Polling"
        Me.Text = "Polling"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents bConn As System.Windows.Forms.Button
    Friend WithEvents cbPort As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents bStartPoll As System.Windows.Forms.Button
    Friend WithEvents bQuit As System.Windows.Forms.Button
    Friend WithEvents lCardLabel As System.Windows.Forms.Label
    Friend WithEvents lCardType As System.Windows.Forms.Label
    Friend WithEvents tPollTimer As System.Windows.Forms.Timer

End Class

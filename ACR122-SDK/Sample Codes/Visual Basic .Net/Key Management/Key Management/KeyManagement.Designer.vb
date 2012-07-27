<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmMain
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(frmMain))
        Me.Label1 = New System.Windows.Forms.Label
        Me.cbPort = New System.Windows.Forms.ComboBox
        Me.btnConnect = New System.Windows.Forms.Button
        Me.mMsg = New System.Windows.Forms.RichTextBox
        Me.btnICC = New System.Windows.Forms.Button
        Me.btnSAMInit = New System.Windows.Forms.Button
        Me.btnMifare = New System.Windows.Forms.Button
        Me.Button1 = New System.Windows.Forms.Button
        Me.Button2 = New System.Windows.Forms.Button
        Me.Button3 = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(51, 21)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(62, 13)
        Me.Label1.TabIndex = 0
        Me.Label1.Text = "Select Port:"
        '
        'cbPort
        '
        Me.cbPort.FormattingEnabled = True
        Me.cbPort.Items.AddRange(New Object() {"COM1", "COM2", "COM3", "COM4", "COM5", "COM6", "COM7", "COM8"})
        Me.cbPort.Location = New System.Drawing.Point(119, 18)
        Me.cbPort.Name = "cbPort"
        Me.cbPort.Size = New System.Drawing.Size(90, 21)
        Me.cbPort.TabIndex = 1
        '
        'btnConnect
        '
        Me.btnConnect.Location = New System.Drawing.Point(84, 45)
        Me.btnConnect.Name = "btnConnect"
        Me.btnConnect.Size = New System.Drawing.Size(125, 31)
        Me.btnConnect.TabIndex = 2
        Me.btnConnect.Text = "Connect"
        Me.btnConnect.UseVisualStyleBackColor = True
        '
        'mMsg
        '
        Me.mMsg.Location = New System.Drawing.Point(215, 18)
        Me.mMsg.Name = "mMsg"
        Me.mMsg.Size = New System.Drawing.Size(368, 280)
        Me.mMsg.TabIndex = 3
        Me.mMsg.Text = ""
        '
        'btnICC
        '
        Me.btnICC.Location = New System.Drawing.Point(84, 82)
        Me.btnICC.Name = "btnICC"
        Me.btnICC.Size = New System.Drawing.Size(125, 31)
        Me.btnICC.TabIndex = 4
        Me.btnICC.Text = "Power On ICC"
        Me.btnICC.UseVisualStyleBackColor = True
        '
        'btnSAMInit
        '
        Me.btnSAMInit.Location = New System.Drawing.Point(84, 119)
        Me.btnSAMInit.Name = "btnSAMInit"
        Me.btnSAMInit.Size = New System.Drawing.Size(125, 31)
        Me.btnSAMInit.TabIndex = 5
        Me.btnSAMInit.Text = "Initialize SAM"
        Me.btnSAMInit.UseVisualStyleBackColor = True
        '
        'btnMifare
        '
        Me.btnMifare.Location = New System.Drawing.Point(84, 156)
        Me.btnMifare.Name = "btnMifare"
        Me.btnMifare.Size = New System.Drawing.Size(125, 31)
        Me.btnMifare.TabIndex = 6
        Me.btnMifare.Text = "Generate Keys"
        Me.btnMifare.UseVisualStyleBackColor = True
        '
        'Button1
        '
        Me.Button1.Location = New System.Drawing.Point(84, 193)
        Me.Button1.Name = "Button1"
        Me.Button1.Size = New System.Drawing.Size(125, 31)
        Me.Button1.TabIndex = 7
        Me.Button1.Text = "Clear"
        Me.Button1.UseVisualStyleBackColor = True
        '
        'Button2
        '
        Me.Button2.Location = New System.Drawing.Point(84, 230)
        Me.Button2.Name = "Button2"
        Me.Button2.Size = New System.Drawing.Size(125, 31)
        Me.Button2.TabIndex = 8
        Me.Button2.Text = "Reset"
        Me.Button2.UseVisualStyleBackColor = True
        '
        'Button3
        '
        Me.Button3.Location = New System.Drawing.Point(84, 267)
        Me.Button3.Name = "Button3"
        Me.Button3.Size = New System.Drawing.Size(125, 31)
        Me.Button3.TabIndex = 9
        Me.Button3.Text = "Quit"
        Me.Button3.UseVisualStyleBackColor = True
        '
        'frmMain
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(595, 307)
        Me.Controls.Add(Me.Button3)
        Me.Controls.Add(Me.Button2)
        Me.Controls.Add(Me.Button1)
        Me.Controls.Add(Me.btnMifare)
        Me.Controls.Add(Me.btnSAMInit)
        Me.Controls.Add(Me.btnICC)
        Me.Controls.Add(Me.mMsg)
        Me.Controls.Add(Me.btnConnect)
        Me.Controls.Add(Me.cbPort)
        Me.Controls.Add(Me.Label1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "frmMain"
        Me.Text = "Key Management"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents cbPort As System.Windows.Forms.ComboBox
    Friend WithEvents btnConnect As System.Windows.Forms.Button
    Friend WithEvents mMsg As System.Windows.Forms.RichTextBox
    Friend WithEvents btnICC As System.Windows.Forms.Button
    Friend WithEvents btnSAMInit As System.Windows.Forms.Button
    Friend WithEvents btnMifare As System.Windows.Forms.Button
    Friend WithEvents Button1 As System.Windows.Forms.Button
    Friend WithEvents Button2 As System.Windows.Forms.Button
    Friend WithEvents Button3 As System.Windows.Forms.Button

End Class

<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class DeviceProgramming
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(DeviceProgramming))
        Me.bConn = New System.Windows.Forms.Button
        Me.cbPort = New System.Windows.Forms.ComboBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.cbBaudRate = New System.Windows.Forms.ComboBox
        Me.bSetBaud = New System.Windows.Forms.Button
        Me.bSetTimeout = New System.Windows.Forms.Button
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.bSetLedBuzz = New System.Windows.Forms.Button
        Me.GroupBox6 = New System.Windows.Forms.GroupBox
        Me.cbBlink2 = New System.Windows.Forms.CheckBox
        Me.cbUpdate2 = New System.Windows.Forms.CheckBox
        Me.GroupBox7 = New System.Windows.Forms.GroupBox
        Me.rbOff4 = New System.Windows.Forms.RadioButton
        Me.rbOn4 = New System.Windows.Forms.RadioButton
        Me.Label9 = New System.Windows.Forms.Label
        Me.GroupBox8 = New System.Windows.Forms.GroupBox
        Me.rbOff3 = New System.Windows.Forms.RadioButton
        Me.rbOn3 = New System.Windows.Forms.RadioButton
        Me.Label10 = New System.Windows.Forms.Label
        Me.GroupBox3 = New System.Windows.Forms.GroupBox
        Me.cbBlink1 = New System.Windows.Forms.CheckBox
        Me.cbUpdate1 = New System.Windows.Forms.CheckBox
        Me.GroupBox5 = New System.Windows.Forms.GroupBox
        Me.rbOff2 = New System.Windows.Forms.RadioButton
        Me.rbOn2 = New System.Windows.Forms.RadioButton
        Me.Label8 = New System.Windows.Forms.Label
        Me.GroupBox4 = New System.Windows.Forms.GroupBox
        Me.rbOff1 = New System.Windows.Forms.RadioButton
        Me.rbOn1 = New System.Windows.Forms.RadioButton
        Me.Label7 = New System.Windows.Forms.Label
        Me.GroupBox2 = New System.Windows.Forms.GroupBox
        Me.cT2 = New System.Windows.Forms.CheckBox
        Me.cT1 = New System.Windows.Forms.CheckBox
        Me.Label6 = New System.Windows.Forms.Label
        Me.tbTimes = New System.Windows.Forms.TextBox
        Me.tbT2 = New System.Windows.Forms.TextBox
        Me.tbT1 = New System.Windows.Forms.TextBox
        Me.Label5 = New System.Windows.Forms.Label
        Me.Label4 = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.mMsg = New System.Windows.Forms.RichTextBox
        Me.bClear = New System.Windows.Forms.Button
        Me.bReset = New System.Windows.Forms.Button
        Me.bQuit = New System.Windows.Forms.Button
        Me.GroupBox1.SuspendLayout()
        Me.GroupBox6.SuspendLayout()
        Me.GroupBox7.SuspendLayout()
        Me.GroupBox8.SuspendLayout()
        Me.GroupBox3.SuspendLayout()
        Me.GroupBox5.SuspendLayout()
        Me.GroupBox4.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        Me.SuspendLayout()
        '
        'bConn
        '
        Me.bConn.Location = New System.Drawing.Point(204, 10)
        Me.bConn.Name = "bConn"
        Me.bConn.Size = New System.Drawing.Size(123, 23)
        Me.bConn.TabIndex = 15
        Me.bConn.Text = "Connect"
        Me.bConn.UseVisualStyleBackColor = True
        '
        'cbPort
        '
        Me.cbPort.FormattingEnabled = True
        Me.cbPort.Location = New System.Drawing.Point(99, 12)
        Me.cbPort.Name = "cbPort"
        Me.cbPort.Size = New System.Drawing.Size(99, 21)
        Me.cbPort.TabIndex = 14
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(31, 15)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(62, 13)
        Me.Label1.TabIndex = 13
        Me.Label1.Text = "Select Port:"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(31, 49)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(61, 13)
        Me.Label2.TabIndex = 16
        Me.Label2.Text = "Baud Rate:"
        '
        'cbBaudRate
        '
        Me.cbBaudRate.FormattingEnabled = True
        Me.cbBaudRate.Location = New System.Drawing.Point(99, 46)
        Me.cbBaudRate.Name = "cbBaudRate"
        Me.cbBaudRate.Size = New System.Drawing.Size(99, 21)
        Me.cbBaudRate.TabIndex = 17
        '
        'bSetBaud
        '
        Me.bSetBaud.Location = New System.Drawing.Point(204, 39)
        Me.bSetBaud.Name = "bSetBaud"
        Me.bSetBaud.Size = New System.Drawing.Size(123, 23)
        Me.bSetBaud.TabIndex = 18
        Me.bSetBaud.Text = "Set Baud Rate"
        Me.bSetBaud.UseVisualStyleBackColor = True
        '
        'bSetTimeout
        '
        Me.bSetTimeout.Location = New System.Drawing.Point(204, 68)
        Me.bSetTimeout.Name = "bSetTimeout"
        Me.bSetTimeout.Size = New System.Drawing.Size(123, 23)
        Me.bSetTimeout.TabIndex = 19
        Me.bSetTimeout.Text = "Set Timeouts"
        Me.bSetTimeout.UseVisualStyleBackColor = True
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.bSetLedBuzz)
        Me.GroupBox1.Controls.Add(Me.GroupBox6)
        Me.GroupBox1.Controls.Add(Me.GroupBox3)
        Me.GroupBox1.Controls.Add(Me.GroupBox2)
        Me.GroupBox1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.GroupBox1.Location = New System.Drawing.Point(12, 97)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(315, 473)
        Me.GroupBox1.TabIndex = 20
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Set LED States with Beep"
        '
        'bSetLedBuzz
        '
        Me.bSetLedBuzz.Location = New System.Drawing.Point(74, 433)
        Me.bSetLedBuzz.Name = "bSetLedBuzz"
        Me.bSetLedBuzz.Size = New System.Drawing.Size(146, 23)
        Me.bSetLedBuzz.TabIndex = 3
        Me.bSetLedBuzz.Text = "Set LED and Buzzer"
        Me.bSetLedBuzz.UseVisualStyleBackColor = True
        '
        'GroupBox6
        '
        Me.GroupBox6.Controls.Add(Me.cbBlink2)
        Me.GroupBox6.Controls.Add(Me.cbUpdate2)
        Me.GroupBox6.Controls.Add(Me.GroupBox7)
        Me.GroupBox6.Controls.Add(Me.GroupBox8)
        Me.GroupBox6.ForeColor = System.Drawing.SystemColors.WindowText
        Me.GroupBox6.Location = New System.Drawing.Point(6, 275)
        Me.GroupBox6.Name = "GroupBox6"
        Me.GroupBox6.Size = New System.Drawing.Size(303, 140)
        Me.GroupBox6.TabIndex = 2
        Me.GroupBox6.TabStop = False
        Me.GroupBox6.Text = "LED 1"
        '
        'cbBlink2
        '
        Me.cbBlink2.AutoSize = True
        Me.cbBlink2.Location = New System.Drawing.Point(157, 114)
        Me.cbBlink2.Name = "cbBlink2"
        Me.cbBlink2.Size = New System.Drawing.Size(85, 17)
        Me.cbBlink2.TabIndex = 3
        Me.cbBlink2.Text = "Enable Blink"
        Me.cbBlink2.UseVisualStyleBackColor = True
        '
        'cbUpdate2
        '
        Me.cbUpdate2.AutoSize = True
        Me.cbUpdate2.Location = New System.Drawing.Point(38, 114)
        Me.cbUpdate2.Name = "cbUpdate2"
        Me.cbUpdate2.Size = New System.Drawing.Size(97, 17)
        Me.cbUpdate2.TabIndex = 2
        Me.cbUpdate2.Text = "Enable Update"
        Me.cbUpdate2.UseVisualStyleBackColor = True
        '
        'GroupBox7
        '
        Me.GroupBox7.Controls.Add(Me.rbOff4)
        Me.GroupBox7.Controls.Add(Me.rbOn4)
        Me.GroupBox7.Controls.Add(Me.Label9)
        Me.GroupBox7.Location = New System.Drawing.Point(29, 58)
        Me.GroupBox7.Name = "GroupBox7"
        Me.GroupBox7.Size = New System.Drawing.Size(229, 39)
        Me.GroupBox7.TabIndex = 1
        Me.GroupBox7.TabStop = False
        '
        'rbOff4
        '
        Me.rbOff4.AutoSize = True
        Me.rbOff4.Location = New System.Drawing.Point(175, 16)
        Me.rbOff4.Name = "rbOff4"
        Me.rbOff4.Size = New System.Drawing.Size(39, 17)
        Me.rbOff4.TabIndex = 2
        Me.rbOff4.TabStop = True
        Me.rbOff4.Text = "Off"
        Me.rbOff4.UseVisualStyleBackColor = True
        '
        'rbOn4
        '
        Me.rbOn4.AutoSize = True
        Me.rbOn4.Location = New System.Drawing.Point(129, 16)
        Me.rbOn4.Name = "rbOn4"
        Me.rbOn4.Size = New System.Drawing.Size(39, 17)
        Me.rbOn4.TabIndex = 1
        Me.rbOn4.TabStop = True
        Me.rbOn4.Text = "On"
        Me.rbOn4.UseVisualStyleBackColor = True
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(6, 18)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(102, 13)
        Me.Label9.TabIndex = 0
        Me.Label9.Text = "Initial Blinking State:"
        '
        'GroupBox8
        '
        Me.GroupBox8.Controls.Add(Me.rbOff3)
        Me.GroupBox8.Controls.Add(Me.rbOn3)
        Me.GroupBox8.Controls.Add(Me.Label10)
        Me.GroupBox8.Location = New System.Drawing.Point(29, 19)
        Me.GroupBox8.Name = "GroupBox8"
        Me.GroupBox8.Size = New System.Drawing.Size(229, 39)
        Me.GroupBox8.TabIndex = 0
        Me.GroupBox8.TabStop = False
        '
        'rbOff3
        '
        Me.rbOff3.AutoSize = True
        Me.rbOff3.Location = New System.Drawing.Point(174, 16)
        Me.rbOff3.Name = "rbOff3"
        Me.rbOff3.Size = New System.Drawing.Size(39, 17)
        Me.rbOff3.TabIndex = 2
        Me.rbOff3.TabStop = True
        Me.rbOff3.Text = "Off"
        Me.rbOff3.UseVisualStyleBackColor = True
        '
        'rbOn3
        '
        Me.rbOn3.AutoSize = True
        Me.rbOn3.Location = New System.Drawing.Point(129, 16)
        Me.rbOn3.Name = "rbOn3"
        Me.rbOn3.Size = New System.Drawing.Size(39, 17)
        Me.rbOn3.TabIndex = 1
        Me.rbOn3.TabStop = True
        Me.rbOn3.Text = "On"
        Me.rbOn3.UseVisualStyleBackColor = True
        '
        'Label10
        '
        Me.Label10.AutoSize = True
        Me.Label10.Location = New System.Drawing.Point(6, 18)
        Me.Label10.Name = "Label10"
        Me.Label10.Size = New System.Drawing.Size(60, 13)
        Me.Label10.TabIndex = 0
        Me.Label10.Text = "Final State:"
        '
        'GroupBox3
        '
        Me.GroupBox3.Controls.Add(Me.cbBlink1)
        Me.GroupBox3.Controls.Add(Me.cbUpdate1)
        Me.GroupBox3.Controls.Add(Me.GroupBox5)
        Me.GroupBox3.Controls.Add(Me.GroupBox4)
        Me.GroupBox3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.GroupBox3.Location = New System.Drawing.Point(6, 129)
        Me.GroupBox3.Name = "GroupBox3"
        Me.GroupBox3.Size = New System.Drawing.Size(303, 140)
        Me.GroupBox3.TabIndex = 1
        Me.GroupBox3.TabStop = False
        Me.GroupBox3.Text = "LED 0"
        '
        'cbBlink1
        '
        Me.cbBlink1.AutoSize = True
        Me.cbBlink1.Location = New System.Drawing.Point(157, 114)
        Me.cbBlink1.Name = "cbBlink1"
        Me.cbBlink1.Size = New System.Drawing.Size(85, 17)
        Me.cbBlink1.TabIndex = 3
        Me.cbBlink1.Text = "Enable Blink"
        Me.cbBlink1.UseVisualStyleBackColor = True
        '
        'cbUpdate1
        '
        Me.cbUpdate1.AutoSize = True
        Me.cbUpdate1.Location = New System.Drawing.Point(38, 114)
        Me.cbUpdate1.Name = "cbUpdate1"
        Me.cbUpdate1.Size = New System.Drawing.Size(97, 17)
        Me.cbUpdate1.TabIndex = 2
        Me.cbUpdate1.Text = "Enable Update"
        Me.cbUpdate1.UseVisualStyleBackColor = True
        '
        'GroupBox5
        '
        Me.GroupBox5.Controls.Add(Me.rbOff2)
        Me.GroupBox5.Controls.Add(Me.rbOn2)
        Me.GroupBox5.Controls.Add(Me.Label8)
        Me.GroupBox5.Location = New System.Drawing.Point(29, 58)
        Me.GroupBox5.Name = "GroupBox5"
        Me.GroupBox5.Size = New System.Drawing.Size(229, 39)
        Me.GroupBox5.TabIndex = 1
        Me.GroupBox5.TabStop = False
        '
        'rbOff2
        '
        Me.rbOff2.AutoSize = True
        Me.rbOff2.Location = New System.Drawing.Point(175, 16)
        Me.rbOff2.Name = "rbOff2"
        Me.rbOff2.Size = New System.Drawing.Size(39, 17)
        Me.rbOff2.TabIndex = 2
        Me.rbOff2.TabStop = True
        Me.rbOff2.Text = "Off"
        Me.rbOff2.UseVisualStyleBackColor = True
        '
        'rbOn2
        '
        Me.rbOn2.AutoSize = True
        Me.rbOn2.Location = New System.Drawing.Point(129, 16)
        Me.rbOn2.Name = "rbOn2"
        Me.rbOn2.Size = New System.Drawing.Size(39, 17)
        Me.rbOn2.TabIndex = 1
        Me.rbOn2.TabStop = True
        Me.rbOn2.Text = "On"
        Me.rbOn2.UseVisualStyleBackColor = True
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(6, 18)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(102, 13)
        Me.Label8.TabIndex = 0
        Me.Label8.Text = "Initial Blinking State:"
        '
        'GroupBox4
        '
        Me.GroupBox4.Controls.Add(Me.rbOff1)
        Me.GroupBox4.Controls.Add(Me.rbOn1)
        Me.GroupBox4.Controls.Add(Me.Label7)
        Me.GroupBox4.Location = New System.Drawing.Point(29, 19)
        Me.GroupBox4.Name = "GroupBox4"
        Me.GroupBox4.Size = New System.Drawing.Size(229, 39)
        Me.GroupBox4.TabIndex = 0
        Me.GroupBox4.TabStop = False
        '
        'rbOff1
        '
        Me.rbOff1.AutoSize = True
        Me.rbOff1.Location = New System.Drawing.Point(174, 16)
        Me.rbOff1.Name = "rbOff1"
        Me.rbOff1.Size = New System.Drawing.Size(39, 17)
        Me.rbOff1.TabIndex = 2
        Me.rbOff1.TabStop = True
        Me.rbOff1.Text = "Off"
        Me.rbOff1.UseVisualStyleBackColor = True
        '
        'rbOn1
        '
        Me.rbOn1.AutoSize = True
        Me.rbOn1.Location = New System.Drawing.Point(129, 16)
        Me.rbOn1.Name = "rbOn1"
        Me.rbOn1.Size = New System.Drawing.Size(39, 17)
        Me.rbOn1.TabIndex = 1
        Me.rbOn1.TabStop = True
        Me.rbOn1.Text = "On"
        Me.rbOn1.UseVisualStyleBackColor = True
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(6, 18)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(60, 13)
        Me.Label7.TabIndex = 0
        Me.Label7.Text = "Final State:"
        '
        'GroupBox2
        '
        Me.GroupBox2.Controls.Add(Me.cT2)
        Me.GroupBox2.Controls.Add(Me.cT1)
        Me.GroupBox2.Controls.Add(Me.Label6)
        Me.GroupBox2.Controls.Add(Me.tbTimes)
        Me.GroupBox2.Controls.Add(Me.tbT2)
        Me.GroupBox2.Controls.Add(Me.tbT1)
        Me.GroupBox2.Controls.Add(Me.Label5)
        Me.GroupBox2.Controls.Add(Me.Label4)
        Me.GroupBox2.Controls.Add(Me.Label3)
        Me.GroupBox2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.GroupBox2.Location = New System.Drawing.Point(6, 19)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(303, 104)
        Me.GroupBox2.TabIndex = 0
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "Buzzer"
        '
        'cT2
        '
        Me.cT2.AutoSize = True
        Me.cT2.Location = New System.Drawing.Point(158, 55)
        Me.cT2.Name = "cT2"
        Me.cT2.Size = New System.Drawing.Size(62, 17)
        Me.cT2.TabIndex = 8
        Me.cT2.Text = "On - T2"
        Me.cT2.UseVisualStyleBackColor = True
        '
        'cT1
        '
        Me.cT1.AutoSize = True
        Me.cT1.Location = New System.Drawing.Point(158, 32)
        Me.cT1.Name = "cT1"
        Me.cT1.Size = New System.Drawing.Size(62, 17)
        Me.cT1.TabIndex = 7
        Me.cT1.Text = "On - T1"
        Me.cT1.UseVisualStyleBackColor = True
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(142, 16)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(72, 13)
        Me.Label6.TabIndex = 6
        Me.Label6.Text = "Buzzer Mode:"
        '
        'tbTimes
        '
        Me.tbTimes.Location = New System.Drawing.Point(67, 69)
        Me.tbTimes.Name = "tbTimes"
        Me.tbTimes.Size = New System.Drawing.Size(40, 20)
        Me.tbTimes.TabIndex = 5
        '
        'tbT2
        '
        Me.tbT2.Location = New System.Drawing.Point(67, 43)
        Me.tbT2.Name = "tbT2"
        Me.tbT2.Size = New System.Drawing.Size(40, 20)
        Me.tbT2.TabIndex = 4
        '
        'tbT1
        '
        Me.tbT1.Location = New System.Drawing.Point(67, 17)
        Me.tbT1.Name = "tbT1"
        Me.tbT1.Size = New System.Drawing.Size(40, 20)
        Me.tbT1.TabIndex = 3
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(16, 76)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(38, 13)
        Me.Label5.TabIndex = 2
        Me.Label5.Text = "Times:"
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(16, 50)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(45, 13)
        Me.Label4.TabIndex = 1
        Me.Label4.Text = "T2 (ms):"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(16, 24)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(45, 13)
        Me.Label3.TabIndex = 0
        Me.Label3.Text = "T1 (ms):"
        '
        'mMsg
        '
        Me.mMsg.Location = New System.Drawing.Point(333, 12)
        Me.mMsg.Name = "mMsg"
        Me.mMsg.Size = New System.Drawing.Size(348, 514)
        Me.mMsg.TabIndex = 21
        Me.mMsg.Text = ""
        '
        'bClear
        '
        Me.bClear.Location = New System.Drawing.Point(333, 533)
        Me.bClear.Name = "bClear"
        Me.bClear.Size = New System.Drawing.Size(112, 37)
        Me.bClear.TabIndex = 22
        Me.bClear.Text = "Clear"
        Me.bClear.UseVisualStyleBackColor = True
        '
        'bReset
        '
        Me.bReset.Location = New System.Drawing.Point(451, 533)
        Me.bReset.Name = "bReset"
        Me.bReset.Size = New System.Drawing.Size(112, 37)
        Me.bReset.TabIndex = 23
        Me.bReset.Text = "Reset"
        Me.bReset.UseVisualStyleBackColor = True
        '
        'bQuit
        '
        Me.bQuit.Location = New System.Drawing.Point(569, 533)
        Me.bQuit.Name = "bQuit"
        Me.bQuit.Size = New System.Drawing.Size(112, 37)
        Me.bQuit.TabIndex = 24
        Me.bQuit.Text = "Quit"
        Me.bQuit.UseVisualStyleBackColor = True
        '
        'DeviceProgramming
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(692, 579)
        Me.Controls.Add(Me.bQuit)
        Me.Controls.Add(Me.bReset)
        Me.Controls.Add(Me.bClear)
        Me.Controls.Add(Me.mMsg)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.bSetTimeout)
        Me.Controls.Add(Me.bSetBaud)
        Me.Controls.Add(Me.cbBaudRate)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.bConn)
        Me.Controls.Add(Me.cbPort)
        Me.Controls.Add(Me.Label1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "DeviceProgramming"
        Me.Text = "Device Programming"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox6.ResumeLayout(False)
        Me.GroupBox6.PerformLayout()
        Me.GroupBox7.ResumeLayout(False)
        Me.GroupBox7.PerformLayout()
        Me.GroupBox8.ResumeLayout(False)
        Me.GroupBox8.PerformLayout()
        Me.GroupBox3.ResumeLayout(False)
        Me.GroupBox3.PerformLayout()
        Me.GroupBox5.ResumeLayout(False)
        Me.GroupBox5.PerformLayout()
        Me.GroupBox4.ResumeLayout(False)
        Me.GroupBox4.PerformLayout()
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox2.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents bConn As System.Windows.Forms.Button
    Friend WithEvents cbPort As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents cbBaudRate As System.Windows.Forms.ComboBox
    Friend WithEvents bSetBaud As System.Windows.Forms.Button
    Friend WithEvents bSetTimeout As System.Windows.Forms.Button
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents GroupBox3 As System.Windows.Forms.GroupBox
    Friend WithEvents cT2 As System.Windows.Forms.CheckBox
    Friend WithEvents cT1 As System.Windows.Forms.CheckBox
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents tbTimes As System.Windows.Forms.TextBox
    Friend WithEvents tbT2 As System.Windows.Forms.TextBox
    Friend WithEvents tbT1 As System.Windows.Forms.TextBox
    Friend WithEvents GroupBox4 As System.Windows.Forms.GroupBox
    Friend WithEvents rbOff1 As System.Windows.Forms.RadioButton
    Friend WithEvents rbOn1 As System.Windows.Forms.RadioButton
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents bSetLedBuzz As System.Windows.Forms.Button
    Friend WithEvents GroupBox6 As System.Windows.Forms.GroupBox
    Friend WithEvents cbBlink2 As System.Windows.Forms.CheckBox
    Friend WithEvents cbUpdate2 As System.Windows.Forms.CheckBox
    Friend WithEvents GroupBox7 As System.Windows.Forms.GroupBox
    Friend WithEvents rbOff4 As System.Windows.Forms.RadioButton
    Friend WithEvents rbOn4 As System.Windows.Forms.RadioButton
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents GroupBox8 As System.Windows.Forms.GroupBox
    Friend WithEvents rbOff3 As System.Windows.Forms.RadioButton
    Friend WithEvents rbOn3 As System.Windows.Forms.RadioButton
    Friend WithEvents Label10 As System.Windows.Forms.Label
    Friend WithEvents cbBlink1 As System.Windows.Forms.CheckBox
    Friend WithEvents cbUpdate1 As System.Windows.Forms.CheckBox
    Friend WithEvents GroupBox5 As System.Windows.Forms.GroupBox
    Friend WithEvents rbOff2 As System.Windows.Forms.RadioButton
    Friend WithEvents rbOn2 As System.Windows.Forms.RadioButton
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents mMsg As System.Windows.Forms.RichTextBox
    Friend WithEvents bClear As System.Windows.Forms.Button
    Friend WithEvents bReset As System.Windows.Forms.Button
    Friend WithEvents bQuit As System.Windows.Forms.Button

End Class

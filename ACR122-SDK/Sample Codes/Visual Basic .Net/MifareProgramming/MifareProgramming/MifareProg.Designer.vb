<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class MifareProg
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(MifareProg))
        Me.bConn = New System.Windows.Forms.Button
        Me.cbPort = New System.Windows.Forms.ComboBox
        Me.Label1 = New System.Windows.Forms.Label
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.bAuth = New System.Windows.Forms.Button
        Me.tKey6 = New System.Windows.Forms.TextBox
        Me.tKey5 = New System.Windows.Forms.TextBox
        Me.tKey4 = New System.Windows.Forms.TextBox
        Me.tKey3 = New System.Windows.Forms.TextBox
        Me.tKey2 = New System.Windows.Forms.TextBox
        Me.tKey1 = New System.Windows.Forms.TextBox
        Me.tBlkNo = New System.Windows.Forms.TextBox
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.GroupBox2 = New System.Windows.Forms.GroupBox
        Me.rbTypeb = New System.Windows.Forms.RadioButton
        Me.rbTypea = New System.Windows.Forms.RadioButton
        Me.GroupBox3 = New System.Windows.Forms.GroupBox
        Me.bUpdate = New System.Windows.Forms.Button
        Me.bRead = New System.Windows.Forms.Button
        Me.tData = New System.Windows.Forms.TextBox
        Me.Label5 = New System.Windows.Forms.Label
        Me.tBinBlk = New System.Windows.Forms.TextBox
        Me.Label4 = New System.Windows.Forms.Label
        Me.GroupBox4 = New System.Windows.Forms.GroupBox
        Me.bValCopy = New System.Windows.Forms.Button
        Me.bValDec = New System.Windows.Forms.Button
        Me.bValInc = New System.Windows.Forms.Button
        Me.bValRead = New System.Windows.Forms.Button
        Me.bValStore = New System.Windows.Forms.Button
        Me.tTarget = New System.Windows.Forms.TextBox
        Me.tSource = New System.Windows.Forms.TextBox
        Me.tValBlock = New System.Windows.Forms.TextBox
        Me.tValue = New System.Windows.Forms.TextBox
        Me.Label9 = New System.Windows.Forms.Label
        Me.Label8 = New System.Windows.Forms.Label
        Me.Label7 = New System.Windows.Forms.Label
        Me.Label6 = New System.Windows.Forms.Label
        Me.mMsg = New System.Windows.Forms.RichTextBox
        Me.bClear = New System.Windows.Forms.Button
        Me.bReset = New System.Windows.Forms.Button
        Me.bQuit = New System.Windows.Forms.Button
        Me.GroupBox1.SuspendLayout()
        Me.GroupBox2.SuspendLayout()
        Me.GroupBox3.SuspendLayout()
        Me.GroupBox4.SuspendLayout()
        Me.SuspendLayout()
        '
        'bConn
        '
        Me.bConn.Location = New System.Drawing.Point(183, 36)
        Me.bConn.Name = "bConn"
        Me.bConn.Size = New System.Drawing.Size(90, 23)
        Me.bConn.TabIndex = 12
        Me.bConn.Text = "Connect"
        Me.bConn.UseVisualStyleBackColor = True
        '
        'cbPort
        '
        Me.cbPort.FormattingEnabled = True
        Me.cbPort.Location = New System.Drawing.Point(152, 12)
        Me.cbPort.Name = "cbPort"
        Me.cbPort.Size = New System.Drawing.Size(121, 21)
        Me.cbPort.TabIndex = 11
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(84, 15)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(62, 13)
        Me.Label1.TabIndex = 10
        Me.Label1.Text = "Select Port:"
        '
        'GroupBox1
        '
        Me.GroupBox1.Controls.Add(Me.bAuth)
        Me.GroupBox1.Controls.Add(Me.tKey6)
        Me.GroupBox1.Controls.Add(Me.tKey5)
        Me.GroupBox1.Controls.Add(Me.tKey4)
        Me.GroupBox1.Controls.Add(Me.tKey3)
        Me.GroupBox1.Controls.Add(Me.tKey2)
        Me.GroupBox1.Controls.Add(Me.tKey1)
        Me.GroupBox1.Controls.Add(Me.tBlkNo)
        Me.GroupBox1.Controls.Add(Me.Label3)
        Me.GroupBox1.Controls.Add(Me.Label2)
        Me.GroupBox1.Controls.Add(Me.GroupBox2)
        Me.GroupBox1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.GroupBox1.Location = New System.Drawing.Point(6, 65)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(265, 199)
        Me.GroupBox1.TabIndex = 13
        Me.GroupBox1.TabStop = False
        Me.GroupBox1.Text = "Authentication"
        '
        'bAuth
        '
        Me.bAuth.Location = New System.Drawing.Point(10, 154)
        Me.bAuth.Name = "bAuth"
        Me.bAuth.Size = New System.Drawing.Size(249, 33)
        Me.bAuth.TabIndex = 10
        Me.bAuth.Text = "Authenticate"
        Me.bAuth.UseVisualStyleBackColor = True
        '
        'tKey6
        '
        Me.tKey6.Location = New System.Drawing.Point(235, 128)
        Me.tKey6.Name = "tKey6"
        Me.tKey6.Size = New System.Drawing.Size(24, 20)
        Me.tKey6.TabIndex = 9
        '
        'tKey5
        '
        Me.tKey5.Location = New System.Drawing.Point(205, 128)
        Me.tKey5.Name = "tKey5"
        Me.tKey5.Size = New System.Drawing.Size(24, 20)
        Me.tKey5.TabIndex = 8
        '
        'tKey4
        '
        Me.tKey4.Location = New System.Drawing.Point(175, 128)
        Me.tKey4.Name = "tKey4"
        Me.tKey4.Size = New System.Drawing.Size(24, 20)
        Me.tKey4.TabIndex = 7
        '
        'tKey3
        '
        Me.tKey3.Location = New System.Drawing.Point(146, 128)
        Me.tKey3.Name = "tKey3"
        Me.tKey3.Size = New System.Drawing.Size(24, 20)
        Me.tKey3.TabIndex = 6
        '
        'tKey2
        '
        Me.tKey2.Location = New System.Drawing.Point(117, 128)
        Me.tKey2.Name = "tKey2"
        Me.tKey2.Size = New System.Drawing.Size(24, 20)
        Me.tKey2.TabIndex = 5
        '
        'tKey1
        '
        Me.tKey1.Location = New System.Drawing.Point(87, 128)
        Me.tKey1.Name = "tKey1"
        Me.tKey1.Size = New System.Drawing.Size(24, 20)
        Me.tKey1.TabIndex = 4
        '
        'tBlkNo
        '
        Me.tBlkNo.Location = New System.Drawing.Point(87, 96)
        Me.tBlkNo.Name = "tBlkNo"
        Me.tBlkNo.Size = New System.Drawing.Size(26, 20)
        Me.tBlkNo.TabIndex = 3
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(3, 131)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(82, 13)
        Me.Label3.TabIndex = 2
        Me.Label3.Text = "Key Value Input"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(3, 99)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(80, 13)
        Me.Label2.TabIndex = 1
        Me.Label2.Text = "Block No (Dec)"
        '
        'GroupBox2
        '
        Me.GroupBox2.Controls.Add(Me.rbTypeb)
        Me.GroupBox2.Controls.Add(Me.rbTypea)
        Me.GroupBox2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.GroupBox2.Location = New System.Drawing.Point(6, 17)
        Me.GroupBox2.Name = "GroupBox2"
        Me.GroupBox2.Size = New System.Drawing.Size(253, 66)
        Me.GroupBox2.TabIndex = 0
        Me.GroupBox2.TabStop = False
        Me.GroupBox2.Text = "Key Type"
        '
        'rbTypeb
        '
        Me.rbTypeb.AutoSize = True
        Me.rbTypeb.Location = New System.Drawing.Point(140, 31)
        Me.rbTypeb.Name = "rbTypeb"
        Me.rbTypeb.Size = New System.Drawing.Size(59, 17)
        Me.rbTypeb.TabIndex = 1
        Me.rbTypeb.TabStop = True
        Me.rbTypeb.Text = "Type B"
        Me.rbTypeb.UseVisualStyleBackColor = True
        '
        'rbTypea
        '
        Me.rbTypea.AutoSize = True
        Me.rbTypea.Location = New System.Drawing.Point(35, 31)
        Me.rbTypea.Name = "rbTypea"
        Me.rbTypea.Size = New System.Drawing.Size(59, 17)
        Me.rbTypea.TabIndex = 0
        Me.rbTypea.TabStop = True
        Me.rbTypea.Text = "Type A"
        Me.rbTypea.UseVisualStyleBackColor = True
        '
        'GroupBox3
        '
        Me.GroupBox3.Controls.Add(Me.bUpdate)
        Me.GroupBox3.Controls.Add(Me.bRead)
        Me.GroupBox3.Controls.Add(Me.tData)
        Me.GroupBox3.Controls.Add(Me.Label5)
        Me.GroupBox3.Controls.Add(Me.tBinBlk)
        Me.GroupBox3.Controls.Add(Me.Label4)
        Me.GroupBox3.ForeColor = System.Drawing.SystemColors.WindowText
        Me.GroupBox3.Location = New System.Drawing.Point(7, 265)
        Me.GroupBox3.Name = "GroupBox3"
        Me.GroupBox3.Size = New System.Drawing.Size(264, 145)
        Me.GroupBox3.TabIndex = 14
        Me.GroupBox3.TabStop = False
        Me.GroupBox3.Text = "Binary Block Functions"
        '
        'bUpdate
        '
        Me.bUpdate.Location = New System.Drawing.Point(145, 104)
        Me.bUpdate.Name = "bUpdate"
        Me.bUpdate.Size = New System.Drawing.Size(98, 30)
        Me.bUpdate.TabIndex = 8
        Me.bUpdate.Text = "Update Block"
        Me.bUpdate.UseVisualStyleBackColor = True
        '
        'bRead
        '
        Me.bRead.Location = New System.Drawing.Point(14, 104)
        Me.bRead.Name = "bRead"
        Me.bRead.Size = New System.Drawing.Size(98, 30)
        Me.bRead.TabIndex = 7
        Me.bRead.Text = "Read Block"
        Me.bRead.UseVisualStyleBackColor = True
        '
        'tData
        '
        Me.tData.Location = New System.Drawing.Point(9, 78)
        Me.tData.Name = "tData"
        Me.tData.Size = New System.Drawing.Size(249, 20)
        Me.tData.TabIndex = 6
        '
        'Label5
        '
        Me.Label5.AutoSize = True
        Me.Label5.Location = New System.Drawing.Point(6, 62)
        Me.Label5.Name = "Label5"
        Me.Label5.Size = New System.Drawing.Size(30, 13)
        Me.Label5.TabIndex = 5
        Me.Label5.Text = "Data"
        '
        'tBinBlk
        '
        Me.tBinBlk.Location = New System.Drawing.Point(63, 26)
        Me.tBinBlk.Name = "tBinBlk"
        Me.tBinBlk.Size = New System.Drawing.Size(26, 20)
        Me.tBinBlk.TabIndex = 4
        '
        'Label4
        '
        Me.Label4.AutoSize = True
        Me.Label4.Location = New System.Drawing.Point(6, 29)
        Me.Label4.Name = "Label4"
        Me.Label4.Size = New System.Drawing.Size(51, 13)
        Me.Label4.TabIndex = 0
        Me.Label4.Text = "Block No"
        '
        'GroupBox4
        '
        Me.GroupBox4.Controls.Add(Me.bValCopy)
        Me.GroupBox4.Controls.Add(Me.bValDec)
        Me.GroupBox4.Controls.Add(Me.bValInc)
        Me.GroupBox4.Controls.Add(Me.bValRead)
        Me.GroupBox4.Controls.Add(Me.bValStore)
        Me.GroupBox4.Controls.Add(Me.tTarget)
        Me.GroupBox4.Controls.Add(Me.tSource)
        Me.GroupBox4.Controls.Add(Me.tValBlock)
        Me.GroupBox4.Controls.Add(Me.tValue)
        Me.GroupBox4.Controls.Add(Me.Label9)
        Me.GroupBox4.Controls.Add(Me.Label8)
        Me.GroupBox4.Controls.Add(Me.Label7)
        Me.GroupBox4.Controls.Add(Me.Label6)
        Me.GroupBox4.ForeColor = System.Drawing.SystemColors.WindowText
        Me.GroupBox4.Location = New System.Drawing.Point(278, 7)
        Me.GroupBox4.Name = "GroupBox4"
        Me.GroupBox4.Size = New System.Drawing.Size(407, 183)
        Me.GroupBox4.TabIndex = 15
        Me.GroupBox4.TabStop = False
        Me.GroupBox4.Text = "Value Block Functions"
        '
        'bValCopy
        '
        Me.bValCopy.Location = New System.Drawing.Point(248, 147)
        Me.bValCopy.Name = "bValCopy"
        Me.bValCopy.Size = New System.Drawing.Size(121, 23)
        Me.bValCopy.TabIndex = 12
        Me.bValCopy.Text = "Copy Block"
        Me.bValCopy.UseVisualStyleBackColor = True
        '
        'bValDec
        '
        Me.bValDec.Location = New System.Drawing.Point(248, 118)
        Me.bValDec.Name = "bValDec"
        Me.bValDec.Size = New System.Drawing.Size(121, 23)
        Me.bValDec.TabIndex = 11
        Me.bValDec.Text = "Decrement"
        Me.bValDec.UseVisualStyleBackColor = True
        '
        'bValInc
        '
        Me.bValInc.Location = New System.Drawing.Point(248, 87)
        Me.bValInc.Name = "bValInc"
        Me.bValInc.Size = New System.Drawing.Size(121, 23)
        Me.bValInc.TabIndex = 10
        Me.bValInc.Text = "Increment"
        Me.bValInc.UseVisualStyleBackColor = True
        '
        'bValRead
        '
        Me.bValRead.Location = New System.Drawing.Point(248, 56)
        Me.bValRead.Name = "bValRead"
        Me.bValRead.Size = New System.Drawing.Size(121, 23)
        Me.bValRead.TabIndex = 9
        Me.bValRead.Text = "Read Value"
        Me.bValRead.UseVisualStyleBackColor = True
        '
        'bValStore
        '
        Me.bValStore.Location = New System.Drawing.Point(248, 26)
        Me.bValStore.Name = "bValStore"
        Me.bValStore.Size = New System.Drawing.Size(121, 23)
        Me.bValStore.TabIndex = 8
        Me.bValStore.Text = "Store Value"
        Me.bValStore.UseVisualStyleBackColor = True
        '
        'tTarget
        '
        Me.tTarget.Location = New System.Drawing.Point(107, 111)
        Me.tTarget.Name = "tTarget"
        Me.tTarget.Size = New System.Drawing.Size(26, 20)
        Me.tTarget.TabIndex = 7
        '
        'tSource
        '
        Me.tSource.Location = New System.Drawing.Point(107, 85)
        Me.tSource.Name = "tSource"
        Me.tSource.Size = New System.Drawing.Size(26, 20)
        Me.tSource.TabIndex = 6
        '
        'tValBlock
        '
        Me.tValBlock.Location = New System.Drawing.Point(107, 58)
        Me.tValBlock.Name = "tValBlock"
        Me.tValBlock.Size = New System.Drawing.Size(26, 20)
        Me.tValBlock.TabIndex = 5
        '
        'tValue
        '
        Me.tValue.Location = New System.Drawing.Point(107, 29)
        Me.tValue.Name = "tValue"
        Me.tValue.Size = New System.Drawing.Size(115, 20)
        Me.tValue.TabIndex = 4
        '
        'Label9
        '
        Me.Label9.AutoSize = True
        Me.Label9.Location = New System.Drawing.Point(18, 118)
        Me.Label9.Name = "Label9"
        Me.Label9.Size = New System.Drawing.Size(68, 13)
        Me.Label9.TabIndex = 3
        Me.Label9.Text = "Target Block"
        '
        'Label8
        '
        Me.Label8.AutoSize = True
        Me.Label8.Location = New System.Drawing.Point(18, 92)
        Me.Label8.Name = "Label8"
        Me.Label8.Size = New System.Drawing.Size(71, 13)
        Me.Label8.TabIndex = 2
        Me.Label8.Text = "Source Block"
        '
        'Label7
        '
        Me.Label7.AutoSize = True
        Me.Label7.Location = New System.Drawing.Point(18, 65)
        Me.Label7.Name = "Label7"
        Me.Label7.Size = New System.Drawing.Size(54, 13)
        Me.Label7.TabIndex = 1
        Me.Label7.Text = "Block No."
        '
        'Label6
        '
        Me.Label6.AutoSize = True
        Me.Label6.Location = New System.Drawing.Point(18, 34)
        Me.Label6.Name = "Label6"
        Me.Label6.Size = New System.Drawing.Size(73, 13)
        Me.Label6.TabIndex = 0
        Me.Label6.Text = "Value Amount"
        '
        'mMsg
        '
        Me.mMsg.Location = New System.Drawing.Point(278, 195)
        Me.mMsg.Name = "mMsg"
        Me.mMsg.Size = New System.Drawing.Size(407, 186)
        Me.mMsg.TabIndex = 16
        Me.mMsg.Text = ""
        '
        'bClear
        '
        Me.bClear.Location = New System.Drawing.Point(278, 387)
        Me.bClear.Name = "bClear"
        Me.bClear.Size = New System.Drawing.Size(125, 45)
        Me.bClear.TabIndex = 17
        Me.bClear.Text = "Clear"
        Me.bClear.UseVisualStyleBackColor = True
        '
        'bReset
        '
        Me.bReset.Location = New System.Drawing.Point(420, 387)
        Me.bReset.Name = "bReset"
        Me.bReset.Size = New System.Drawing.Size(125, 45)
        Me.bReset.TabIndex = 18
        Me.bReset.Text = "Reset"
        Me.bReset.UseVisualStyleBackColor = True
        '
        'bQuit
        '
        Me.bQuit.Location = New System.Drawing.Point(560, 387)
        Me.bQuit.Name = "bQuit"
        Me.bQuit.Size = New System.Drawing.Size(125, 45)
        Me.bQuit.TabIndex = 19
        Me.bQuit.Text = "Quit"
        Me.bQuit.UseVisualStyleBackColor = True
        '
        'MifareProg
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(694, 446)
        Me.Controls.Add(Me.bQuit)
        Me.Controls.Add(Me.bReset)
        Me.Controls.Add(Me.bClear)
        Me.Controls.Add(Me.mMsg)
        Me.Controls.Add(Me.GroupBox4)
        Me.Controls.Add(Me.GroupBox3)
        Me.Controls.Add(Me.GroupBox1)
        Me.Controls.Add(Me.bConn)
        Me.Controls.Add(Me.cbPort)
        Me.Controls.Add(Me.Label1)
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.Name = "MifareProg"
        Me.Text = "Mifare Programming"
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.GroupBox2.ResumeLayout(False)
        Me.GroupBox2.PerformLayout()
        Me.GroupBox3.ResumeLayout(False)
        Me.GroupBox3.PerformLayout()
        Me.GroupBox4.ResumeLayout(False)
        Me.GroupBox4.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents bConn As System.Windows.Forms.Button
    Friend WithEvents cbPort As System.Windows.Forms.ComboBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents GroupBox2 As System.Windows.Forms.GroupBox
    Friend WithEvents rbTypeb As System.Windows.Forms.RadioButton
    Friend WithEvents rbTypea As System.Windows.Forms.RadioButton
    Friend WithEvents tKey6 As System.Windows.Forms.TextBox
    Friend WithEvents tKey5 As System.Windows.Forms.TextBox
    Friend WithEvents tKey4 As System.Windows.Forms.TextBox
    Friend WithEvents tKey3 As System.Windows.Forms.TextBox
    Friend WithEvents tKey2 As System.Windows.Forms.TextBox
    Friend WithEvents tKey1 As System.Windows.Forms.TextBox
    Friend WithEvents tBlkNo As System.Windows.Forms.TextBox
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents bAuth As System.Windows.Forms.Button
    Friend WithEvents GroupBox3 As System.Windows.Forms.GroupBox
    Friend WithEvents tData As System.Windows.Forms.TextBox
    Friend WithEvents Label5 As System.Windows.Forms.Label
    Friend WithEvents tBinBlk As System.Windows.Forms.TextBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Friend WithEvents bUpdate As System.Windows.Forms.Button
    Friend WithEvents bRead As System.Windows.Forms.Button
    Friend WithEvents GroupBox4 As System.Windows.Forms.GroupBox
    Friend WithEvents bValCopy As System.Windows.Forms.Button
    Friend WithEvents bValDec As System.Windows.Forms.Button
    Friend WithEvents bValInc As System.Windows.Forms.Button
    Friend WithEvents bValRead As System.Windows.Forms.Button
    Friend WithEvents bValStore As System.Windows.Forms.Button
    Friend WithEvents tTarget As System.Windows.Forms.TextBox
    Friend WithEvents tSource As System.Windows.Forms.TextBox
    Friend WithEvents tValBlock As System.Windows.Forms.TextBox
    Friend WithEvents tValue As System.Windows.Forms.TextBox
    Friend WithEvents Label9 As System.Windows.Forms.Label
    Friend WithEvents Label8 As System.Windows.Forms.Label
    Friend WithEvents Label7 As System.Windows.Forms.Label
    Friend WithEvents Label6 As System.Windows.Forms.Label
    Friend WithEvents mMsg As System.Windows.Forms.RichTextBox
    Friend WithEvents bClear As System.Windows.Forms.Button
    Friend WithEvents bReset As System.Windows.Forms.Button
    Friend WithEvents bQuit As System.Windows.Forms.Button

End Class

namespace Device_Programming
{
    partial class frmMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMain));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.cbPort = new System.Windows.Forms.ComboBox();
            this.cbBaud = new System.Windows.Forms.ComboBox();
            this.btnConnect = new System.Windows.Forms.Button();
            this.btnBaud = new System.Windows.Forms.Button();
            this.btnTimeOut = new System.Windows.Forms.Button();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnSetLED = new System.Windows.Forms.Button();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.groupBox8 = new System.Windows.Forms.GroupBox();
            this.rbL1BlinkStateOff = new System.Windows.Forms.RadioButton();
            this.rbL1BlinkStateOn = new System.Windows.Forms.RadioButton();
            this.label9 = new System.Windows.Forms.Label();
            this.groupBox7 = new System.Windows.Forms.GroupBox();
            this.rbL1fStateOff = new System.Windows.Forms.RadioButton();
            this.rbL1fStateOn = new System.Windows.Forms.RadioButton();
            this.label10 = new System.Windows.Forms.Label();
            this.cbLED1Blink = new System.Windows.Forms.CheckBox();
            this.cbLED1Update = new System.Windows.Forms.CheckBox();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.groupBox6 = new System.Windows.Forms.GroupBox();
            this.rbL0BlinkStateOff = new System.Windows.Forms.RadioButton();
            this.rbL0BlinkStateOn = new System.Windows.Forms.RadioButton();
            this.label8 = new System.Windows.Forms.Label();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.rbL0fStateOff = new System.Windows.Forms.RadioButton();
            this.rbL0fStateOn = new System.Windows.Forms.RadioButton();
            this.label7 = new System.Windows.Forms.Label();
            this.cbLED0Blink = new System.Windows.Forms.CheckBox();
            this.cbLED0Update = new System.Windows.Forms.CheckBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.cbT2 = new System.Windows.Forms.CheckBox();
            this.cbT1 = new System.Windows.Forms.CheckBox();
            this.label6 = new System.Windows.Forms.Label();
            this.tbNum = new System.Windows.Forms.TextBox();
            this.tbT2 = new System.Windows.Forms.TextBox();
            this.tbT1 = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.mMsg = new System.Windows.Forms.RichTextBox();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnReset = new System.Windows.Forms.Button();
            this.btnQuit = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.groupBox8.SuspendLayout();
            this.groupBox7.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox6.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 19);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(62, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Select Port:";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 52);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(61, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Baud Rate:";
            // 
            // cbPort
            // 
            this.cbPort.FormattingEnabled = true;
            this.cbPort.Items.AddRange(new object[] {
            "COM1",
            "COM2",
            "COM3",
            "COM4",
            "COM5",
            "COM6",
            "COM7",
            "COM8"});
            this.cbPort.Location = new System.Drawing.Point(80, 16);
            this.cbPort.Name = "cbPort";
            this.cbPort.Size = new System.Drawing.Size(90, 21);
            this.cbPort.TabIndex = 2;
            // 
            // cbBaud
            // 
            this.cbBaud.FormattingEnabled = true;
            this.cbBaud.Items.AddRange(new object[] {
            "9600",
            "115200"});
            this.cbBaud.Location = new System.Drawing.Point(80, 49);
            this.cbBaud.Name = "cbBaud";
            this.cbBaud.Size = new System.Drawing.Size(90, 21);
            this.cbBaud.TabIndex = 3;
            // 
            // btnConnect
            // 
            this.btnConnect.Location = new System.Drawing.Point(176, 13);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(137, 25);
            this.btnConnect.TabIndex = 4;
            this.btnConnect.Text = "Connect";
            this.btnConnect.UseVisualStyleBackColor = true;
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // btnBaud
            // 
            this.btnBaud.Location = new System.Drawing.Point(176, 46);
            this.btnBaud.Name = "btnBaud";
            this.btnBaud.Size = new System.Drawing.Size(137, 25);
            this.btnBaud.TabIndex = 5;
            this.btnBaud.Text = "Set Baud Rate";
            this.btnBaud.UseVisualStyleBackColor = true;
            this.btnBaud.Click += new System.EventHandler(this.btnBaud_Click);
            // 
            // btnTimeOut
            // 
            this.btnTimeOut.Location = new System.Drawing.Point(176, 77);
            this.btnTimeOut.Name = "btnTimeOut";
            this.btnTimeOut.Size = new System.Drawing.Size(137, 25);
            this.btnTimeOut.TabIndex = 6;
            this.btnTimeOut.Text = "Set Timeouts";
            this.btnTimeOut.UseVisualStyleBackColor = true;
            this.btnTimeOut.Click += new System.EventHandler(this.btnTimeOut_Click);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnSetLED);
            this.groupBox1.Controls.Add(this.groupBox4);
            this.groupBox1.Controls.Add(this.groupBox3);
            this.groupBox1.Controls.Add(this.groupBox2);
            this.groupBox1.Location = new System.Drawing.Point(12, 108);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(300, 451);
            this.groupBox1.TabIndex = 7;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Set LED States with Beep";
            // 
            // btnSetLED
            // 
            this.btnSetLED.Location = new System.Drawing.Point(61, 410);
            this.btnSetLED.Name = "btnSetLED";
            this.btnSetLED.Size = new System.Drawing.Size(181, 29);
            this.btnSetLED.TabIndex = 9;
            this.btnSetLED.Text = "Set LED and Buzzer";
            this.btnSetLED.UseVisualStyleBackColor = true;
            this.btnSetLED.Click += new System.EventHandler(this.btnSetLED_Click);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.groupBox8);
            this.groupBox4.Controls.Add(this.groupBox7);
            this.groupBox4.Controls.Add(this.cbLED1Blink);
            this.groupBox4.Controls.Add(this.cbLED1Update);
            this.groupBox4.Location = new System.Drawing.Point(6, 264);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(288, 140);
            this.groupBox4.TabIndex = 8;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "LED 1";
            // 
            // groupBox8
            // 
            this.groupBox8.Controls.Add(this.rbL1BlinkStateOff);
            this.groupBox8.Controls.Add(this.rbL1BlinkStateOn);
            this.groupBox8.Controls.Add(this.label9);
            this.groupBox8.Location = new System.Drawing.Point(24, 67);
            this.groupBox8.Name = "groupBox8";
            this.groupBox8.Size = new System.Drawing.Size(236, 40);
            this.groupBox8.TabIndex = 9;
            this.groupBox8.TabStop = false;
            // 
            // rbL1BlinkStateOff
            // 
            this.rbL1BlinkStateOff.AutoSize = true;
            this.rbL1BlinkStateOff.Location = new System.Drawing.Point(176, 14);
            this.rbL1BlinkStateOff.Name = "rbL1BlinkStateOff";
            this.rbL1BlinkStateOff.Size = new System.Drawing.Size(39, 17);
            this.rbL1BlinkStateOff.TabIndex = 8;
            this.rbL1BlinkStateOff.TabStop = true;
            this.rbL1BlinkStateOff.Text = "Off";
            this.rbL1BlinkStateOff.UseVisualStyleBackColor = true;
            // 
            // rbL1BlinkStateOn
            // 
            this.rbL1BlinkStateOn.AutoSize = true;
            this.rbL1BlinkStateOn.Location = new System.Drawing.Point(122, 14);
            this.rbL1BlinkStateOn.Name = "rbL1BlinkStateOn";
            this.rbL1BlinkStateOn.Size = new System.Drawing.Size(39, 17);
            this.rbL1BlinkStateOn.TabIndex = 7;
            this.rbL1BlinkStateOn.TabStop = true;
            this.rbL1BlinkStateOn.Text = "On";
            this.rbL1BlinkStateOn.UseVisualStyleBackColor = true;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(15, 16);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(102, 13);
            this.label9.TabIndex = 6;
            this.label9.Text = "Initial Blinking State:";
            // 
            // groupBox7
            // 
            this.groupBox7.Controls.Add(this.rbL1fStateOff);
            this.groupBox7.Controls.Add(this.rbL1fStateOn);
            this.groupBox7.Controls.Add(this.label10);
            this.groupBox7.Location = new System.Drawing.Point(24, 19);
            this.groupBox7.Name = "groupBox7";
            this.groupBox7.Size = new System.Drawing.Size(240, 42);
            this.groupBox7.TabIndex = 8;
            this.groupBox7.TabStop = false;
            // 
            // rbL1fStateOff
            // 
            this.rbL1fStateOff.AutoSize = true;
            this.rbL1fStateOff.Location = new System.Drawing.Point(176, 19);
            this.rbL1fStateOff.Name = "rbL1fStateOff";
            this.rbL1fStateOff.Size = new System.Drawing.Size(39, 17);
            this.rbL1fStateOff.TabIndex = 6;
            this.rbL1fStateOff.TabStop = true;
            this.rbL1fStateOff.Text = "Off";
            this.rbL1fStateOff.UseVisualStyleBackColor = true;
            // 
            // rbL1fStateOn
            // 
            this.rbL1fStateOn.AutoSize = true;
            this.rbL1fStateOn.Location = new System.Drawing.Point(122, 19);
            this.rbL1fStateOn.Name = "rbL1fStateOn";
            this.rbL1fStateOn.Size = new System.Drawing.Size(39, 17);
            this.rbL1fStateOn.TabIndex = 5;
            this.rbL1fStateOn.TabStop = true;
            this.rbL1fStateOn.Text = "On";
            this.rbL1fStateOn.UseVisualStyleBackColor = true;
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(15, 21);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(60, 13);
            this.label10.TabIndex = 4;
            this.label10.Text = "Final State:";
            // 
            // cbLED1Blink
            // 
            this.cbLED1Blink.AutoSize = true;
            this.cbLED1Blink.Location = new System.Drawing.Point(158, 113);
            this.cbLED1Blink.Name = "cbLED1Blink";
            this.cbLED1Blink.Size = new System.Drawing.Size(85, 17);
            this.cbLED1Blink.TabIndex = 7;
            this.cbLED1Blink.Text = "Enable Blink";
            this.cbLED1Blink.UseVisualStyleBackColor = true;
            // 
            // cbLED1Update
            // 
            this.cbLED1Update.AutoSize = true;
            this.cbLED1Update.Location = new System.Drawing.Point(45, 113);
            this.cbLED1Update.Name = "cbLED1Update";
            this.cbLED1Update.Size = new System.Drawing.Size(97, 17);
            this.cbLED1Update.TabIndex = 6;
            this.cbLED1Update.Text = "Enable Update";
            this.cbLED1Update.UseVisualStyleBackColor = true;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.groupBox6);
            this.groupBox3.Controls.Add(this.groupBox5);
            this.groupBox3.Controls.Add(this.cbLED0Blink);
            this.groupBox3.Controls.Add(this.cbLED0Update);
            this.groupBox3.Location = new System.Drawing.Point(6, 126);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(288, 132);
            this.groupBox3.TabIndex = 1;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "LED 0";
            // 
            // groupBox6
            // 
            this.groupBox6.Controls.Add(this.rbL0BlinkStateOff);
            this.groupBox6.Controls.Add(this.rbL0BlinkStateOn);
            this.groupBox6.Controls.Add(this.label8);
            this.groupBox6.Location = new System.Drawing.Point(24, 62);
            this.groupBox6.Name = "groupBox6";
            this.groupBox6.Size = new System.Drawing.Size(240, 39);
            this.groupBox6.TabIndex = 9;
            this.groupBox6.TabStop = false;
            // 
            // rbL0BlinkStateOff
            // 
            this.rbL0BlinkStateOff.AutoSize = true;
            this.rbL0BlinkStateOff.Location = new System.Drawing.Point(180, 14);
            this.rbL0BlinkStateOff.Name = "rbL0BlinkStateOff";
            this.rbL0BlinkStateOff.Size = new System.Drawing.Size(39, 17);
            this.rbL0BlinkStateOff.TabIndex = 8;
            this.rbL0BlinkStateOff.TabStop = true;
            this.rbL0BlinkStateOff.Text = "Off";
            this.rbL0BlinkStateOff.UseVisualStyleBackColor = true;
            // 
            // rbL0BlinkStateOn
            // 
            this.rbL0BlinkStateOn.AutoSize = true;
            this.rbL0BlinkStateOn.Location = new System.Drawing.Point(126, 14);
            this.rbL0BlinkStateOn.Name = "rbL0BlinkStateOn";
            this.rbL0BlinkStateOn.Size = new System.Drawing.Size(39, 17);
            this.rbL0BlinkStateOn.TabIndex = 7;
            this.rbL0BlinkStateOn.TabStop = true;
            this.rbL0BlinkStateOn.Text = "On";
            this.rbL0BlinkStateOn.UseVisualStyleBackColor = true;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(19, 16);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(102, 13);
            this.label8.TabIndex = 6;
            this.label8.Text = "Initial Blinking State:";
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.rbL0fStateOff);
            this.groupBox5.Controls.Add(this.rbL0fStateOn);
            this.groupBox5.Controls.Add(this.label7);
            this.groupBox5.Location = new System.Drawing.Point(24, 19);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(240, 37);
            this.groupBox5.TabIndex = 8;
            this.groupBox5.TabStop = false;
            // 
            // rbL0fStateOff
            // 
            this.rbL0fStateOff.AutoSize = true;
            this.rbL0fStateOff.Location = new System.Drawing.Point(180, 12);
            this.rbL0fStateOff.Name = "rbL0fStateOff";
            this.rbL0fStateOff.Size = new System.Drawing.Size(39, 17);
            this.rbL0fStateOff.TabIndex = 6;
            this.rbL0fStateOff.TabStop = true;
            this.rbL0fStateOff.Text = "Off";
            this.rbL0fStateOff.UseVisualStyleBackColor = true;
            // 
            // rbL0fStateOn
            // 
            this.rbL0fStateOn.AutoSize = true;
            this.rbL0fStateOn.Location = new System.Drawing.Point(126, 12);
            this.rbL0fStateOn.Name = "rbL0fStateOn";
            this.rbL0fStateOn.Size = new System.Drawing.Size(39, 17);
            this.rbL0fStateOn.TabIndex = 5;
            this.rbL0fStateOn.TabStop = true;
            this.rbL0fStateOn.Text = "On";
            this.rbL0fStateOn.UseVisualStyleBackColor = true;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(19, 16);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(60, 13);
            this.label7.TabIndex = 4;
            this.label7.Text = "Final State:";
            // 
            // cbLED0Blink
            // 
            this.cbLED0Blink.AutoSize = true;
            this.cbLED0Blink.Location = new System.Drawing.Point(155, 107);
            this.cbLED0Blink.Name = "cbLED0Blink";
            this.cbLED0Blink.Size = new System.Drawing.Size(85, 17);
            this.cbLED0Blink.TabIndex = 7;
            this.cbLED0Blink.Text = "Enable Blink";
            this.cbLED0Blink.UseVisualStyleBackColor = true;
            // 
            // cbLED0Update
            // 
            this.cbLED0Update.AutoSize = true;
            this.cbLED0Update.Location = new System.Drawing.Point(42, 107);
            this.cbLED0Update.Name = "cbLED0Update";
            this.cbLED0Update.Size = new System.Drawing.Size(97, 17);
            this.cbLED0Update.TabIndex = 6;
            this.cbLED0Update.Text = "Enable Update";
            this.cbLED0Update.UseVisualStyleBackColor = true;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.cbT2);
            this.groupBox2.Controls.Add(this.cbT1);
            this.groupBox2.Controls.Add(this.label6);
            this.groupBox2.Controls.Add(this.tbNum);
            this.groupBox2.Controls.Add(this.tbT2);
            this.groupBox2.Controls.Add(this.tbT1);
            this.groupBox2.Controls.Add(this.label5);
            this.groupBox2.Controls.Add(this.label4);
            this.groupBox2.Controls.Add(this.label3);
            this.groupBox2.Location = new System.Drawing.Point(6, 19);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(288, 101);
            this.groupBox2.TabIndex = 0;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Buzzer";
            // 
            // cbT2
            // 
            this.cbT2.AutoSize = true;
            this.cbT2.Location = new System.Drawing.Point(178, 72);
            this.cbT2.Name = "cbT2";
            this.cbT2.Size = new System.Drawing.Size(62, 17);
            this.cbT2.TabIndex = 8;
            this.cbT2.Text = "On - T2";
            this.cbT2.UseVisualStyleBackColor = true;
            // 
            // cbT1
            // 
            this.cbT1.AutoSize = true;
            this.cbT1.Location = new System.Drawing.Point(178, 49);
            this.cbT1.Name = "cbT1";
            this.cbT1.Size = new System.Drawing.Size(62, 17);
            this.cbT1.TabIndex = 7;
            this.cbT1.Text = "On - T1";
            this.cbT1.UseVisualStyleBackColor = true;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(164, 27);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(72, 13);
            this.label6.TabIndex = 6;
            this.label6.Text = "Buzzer Mode:";
            // 
            // tbNum
            // 
            this.tbNum.Location = new System.Drawing.Point(57, 70);
            this.tbNum.Name = "tbNum";
            this.tbNum.Size = new System.Drawing.Size(60, 20);
            this.tbNum.TabIndex = 5;
            // 
            // tbT2
            // 
            this.tbT2.Location = new System.Drawing.Point(57, 47);
            this.tbT2.Name = "tbT2";
            this.tbT2.Size = new System.Drawing.Size(60, 20);
            this.tbT2.TabIndex = 4;
            // 
            // tbT1
            // 
            this.tbT1.Location = new System.Drawing.Point(57, 24);
            this.tbT1.Name = "tbT1";
            this.tbT1.Size = new System.Drawing.Size(60, 20);
            this.tbT1.TabIndex = 3;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(6, 73);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(38, 13);
            this.label5.TabIndex = 2;
            this.label5.Text = "Times:";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 50);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(45, 13);
            this.label4.TabIndex = 1;
            this.label4.Text = "T2 (ms):";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 27);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(45, 13);
            this.label3.TabIndex = 0;
            this.label3.Text = "T1 (ms):";
            // 
            // mMsg
            // 
            this.mMsg.Location = new System.Drawing.Point(319, 13);
            this.mMsg.Name = "mMsg";
            this.mMsg.Size = new System.Drawing.Size(374, 517);
            this.mMsg.TabIndex = 8;
            this.mMsg.Text = "";
            // 
            // btnClear
            // 
            this.btnClear.Location = new System.Drawing.Point(319, 536);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(118, 23);
            this.btnClear.TabIndex = 9;
            this.btnClear.Text = "Clear";
            this.btnClear.UseVisualStyleBackColor = true;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnReset
            // 
            this.btnReset.Location = new System.Drawing.Point(443, 536);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(126, 23);
            this.btnReset.TabIndex = 10;
            this.btnReset.Text = "Reset";
            this.btnReset.UseVisualStyleBackColor = true;
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // btnQuit
            // 
            this.btnQuit.Location = new System.Drawing.Point(575, 536);
            this.btnQuit.Name = "btnQuit";
            this.btnQuit.Size = new System.Drawing.Size(118, 23);
            this.btnQuit.TabIndex = 11;
            this.btnQuit.Text = "Quit";
            this.btnQuit.UseVisualStyleBackColor = true;
            this.btnQuit.Click += new System.EventHandler(this.btnQuit_Click);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(705, 567);
            this.Controls.Add(this.btnQuit);
            this.Controls.Add(this.btnReset);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.mMsg);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.btnTimeOut);
            this.Controls.Add(this.btnBaud);
            this.Controls.Add(this.btnConnect);
            this.Controls.Add(this.cbBaud);
            this.Controls.Add(this.cbPort);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmMain";
            this.Text = "Device Programming";
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.groupBox8.ResumeLayout(false);
            this.groupBox8.PerformLayout();
            this.groupBox7.ResumeLayout(false);
            this.groupBox7.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox6.ResumeLayout(false);
            this.groupBox6.PerformLayout();
            this.groupBox5.ResumeLayout(false);
            this.groupBox5.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cbPort;
        private System.Windows.Forms.ComboBox cbBaud;
        private System.Windows.Forms.Button btnConnect;
        private System.Windows.Forms.Button btnBaud;
        private System.Windows.Forms.Button btnTimeOut;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.TextBox tbT1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox tbNum;
        private System.Windows.Forms.TextBox tbT2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.CheckBox cbT2;
        private System.Windows.Forms.CheckBox cbT1;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.CheckBox cbLED1Blink;
        private System.Windows.Forms.CheckBox cbLED1Update;
        private System.Windows.Forms.CheckBox cbLED0Blink;
        private System.Windows.Forms.CheckBox cbLED0Update;
        private System.Windows.Forms.Button btnSetLED;
        private System.Windows.Forms.RichTextBox mMsg;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.RadioButton rbL0fStateOff;
        private System.Windows.Forms.RadioButton rbL0fStateOn;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.GroupBox groupBox6;
        private System.Windows.Forms.RadioButton rbL0BlinkStateOff;
        private System.Windows.Forms.RadioButton rbL0BlinkStateOn;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.GroupBox groupBox7;
        private System.Windows.Forms.RadioButton rbL1fStateOff;
        private System.Windows.Forms.RadioButton rbL1fStateOn;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.GroupBox groupBox8;
        private System.Windows.Forms.RadioButton rbL1BlinkStateOff;
        private System.Windows.Forms.RadioButton rbL1BlinkStateOn;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnReset;
        private System.Windows.Forms.Button btnQuit;
    }
}


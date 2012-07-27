namespace Key_Management
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
            this.cbPort = new System.Windows.Forms.ComboBox();
            this.mMsg = new System.Windows.Forms.RichTextBox();
            this.btnConnect = new System.Windows.Forms.Button();
            this.btnICC = new System.Windows.Forms.Button();
            this.btnInitSAM = new System.Windows.Forms.Button();
            this.btnGenKeys = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(41, 15);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(62, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Select Port:";
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
            this.cbPort.Location = new System.Drawing.Point(109, 12);
            this.cbPort.Name = "cbPort";
            this.cbPort.Size = new System.Drawing.Size(89, 21);
            this.cbPort.TabIndex = 1;
            // 
            // mMsg
            // 
            this.mMsg.Location = new System.Drawing.Point(204, 12);
            this.mMsg.Name = "mMsg";
            this.mMsg.Size = new System.Drawing.Size(386, 308);
            this.mMsg.TabIndex = 2;
            this.mMsg.Text = "";
            // 
            // btnConnect
            // 
            this.btnConnect.Location = new System.Drawing.Point(73, 39);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(125, 35);
            this.btnConnect.TabIndex = 3;
            this.btnConnect.Text = "Connect";
            this.btnConnect.UseVisualStyleBackColor = true;
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // btnICC
            // 
            this.btnICC.Location = new System.Drawing.Point(73, 80);
            this.btnICC.Name = "btnICC";
            this.btnICC.Size = new System.Drawing.Size(125, 35);
            this.btnICC.TabIndex = 4;
            this.btnICC.Text = "Power On ICC";
            this.btnICC.UseVisualStyleBackColor = true;
            this.btnICC.Click += new System.EventHandler(this.btnICC_Click);
            // 
            // btnInitSAM
            // 
            this.btnInitSAM.Location = new System.Drawing.Point(73, 121);
            this.btnInitSAM.Name = "btnInitSAM";
            this.btnInitSAM.Size = new System.Drawing.Size(125, 35);
            this.btnInitSAM.TabIndex = 5;
            this.btnInitSAM.Text = "Initialize SAM";
            this.btnInitSAM.UseVisualStyleBackColor = true;
            this.btnInitSAM.Click += new System.EventHandler(this.btnInitSAM_Click);
            // 
            // btnGenKeys
            // 
            this.btnGenKeys.Location = new System.Drawing.Point(73, 162);
            this.btnGenKeys.Name = "btnGenKeys";
            this.btnGenKeys.Size = new System.Drawing.Size(125, 35);
            this.btnGenKeys.TabIndex = 6;
            this.btnGenKeys.Text = "Generate Keys";
            this.btnGenKeys.UseVisualStyleBackColor = true;
            this.btnGenKeys.Click += new System.EventHandler(this.btnGenKeys_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(73, 203);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(125, 35);
            this.button1.TabIndex = 7;
            this.button1.Text = "Clear";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(73, 244);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(125, 35);
            this.button2.TabIndex = 8;
            this.button2.Text = "Reset";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(73, 285);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(125, 35);
            this.button3.TabIndex = 9;
            this.button3.Text = "Quit";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // frmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(602, 327);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.btnGenKeys);
            this.Controls.Add(this.btnInitSAM);
            this.Controls.Add(this.btnICC);
            this.Controls.Add(this.btnConnect);
            this.Controls.Add(this.mMsg);
            this.Controls.Add(this.cbPort);
            this.Controls.Add(this.label1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "frmMain";
            this.Text = "Key Management";
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        public System.Windows.Forms.ComboBox cbPort;
        private System.Windows.Forms.RichTextBox mMsg;
        private System.Windows.Forms.Button btnConnect;
        private System.Windows.Forms.Button btnICC;
        private System.Windows.Forms.Button btnInitSAM;
        private System.Windows.Forms.Button btnGenKeys;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button3;
    }
}


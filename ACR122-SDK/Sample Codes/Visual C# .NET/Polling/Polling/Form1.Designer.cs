namespace Polling
{
    partial class Form1
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.label1 = new System.Windows.Forms.Label();
            this.cbPort = new System.Windows.Forms.ComboBox();
            this.btnConnect = new System.Windows.Forms.Button();
            this.btnPolling = new System.Windows.Forms.Button();
            this.btnQuit = new System.Windows.Forms.Button();
            this.statusStrip1 = new System.Windows.Forms.StatusStrip();
            this.sb1 = new System.Windows.Forms.ToolStripStatusLabel();
            this.sb3 = new System.Windows.Forms.ToolStripStatusLabel();
            this.sbStatus = new System.Windows.Forms.ToolStripStatusLabel();
            this.sbCardtype = new System.Windows.Forms.ToolStripStatusLabel();
            this.timer1 = new System.Windows.Forms.Timer(this.components);
            this.statusStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(40, 15);
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
            this.cbPort.Location = new System.Drawing.Point(108, 12);
            this.cbPort.Name = "cbPort";
            this.cbPort.Size = new System.Drawing.Size(109, 21);
            this.cbPort.TabIndex = 1;
            // 
            // btnConnect
            // 
            this.btnConnect.Location = new System.Drawing.Point(43, 52);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(174, 33);
            this.btnConnect.TabIndex = 2;
            this.btnConnect.Text = "Connect";
            this.btnConnect.UseVisualStyleBackColor = true;
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // btnPolling
            // 
            this.btnPolling.Location = new System.Drawing.Point(43, 91);
            this.btnPolling.Name = "btnPolling";
            this.btnPolling.Size = new System.Drawing.Size(174, 33);
            this.btnPolling.TabIndex = 3;
            this.btnPolling.Text = "Start Polling";
            this.btnPolling.UseVisualStyleBackColor = true;
            this.btnPolling.Click += new System.EventHandler(this.btnPolling_Click);
            // 
            // btnQuit
            // 
            this.btnQuit.Location = new System.Drawing.Point(43, 130);
            this.btnQuit.Name = "btnQuit";
            this.btnQuit.Size = new System.Drawing.Size(174, 33);
            this.btnQuit.TabIndex = 4;
            this.btnQuit.Text = "Quit";
            this.btnQuit.UseVisualStyleBackColor = true;
            this.btnQuit.Click += new System.EventHandler(this.btnQuit_Click);
            // 
            // statusStrip1
            // 
            this.statusStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.sb1,
            this.sb3,
            this.sbStatus,
            this.sbCardtype});
            this.statusStrip1.Location = new System.Drawing.Point(0, 192);
            this.statusStrip1.Name = "statusStrip1";
            this.statusStrip1.Size = new System.Drawing.Size(262, 22);
            this.statusStrip1.TabIndex = 5;
            this.statusStrip1.Text = "statusStrip1";
            // 
            // sb1
            // 
            this.sb1.Name = "sb1";
            this.sb1.Size = new System.Drawing.Size(0, 17);
            // 
            // sb3
            // 
            this.sb3.Name = "sb3";
            this.sb3.Size = new System.Drawing.Size(0, 17);
            // 
            // sbStatus
            // 
            this.sbStatus.Name = "sbStatus";
            this.sbStatus.Size = new System.Drawing.Size(10, 17);
            this.sbStatus.Text = " ";
            // 
            // sbCardtype
            // 
            this.sbCardtype.Name = "sbCardtype";
            this.sbCardtype.Size = new System.Drawing.Size(10, 17);
            this.sbCardtype.Text = " ";
            // 
            // timer1
            // 
            this.timer1.Tick += new System.EventHandler(this.timer1_Tick);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(262, 214);
            this.Controls.Add(this.statusStrip1);
            this.Controls.Add(this.btnQuit);
            this.Controls.Add(this.btnPolling);
            this.Controls.Add(this.btnConnect);
            this.Controls.Add(this.cbPort);
            this.Controls.Add(this.label1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Form1";
            this.Text = "Polling";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.statusStrip1.ResumeLayout(false);
            this.statusStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cbPort;
        private System.Windows.Forms.Button btnConnect;
        private System.Windows.Forms.Button btnPolling;
        private System.Windows.Forms.Button btnQuit;
        private System.Windows.Forms.StatusStrip statusStrip1;
        private System.Windows.Forms.ToolStripStatusLabel sb1;
        private System.Windows.Forms.ToolStripStatusLabel sbCardtype;
        private System.Windows.Forms.ToolStripStatusLabel sb3;
        private System.Windows.Forms.ToolStripStatusLabel sbStatus;
        private System.Windows.Forms.Timer timer1;
    }
}


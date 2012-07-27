namespace Mifare_Programming
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.label1 = new System.Windows.Forms.Label();
            this.cbPort = new System.Windows.Forms.ComboBox();
            this.btnConnect = new System.Windows.Forms.Button();
            this.mMsg = new System.Windows.Forms.RichTextBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.btnAuth = new System.Windows.Forms.Button();
            this.tbKey6 = new System.Windows.Forms.TextBox();
            this.tbKey5 = new System.Windows.Forms.TextBox();
            this.tbKey4 = new System.Windows.Forms.TextBox();
            this.tbKey3 = new System.Windows.Forms.TextBox();
            this.tbKey2 = new System.Windows.Forms.TextBox();
            this.tbKey1 = new System.Windows.Forms.TextBox();
            this.tbBlockNo = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.rbTypeB = new System.Windows.Forms.RadioButton();
            this.rbTypeA = new System.Windows.Forms.RadioButton();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.btnRead = new System.Windows.Forms.Button();
            this.btnUpdate = new System.Windows.Forms.Button();
            this.tbData = new System.Windows.Forms.TextBox();
            this.label7 = new System.Windows.Forms.Label();
            this.tbBinaryBlockNo = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.btnCopy = new System.Windows.Forms.Button();
            this.btnDec = new System.Windows.Forms.Button();
            this.btnInc = new System.Windows.Forms.Button();
            this.btnReadVal = new System.Windows.Forms.Button();
            this.btnStore = new System.Windows.Forms.Button();
            this.tbTarget = new System.Windows.Forms.TextBox();
            this.tbSource = new System.Windows.Forms.TextBox();
            this.tbValueBlockNo = new System.Windows.Forms.TextBox();
            this.tbValue = new System.Windows.Forms.TextBox();
            this.label9 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.btnClear = new System.Windows.Forms.Button();
            this.btnReset = new System.Windows.Forms.Button();
            this.btnQuit = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(89, 9);
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
            this.cbPort.Location = new System.Drawing.Point(157, 6);
            this.cbPort.Name = "cbPort";
            this.cbPort.Size = new System.Drawing.Size(103, 21);
            this.cbPort.TabIndex = 1;
            // 
            // btnConnect
            // 
            this.btnConnect.Location = new System.Drawing.Point(124, 33);
            this.btnConnect.Name = "btnConnect";
            this.btnConnect.Size = new System.Drawing.Size(136, 37);
            this.btnConnect.TabIndex = 2;
            this.btnConnect.Text = "Connect";
            this.btnConnect.UseVisualStyleBackColor = true;
            this.btnConnect.Click += new System.EventHandler(this.btnConnect_Click);
            // 
            // mMsg
            // 
            this.mMsg.Location = new System.Drawing.Point(299, 181);
            this.mMsg.Name = "mMsg";
            this.mMsg.Size = new System.Drawing.Size(391, 196);
            this.mMsg.TabIndex = 3;
            this.mMsg.Text = "";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.btnAuth);
            this.groupBox1.Controls.Add(this.tbKey6);
            this.groupBox1.Controls.Add(this.tbKey5);
            this.groupBox1.Controls.Add(this.tbKey4);
            this.groupBox1.Controls.Add(this.tbKey3);
            this.groupBox1.Controls.Add(this.tbKey2);
            this.groupBox1.Controls.Add(this.tbKey1);
            this.groupBox1.Controls.Add(this.tbBlockNo);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.groupBox2);
            this.groupBox1.Location = new System.Drawing.Point(12, 76);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(281, 219);
            this.groupBox1.TabIndex = 4;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Authentication";
            // 
            // btnAuth
            // 
            this.btnAuth.Location = new System.Drawing.Point(62, 172);
            this.btnAuth.Name = "btnAuth";
            this.btnAuth.Size = new System.Drawing.Size(166, 35);
            this.btnAuth.TabIndex = 10;
            this.btnAuth.Text = "Authenticate";
            this.btnAuth.UseVisualStyleBackColor = true;
            this.btnAuth.Click += new System.EventHandler(this.btnAuth_Click);
            // 
            // tbKey6
            // 
            this.tbKey6.Location = new System.Drawing.Point(234, 130);
            this.tbKey6.Name = "tbKey6";
            this.tbKey6.Size = new System.Drawing.Size(28, 20);
            this.tbKey6.TabIndex = 9;
            // 
            // tbKey5
            // 
            this.tbKey5.Location = new System.Drawing.Point(200, 130);
            this.tbKey5.Name = "tbKey5";
            this.tbKey5.Size = new System.Drawing.Size(28, 20);
            this.tbKey5.TabIndex = 8;
            // 
            // tbKey4
            // 
            this.tbKey4.Location = new System.Drawing.Point(166, 130);
            this.tbKey4.Name = "tbKey4";
            this.tbKey4.Size = new System.Drawing.Size(28, 20);
            this.tbKey4.TabIndex = 7;
            // 
            // tbKey3
            // 
            this.tbKey3.Location = new System.Drawing.Point(132, 130);
            this.tbKey3.Name = "tbKey3";
            this.tbKey3.Size = new System.Drawing.Size(28, 20);
            this.tbKey3.TabIndex = 6;
            // 
            // tbKey2
            // 
            this.tbKey2.Location = new System.Drawing.Point(97, 130);
            this.tbKey2.Name = "tbKey2";
            this.tbKey2.Size = new System.Drawing.Size(28, 20);
            this.tbKey2.TabIndex = 5;
            // 
            // tbKey1
            // 
            this.tbKey1.Location = new System.Drawing.Point(63, 130);
            this.tbKey1.Name = "tbKey1";
            this.tbKey1.Size = new System.Drawing.Size(28, 20);
            this.tbKey1.TabIndex = 4;
            // 
            // tbBlockNo
            // 
            this.tbBlockNo.Location = new System.Drawing.Point(63, 102);
            this.tbBlockNo.Name = "tbBlockNo";
            this.tbBlockNo.Size = new System.Drawing.Size(28, 20);
            this.tbBlockNo.TabIndex = 3;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 133);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(55, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Key Value";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(6, 105);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(51, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Block No";
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.rbTypeB);
            this.groupBox2.Controls.Add(this.rbTypeA);
            this.groupBox2.Location = new System.Drawing.Point(6, 19);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(269, 62);
            this.groupBox2.TabIndex = 0;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Key Type";
            // 
            // rbTypeB
            // 
            this.rbTypeB.AutoSize = true;
            this.rbTypeB.Location = new System.Drawing.Point(163, 28);
            this.rbTypeB.Name = "rbTypeB";
            this.rbTypeB.Size = new System.Drawing.Size(59, 17);
            this.rbTypeB.TabIndex = 1;
            this.rbTypeB.TabStop = true;
            this.rbTypeB.Text = "Type B";
            this.rbTypeB.UseVisualStyleBackColor = true;
            // 
            // rbTypeA
            // 
            this.rbTypeA.AutoSize = true;
            this.rbTypeA.Location = new System.Drawing.Point(43, 28);
            this.rbTypeA.Name = "rbTypeA";
            this.rbTypeA.Size = new System.Drawing.Size(59, 17);
            this.rbTypeA.TabIndex = 0;
            this.rbTypeA.TabStop = true;
            this.rbTypeA.Text = "Type A";
            this.rbTypeA.UseVisualStyleBackColor = true;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.btnRead);
            this.groupBox3.Controls.Add(this.btnUpdate);
            this.groupBox3.Controls.Add(this.tbData);
            this.groupBox3.Controls.Add(this.label7);
            this.groupBox3.Controls.Add(this.tbBinaryBlockNo);
            this.groupBox3.Controls.Add(this.label4);
            this.groupBox3.Location = new System.Drawing.Point(12, 301);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(281, 111);
            this.groupBox3.TabIndex = 5;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Binary Block Functions";
            // 
            // btnRead
            // 
            this.btnRead.Location = new System.Drawing.Point(169, 69);
            this.btnRead.Name = "btnRead";
            this.btnRead.Size = new System.Drawing.Size(106, 30);
            this.btnRead.TabIndex = 5;
            this.btnRead.Text = "Read Block";
            this.btnRead.UseVisualStyleBackColor = true;
            this.btnRead.Click += new System.EventHandler(this.btnRead_Click);
            // 
            // btnUpdate
            // 
            this.btnUpdate.CausesValidation = false;
            this.btnUpdate.Location = new System.Drawing.Point(169, 33);
            this.btnUpdate.Name = "btnUpdate";
            this.btnUpdate.Size = new System.Drawing.Size(106, 30);
            this.btnUpdate.TabIndex = 4;
            this.btnUpdate.Text = "Update Block";
            this.btnUpdate.UseVisualStyleBackColor = true;
            this.btnUpdate.Click += new System.EventHandler(this.btnUpdate_Click);
            // 
            // tbData
            // 
            this.tbData.Location = new System.Drawing.Point(9, 79);
            this.tbData.MaxLength = 16;
            this.tbData.Name = "tbData";
            this.tbData.Size = new System.Drawing.Size(151, 20);
            this.tbData.TabIndex = 3;
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(6, 63);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(30, 13);
            this.label7.TabIndex = 2;
            this.label7.Text = "Data";
            // 
            // tbBinaryBlockNo
            // 
            this.tbBinaryBlockNo.Location = new System.Drawing.Point(63, 29);
            this.tbBinaryBlockNo.MaxLength = 2;
            this.tbBinaryBlockNo.Name = "tbBinaryBlockNo";
            this.tbBinaryBlockNo.Size = new System.Drawing.Size(28, 20);
            this.tbBinaryBlockNo.TabIndex = 1;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 32);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(51, 13);
            this.label4.TabIndex = 0;
            this.label4.Text = "Block No";
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.btnCopy);
            this.groupBox4.Controls.Add(this.btnDec);
            this.groupBox4.Controls.Add(this.btnInc);
            this.groupBox4.Controls.Add(this.btnReadVal);
            this.groupBox4.Controls.Add(this.btnStore);
            this.groupBox4.Controls.Add(this.tbTarget);
            this.groupBox4.Controls.Add(this.tbSource);
            this.groupBox4.Controls.Add(this.tbValueBlockNo);
            this.groupBox4.Controls.Add(this.tbValue);
            this.groupBox4.Controls.Add(this.label9);
            this.groupBox4.Controls.Add(this.label8);
            this.groupBox4.Controls.Add(this.label6);
            this.groupBox4.Controls.Add(this.label5);
            this.groupBox4.Location = new System.Drawing.Point(299, 8);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(391, 165);
            this.groupBox4.TabIndex = 6;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Value Block Functions";
            // 
            // btnCopy
            // 
            this.btnCopy.Location = new System.Drawing.Point(275, 133);
            this.btnCopy.Name = "btnCopy";
            this.btnCopy.Size = new System.Drawing.Size(110, 23);
            this.btnCopy.TabIndex = 12;
            this.btnCopy.Text = "Copy Block";
            this.btnCopy.UseVisualStyleBackColor = true;
            this.btnCopy.Click += new System.EventHandler(this.btnCopy_Click);
            // 
            // btnDec
            // 
            this.btnDec.Location = new System.Drawing.Point(275, 104);
            this.btnDec.Name = "btnDec";
            this.btnDec.Size = new System.Drawing.Size(110, 23);
            this.btnDec.TabIndex = 11;
            this.btnDec.Text = "Decrement";
            this.btnDec.UseVisualStyleBackColor = true;
            this.btnDec.Click += new System.EventHandler(this.btnDec_Click);
            // 
            // btnInc
            // 
            this.btnInc.Location = new System.Drawing.Point(275, 78);
            this.btnInc.Name = "btnInc";
            this.btnInc.Size = new System.Drawing.Size(110, 23);
            this.btnInc.TabIndex = 10;
            this.btnInc.Text = "Increment";
            this.btnInc.UseVisualStyleBackColor = true;
            this.btnInc.Click += new System.EventHandler(this.btnInc_Click);
            // 
            // btnReadVal
            // 
            this.btnReadVal.Location = new System.Drawing.Point(275, 49);
            this.btnReadVal.Name = "btnReadVal";
            this.btnReadVal.Size = new System.Drawing.Size(110, 23);
            this.btnReadVal.TabIndex = 9;
            this.btnReadVal.Text = "Read Value";
            this.btnReadVal.UseVisualStyleBackColor = true;
            this.btnReadVal.Click += new System.EventHandler(this.btnReadVal_Click);
            // 
            // btnStore
            // 
            this.btnStore.Location = new System.Drawing.Point(275, 20);
            this.btnStore.Name = "btnStore";
            this.btnStore.Size = new System.Drawing.Size(110, 23);
            this.btnStore.TabIndex = 8;
            this.btnStore.Text = "Store Value";
            this.btnStore.UseVisualStyleBackColor = true;
            this.btnStore.Click += new System.EventHandler(this.btnStore_Click);
            // 
            // tbTarget
            // 
            this.tbTarget.Location = new System.Drawing.Point(87, 101);
            this.tbTarget.MaxLength = 2;
            this.tbTarget.Name = "tbTarget";
            this.tbTarget.Size = new System.Drawing.Size(22, 20);
            this.tbTarget.TabIndex = 7;
            // 
            // tbSource
            // 
            this.tbSource.Location = new System.Drawing.Point(87, 74);
            this.tbSource.MaxLength = 2;
            this.tbSource.Name = "tbSource";
            this.tbSource.Size = new System.Drawing.Size(22, 20);
            this.tbSource.TabIndex = 6;
            // 
            // tbValueBlockNo
            // 
            this.tbValueBlockNo.Location = new System.Drawing.Point(87, 49);
            this.tbValueBlockNo.MaxLength = 2;
            this.tbValueBlockNo.Name = "tbValueBlockNo";
            this.tbValueBlockNo.Size = new System.Drawing.Size(22, 20);
            this.tbValueBlockNo.TabIndex = 5;
            // 
            // tbValue
            // 
            this.tbValue.Location = new System.Drawing.Point(87, 22);
            this.tbValue.Name = "tbValue";
            this.tbValue.Size = new System.Drawing.Size(100, 20);
            this.tbValue.TabIndex = 4;
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(8, 104);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(68, 13);
            this.label9.TabIndex = 3;
            this.label9.Text = "Target Block";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(8, 77);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(71, 13);
            this.label8.TabIndex = 2;
            this.label8.Text = "Source Block";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(8, 49);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(51, 13);
            this.label6.TabIndex = 1;
            this.label6.Text = "Block No";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(8, 25);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(73, 13);
            this.label5.TabIndex = 0;
            this.label5.Text = "Value Amount";
            // 
            // btnClear
            // 
            this.btnClear.Location = new System.Drawing.Point(299, 383);
            this.btnClear.Name = "btnClear";
            this.btnClear.Size = new System.Drawing.Size(123, 29);
            this.btnClear.TabIndex = 7;
            this.btnClear.Text = "Clear";
            this.btnClear.UseVisualStyleBackColor = true;
            this.btnClear.Click += new System.EventHandler(this.btnClear_Click);
            // 
            // btnReset
            // 
            this.btnReset.Location = new System.Drawing.Point(428, 383);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(133, 29);
            this.btnReset.TabIndex = 8;
            this.btnReset.Text = "Reset";
            this.btnReset.UseVisualStyleBackColor = true;
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // btnQuit
            // 
            this.btnQuit.Location = new System.Drawing.Point(567, 383);
            this.btnQuit.Name = "btnQuit";
            this.btnQuit.Size = new System.Drawing.Size(123, 29);
            this.btnQuit.TabIndex = 9;
            this.btnQuit.Text = "Quit";
            this.btnQuit.UseVisualStyleBackColor = true;
            this.btnQuit.Click += new System.EventHandler(this.btnQuit_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(702, 422);
            this.Controls.Add(this.btnQuit);
            this.Controls.Add(this.btnReset);
            this.Controls.Add(this.btnClear);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.mMsg);
            this.Controls.Add(this.btnConnect);
            this.Controls.Add(this.cbPort);
            this.Controls.Add(this.label1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form1";
            this.Text = "Mifare Programming";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.Leave += new System.EventHandler(this.Form1_Leave);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox cbPort;
        private System.Windows.Forms.Button btnConnect;
        private System.Windows.Forms.RichTextBox mMsg;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.RadioButton rbTypeB;
        private System.Windows.Forms.RadioButton rbTypeA;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button btnAuth;
        private System.Windows.Forms.TextBox tbKey6;
        private System.Windows.Forms.TextBox tbKey5;
        private System.Windows.Forms.TextBox tbKey4;
        private System.Windows.Forms.TextBox tbKey3;
        private System.Windows.Forms.TextBox tbKey2;
        private System.Windows.Forms.TextBox tbKey1;
        private System.Windows.Forms.TextBox tbBlockNo;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox tbData;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.TextBox tbBinaryBlockNo;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button btnRead;
        private System.Windows.Forms.Button btnUpdate;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox tbTarget;
        private System.Windows.Forms.TextBox tbSource;
        private System.Windows.Forms.TextBox tbValueBlockNo;
        private System.Windows.Forms.TextBox tbValue;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Button btnCopy;
        private System.Windows.Forms.Button btnDec;
        private System.Windows.Forms.Button btnInc;
        private System.Windows.Forms.Button btnReadVal;
        private System.Windows.Forms.Button btnStore;
        private System.Windows.Forms.Button btnClear;
        private System.Windows.Forms.Button btnReset;
        private System.Windows.Forms.Button btnQuit;
    }
}


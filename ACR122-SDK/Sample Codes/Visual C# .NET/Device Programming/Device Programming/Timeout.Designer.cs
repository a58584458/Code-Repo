namespace Device_Programming
{
    partial class Timeout
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.btnOK = new System.Windows.Forms.Button();
            this.btnCancel = new System.Windows.Forms.Button();
            this.tbStatTO = new System.Windows.Forms.TextBox();
            this.tbStatRet = new System.Windows.Forms.TextBox();
            this.tbRespTO = new System.Windows.Forms.TextBox();
            this.tbRespRet = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 24);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(103, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Status Timeout (ms):";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(12, 55);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(73, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = "Status Retries";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 85);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(121, 13);
            this.label3.TabIndex = 2;
            this.label3.Text = "Response Timeout (ms):";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 117);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(94, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = "Response Retries:";
            // 
            // btnOK
            // 
            this.btnOK.Location = new System.Drawing.Point(31, 149);
            this.btnOK.Name = "btnOK";
            this.btnOK.Size = new System.Drawing.Size(75, 23);
            this.btnOK.TabIndex = 4;
            this.btnOK.Text = "OK";
            this.btnOK.UseVisualStyleBackColor = true;
            this.btnOK.Click += new System.EventHandler(this.btnOK_Click);
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(134, 149);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 5;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // tbStatTO
            // 
            this.tbStatTO.Location = new System.Drawing.Point(134, 21);
            this.tbStatTO.Name = "tbStatTO";
            this.tbStatTO.Size = new System.Drawing.Size(79, 20);
            this.tbStatTO.TabIndex = 6;
            // 
            // tbStatRet
            // 
            this.tbStatRet.Location = new System.Drawing.Point(134, 52);
            this.tbStatRet.Name = "tbStatRet";
            this.tbStatRet.Size = new System.Drawing.Size(79, 20);
            this.tbStatRet.TabIndex = 7;
            // 
            // tbRespTO
            // 
            this.tbRespTO.Location = new System.Drawing.Point(134, 82);
            this.tbRespTO.Name = "tbRespTO";
            this.tbRespTO.Size = new System.Drawing.Size(79, 20);
            this.tbRespTO.TabIndex = 8;
            // 
            // tbRespRet
            // 
            this.tbRespRet.Location = new System.Drawing.Point(134, 114);
            this.tbRespRet.Name = "tbRespRet";
            this.tbRespRet.Size = new System.Drawing.Size(79, 20);
            this.tbRespRet.TabIndex = 9;
            // 
            // Timeout
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(242, 184);
            this.Controls.Add(this.tbRespRet);
            this.Controls.Add(this.tbRespTO);
            this.Controls.Add(this.tbStatRet);
            this.Controls.Add(this.tbStatTO);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnOK);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Timeout";
            this.Text = "Timeout";
            this.Load += new System.EventHandler(this.Timeout_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Button btnOK;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.TextBox tbStatTO;
        private System.Windows.Forms.TextBox tbStatRet;
        private System.Windows.Forms.TextBox tbRespTO;
        private System.Windows.Forms.TextBox tbRespRet;
    }
}
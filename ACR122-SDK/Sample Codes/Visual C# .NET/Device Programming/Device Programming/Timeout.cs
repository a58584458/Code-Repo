using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Device_Programming
{
    public partial class Timeout : Form
    {
        frmMain parent;
        public Timeout()
        {
            InitializeComponent();
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            int res, flag;
            acr122.ACR122_TIMEOUTS to;

            if (tbStatTO.Text == "" || (!int.TryParse(tbStatTO.Text, System.Globalization.NumberStyles.Integer, null, out flag)))
            {
                MessageBox.Show("Please enter a valid integer value for Status Timeout");
                tbStatTO.Focus();
                return;
            }

            if (tbStatRet.Text == "" || (!int.TryParse(tbStatRet.Text, System.Globalization.NumberStyles.Integer, null, out flag)))
            {
                MessageBox.Show("Please enter a valid integer value for Status Retries");
                tbStatRet.Focus();
                return;
            }

            if (tbRespTO.Text == "" || (!int.TryParse(tbRespTO.Text, System.Globalization.NumberStyles.Integer, null, out flag)))
            {
                MessageBox.Show("Please enter a valid integer value for Response Timeout");
                tbRespTO.Focus();
                return;
            }

            if (tbRespRet.Text == "" || (!int.TryParse(tbRespRet.Text, System.Globalization.NumberStyles.Integer, null, out flag)))
            {
                MessageBox.Show("Please enter a valid integer value for Response Retries");
                tbRespRet.Focus();
                return;
            }
            
            to.statusTimeout = int.Parse(tbStatTO.Text, System.Globalization.NumberStyles.Integer);
            to.numStatusRetries = int.Parse(tbStatRet.Text, System.Globalization.NumberStyles.Integer);
            to.responseTimeout = int.Parse(tbRespTO.Text, System.Globalization.NumberStyles.Integer);
            to.numResponseRetries = int.Parse(tbRespRet.Text, System.Globalization.NumberStyles.Integer);

            res = acr122.ACR122_SetTimeouts(parent.hReader, ref to);
            if (res != 0)
            {
                parent.displayOut(0, "Set timeouts failed");
            }
            else
            {
                parent.displayOut(0, "Set timeouts success");
            }

            this.Close();
        }

        private void Timeout_Load(object sender, EventArgs e)
        {
            parent = (frmMain)this.Owner;
            tbStatTO.Text = "2000";
            tbStatRet.Text = "1";
            tbRespTO.Text = "10000";
            tbRespRet.Text = "1";
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}

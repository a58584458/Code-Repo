using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Key_Management
{
    public partial class frmMain : Form
    {
        public frmMain()
        {
            InitializeComponent();
        }

        public void displayOut(int errType, string PrintText)
        {
            PrintText = PrintText + "\n";
            switch (errType)
            {
                case 0:                                                 // Notifications
                    mMsg.ForeColor = Color.Green;
                    break;
                case 1:                                                 // Error Messages
                    mMsg.ForeColor = Color.Red;
                    break;
                case 2:                                                 // Input data
                    PrintText = "<" + PrintText;
                    mMsg.ForeColor = Color.Black;
                    break;
                case 3:
                    PrintText = ">" + PrintText;                       // Output data
                    mMsg.ForeColor = Color.Black;
                    break;
            }

            mMsg.AppendText(PrintText);
            mMsg.ForeColor = Color.Black;
            mMsg.Focus();
        }

        public int SendAPDU( int type )
        {
            string tempstr;
            int i;

            tempstr = "";
            for (i = 0; i < common.SendLen; i++)
            {
                tempstr = tempstr + " " + string.Format("{0:X2}", common.SendBuff[i]);
            }

            displayOut(2, tempstr);

            if (type == 0)
            {
                common.retCode = acr122.ACR122_DirectTransmit(common.hReader, ref common.SendBuff[0], common.SendLen, ref common.RecvBuff[0], ref common.RecvLen);
            }
            else
            {
                common.retCode = acr122.ACR122_ExchangeApdu(common.hReader, 0, ref common.SendBuff[0], common.SendLen, ref common.RecvBuff[0], ref common.RecvLen);
            }
            if (common.retCode != 0)
            {
                return common.retCode;
            }

            tempstr = "";
            for (i = 0; i < common.RecvLen; i++)
            {
                tempstr = tempstr + " " + string.Format("{0:X2}", common.RecvBuff[i]);
            }
            displayOut(3, tempstr);
            return common.retCode;
        }

        public void ClearBuffers()
        {
            for (int i = 0; i < 255; i++)
            {
                common.SendBuff[i] = 0x00;
                common.RecvBuff[i] = 0x00;
            }
        }

        void Init()
        {
            mMsg.Text = "";
            displayOut(0, "Program Started");
            btnConnect.Enabled = true;
            btnICC.Enabled = false;
            btnInitSAM.Enabled = false;
            btnGenKeys.Enabled = false;
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            string tempstr;
            byte[] fw = new byte[255];
            int fwlen;

            tempstr = cbPort.Text;

            //connect to ACR122S
            common.retCode = acr122.ACR122_OpenA(tempstr, ref common.hReader);
            if (common.retCode != 0)
            {
                displayOut(1, "Connection to " + cbPort.Text + " failed");
                return;
            }
            else
            {
                displayOut(0, "Connection to " + cbPort.Text + " success");
            }

            fwlen = 255;
            common.retCode = acr122.ACR122_GetFirmwareVersion(common.hReader, 0, ref fw[0], ref fwlen);
            if (common.retCode != 0)
            {
                displayOut(1, "Get Firmware version failed");
                return;
            }
            else
            {
                tempstr = "";
                for (int i = 0; i < fwlen; i++)
                {
                    tempstr = tempstr + Convert.ToChar(fw[i]);
                }

                displayOut(0, "Get Firmware Version success");
                displayOut(0, "Firmware: " + tempstr);
                displayOut(0, "");
            }

            btnConnect.Enabled = false;
            btnICC.Enabled = true;
        }

        private void btnICC_Click(object sender, EventArgs e)
        {
            string tempstr;

            ClearBuffers();

            common.RecvLen = 255;

            common.retCode = acr122.ACR122_PowerOnIcc(common.hReader, 0, ref common.RecvBuff[0], ref common.RecvLen);
            if (common.retCode != 0)
            {
                displayOut(0, "Power on ICC failed");
                return;
            }
            else
            {
                displayOut(0, "Power on ICC success");

                tempstr = "";

                for (int i = 0; i < common.RecvLen; i++)
                {
                    tempstr = tempstr + string.Format("{0:X2} ", common.RecvBuff[i]);
                }

                displayOut(0, "ATR: " + tempstr);
            }

            btnICC.Enabled = false;
            btnInitSAM.Enabled = true;
            btnGenKeys.Enabled = true;
        }

        private void btnInitSAM_Click(object sender, EventArgs e)
        {
            //Show Initialize SAM Dialog
            SAM_INIT formSAM = new SAM_INIT();
            DialogResult dr = formSAM.ShowDialog(this);
        }

        private void btnGenKeys_Click(object sender, EventArgs e)
        {
            //Show Generate keys Dialog
            MifareInit formMi = new MifareInit();
            DialogResult dr = formMi.ShowDialog(this);
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            cbPort.SelectedIndex = 0;
            Init();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            mMsg.Text = "";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            acr122.ACR122_PowerOffIcc(common.hReader, 0);
            acr122.ACR122_Close(common.hReader);
            Init();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            acr122.ACR122_PowerOffIcc(common.hReader, 0);
            acr122.ACR122_Close(common.hReader);
            this.Close();
        }
    }
}

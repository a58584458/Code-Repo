using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Other_PICC_Cards
{
    public partial class Form1 : Form
    {
        //global variables
        int retCode;
        int SendLen, RecvLen;
        int hReader;
        byte[] SendBuff = new byte[255];
        byte[] RecvBuff = new byte[255];

        public Form1()
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

        public void ClearBuffers()
        {
            for (int i = 0; i < 255; i++)
            {
                SendBuff[i] = 0x00;
                RecvBuff[i] = 0x00;
            }
        }

        public void Init()
        {
            mMsg.Text = "";
            displayOut(0, "Program Started");

            btnConnect.Enabled = true;
            groupBox1.Enabled = false;

            tbData.Text = "";
            cbPort.SelectedIndex = 0;
        }

        public int SendAPDU()
        {
            string tempstr;
            int i;

            tempstr = "";
            for (i = 0; i < SendLen; i++)
            {
                tempstr = tempstr + " " + string.Format("{0:X2}", SendBuff[i]);
            }

            displayOut(2, tempstr);

            retCode = acr122.ACR122_DirectTransmit(hReader, ref SendBuff[0], SendLen, ref RecvBuff[0], ref RecvLen);
            if (retCode != 0)
            {
                return retCode;
            }

            tempstr = "";
            for (i = 0; i < RecvLen; i++)
            {
                tempstr = tempstr + " " + string.Format("{0:X2}", RecvBuff[i]);
            }
            displayOut(3, tempstr);
            return retCode;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            Init();
        }

        private void btnSend_Click(object sender, EventArgs e)
        {
            string tempstr, StrIn, tempdata;
            int i,k;

            tempstr = "";
            tempdata = "";
            StrIn = tbData.Text;

            for (i = 0; i <= StrIn.Length - 1; i++)
            {
                if (StrIn[i] != ' ')
                {
                    tempstr = tempstr + StrIn[i];
                }
            }

            if (tempstr.Length % 2 != 0)
            {
                MessageBox.Show("Command should be divisible by 2");
                tbData.Focus();
                return;
            }

            for (i = 0, k = 0; i < tempstr.Length; i += 2,k++)
            {
                tempdata = tempstr.Substring(i, 2);
                SendBuff[k] = byte.Parse(tempdata, System.Globalization.NumberStyles.HexNumber, null);
            }

            SendLen = k;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Send command failed");
                return;
            }
            else
            {
                displayOut(0, "Send command success");
            }
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            string tempstr;
            byte[] fw = new byte[255];
            int fwlen;

            tempstr = cbPort.Text;

            //connect to ACR122S
            retCode = acr122.ACR122_OpenA(tempstr, ref hReader);
            if (retCode != 0)
            {
                displayOut(1, "Connection to " + cbPort.Text + " failed");
                return;
            }
            else
            {
                displayOut(0, "Connection to " + cbPort.Text + " success");
            }

            fwlen = 255;
            retCode = acr122.ACR122_GetFirmwareVersion(hReader, 0, ref fw[0], ref fwlen);
            if (retCode != 0)
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
            groupBox1.Enabled = true;
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            mMsg.Text = "";
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            acr122.ACR122_Close(hReader);
            Init();
        }

        private void btnQuit_Click(object sender, EventArgs e)
        {
            acr122.ACR122_Close(hReader);
            this.Close();
        }
    }
}

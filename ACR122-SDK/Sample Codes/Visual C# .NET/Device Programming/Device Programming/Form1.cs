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
    public partial class frmMain : Form
    {
        //global variables
        int retCode;
        public int hReader;
        byte[] SendBuff = new byte[255];
        byte[] RecvBuff = new byte[255];

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
            btnBaud.Enabled = false;
            btnTimeOut.Enabled = false;
            groupBox1.Enabled = false;

            rbL0BlinkStateOn.Checked = true;
            rbL0fStateOn.Checked = true;
            rbL1BlinkStateOn.Checked = true;
            rbL1fStateOn.Checked = true;
            cbLED0Blink.Checked = false;
            cbLED1Blink.Checked = false;
            cbLED0Update.Checked = false;
            cbLED1Update.Checked = false;
            cbT1.Checked = true;

            tbNum.Text = "1";
            tbT1.Text = "500";
            tbT2.Text = "500";

            cbPort.SelectedIndex = 0;
            cbBaud.SelectedIndex = 0;
        }

        private void frmMain_Load(object sender, EventArgs e)
        {
            Init();
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
            btnBaud.Enabled = true;
            btnTimeOut.Enabled = true;
            groupBox1.Enabled = true;
        }

        private void btnBaud_Click(object sender, EventArgs e)
        {
            if (cbBaud.SelectedIndex == 0)
            {
                retCode = acr122.ACR122_SetBaudRate(hReader, 9600);
            }
            else
            {
                retCode = acr122.ACR122_SetBaudRate(hReader, 115200);
            }

            if (retCode != 0)
            {
                displayOut(0, "Set baud rate failed");
            }
            else
            {
                displayOut(0, "Set baud rate success");
            }
        }

        private void btnSetLED_Click(object sender, EventArgs e)
        {
            acr122.ACR122_LED_CONTROL[] ledCtrl = new acr122.ACR122_LED_CONTROL[2];
            int t1, t2, num, buzzmode, flag;

            if (tbT1.Text == "" || (!int.TryParse(tbT1.Text, System.Globalization.NumberStyles.Integer, null, out flag)))
            {
                MessageBox.Show("Enter a valid integer value for T1");
                tbT1.Focus();
                return;
            }
            if (flag > 25500)
            {
                tbT1.Text = "25500";
                tbT1.Focus();
                return;
            }

            if (tbT2.Text == "" || (!int.TryParse(tbT2.Text, System.Globalization.NumberStyles.Integer, null, out flag)))
            {
                MessageBox.Show("Enter a valid integer value for T2");
                tbT2.Focus();
                return;
            }
            if (flag > 25500)
            {
                tbT2.Text = "25500";
                tbT2.Focus();
                return;
            }

            if (tbNum.Text == "" || (!int.TryParse(tbNum.Text, System.Globalization.NumberStyles.Integer, null, out flag)))
            {
                MessageBox.Show("Enter a valid integer value for Times");
                tbNum.Focus();
                return;
            }
            if (flag > 255)
            {
                tbNum.Text = "255";
                tbNum.Focus();
                return;
            }
            

            if (rbL0fStateOn.Checked == true)
            {
                ledCtrl[0].finalState = acr122.ACR122_LED_STATE_ON;
            }
            else
            {
                ledCtrl[0].finalState = acr122.ACR122_LED_STATE_OFF;
            }

            if (rbL0BlinkStateOn.Checked == true)
            {
                ledCtrl[0].initialBlinkingState = acr122.ACR122_LED_STATE_ON;
            }
            else
            {
                ledCtrl[0].initialBlinkingState = acr122.ACR122_LED_STATE_OFF;
            }

            if (rbL1fStateOn.Checked == true)
            {
                ledCtrl[1].finalState = acr122.ACR122_LED_STATE_ON;
            }
            else
            {
                ledCtrl[1].finalState = acr122.ACR122_LED_STATE_OFF;
            }

            if (rbL1BlinkStateOn.Checked == true)
            {
                ledCtrl[1].initialBlinkingState = acr122.ACR122_LED_STATE_ON;
            }
            else
            {
                ledCtrl[1].initialBlinkingState = acr122.ACR122_LED_STATE_OFF;
            }

            if (cbLED0Blink.Checked == true)
            {
                ledCtrl[0].blinkEnabled = true;
            }
            else
            {
                ledCtrl[0].blinkEnabled = false;
            }

            if (cbLED0Update.Checked == true)
            {
                ledCtrl[0].updateEnabled = true;
            }
            else
            {
                ledCtrl[0].updateEnabled = false;
            }

            if (cbLED1Blink.Checked == true)
            {
                ledCtrl[1].blinkEnabled = true;
            }
            else
            {
                ledCtrl[1].blinkEnabled = false;
            }

            if (cbLED1Update.Checked == true)
            {
                ledCtrl[1].updateEnabled = true;
            }
            else
            {
                ledCtrl[1].updateEnabled = false;
            }

            t1 = int.Parse(tbT1.Text, System.Globalization.NumberStyles.Integer);
            t2 = int.Parse(tbT2.Text, System.Globalization.NumberStyles.Integer);
            num = int.Parse(tbNum.Text, System.Globalization.NumberStyles.Integer);

            buzzmode = acr122.ACR122_BUZZER_MODE_OFF;
            if (cbT1.Checked == true)
            {
                buzzmode = acr122.ACR122_BUZZER_MODE_T1;
            }

            if (cbT2.Checked == true)
            {
                buzzmode = acr122.ACR122_BUZZER_MODE_T2;
            }

            if ((cbT1.Checked == true) && (cbT2.Checked == true))
            {
                buzzmode = acr122.ACR122_BUZZER_MODE_T1 | acr122.ACR122_BUZZER_MODE_T2;
            }

            retCode = acr122.ACR122_SetLedStatesWithBeep(hReader, ref ledCtrl[0], 2, t1, t2, num, buzzmode);
            if (retCode != 0)
            {
                displayOut(0, "Set LED States with Beep failed");
            }
            else
            {
                displayOut(0, "Set LED States with Beep success");
            }
        }

        private void btnTimeOut_Click(object sender, EventArgs e)
        {
            //Show timeout dialog
            Timeout formTO = new Timeout();
            DialogResult dr = formTO.ShowDialog(this);
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

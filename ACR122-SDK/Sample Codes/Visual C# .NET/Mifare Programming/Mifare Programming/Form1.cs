using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;


namespace Mifare_Programming
{
    public partial class Form1 : Form
    {
        //global variables
        int retCode;
        int SendLen, RecvLen;
        int hReader;
        byte isHex;
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
            groupBox2.Enabled = false;
            groupBox3.Enabled = false;
            groupBox4.Enabled = false;

            rbTypeA.Checked = true;
            tbBinaryBlockNo.Text = "";
            tbBlockNo.Text = "";
            tbData.Text = "";
            tbKey1.Text = "";
            tbKey2.Text = "";
            tbKey3.Text = "";
            tbKey4.Text = "";
            tbKey5.Text = "";
            tbKey6.Text = "";
            tbSource.Text = "";
            tbTarget.Text = "";
            tbValue.Text = "";
            tbValueBlockNo.Text = "";

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
            groupBox2.Enabled = true;
            groupBox3.Enabled = true;
            groupBox4.Enabled = true;
        }

        private void btnAuth_Click(object sender, EventArgs e)
        {
            byte[] UID = new byte[4];

            if (!byte.TryParse(tbBlockNo.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Block number.");
                tbBlockNo.Focus();
                return;
            }

            if (!byte.TryParse(tbKey1.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Key.");
                tbKey1.Focus();
                return;
            }
            if (!byte.TryParse(tbKey2.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Key.");
                tbKey2.Focus();
                return;
            }
            if (!byte.TryParse(tbKey3.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Key.");
                tbKey3.Focus();
                return;
            }
            if (!byte.TryParse(tbKey4.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Key.");
                tbKey4.Focus();
                return;
            }
            if (!byte.TryParse(tbKey5.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Key.");
                tbKey5.Focus();
                return;
            }
            if (!byte.TryParse(tbKey6.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Key.");
                tbKey6.Focus();
                return;
            }

            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x4A;
            SendBuff[2] = 0x01;
            SendBuff[3] = 0x00;

            SendLen = 4;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Authentication failed");
                return;
            }
            else
            {
                for (int i = 8; i < RecvBuff[7] + 8; i++)
                {
                    UID[i - 8] = RecvBuff[i];
                }
            }

            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x40;
            SendBuff[2] = 0x01;

            if (rbTypeA.Checked)
            {
                SendBuff[3] = 0x60;
            }
            else
            {
                SendBuff[3] = 0x61;
            }

            SendBuff[4] = byte.Parse(tbBlockNo.Text, System.Globalization.NumberStyles.HexNumber);
            SendBuff[5] = byte.Parse(tbKey1.Text, System.Globalization.NumberStyles.HexNumber);
            SendBuff[6] = byte.Parse(tbKey2.Text, System.Globalization.NumberStyles.HexNumber);
            SendBuff[7] = byte.Parse(tbKey3.Text, System.Globalization.NumberStyles.HexNumber);
            SendBuff[8] = byte.Parse(tbKey4.Text, System.Globalization.NumberStyles.HexNumber);
            SendBuff[9] = byte.Parse(tbKey5.Text, System.Globalization.NumberStyles.HexNumber);
            SendBuff[10] = byte.Parse(tbKey6.Text, System.Globalization.NumberStyles.HexNumber);
            

            SendBuff[11] = UID[0];
            SendBuff[12] = UID[1];
            SendBuff[13] = UID[2];
            SendBuff[14] = UID[3];

            SendLen = 15;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Authentication failed");
                return;
            }
            else
            {
                displayOut(0, "Authentication success");
            }
        }

        private void btnRead_Click(object sender, EventArgs e)
        {
            string tempstr;

            if (!byte.TryParse(tbBinaryBlockNo.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Block number.");
                tbBinaryBlockNo.Focus();
                return;
            }

            tempstr = "";

            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x40;
            SendBuff[2] = 0x01;
            SendBuff[3] = 0x30;
            SendBuff[4] = byte.Parse(tbBinaryBlockNo.Text, System.Globalization.NumberStyles.HexNumber);

            SendLen = 5;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Read Block failed");
                return;
            }
            else
            {
                if (RecvLen < 4)
                {
                    displayOut(0, "Read Block failed");
                    return;
                }
                else
                {
                    displayOut(0, "Read Block success");
                    for (int i = 3; i < RecvLen; i++)
                    {
                        tempstr = tempstr + Convert.ToChar(RecvBuff[i]);
                    }

                    tbData.Text = tempstr;
                }
            }
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            string tempstr;

            if (!byte.TryParse(tbBinaryBlockNo.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Block number.");
                tbBinaryBlockNo.Focus();
                return;
            }

            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x40;
            SendBuff[2] = 0x01;
            SendBuff[3] = 0xA0;
            SendBuff[4] = byte.Parse(tbBinaryBlockNo.Text, System.Globalization.NumberStyles.HexNumber);

            tempstr = tbData.Text;

            for (int i = 0; i < tempstr.Length; i++)
            {
                SendBuff[i + 5] = (byte)tempstr[i];
            }

            SendLen = 21;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Update block failed");
                return;
            }
            else
            {
                displayOut(0, "Update block success");
            }
        }

        private void btnStore_Click(object sender, EventArgs e)
        {
            int tempval, pVal;

            if (!byte.TryParse(tbValueBlockNo.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Block number.");
                tbValueBlockNo.Focus();
                return;
            }

            if (tbValue.Text == "" || (!int.TryParse(tbValue.Text.Trim(), System.Globalization.NumberStyles.Integer, null, out tempval)))
            {
                MessageBox.Show("Pls. key-in integer value for Value.");
                tbValue.Focus();
                return;
            }

            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x40;
            SendBuff[2] = 0x01;
            SendBuff[3] = 0xA0;
            SendBuff[4] = byte.Parse(tbValueBlockNo.Text, System.Globalization.NumberStyles.HexNumber);

            tempval = int.Parse(tbValue.Text, System.Globalization.NumberStyles.Integer);

            pVal = tempval;
            if (pVal >= 0)
            {
                //Computation of pVal
                tempval = pVal % 256;
                SendBuff[5] = (byte)tempval;

                tempval = pVal / 256;
                tempval = tempval % 256;
                SendBuff[6] = (byte)tempval;

                tempval = pVal / 256;
                tempval = tempval / 256;
                tempval = tempval % 256;
                SendBuff[7] = (byte)tempval;

                tempval = pVal / 256;
                tempval = tempval / 256;
                tempval = tempval / 256;
                tempval = tempval % 256;
                SendBuff[8] = (byte)tempval;

                //Get complemet of pVal
                SendBuff[9] = (byte)(255 - SendBuff[5]);
                SendBuff[10] = (byte)(255 - SendBuff[6]);
                SendBuff[11] = (byte)(255 - SendBuff[7]);
                SendBuff[12] = (byte)(255 - SendBuff[8]);
            }
            else
            {
                long temp = abs(pVal);

                //Computation of pVal
                SendBuff[5] = (byte)(~tempval + 1);
                SendBuff[9] = (byte)(tempval - 1);

                tempval = (byte)temp / 256;
                tempval = (byte)tempval % 256;
                SendBuff[6] = (byte)~tempval;
                SendBuff[10] = (byte)tempval;

                tempval = (byte)(temp / 256);
                tempval = tempval / 256;
                tempval = tempval % 256;
                SendBuff[7] = (byte)~tempval;
                SendBuff[11] = (byte)tempval;

                tempval = (byte)(temp / 256);
                tempval = tempval / 256;
                tempval = tempval / 256;
                tempval = tempval % 256;
                SendBuff[8] = (byte)~tempval;
                SendBuff[12] = (byte)tempval;
            }

            SendBuff[13] = SendBuff[5];
            SendBuff[14] = SendBuff[6];
            SendBuff[15] = SendBuff[7];
            SendBuff[16] = SendBuff[8];

            SendBuff[17] = SendBuff[4];
            SendBuff[18] = (byte)(255 - SendBuff[4]);
            SendBuff[19] = SendBuff[4];
            SendBuff[20] = (byte)(255 - SendBuff[4]);

            SendLen = 21;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Store value block failed");
                return;
            }
            else
            {
                displayOut(0, "Written to block " + tbValueBlockNo.Text + " success");
            }
        }

        private long abs(int pVal)
        {
            throw new NotImplementedException();
        }

        private void btnReadVal_Click(object sender, EventArgs e)
        {
            long amount;
            string tempstr;

            if (!byte.TryParse(tbValueBlockNo.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Block number.");
                tbValueBlockNo.Focus();
                return;
            }

            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x40;
            SendBuff[2] = 0x01;
            SendBuff[3] = 0x30;
            SendBuff[4] = byte.Parse(tbValueBlockNo.Text, System.Globalization.NumberStyles.HexNumber);

            SendLen = 5;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Read value from block failed");
                return;
            }
            else
            {
                if (RecvLen < 4)
                {
                    displayOut(0, "Read value from block failed");
                    return;
                }

                tempstr = "";

                for (int i = 6; i >= 3; i--)
                {
                    tempstr = tempstr + string.Format("{0:X2}", RecvBuff[i]);
                }

                amount = long.Parse(tempstr, System.Globalization.NumberStyles.HexNumber);
                tbValue.Text = amount.ToString();

                displayOut(0, "Read block success");
            }
        }

        private void btnInc_Click(object sender, EventArgs e)
        {
            ulong val, tempval;
            ulong[] valBuff = new ulong[4];

            if (!byte.TryParse(tbValueBlockNo.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Block number.");
                tbValueBlockNo.Focus();
                return;
            }

            tempval = ulong.Parse(tbValue.Text, System.Globalization.NumberStyles.Integer);

            //Computation of the increment value
            val = tempval;

            val = tempval % 256;
            valBuff[0] = val;

            val = tempval / 256;
            val = val % 256;
            valBuff[1] = val;

            val = tempval / 256;
            val = val / 256;
            val = val % 256;
            valBuff[2] = val;

            val = tempval / 256;
            val = val / 256;
            val = val / 256;
            val = val % 256;
            valBuff[3] = val;

            ClearBuffers();
	        SendBuff[0] = 0xD4;
	        SendBuff[1] = 0x40;
	        SendBuff[2] = 0x01;
	        SendBuff[3] = 0xC1;

	        SendBuff[4] = byte.Parse(tbValueBlockNo.Text, System.Globalization.NumberStyles.HexNumber);

	        for( int i = 0; i < 4; i++ )
	        {
		        SendBuff[i + 5] = (byte)valBuff[i];
	        }

	        SendLen = 9;
	        RecvLen = 255;

	        retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Increment block failed");
                return;
            }
            else
            {
                ClearBuffers();
                SendBuff[0] = 0xD4;
                SendBuff[1] = 0x40;
                SendBuff[2] = 0x01;
                SendBuff[3] = 0xB0;

                SendBuff[4] = byte.Parse(tbValueBlockNo.Text, System.Globalization.NumberStyles.HexNumber);

                SendLen = 5;
                RecvLen = 255;

                retCode = SendAPDU();
                if (retCode != 0)
                {
                    displayOut(0, "Increment block failed");
                    return;
                }
                else
                {
                    displayOut(0, "Increment value of block " + tbValueBlockNo.Text + " success");
                    
                }
            }
        }

        private void btnDec_Click(object sender, EventArgs e)
        {
            ulong val, tempval;
            ulong[] valBuff = new ulong[4];

            if (!byte.TryParse(tbValueBlockNo.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Block number.");
                tbValueBlockNo.Focus();
                return;
            }

            tempval = ulong.Parse(tbValue.Text, System.Globalization.NumberStyles.Integer);

            //Computation of the increment value
            val = tempval;

            val = tempval % 256;
            valBuff[0] = val;

            val = tempval / 256;
            val = val % 256;
            valBuff[1] = val;

            val = tempval / 256;
            val = val / 256;
            val = val % 256;
            valBuff[2] = val;

            val = tempval / 256;
            val = val / 256;
            val = val / 256;
            val = val % 256;
            valBuff[3] = val;

            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x40;
            SendBuff[2] = 0x01;
            SendBuff[3] = 0xC0;

            SendBuff[4] = byte.Parse(tbValueBlockNo.Text, System.Globalization.NumberStyles.HexNumber);

            for (int i = 0; i < 4; i++)
            {
                SendBuff[i + 5] = (byte)valBuff[i];
            }

            SendLen = 9;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Increment block failed");
                return;
            }
            else
            {
                ClearBuffers();
                SendBuff[0] = 0xD4;
                SendBuff[1] = 0x40;
                SendBuff[2] = 0x01;
                SendBuff[3] = 0xB0;

                SendBuff[4] = byte.Parse(tbValueBlockNo.Text, System.Globalization.NumberStyles.HexNumber);

                SendLen = 5;
                RecvLen = 255;

                retCode = SendAPDU();
                if (retCode != 0)
                {
                    displayOut(0, "Increment block failed");
                    return;
                }
                else
                {
                    displayOut(0, "Increment value of block " + tbValueBlockNo.Text + " success");

                }
            }
        }

        private void btnCopy_Click(object sender, EventArgs e)
        {
            if (!byte.TryParse(tbSource.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Source Block number.");
                tbSource.Focus();
                return;
            }

            if (!byte.TryParse(tbTarget.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
            {
                MessageBox.Show("Pls. key-in hexadecimal value for Target Block number.");
                tbTarget.Focus();
                return;
            }

            //Copy from source block
            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x40;
            SendBuff[2] = 0x01;
            SendBuff[3] = 0xC2;
            SendBuff[4] = byte.Parse(tbSource.Text, System.Globalization.NumberStyles.HexNumber);

            SendLen = 5;
	        RecvLen = 255;

	        retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Copy block failed");
                return;
            }
            else
            {
                //Copy to target block
                ClearBuffers();
                SendBuff[0] = 0xD4;
                SendBuff[1] = 0x40;
                SendBuff[2] = 0x01;
                SendBuff[3] = 0xB0;

                SendBuff[4] = byte.Parse(tbTarget.Text, System.Globalization.NumberStyles.HexNumber);

                SendLen = 5;
                RecvLen = 255;

                retCode = SendAPDU();
                if (retCode != 0)
                {
                    displayOut(0, "Copy block failed");
                    return;
                }
                else
                {
                    displayOut(0,"Copying value to block " + tbTarget.Text + "success");
                }
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            Init();
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

        private void Form1_Leave(object sender, EventArgs e)
        {
            acr122.ACR122_Close(hReader);
        }
    }
}

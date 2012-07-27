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
    public partial class MifareInit : Form
    {
        frmMain par;
        byte[] UID = new byte[4];
        byte isHex;

        public MifareInit()
        {
            InitializeComponent();
        }

        void SaveKey(byte BlockNo, int Keytype)
        {
            string tempstr, keyin;
            int i, k;

            tempstr = "";
            keyin = "";

            BlockNo = (byte)((BlockNo * 4) + 3);

            par.ClearBuffers();
            common.SendBuff[0] = 0xD4;
            common.SendBuff[1] = 0x40;
            common.SendBuff[2] = 0x01;
            common.SendBuff[3] = 0x60;
            common.SendBuff[4] = BlockNo;
            common.SendBuff[5] = 0xFF;
            common.SendBuff[6] = 0xFF;
            common.SendBuff[7] = 0xFF;
            common.SendBuff[8] = 0xFF;
            common.SendBuff[9] = 0xFF;
            common.SendBuff[10] = 0xFF;

            for (i = 0; i < 4; i++)
            {
                common.SendBuff[i + 11] = UID[i];
            }

            common.SendLen = 15;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(0);
            if (common.retCode != 0)
            {
                par.displayOut(0, "Error in saving key");
                this.Close();
                return;
            }
            else
            {
                if (common.RecvBuff[2] != 0x00)
                {
                    par.displayOut(0, "Error in saving key");
                    this.Close();
                    return;
                }
            }

            par.ClearBuffers();
            common.SendBuff[0] = 0xD4;
            common.SendBuff[1] = 0x40;
            common.SendBuff[2] = 0x01;
            common.SendBuff[3] = 0x30;
            common.SendBuff[4] = BlockNo;

            common.SendLen = 5;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(0);
            if (common.retCode != 0)
            {
                par.displayOut(0, "Error in saving key");
                this.Close();
                return;
            }
            else
            {
                if (common.RecvLen < 4)
                {
                    par.displayOut(0, "Error in saving key");
                    this.Close();
                    return;
                }

                tempstr = "";
                for (i = 3; i < common.RecvLen; i++)
                {
                    tempstr = tempstr + string.Format("{0:X2}", common.RecvBuff[i]);
                }
            }

            switch (Keytype)
            { 
                case 1:
                    keyin = tbKc.Text;
                    break;
                case 2:
                    keyin = tbKt.Text;
                    break;
                case 3:
                    keyin = tbKd.Text;
                    break;
                case 4:
                    keyin = tbKcr.Text;
                    break;
                case 5:
                    keyin = tbKcf.Text;
                    break;
                case 6:
                    keyin = tbKrd.Text;
                    break;
                case 7:
                    par.displayOut(0, "Error in saving key");
                    this.Close();
                    break;
            }

            if (rbA.Checked)
            {
                for (i = 0, k = 0; i < 32; i += 2, k++)
                {
                    if (i < 12)
                    {
                        common.RecvBuff[k] = Convert.ToByte(keyin.Substring(i, 2), 16);
                    }
                    else
                    {
                        common.RecvBuff[k] = Convert.ToByte(tempstr.Substring(i, 2), 16);
                    }
                }
            }
            else
            {
                for (i = 0, k = 0; i < 32; i += 2, k++)
                {
                    if (i < 20)
                    {
                        common.RecvBuff[k] = Convert.ToByte(tempstr.Substring(i, 2), 16);
                    }
                    else
                    {
                        common.RecvBuff[k] = Convert.ToByte(tempstr.Substring(i, 2), 16);
                    }
                }
            }

            common.SendBuff[0] = 0xD4;
            common.SendBuff[1] = 0x40;
            common.SendBuff[2] = 0x01;
            common.SendBuff[3] = 0xA0;
            common.SendBuff[4] = BlockNo;

            for (i = 0; i < 16; i++)
            {
                common.SendBuff[i+5] = common.RecvBuff[i];
            }

            common.SendLen = 21;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(0);
            if (common.retCode != 0)
            {
                par.displayOut(0, "Error in saving key");
                this.Close();
                return;
            }
        }

        string GenSAMKey(byte KeyID)
        {
            int i;
            string buff;

            buff = "";

            par.ClearBuffers();
            common.SendBuff[0] = 0x80;
            common.SendBuff[1] = 0x88;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = KeyID; //KeyID
            common.SendBuff[4] = 0x08;

            for (i = 0; i < 4; i++)
            {
                common.SendBuff[i + 5] = UID[i];
            }

            common.SendLen = 13;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0)
            {
                par.displayOut(0, "Error in generating Keys");
                this.Close();
                return "";
            }

            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xC0;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x08;

            common.SendLen = 5;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if( common.retCode != 0 )
            {
                par.displayOut(0,"Error in generating keys");
                this.Close();
                return "";
            }
            else
            {
                if (common.RecvLen == 0)
                {
                    par.displayOut(0, "Error in generating keys");
                    this.Close();
                    return "";
                }
                if (common.RecvBuff[common.RecvLen - 2] == 0x90 && common.RecvBuff[common.RecvLen - 1] == 0x00)
                {
                    //Get only first 6 bytes as key
                    for (i = 0; i < 6; i++)
                    { 
                        buff = buff + string.Format("{0:X2}",common.RecvBuff[i]);
                    }
                }
            }

            return buff;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int i;
            string serial, key;

            par.ClearBuffers();
            common.SendBuff[0] = 0xD4;
            common.SendBuff[1] = 0x4A;
            common.SendBuff[2] = 0x01;
            common.SendBuff[3] = 0x00;

            common.SendLen = 4;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(0);
            if (common.retCode != 0)
            {
                par.displayOut(0, "Failed to get card serial number");
                this.Close();
                return;
            }
            else
            {
                for (i = 8; i < common.RecvBuff[7] + 8; i++)
                {
                    UID[i - 8] = common.RecvBuff[i];
                }

                serial = "";
                for (i = 0; i < 4; i++)
                {
                    serial = serial + string.Format("{0:X2}  ", UID[i]);
                }
                tbSerial.Text = serial;
            }

            //Select Issuer DF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xA4;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x02;
            common.SendBuff[5] = 0x11;
            common.SendBuff[6] = 0x00;

            common.SendLen = 7;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0)
            {
                par.displayOut(0, "Failed to select issuer DF");
                this.Close();
                return;
            }

            //Submit Issuer PIN
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0x20;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x01;
            common.SendBuff[4] = 0x08;

            for (i = 0; i < 8; i++)
            {
                common.SendBuff[i + 4] = common.GSAM[i];
            }

            common.SendLen = 13;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0)
            {
                par.displayOut(0, "Failed to submit issuer PIN");
                this.Close();
                return;
            }

            //Generate Key
            //Generate IC Using 1st SAM Master Key (KeyID=81)
            key = GenSAMKey(0x81);
            if (key.Length == 0)
            {
                par.displayOut(0, "Failed to obtain IC Key");
                this.Close();
                return;
            }
            else
            {
                tbIC.Text = key;
            }

            //Generate Card Key Using 2nd SAM Master Key (KeyID=82)    
            key = GenSAMKey(0x82);
            if (key.Length == 0)
            {
                par.displayOut(0, "Failed to obtain Card Key");
                this.Close();
                return;
            }
            else
            {
                tbKc.Text = key;
            }

            //Generate Terminal Key Using 3rd SAM Master Key (KeyID=83)
            key = GenSAMKey(0x83);
            if (key.Length == 0)
            {
                par.displayOut(0, "Failed to obtain Terminal Key");
                this.Close();
                return;
            }
            else
            {
                tbKt.Text = key;
            }

            //Generate Debit Key Using 4th SAM Master Key (KeyID=84) 
            key = GenSAMKey(0x84);
            if (key.Length == 0)
            {
                par.displayOut(0, "Failed to Debit IC Key");
                this.Close();
                return;
            }
            else
            {
                tbKd.Text = key;
            }

            //Generate Credit Key Using 5th SAM Master Key (KeyID=85) 
            key = GenSAMKey(0x85);
            if (key.Length == 0)
            {
                par.displayOut(0, "Failed to obtain Credit Key");
                this.Close();
                return;
            }
            else
            {
                tbKcr.Text = key;
            }

            //Generate Certify Key Using 6th SAM Master Key (KeyID=86)  
            key = GenSAMKey(0x86);
            if (key.Length == 0)
            {
                par.displayOut(0, "Failed to obtain Certify Key");
                this.Close();
                return;
            }
            else
            {
                tbKcf.Text = key;
            }

            //Generate Revoke Debit Key Using 7th SAM Master Key (KeyID=87)    
            key = GenSAMKey(0x87);
            if (key.Length == 0)
            {
                par.displayOut(0, "Failed to obtain Revoke Debit Key");
                this.Close();
                return;
            }
            else
            {
                tbKrd.Text = key;
            }
        }

        private void MifareInit_Load(object sender, EventArgs e)
        {
            par = (frmMain)this.Owner;
            rbA.Checked = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            DialogResult dr = MessageBox.Show("Saving keys to Mifare assumes that the keys stored is \"FF FF FF FF FF FF\". Continue?", "", MessageBoxButtons.OKCancel, MessageBoxIcon.Warning);
            if (dr == DialogResult.Cancel)
            {
                return;
            }

            if (tbIC.Text == "")
            {
                MessageBox.Show("Issuer");
            }

            if (cb1.Checked)
            {
                if (!byte.TryParse(tb1.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
                {
                    MessageBox.Show("Pls. key-in hexadecimal value for Sector number.");
                    tb1.Focus();
                    return;
                }
            }

            if (cb2.Checked)
            {
                if (!byte.TryParse(tb2.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
                {
                    MessageBox.Show("Pls. key-in hexadecimal value for Sector number.");
                    tb2.Focus();
                    return;
                }
            }

            if (cb3.Checked)
            {
                if (!byte.TryParse(tb3.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
                {
                    MessageBox.Show("Pls. key-in hexadecimal value for Sector number.");
                    tb3.Focus();
                    return;
                }
            }

            if (cb4.Checked)
            {
                if (!byte.TryParse(tb4.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
                {
                    MessageBox.Show("Pls. key-in hexadecimal value for Sector number.");
                    tb4.Focus();
                    return;
                }
            }

            if (cb5.Checked)
            {
                if (!byte.TryParse(tb5.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
                {
                    MessageBox.Show("Pls. key-in hexadecimal value for Sector number.");
                    tb5.Focus();
                    return;
                }
            }

            if (cb6.Checked)
            {
                if (!byte.TryParse(tb6.Text.Trim(), System.Globalization.NumberStyles.HexNumber, null, out isHex))
                {
                    MessageBox.Show("Pls. key-in hexadecimal value for Sector number.");
                    tb6.Focus();
                    return;
                }
            }

            if (cb1.Checked)
            {
                isHex = Convert.ToByte(tb1.Text, 16);
                SaveKey(isHex, 1);
            }

            if (cb2.Checked)
            {
                isHex = Convert.ToByte(tb2.Text, 16);
                SaveKey(isHex, 21);
            }

            if (cb3.Checked)
            {
                isHex = Convert.ToByte(tb3.Text, 16);
                SaveKey(isHex, 3);
            }

            if (cb4.Checked)
            {
                isHex = Convert.ToByte(tb4.Text, 16);
                SaveKey(isHex, 4);
            }

            if (cb5.Checked)
            {
                isHex = Convert.ToByte(tb5.Text, 16);
                SaveKey(isHex, 5);
            }

            if (cb6.Checked)
            {
                isHex = Convert.ToByte(tb6.Text, 16);
                SaveKey(isHex, 6);
            }

            par.displayOut(0, "Save Keys success");
            this.Close();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}

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
    public partial class SAM_INIT : Form
    {
        byte isHex;
        frmMain par;

        public SAM_INIT()
        {
            InitializeComponent();
        }

        private void btnInit_Click(object sender, EventArgs e)
        {
            string port;
            int i, k;

            if (tbGlobal.Text == "" || (byte.TryParse(tbGlobal.Text, System.Globalization.NumberStyles.HexNumber, null, out isHex)))
            {
                MessageBox.Show("Please enter 8 bytes of keys for global PIN");
                tbGlobal.Focus();
                return;
            }
            if (tbIC.Text == "" || (byte.TryParse(tbIC.Text, System.Globalization.NumberStyles.HexNumber, null, out isHex)))
            {
                MessageBox.Show("Please enter 8 bytes of keys for Issuer Code");
                tbIC.Focus();
                return;
            }
            if (tbKc.Text == "" || (byte.TryParse(tbKc.Text, System.Globalization.NumberStyles.HexNumber, null, out isHex)))
            {
                MessageBox.Show("Please enter 8 bytes of keys for Card Key");
                tbKc.Focus();
                return;
            }
            if (tbKt.Text == "" || (byte.TryParse(tbKt.Text, System.Globalization.NumberStyles.HexNumber, null, out isHex)))
            {
                MessageBox.Show("Please enter 8 bytes of keys for Terminal Key");
                tbKt.Focus();
                return;
            }
            if (tbKd.Text == "" || (byte.TryParse(tbKd.Text, System.Globalization.NumberStyles.HexNumber, null, out isHex)))
            {
                MessageBox.Show("Please enter 8 bytes of keys for Debit Key");
                tbKd.Focus();
                return;
            }
            if (tbKcr.Text == "" || (byte.TryParse(tbKcr.Text, System.Globalization.NumberStyles.HexNumber, null, out isHex)))
            {
                MessageBox.Show("Please enter 8 bytes of keys for Credit Key");
                tbKcr.Focus();
                return;
            }
            if (tbKcf.Text == "" || (byte.TryParse(tbKcf.Text, System.Globalization.NumberStyles.HexNumber, null, out isHex)))
            {
                MessageBox.Show("Please enter 8 bytes of keys for Certify Key");
                tbKcf.Focus();
                return;
            }
            if (tbKrd.Text == "" || (byte.TryParse(tbKrd.Text, System.Globalization.NumberStyles.HexNumber, null, out isHex)) || tbKrd.Text.Length < 16 )
            {
                MessageBox.Show("Please enter 8 bytes of keys for Revoke Credit Key");
                tbKrd.Focus();
                return;
            }

            par.ClearBuffers();
            //Clear Card
            common.SendBuff[0] = 0x80;
            common.SendBuff[1] = 0x30;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x00;

            common.SendLen = 5;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);

            //reset SAM
            common.retCode = acr122.ACR122_PowerOffIcc(common.hReader, 0);
            common.retCode = acr122.ACR122_Close(common.hReader);
            port = par.cbPort.Text;
            common.retCode = acr122.ACR122_OpenA(port, ref common.hReader);
            common.RecvLen = 255;
            common.retCode = acr122.ACR122_PowerOnIcc(common.hReader, 0, ref common.RecvBuff[0], ref common.RecvLen);
            if (common.retCode != 0)
            {
                par.displayOut(0, "Power on ICC failed");
                this.Close();
                return;
            }

            //Create Master file
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE0;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x0F;
            common.SendBuff[5] = 0x62;
            common.SendBuff[6] = 0x0D;
            common.SendBuff[7] = 0x82;
            common.SendBuff[8] = 0x01;
            common.SendBuff[9] = 0x3F;
            common.SendBuff[10] = 0x83;
            common.SendBuff[11] = 0x02;
            common.SendBuff[12] = 0x3F;
            common.SendBuff[13] = 0x00;
            common.SendBuff[14] = 0x8A;
            common.SendBuff[15] = 0x01;
            common.SendBuff[16] = 0x01;
            common.SendBuff[17] = 0x8C;
            common.SendBuff[18] = 0x01;
            common.SendBuff[19] = 0x00;

            common.SendLen = 20;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90 )
            {
                par.displayOut(0, "Creating master file failed");
                this.Close();
                return;
            }

            //Create EF1 to store PIN
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE0;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x1B;
            common.SendBuff[5] = 0x62;
            common.SendBuff[6] = 0x19;
            common.SendBuff[7] = 0x83;
            common.SendBuff[8] = 0x02;
            common.SendBuff[9] = 0xFF;
            common.SendBuff[10] = 0x0A;
            common.SendBuff[11] = 0x88;
            common.SendBuff[12] = 0x01;
            common.SendBuff[13] = 0x01;
            common.SendBuff[14] = 0x82;
            common.SendBuff[15] = 0x06;
            common.SendBuff[16] = 0x0C;
            common.SendBuff[17] = 0x00;
            common.SendBuff[18] = 0x00;
            common.SendBuff[19] = 0x0A;
            common.SendBuff[20] = 0x00;
            common.SendBuff[21] = 0x01;
            common.SendBuff[22] = 0x8C;
            common.SendBuff[23] = 0x08;
            common.SendBuff[24] = 0x7F;
            common.SendBuff[25] = 0xFF;
            common.SendBuff[26] = 0xFF;
            common.SendBuff[27] = 0xFF;
            common.SendBuff[28] = 0xFF;
            common.SendBuff[29] = 0x27;
            common.SendBuff[30] = 0x27;
            common.SendBuff[31] = 0xFF;

            common.SendLen = 32;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Creating EF1 failed");
                this.Close();
                return;
            }

            //Set Global PIN
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xDC;
            common.SendBuff[2] = 0x01;
            common.SendBuff[3] = 0x04;
            common.SendBuff[4] = 0x0A;
            common.SendBuff[5] = 0x01;
            common.SendBuff[6] = 0x88;

            for (i = 0,k = 0; i < 15; i += 2,k++)
            {
                common.SendBuff[k + 7] = Convert.ToByte(tbGlobal.Text.Substring(i, 2), 16);
            }

            common.SendLen = 15;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if( common.retCode != 0 ) 
            {
                par.displayOut(0, "Setting global PIN failed");
                this.Close();
                return;
            }

            //Create DF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE0;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x2B;
            common.SendBuff[5] = 0x62;
            common.SendBuff[6] = 0x29;
            common.SendBuff[7] = 0x82;
            common.SendBuff[8] = 0x01;
            common.SendBuff[9] = 0x38;
            common.SendBuff[10] = 0x83;
            common.SendBuff[11] = 0x02;
            common.SendBuff[12] = 0x11;
            common.SendBuff[13] = 0x00;
            common.SendBuff[14] = 0x8A;
            common.SendBuff[15] = 0x01;
            common.SendBuff[16] = 0x01;
            common.SendBuff[17] = 0x8C;
            common.SendBuff[18] = 0x08;
            common.SendBuff[19] = 0x7F;
            common.SendBuff[20] = 0x03;
            common.SendBuff[21] = 0x03;
            common.SendBuff[22] = 0x03;
            common.SendBuff[23] = 0x03;
            common.SendBuff[24] = 0x03;
            common.SendBuff[25] = 0x03;
            common.SendBuff[26] = 0x03;
            common.SendBuff[27] = 0x8D;
            common.SendBuff[28] = 0x02;
            common.SendBuff[29] = 0x41;
            common.SendBuff[30] = 0x03;
            common.SendBuff[31] = 0x80;
            common.SendBuff[32] = 0x02;
            common.SendBuff[33] = 0x03;
            common.SendBuff[34] = 0x20;
            common.SendBuff[35] = 0xAB;
            common.SendBuff[36] = 0x0B;
            common.SendBuff[37] = 0x84;
            common.SendBuff[38] = 0x01;
            common.SendBuff[39] = 0x88;
            common.SendBuff[40] = 0xA4;
            common.SendBuff[41] = 0x06;
            common.SendBuff[42] = 0x83;
            common.SendBuff[43] = 0x01;
            common.SendBuff[44] = 0x81;
            common.SendBuff[45] = 0x95;
            common.SendBuff[46] = 0x01;
            common.SendBuff[47] = 0xFF;

            common.SendLen = 48;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Creating DF failed");
                this.Close();
                return;
            }

            //Create Key File
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE0;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x1D;
            common.SendBuff[5] = 0x62;
            common.SendBuff[6] = 0x1B;
            common.SendBuff[7] = 0x82;
            common.SendBuff[8] = 0x05;
            common.SendBuff[9] = 0x0C;
            common.SendBuff[10] = 0x41;
            common.SendBuff[11] = 0x00;
            common.SendBuff[12] = 0x16;
            common.SendBuff[13] = 0x08;
            common.SendBuff[14] = 0x83;
            common.SendBuff[15] = 0x02;
            common.SendBuff[16] = 0x11;
            common.SendBuff[17] = 0x01;
            common.SendBuff[18] = 0x88;
            common.SendBuff[19] = 0x01;
            common.SendBuff[20] = 0x02;
            common.SendBuff[21] = 0x8A;
            common.SendBuff[22] = 0x01;
            common.SendBuff[23] = 0x01;
            common.SendBuff[24] = 0x8C;
            common.SendBuff[25] = 0x08;
            common.SendBuff[26] = 0x7F;
            common.SendBuff[27] = 0x03;
            common.SendBuff[28] = 0x03;
            common.SendBuff[29] = 0x03;
            common.SendBuff[30] = 0x03;
            common.SendBuff[31] = 0x03;
            common.SendBuff[32] = 0x03;
            common.SendBuff[33] = 0x03;

            common.SendLen = 34;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Creating EF2 failed");
                this.Close();
                return;
            }

            //Acquires the global SAM PIN and assigns to global array;
            for (i = 0, k = 0; i < 15; i+=2, k++)
            {
                common.GSAM[k] = Convert.ToByte(tbGlobal.Text.Substring(i, 2), 16);
            }

            //Append Record To EF2, Define 8 Key Records in EF2 - Master Keys
            //1st Master key, key ID=81, key type=03, int/ext authenticate, usage counter = FF FF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE2;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x16;
            common.SendBuff[5] = 0x81; //KeyID
            common.SendBuff[6] = 0x03;
            common.SendBuff[7] = 0xFF;
            common.SendBuff[8] = 0xFF;
            common.SendBuff[9] = 0x88;
            common.SendBuff[10] = 0x00;

            for (i = 0, k = 0; i < 15; i+=2, k++)
            {
                common.SendBuff[k + 11] = Convert.ToByte(tbIC.Text.Substring(i, 2), 16);
            }

            common.SendLen = 19;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Appending Issuer Code to EF2 failed");
                this.Close();
                return;
            }

            //2nd Master key, key ID=82, key type=03, int/ext authenticate, usage counter = FF FF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE2;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x16;
            common.SendBuff[5] = 0x82; //KeyID
            common.SendBuff[6] = 0x03;
            common.SendBuff[7] = 0xFF;
            common.SendBuff[8] = 0xFF;
            common.SendBuff[9] = 0x88;
            common.SendBuff[10] = 0x00;

            for (i = 0, k = 0; i < 15; i += 2, k++)
            {
                common.SendBuff[k + 11] = Convert.ToByte(tbKc.Text.Substring(i, 2), 16);
            }

            common.SendLen = 19;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Appending Card Key to EF2 failed");
                this.Close();
                return;
            }

            //3rd Master key, key ID=83, key type=03, int/ext authenticate, usage counter = FF FF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE2;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x16;
            common.SendBuff[5] = 0x83; //KeyID
            common.SendBuff[6] = 0x03;
            common.SendBuff[7] = 0xFF;
            common.SendBuff[8] = 0xFF;
            common.SendBuff[9] = 0x88;
            common.SendBuff[10] = 0x00;

            for (i = 0, k = 0; i < 15; i += 2, k++)
            {
                common.SendBuff[k + 11] = Convert.ToByte(tbKt.Text.Substring(i, 2), 16);
            }

            common.SendLen = 19;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Appending Terminal Key to EF2 failed");
                this.Close();
                return;
            }

            //4th Master key, key ID=84, key type=03, int/ext authenticate, usage counter = FF FF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE2;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x16;
            common.SendBuff[5] = 0x84; //KeyID
            common.SendBuff[6] = 0x03;
            common.SendBuff[7] = 0xFF;
            common.SendBuff[8] = 0xFF;
            common.SendBuff[9] = 0x88;
            common.SendBuff[10] = 0x00;

            for (i = 0, k = 0; i < 15; i += 2, k++)
            {
                common.SendBuff[k + 11] = Convert.ToByte(tbKd.Text.Substring(i, 2), 16);
            }

            common.SendLen = 19;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Appending Debit Key to EF2 failed");
                this.Close();
                return;
            }

            //5th Master key, key ID=85, key type=03, int/ext authenticate, usage counter = FF FF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE2;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x16;
            common.SendBuff[5] = 0x85; //KeyID
            common.SendBuff[6] = 0x03;
            common.SendBuff[7] = 0xFF;
            common.SendBuff[8] = 0xFF;
            common.SendBuff[9] = 0x88;
            common.SendBuff[10] = 0x00;

            for (i = 0, k = 0; i < 15; i += 2, k++)
            {
                common.SendBuff[k + 11] = Convert.ToByte(tbKcr.Text.Substring(i, 2), 16);
            }

            common.SendLen = 19;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Appending Credit Key to EF2 failed");
                this.Close();
                return;
            }

            //'6th Master key, key ID=86, key type=03, int/ext authenticate, usage counter = FF FF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE2;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x16;
            common.SendBuff[5] = 0x86; //KeyID
            common.SendBuff[6] = 0x03;
            common.SendBuff[7] = 0xFF;
            common.SendBuff[8] = 0xFF;
            common.SendBuff[9] = 0x88;
            common.SendBuff[10] = 0x00;

            for (i = 0, k = 0; i < 15; i += 2, k++)
            {
                common.SendBuff[k + 11] = Convert.ToByte(tbKcf.Text.Substring(i, 2), 16);
            }

            common.SendLen = 19;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Appending Certify Key to EF2 failed");
                this.Close();
                return;
            }

            //'7th Master key, key ID=87, key type=03, int/ext authenticate, usage counter = FF FF
            par.ClearBuffers();
            common.SendBuff[0] = 0x00;
            common.SendBuff[1] = 0xE2;
            common.SendBuff[2] = 0x00;
            common.SendBuff[3] = 0x00;
            common.SendBuff[4] = 0x16;
            common.SendBuff[5] = 0x87; //KeyID
            common.SendBuff[6] = 0x03;
            common.SendBuff[7] = 0xFF;
            common.SendBuff[8] = 0xFF;
            common.SendBuff[9] = 0x88;
            common.SendBuff[10] = 0x00;

            for (i = 0, k = 0; i < 15; i += 2, k++)
            {
                common.SendBuff[k + 11] = Convert.ToByte(tbKrd.Text.Substring(i, 2), 16);
            }

            common.SendLen = 19;
            common.RecvLen = 255;

            common.retCode = par.SendAPDU(1);
            if (common.retCode != 0 || common.RecvBuff[0] != 0x90)
            {
                par.displayOut(0, "Appending Revoke Debit Key to EF2 failed");
                this.Close();
                return;
            }

            par.displayOut(0, "Initializing SAM Success");
            this.Close();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void SAM_INIT_Load(object sender, EventArgs e)
        {
            par = (frmMain)this.Owner;
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }
    }
}

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;

namespace GetATR
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
            btnConnect.Enabled = true;
            btnGetATR.Enabled = false;
            displayOut(0,"Program Started");
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
            btnGetATR.Enabled = true;
        }

        private void btnGetATR_Click(object sender, EventArgs e)
        {
            byte CardType;
            bool secondtype;
            string tempstr;

            secondtype = false;
            tempstr = "";

            ClearBuffers();
            SendBuff[0] = 0xD4;
            SendBuff[1] = 0x60;
            SendBuff[2] = 0x01;
            SendBuff[3] = 0x01;
            SendBuff[4] = 0x20;
            SendBuff[5] = 0x23;
            SendBuff[6] = 0x11;
            SendBuff[7] = 0x04;
            SendBuff[8] = 0x10;

            SendLen = 9;
            RecvLen = 255;

            retCode = SendAPDU();
            if (retCode != 0)
            {
                displayOut(0, "Get ATR failed");
                return;
            }
            else
            {
                if (RecvLen > 3)
                {
                    CardType = RecvBuff[8];
                    switch (CardType)
                    {
                        case 0x18:
                            tempstr = "Mifare 4K ";
                            break;
                        case 0x00:
                            tempstr = "Mifare Ultralight ";
                            break;
                        case 0x28:
                            tempstr = "ISO 14443-4 Type A ";
                            break;
                        case 0x08:
                            tempstr = "Mifare 1K ";
                            break;
                        case 0x09:
                            tempstr = "Mifare Mini ";
                            break;
                        case 0x20:
                            tempstr = "Mifare DesFire ";
                            break;
                        case 0x98:
                            tempstr = "Gemplus MPCOS ";
                            break;
                        default:
                            CardType = RecvBuff[3];
                            secondtype = true;
                            break;
                    }

                    if (secondtype)
                    {
                        switch (CardType)
                        {
                            case 0x23:
                                tempstr = "ISO 14443-4 Type B ";
                                break;
                            case 0x11:
                                tempstr = "FeliCa 212K ";
                                break;
                            case 0x04:
                                tempstr = "Topaz ";
                                break;
                            default:
                                tempstr = "Unknown contactless card ";
                                break;
                        }
                    }
                }
                else
                {
                    tempstr = "No contactless card ";
                }

                tempstr = tempstr + "detected";
                displayOut(0, tempstr);
            }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            mMsg.Text = "";
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            cbPort.SelectedIndex = 0;
            Init();
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            acr122.ACR122_Close(hReader);
            mMsg.Text = "";
            Init();
        }

        private void btnQuit_Click(object sender, EventArgs e)
        {
            acr122.ACR122_Close(hReader);
            System.Environment.Exit(0);
        }

        private void Form1_Leave(object sender, EventArgs e)
        {
            acr122.ACR122_Close(hReader);
        }
    }
}
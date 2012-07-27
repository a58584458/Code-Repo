using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Polling
{
    public partial class Form1 : Form
    {
        //global variables
        bool Poll = false;
        int retCode;
        int hReader;
        int SendLen, RecvLen;
        byte[] SendBuff = new byte[255];
        byte[] RecvBuff = new byte[255];

        public Form1()
        {
            InitializeComponent();
        }

        public void ClearBuffers()
        {
            for (int i = 0; i < 255; i++)
            {
                SendBuff[i] = 0x00;
                RecvBuff[i] = 0x00;
            }
        }

        public int SendAPDU()
        {
            retCode = acr122.ACR122_DirectTransmit(hReader, ref SendBuff[0], SendLen, ref RecvBuff[0], ref RecvLen);
            if (retCode != 0)
            {
                return retCode;
            }
            return retCode;
        }

        public void Init()
        {
            timer1.Enabled = false;
            cbPort.SelectedIndex = 0;
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            Init();
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            string tempstr;
            byte[] fw = new byte[255];

            tempstr = cbPort.Text;

            //connect to ACR122S
            retCode = acr122.ACR122_OpenA(tempstr, ref hReader);
            if (retCode != 0)
            {
                sbCardtype.Text = "Error in Connecting to " + cbPort.Text;
                return;
            }            
        }

        private void timer1_Tick(object sender, EventArgs e)
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
                sbCardtype.Text = "Error in getting cardtype";
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
                sbCardtype.Text = tempstr;
            }
        }

        private void btnPolling_Click(object sender, EventArgs e)
        {
            if (Poll)
            {
                btnPolling.Text = "Start Polling";
                Poll = false;
                timer1.Enabled = false;
                sbCardtype.Text = "";
            }
            else
            {
                btnPolling.Text = "End Polling";
                Poll = true;
                timer1.Interval = 250;
                timer1.Enabled = true;
            }
        }

        private void btnQuit_Click(object sender, EventArgs e)
        {
            acr122.ACR122_Close(hReader);
            this.Close();
        }
    }
}

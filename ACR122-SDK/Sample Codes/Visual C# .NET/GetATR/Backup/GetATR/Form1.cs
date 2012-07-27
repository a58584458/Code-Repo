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
        long SendLen, RecvLen, retCode;
        long hReader;
        byte[] SendBuff = new byte[255];
        byte[] RecvBuff = new byte[255];

        public Form1()
        {
            InitializeComponent();
        }

        private void btnConnect_Click(object sender, EventArgs e)
        {
            string tempstr;

            tempstr = cbPort.Text;

            retCode = acr122.ACR122_OpenA(tempstr, ref this.hReader);
            
        }
    }
}
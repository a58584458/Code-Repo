using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Key_Management
{
    public class common
    {
        //global variables
        public static int retCode;
        public static int SendLen, RecvLen;
        public static int hReader;
        public static byte isHex;
        public static byte[] SendBuff = new byte[255];
        public static byte[] RecvBuff = new byte[255];
        public static byte[] GSAM = new byte[255];
    }
}

using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace Device_Programming
{
    class acr122
    {
        [StructLayout(LayoutKind.Sequential)]
        public struct ACR122_LED_CONTROL
        {
            public long finalState;
            public bool updateEnabled;
            public long initialBlinkingState;
            public bool blinkEnabled;
        }

        [StructLayout(LayoutKind.Sequential)]
        public struct ACR122_TIMEOUTS
        {
            public long statusTimeout;
            public long numStatusRetries;
            public long responseTimeout;
            public long numResponseRetries;
        }

        //LED States
        public const int ACR122_LED_STATE_OFF = 0;
        public const int ACR122_LED_STATE_ON = 1;

        //Buzzer Mode
        public const byte ACR122_BUZZER_MODE_OFF = 0x00;
        public const byte ACR122_BUZZER_MODE_T1 = 0x01;
        public const byte ACR122_BUZZER_MODE_T2 = 0x02;

        //Error Codes
        public const long ACR122_ERROR_NO_MORE_HANDLES = 0x20000001;
        public const long ACR122_ERROR_UNKNOWN_STATUS = 0x20000002;
        public const long ACR122_ERROR_OPERATION_FAILURE = 0x20000003;
        public const long ACR122_ERROR_OPERATION_TIMEOUT = 0x20000004;
        public const long ACR122_ERROR_INVALID_CHECKSUM = 0x20000005;
        public const long ACR122_ERROR_INVALID_PARAMETER = 0x20000006;

        //====================================================
        //FUNCTIONS
        //====================================================
        [DllImport("acr122.dll")]
        public static extern int ACR122_OpenA(string portName, ref int phReader);

        [DllImport("acr122.dll")]
        public static extern int ACR122_GetFirmwareVersion(int phReader, int slotNum, ref byte firmwareVersion, ref int pFirmwareVersion);

        [DllImport("acr122.dll")]
        public static extern int ACR122_Close(int phReader);

        [DllImport("acr122.dll")]
        public static extern int ACR122_DirectTransmit(int phReader, ref byte SendBuff, int SendBuffLen, ref byte RecvBuff, ref int RecvBuffLen);

        [DllImport("acr122.dll")]
        public static extern int ACR122_GetNumSlots(int phReader, ref int pNumSlots);

        [DllImport("acr122.dll")]
        public static extern int ACR122_GetBaudRate(int phReader, ref int pBaudRate);

        [DllImport("acr122.dll")]
        public static extern int ACR122_SetBaudRate(int phReader, int baudRate);

        [DllImport("acr122.dll")]
        public static extern int ACR122_GetTimeouts(int phReader, ref ACR122_TIMEOUTS pTimeouts);

        [DllImport("acr122.dll")]
        public static extern int ACR122_SetTimeouts(int phReader, ref ACR122_TIMEOUTS pTimeouts);

        [DllImport("acr122.dll")]
        public static extern int ACR122_SetLedStatesWithBeep(int phReader, ref ACR122_LED_CONTROL controls, int numControls, int t1, int t2, int numTimes, int buzzerMode);

        [DllImport("acr122.dll")]
        public static extern int ACR122_PowerOnIcc(int phReader, int slotNum, ref byte atr, ref int pAtrLen);

        [DllImport("acr122.dll")]
        public static extern int ACR122_PowerOffIcc(int phReader, int slotNum);

        [DllImport("acr122.dll")]
        public static extern int ACR122_ExchangeApdu(int phReader, int slotNum, ref byte SendBuff, int SendBuffLen, ref byte RecvBuff, ref int RecvBuffLen);
    }
}

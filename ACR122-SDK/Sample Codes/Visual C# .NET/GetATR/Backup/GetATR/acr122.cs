using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.InteropServices;

namespace GetATR
{
    class acr122
    {
        [StructLayout(LayoutKind.Sequential)]
        public struct ACR122_LED_CONTROL
        {
            public long finalState;
            public bool updateEnables;
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
        public static extern long ACR122_OpenA(string portName, ref long phReader);

        [DllImport("acr122.dll")]
        public static extern long ACR122_GetFirmwareVersion(long phReader, long slotNum, string firmwareVersion, ref long pFirmwareVersion);

        [DllImport("acr122.dll")]
        public static extern long ACR122_Close(long phReader);

        [DllImport("acr122.dll")]
        public static extern long ACR122_DirectTransmit(long phReader, ref byte SendBuff, long SendBuffLen, ref byte RecvBuff, ref long RecvBuffLen);

        [DllImport("acr122.dll")]
        public static extern long ACR122_GetNumSlots(long phReader, ref ulong pNumSlots);

        [DllImport("acr122.dll")]
        public static extern long ACR122_GetBaudRate(long phReader, ref ulong pBaudRate);

        [DllImport("acr122.dll")]
        public static extern long ACR122_SetBaudRate(long phReader, ulong baudRate);

        [DllImport("acr122.dll")]
        public static extern long ACR122_GetTimeouts(long phReader, ACR122_TIMEOUTS pTimeouts);

        [DllImport("acr122.dll")]
        public static extern long ACR122_SetTimeouts(long phReader, ACR122_TIMEOUTS pTimeouts);

        [DllImport("acr122.dll")]
        public static extern long ACR122_SetLedStatesWithBeep(long phReader, ACR122_LED_CONTROL controls, long numControls, long t1, long t2, long numTimes, long buzzerMode);

        [DllImport("acr122.dll")]
        public static extern long ACR122_PowerOnIcc(long phReader, long slotNum, ref byte atr, ref long pAtrLen);

        [DllImport("acr122.dll")]
        public static extern long ACR122_PowerOffIcc(long phReader, long slotNum);

        [DllImport("acr122.dll")]
        public static extern long ACR122_ExchangeApdu(long phReader, long slotNum, ref byte SendBuff, long SendBuffLen, ref byte RecvBuff, ref long RecvBuffLen);
    }
}

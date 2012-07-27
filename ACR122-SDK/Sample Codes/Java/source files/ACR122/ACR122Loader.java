package ACR122;

public class ACR122Loader {
	
	//Declarations
	//LED States
	public static final int ACR122_LED_STATE_OFF = 0;
	public static final int ACR122_LED_STATE_ON = 1;
	
	//Buzzer Mode
	public static final int ACR122_BUZZER_MODE_OFF = 0x00;
	public static final int ACR122_BUZZER_MODE_ON_T1 = 0x01;
	public static final int ACR122_BUZZER_MODE_ON_T2 = 0x02;
	
	//Error Codes
	public static final long ACR122_ERROR_NO_MORE_HANDLES = 0x20000001L;
	public static final long ACR122_ERROR_UNKNOWN_STATUS = 0x20000002L;
	public static final long ACR122_ERROR_OPERATION_FAILURE = 0x20000003L;
	public static final long ACR122_ERROR_OPERATION_TIMEOUT = 0x20000004L;
	public static final long ACR122_ERROR_INVALID_CHECKSUM = 0x20000005L;
	public static final long ACR122_ERROR_INVALID_PARAMETER = 0x20000006L;
	
	
	private static int hReader=0, fwLen=0, recvLen=0, atrRecvLen=0, recvLenExAPDU=0;
	private static int numSlots=0, GetbaudRate=0;
	private static int ret =0;

	/***********WRAPPER FUNCTIONS**************/
	
	public int jACR122_Open(String port, int[] phReader)
	{
		
		byte [] tmpDest = port.getBytes();
		byte [] portName = new byte[port.length()+1];
		
		for(int i=0; i<port.length(); i++)
			portName[i] = tmpDest[i];
		
		portName[port.length()] = 0;
		
		ret = ACR122_Open(portName, hReader);
		
		phReader[0] = hReader;
		
		return ret;
	}
	
	public int jACR122_Close(int [] phReader)
	{
		
		ret = ACR122_Close(phReader[0]);
		
		return ret;
	}
	
	public int jACR122_SetBaudRate(int [] phReader, int baudRate)
	{
		
		ret = ACR122_SetBaudRate(phReader[0], baudRate);
		
		return ret;
	}
	
	public int jACS122_GetFirmwareVersion(int [] phReader, int slotNum, byte [] fwVersion, int [] fwVerLen)
	{

		ACR122_GetFirmwareVersion(phReader[0], slotNum, fwVersion, fwLen);
		
		fwVerLen[0] = fwLen;
		
		return ret;

	}
	
	public int jACR122_SetLedStatesWithBeep(int [] phReader, ACR122.ACR122_LED_CONTROL[] ledCtrl, int numCtrl, int t1, int t2, int numTimes, int buzzreMode)
	{
		
		ret = ACR122_SetLedStatesWithBeep(phReader[0], ledCtrl, numCtrl, t1, t2, numTimes, buzzreMode);
		
		return ret;
	}
	
	public int jACR122_DirectTransmit(int [] phReader, byte [] sendBuff, int sendBuffLen, byte [] recvBuff, int [] recvBuffLen)
	{
		
		ret = ACR122_DirectTransmit(phReader[0], sendBuff, sendBuffLen, recvBuff, recvLen);
		
		recvBuffLen[0] = recvLen;
		
		return ret;
	}
	
	public int jACR122_PowerOnIcc(int [] phReader, int slotNum, byte [] atr, int [] atrLen)
	{
		
		ret = ACR122_PowerOnIcc(phReader[0], slotNum, atr, atrRecvLen);
		
		atrLen[0] = atrRecvLen;
		
		return ret;
	}
	
	public int jACR122_PowerOffIcc(int [] phReader, int slotNum)
	{
		
		ret = ACR122_PowerOffIcc(phReader[0], slotNum);
		
		return ret;
	}
	
	public int jACR122_ExchangeApdu(int [] phReader, int slotNum, byte [] sendBuff, int sendBuffLen, byte [] recvBuff, int [] recvExAPDULen)
	{
		
		ret = ACR122_ExchangeApdu(phReader[0], slotNum, sendBuff, sendBuffLen, recvBuff, recvLenExAPDU);
		
		recvExAPDULen[0] = recvLenExAPDU;
		
		return ret;
	}
	
	public int jACR122_GetNumSlots(int [] phReader, int [] pNumSlots)
	{
		
		ret = ACR122_GetNumSlots(phReader[0], numSlots);
		
		pNumSlots[0] = numSlots;
		
		return ret;
	}
	
	public int jACR122_GetBaudRate(int [] phReader, int [] baudRate)
	{
		
		ret = ACR122_GetBaudRate(phReader[0], GetbaudRate);
		
		baudRate[0] = GetbaudRate;
		
		return ret;
	}
	
	public int jACR122_GetTimeouts(int [] phReader, ACR122.ACR122_TIMEOUTS tOut)
	{
		ret = ACR122_GetTimeouts(phReader[0], tOut);
		return ret;
	}
	
	public int jACR122_SetTimeouts(int [] phReader, ACR122.ACR122_TIMEOUTS tOut)
	{
		ret = ACR122_SetTimeouts(phReader[0], tOut);
		return ret;
	}
	
	
	/***********JNI FUNCTIONS**************/
	
	private native int ACR122_Open( byte[] portName,
									int phReader);
	
	private native int ACR122_Close( int phReader);
	
	private native int ACR122_SetBaudRate( int phReader,
										   int baudrate);
	
	private native int ACR122_GetFirmwareVersion( int phReader,
			   									  int slotNum,
			   									  byte [] firmwareVersion,
			   									  int pFirmwareVersionLen);
		
	private native int ACR122_SetLedStatesWithBeep( int phReader,
												ACR122.ACR122_LED_CONTROL[] ledCtrl,
				  								int numControls,
				  								int t1,
				  								int t2,
				  								int numTimes,
				  								int buzzerMode);
	
	private native int ACR122_DirectTransmit( int phReader,
											  byte [] sendBuffer,
											  int sendBufferLen,
											  byte [] recvBuffer,
											  int pRecvBufferLen);	
	
	private native int ACR122_PowerOnIcc( int phReader,
										  int slotNum,
										  byte [] atr,
										  int cpAtrLen);
	
	private native int ACR122_PowerOffIcc( int phReader,
			  							   int slotNum);
	
	private native int ACR122_ExchangeApdu( int phReader,
											int slotNum,
											byte [] sendBuffer,
											int sendBufferLen,
											byte [] recvBuffer,
											int pRecvBufferLen);	
	
	private native int ACR122_GetNumSlots(int hReader, int pNumSlots);
	
	private native int ACR122_GetBaudRate(int hReader, int pBaudRate);
	
	private native int ACR122_GetTimeouts(int hReader, ACR122.ACR122_TIMEOUTS pTimeouts);
	
	private native int ACR122_SetTimeouts(int hReader, ACR122.ACR122_TIMEOUTS pTimeouts);
	
	static {
	       System.loadLibrary("ACR122JNI");
	}
}

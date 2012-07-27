import java.awt.EventQueue;

import ACR122.*;
import ACR122.ACR122_LED_CONTROL;

public class test {

	static ACR122Loader acr122 = new ACR122Loader();
	static ACR122_LED_CONTROL [] ledCtrl = new ACR122_LED_CONTROL[2];
	static ACR122_TIMEOUTS tOut = new ACR122_TIMEOUTS();
	static ACR122_TIMEOUTS tOutGet = new ACR122_TIMEOUTS();
	
	int ret =0;
	int [] hReader = new int[1];
	int [] fwLen = new int[1];
	byte [] fwVer = new byte[100];
	byte [] sendBuff = new byte[255];
	byte [] recvBuff = new byte[255];
	byte [] atr = new byte[255];
	int [] recvLen = new int[1];
	int [] ATRrecvLen = new int[1];
	int [] numSlots = new int[1];
	int [] baudRate = new int[1];
	int sendLen;
	
	public test()
	{
		init();
	}
	
	public void init()
	{
		//Open
		String port = "\\\\.\\COM5";
		
		ret = acr122.jACR122_Open(port, hReader);
		
		if(ret == 0)
		{
			System.out.println("Open: "+ ret);
			System.out.println("Reader Handle: "+hReader[0]);
		}
		else
			System.out.println("Error: " + ret);
		
		/*//Set Baud Rate
		int bRate = 9600;
		
		ret = acr122.jACR122_SetBaudRate(hReader, bRate);
		
		if(ret == 0)
			System.out.println("Baud Rate Set: "+ret);
		else
			System.out.println("Error: " + ret);
	
		//Get Baud Rate
		ret = acr122.jACR122_GetBaudRate(hReader, baudRate);
		
		if(ret == 0)
		{
			System.out.println("Get Baud Rate: "+ret);
			System.out.println("Baud Rate: "+baudRate[0]);
		}
		else
			System.out.println("Error: " + ret);
		
		//Set Timeout
		tOut.statusTimeout = 3000;
		tOut.numStatusRetries = 1;
		tOut.responseTimeout = 10000;
		tOut.numResponseRetries = 1;
		
		ret = acr122.jACR122_SetTimeouts(hReader, tOut);
		
		if(ret == 0)
			System.out.println("Set Timeouts: "+ret);
		else
			System.out.println("Error: " + ret);
		
		ret = acr122.jACR122_GetTimeouts(hReader, tOutGet);
		
		if(ret == 0)
		{
			System.out.println("Get Timeouts: "+ret);
			System.out.println("Status Timeout: "+tOutGet.statusTimeout);
			System.out.println("Status Timeout Retries: "+tOutGet.numStatusRetries);
			System.out.println("Response Timeout: "+tOutGet.responseTimeout);
			System.out.println("Response Timeout Retries: "+tOutGet.numResponseRetries);
		}
		else
			System.out.println("Error: " + ret);
		
		//Get Firmware Version
		fwLen[0] = 100;
		
		ret = acr122.jACS122_GetFirmwareVersion(hReader, 0, fwVer, fwLen);
		
		if(ret == 0)
		{
			System.out.println("Get FW Wersion: "+ret);
			System.out.println("FW Len: "+fwLen[0]);
			System.out.print("FW Version: ");
			
			for(int i=0; i<fwLen[0]-1; i++)
				System.out.print((char)fwVer[i]);
			
			System.out.println();
		}
		else
			System.out.println("Error: " + ret);
		
		//Set led controls with buzzer
		//instantiate new classes for each element of array
		ledCtrl[0] = new ACR122_LED_CONTROL();
		ledCtrl[1] = new ACR122_LED_CONTROL();
		
		//place info
		ledCtrl[0].blinkEnabled = true;
		ledCtrl[0].finalState = ACR122Loader.ACR122_LED_STATE_OFF;
		ledCtrl[0].initialBlinkingState = ACR122Loader.ACR122_LED_STATE_ON;
		ledCtrl[0].updateEnabled = true;
		
		ledCtrl[1].blinkEnabled = true;
		ledCtrl[1].finalState = ACR122Loader.ACR122_LED_STATE_OFF;
		ledCtrl[1].initialBlinkingState = ACR122Loader.ACR122_LED_STATE_OFF;
		ledCtrl[0].updateEnabled = true;
		
		ret = acr122.jACR122_SetLedStatesWithBeep(hReader, ledCtrl, 2, 500, 500, 3, ACR122Loader.ACR122_BUZZER_MODE_ON_T1);
		
		if(ret == 0)
			System.out.println("Set LED States With Beep: "+ret);
		else
			System.out.println("Error: " + ret);
	
		//Direct Transmit
 		clearBuffers();
		sendBuff[0] = (byte)0xD4;
		sendBuff[1] = (byte)0x4A;
		sendBuff[2] = (byte)0x01;
		sendBuff[3] = (byte)0x00;
		
		sendLen = 4;
		recvLen[0] = 255;
		
		ret = acr122.jACR122_DirectTransmit(hReader, sendBuff, sendLen, recvBuff, recvLen);
		
		if(ret == 0)
		{
			System.out.println("Direct Transmit: "+ret);
			System.out.println("RecvLen: "+recvLen[0]);
			System.out.print("Data: ");
		
			String tmpHex="", tmpStr="";
			for(int i=0; i<recvLen[0]; i++){
				  tmpHex = Integer.toHexString(((Byte)recvBuff[i]).intValue() & 0xFF).toUpperCase();
					
					//For single character hex
					if (tmpHex.length() == 1) 
						tmpHex = "0" + tmpHex;
					
					tmpStr += " " + tmpHex;  
				  
			  }
			
			System.out.println("Return Data: " + tmpStr);
		}
		else
			System.out.println("Error: " + ret);
		
		//ICC Power On
		int slotNum = 0;
		ATRrecvLen[0] = 255;
		
		ret = acr122.jACR122_PowerOnIcc(hReader, slotNum, atr, ATRrecvLen);
		
		if(ret == 0)
		{
			System.out.println("ICC Power On: "+ret);
			System.out.println("ATRRecvLen: "+ATRrecvLen[0]);
			
			String tmpHex="", tmpStr="";
			for(int i=0; i<ATRrecvLen[0]; i++){
				  tmpHex = Integer.toHexString(((Byte)atr[i]).intValue() & 0xFF).toUpperCase();
					
					//For single character hex
					if (tmpHex.length() == 1) 
						tmpHex = "0" + tmpHex;
					
					tmpStr += " " + tmpHex;  
				  
			  }
			
			System.out.println("Return Data: " + tmpStr);
		}
		else
			System.out.println("Error: " + ret);
		
		//Exchange APDU
		clearBuffers();
		sendBuff[0] = (byte) 0x80;
		sendBuff[1] = (byte) 0x84;
		sendBuff[2] = (byte) 0x00;
		sendBuff[3] = (byte) 0x00;
		sendBuff[4] = (byte) 0x08;
		
		slotNum = 0;
		sendLen = 5;
		recvLen[0] = 255;
		
		ret = acr122.jACR122_ExchangeApdu(hReader, slotNum, sendBuff, sendLen, recvBuff, recvLen);
		
		if(ret == 0)
		{
			System.out.println("Exchange APDU: "+ret);
			System.out.println("Exchange APDU RecvLen: "+recvLen[0]);
			System.out.print("Data: ");
			
			String tmpHex="", tmpStr="";
			for(int i=0; i<recvLen[0]; i++){
				  tmpHex = Integer.toHexString(((Byte)recvBuff[i]).intValue() & 0xFF).toUpperCase();
					
					//For single character hex
					if (tmpHex.length() == 1) 
						tmpHex = "0" + tmpHex;
					
					tmpStr += " " + tmpHex;  
				  
			  }
			
			System.out.println("Return Data: " + tmpStr);
		}
		else
			System.out.println("Error: " + ret);
		
		//ICC Power Off
		slotNum = 0;
		
		ret = acr122.jACR122_PowerOffIcc(hReader, slotNum);
		
		if (ret == 0)
			System.out.println("ICC Power Off: "+ret);
		else
			System.out.println("Error: " + ret);
		
		//Get Number of Slots
		ret = acr122.jACR122_GetNumSlots(hReader, numSlots);
		
		if(ret == 0)
		{
			System.out.println("Get Number of Slots: "+ret);
			System.out.println("Number of Slots: "+numSlots[0]);
		}
		else
			System.out.println("Error: " + ret);
		*/
		//Close
		ret = acr122.jACR122_Close(hReader);
		
		if(ret == 0)
			System.out.println("Close: "+ret);
		else
			System.out.println("Error: " + ret);
		
		return;
	}
	
	void clearBuffers()
	{
		for(int i=0; i<255; i++)
		{
			sendBuff[i] = 0x00;
			recvBuff[i] = 0x00;
		}
	}
	
	public static void main(String args[]) {
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                new test();
            }
        });
    }
	
}

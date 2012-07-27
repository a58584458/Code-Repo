unit ACR122s;

interface
uses Windows,classes,StdCtrls,SysUtils,Menus;


type

SCARDHANDLE = ULONG;
LPBYTE = PByte;
LPDWORD = ^DWORD;
LPSCARDHANDLE = ^SCARDHANDLE;

// LED States
Const ACR122_LED_STATE_OFF = 0; ///< Turn on LED.
Const ACR122_LED_STATE_ON  = 1;  ///< Turn off LED.

// Buzzer Mode
Const ACR122_BUZZER_MODE_OFF   = 0; ///< The buzzer will not turn on.
Const ACR122_BUZZER_MODE_ON_T1 = 1; ///< The buzzer will turn on during T1 duration.
Const ACR122_BUZZER_MODE_ON_T2 = 2; ///< The buzzer will turn on during T2 duration.

type ACR122_LED_CONTROL = record

    //Final state. Possible values are ACR122_LED_STATE_OFF and
    //ACR122_LED_STATE_ON.
    finalState : DWORD;

    //Enable update. Set to TRUE to update the state. Otherwise, set to FALSE
    //to keep the state unchanged.
    updateEnabled : BOOL;

    //Initial blinking state. Possible values are ACR122_LED_STATE_OFF and
    //ACR122_LED_STATE_ON.
    initialBlinkingState :DWORD;

    //Enable blink. Set to TRUE to enable blink. Otherwise, set to FALSE.
    blinkEnabled : BOOL;

end;

LPACR122_LED_CONTROL = ^ACR122_LED_CONTROL;

type ACR122_TIMEOUTS = record

     //Status timeout in milliseconds. Default is 2000 ms.
     statusTimeout : DWORD;

     //Number of status retries. Default is 1.
     numStatusRetries : DWORD;

     //Response timeout in milliseconds. Default is 10000 ms.
     responseTimeout : DWORD;

     //Number of response retries. Default is 1.
     numResponseRetries : DWORD;

end;

LPACR122_TIMEOUT = ^ACR122_TIMEOUTS;


Function ACR122_OpenA(portName :String;
					  phReader :LPSCARDHANDLE): smallint; stdcall; external 'acr122.dll';

Function ACR122_OpenW(portName :LPCWSTR;
					  phReader :Pointer): smallint; stdcall; external 'acr122.dll';

Function ACR122_Close(hReader :SCARDHANDLE): smallint; stdcall; external 'acr122.dll';

Function ACR122_GetNumSlots(hReader :SCARDHANDLE;
							pNumSlots :LPDWORD): smallint; stdcall; external 'acr122.dll';

Function ACR122_GetBaudRate(hReader :SCARDHANDLE;
							pBaudRate :LPDWORD): smallint; stdcall; external 'acr122.dll';
							
Function ACR122_SetBaudRate(hReader :SCARDHANDLE;
							pBaudRate : DWORD): smallint; stdcall; external 'acr122.dll';

Function ACR122_GetTimeouts(hReader :SCARDHANDLE;
							pTimeouts :smallint): smallint; stdcall; external 'acr122.dll';

Function ACR122_SetTimeouts(hReader :SCARDHANDLE;
							pTimeouts :LPACR122_TIMEOUT): smallint; stdcall; external 'acr122.dll';

Function ACR122_GetFirmwareVersionA(hReader :SCARDHANDLE;
							slotNum :DWORD;
							firmwareVersion :LPSTR;
							pFirmwareVersionLen :LPDWORD): smallint; stdcall; external 'acr122.dll';

Function ACR122_GetFirmwareVersionW(hReader :SCARDHANDLE;
							slotNum :DWORD;
							firmwareVersion :LPSTR;
							pFirmwareVersionLen :LPDWORD): smallint; stdcall; external 'acr122.dll';

Function ACR122_DisplayLcdMessageA(hReader :SCARDHANDLE;
							row :DWORD;
							col :DWORD;
							msg :LPCSTR): smallint; stdcall; external 'acr122.dll';
							
Function ACR122_DisplayLcdMessageW(hReader :SCARDHANDLE;
							row :DWORD;
							col :DWORD;
							msg :LPCSTR): smallint; stdcall; external 'acr122.dll';
							
Function ACR122_ClearLcd(hReader :SCARDHANDLE): smallint; stdcall; external 'acr122.dll';

Function ACR122_EnableLcdBacklight(hReader :SCARDHANDLE;
								   enabled :BOOL): smallint; stdcall; external 'acr122.dll';
								   
Function ACR122_SetLcdContrast(hReader :SCARDHANDLE;
							   level :DWORD): smallint; stdcall; external 'acr122.dll';
							   
Function ACR122_EnableLed(hReader :SCARDHANDLE;
						  enabled :BOOL): smallint; stdcall; external 'acr122.dll';
				
Function ACR122_SetLedStatesWithBeep(hReader :SCARDHANDLE;
									controls :LPACR122_LED_CONTROL;
									numControls :DWORD;
									t1 :DWORD;
									t2 :DWORD;
									numTimes :DWORD;
									buzzerMode :DWORD): smallint; stdcall; external 'acr122.dll';
						
Function ACR122_SetLedStates(hReader :SCARDHANDLE;
						     states :DWORD;
							 numStates :DWORD): smallint; stdcall; external 'acr122.dll';

Function ACR122_Beep(hReader :SCARDHANDLE;
					 buzzerOnDuration :DWORD;
					 buzzerOffDuration :DWORD;
					 numTimes :DWORD): smallint; stdcall; external 'acr122.dll';

Function ACR122_DirectTransmit(hReader :SCARDHANDLE;
							   sendBuffer :LPBYTE;
							   sendBufferLen :DWORD;
							   recvBuffer :LPBYTE;
							   pRecvBufferLen :LPDWORD): smallint; stdcall; external 'acr122.dll';

Function ACR122_PowerOnIcc(hReader :SCARDHANDLE;
						   slotNum :DWORD;
						   atr : LPBYTE;
						   pAtrLen :LPDWORD): smallint; stdcall; external 'acr122.dll';
						
Function ACR122_PowerOffIcc(hReader :SCARDHANDLE;
							slotNum :DWORD): smallint; stdcall; external 'acr122.dll';
					
Function ACR122_ExchangeApdu(hReader :SCARDHANDLE;
							 slotNum :DWORD;
							 sendBuffer :LPBYTE;
							 sendBufferLen :DWORD;
							 recvBuffer :LPBYTE;
							 pRecvBufferLen :LPDWORD): smallint; stdcall; external 'acr122.dll';

implementation

end.





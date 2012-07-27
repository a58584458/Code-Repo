Attribute VB_Name = "acr122"
'===============================================================================
'
' Company   : Advanced Card Systems, Ltd
'
' Author    : M.J.E.Castillo
'
' Date      : 19 / 10 / 2009
'
' Description: Module for acr122.dll
'
' Revision Trail: (Date/Author/Description)
'
'===============================================================================

Public Type ACR122_LED_CONTROL
    finalState As Long
    updateEnables As Boolean
    initialBlinkingState As Long
    blinkEnabled As Boolean
End Type

Public Type ACR122_TIMEOUTS
    statusTimeout As Long
    numStatusRetries As Long
    responseTimeout As Long
    numResponseRetries As Long
End Type

'LED States
Global Const ACR122_LED_STATE_OFF = 0
Global Const ACR122_LED_STATE_ON = 1

'Buzzer Mode
Global Const ACR122_BUZZER_MODE_OFF = &H0
Global Const ACR122_BUZZER_MODE_T1 = &H1
Global Const ACR122_BUZZER_MODE_T2 = &H2

'Error Codes
Global Const ACR122_ERROR_NO_MORE_HANDLES = &H20000001
Global Const ACR122_ERROR_UNKNOWN_STATUS = &H20000002
Global Const ACR122_ERROR_OPERATION_FAILURE = &H20000003
Global Const ACR122_ERROR_OPERATION_TIMEOUT = &H20000004
Global Const ACR122_ERROR_INVALID_CHECKSUM = &H20000005
Global Const ACR122_ERROR_INVALID_PARAMETER = &H20000006

'===============================================================
' FUNCTIONS
'===============================================================

Public Declare Function ACR122_Open Lib "acr122.dll" Alias "ACR122_OpenA" (ByVal portName As String, _
                                                      ByRef phReader As Long) As Long

Public Declare Function ACR122_GetFirmwareVersion Lib "acr122.dll" Alias "ACR122_GetFirmwareVersionA" (ByVal phReader As Long, _
                                                     ByVal slotNum As Long, _
                                                     ByVal firmwareVersion As String, _
                                                     ByRef pFirmwareVersionLen As Long) As Long

Public Declare Function ACR122_Close Lib "acr122.dll" (ByVal phReader As Long) As Long

Public Declare Function ACR122_DirectTransmit Lib "acr122.dll" (ByVal phReader As Long, _
                                                      ByRef Sendbuff As Byte, _
                                                      ByVal SendBuffLen As Long, _
                                                      ByRef RecvBuff As Byte, _
                                                      ByRef RecvBuffLen As Long) As Long

Public Declare Function ACR122_GetNumSlots Lib "acr122.dll" (ByVal phReader As Long, _
                                                      ByRef pNumSlots As Long) As Long
                                                      
Public Declare Function ACR122_GetBaudRate Lib "acr122.dll" (ByVal phReader As Long, _
                                                      ByRef pBaudRate As Long) As Long

Public Declare Function ACR122_SetBaudRate Lib "acr122.dll" (ByVal phReader As Long, _
                                                      ByVal baudRate As Long) As Long

Public Declare Function ACR122_GetTimeouts Lib "acr122.dll" (ByVal phReader As Long, _
                                                      pTimeouts As ACR122_TIMEOUTS) As Long

Public Declare Function ACR122_SetTimeouts Lib "acr122.dll" (ByVal phReader As Long, _
                                                      pTimeouts As ACR122_TIMEOUTS) As Long

Public Declare Function ACR122_SetLedStatesWithBeep Lib "acr122.dll" (ByVal phReader As Long, _
                                                      controls As ACR122_LED_CONTROL, _
                                                      ByVal numControls As Long, _
                                                      ByVal t1 As Long, _
                                                      ByVal t2 As Long, _
                                                      ByVal numTimes As Long, _
                                                      ByVal buzzerMode As Long) As Long

Public Declare Function ACR122_PowerOnIcc Lib "acr122.dll" (ByVal phReader As Long, _
                                                      ByVal slotNum As Long, _
                                                      ByRef atr As Byte, _
                                                      ByRef pAtrLen As Long) As Long
                                                      
Public Declare Function ACR122_PowerOffIcc Lib "acr122.dll" (ByVal phReader As Long, _
                                                      ByVal slotNum As Long) As Long
                                                      

Public Declare Function ACR122_ExchangeApdu Lib "acr122.dll" (ByVal phReader As Long, _
                                                      ByVal slotNum As Long, _
                                                      ByRef Sendbuff As Byte, _
                                                      ByVal SendBuffLen As Long, _
                                                      ByRef RecvBuff As Byte, _
                                                      ByRef RecvBuffLen As Long) As Long


Option Strict Off
Option Explicit On
Module acr122
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

    Public Structure ACR122_LED_CONTROL
        Dim finalState As Integer
        Dim updateEnables As Boolean
        Dim initialBlinkingState As Integer
        Dim blinkEnabled As Boolean
    End Structure

    Public Structure ACR122_TIMEOUTS
        Dim statusTimeout As Integer
        Dim numStatusRetries As Integer
        Dim responseTimeout As Integer
        Dim numResponseRetries As Integer
    End Structure

    'LED States
    Public Const ACR122_LED_STATE_OFF As Short = 0
    Public Const ACR122_LED_STATE_ON As Short = 1

    'Buzzer Mode
    Public Const ACR122_BUZZER_MODE_OFF As Integer = &H0
    Public Const ACR122_BUZZER_MODE_T1 As Integer = &H1
    Public Const ACR122_BUZZER_MODE_T2 As Integer = &H2

    'Error Codes
    Public Const ACR122_ERROR_NO_MORE_HANDLES As Integer = &H20000001
    Public Const ACR122_ERROR_UNKNOWN_STATUS As Integer = &H20000002
    Public Const ACR122_ERROR_OPERATION_FAILURE As Integer = &H20000003
    Public Const ACR122_ERROR_OPERATION_TIMEOUT As Integer = &H20000004
    Public Const ACR122_ERROR_INVALID_CHECKSUM As Integer = &H20000005
    Public Const ACR122_ERROR_INVALID_PARAMETER As Integer = &H20000006



    '===============================================================
    ' FUNCTIONS
    '===============================================================

    Public Declare Function ACR122_Open Lib "acr122.dll" Alias "ACR122_OpenA" (ByVal portName As String, ByRef phReader As Integer) As Integer

    Public Declare Function ACR122_GetFirmwareVersion Lib "acr122.dll" Alias "ACR122_GetFirmwareVersionA" (ByVal phReader As Integer, _
                                                                                                           ByVal slotNum As Integer, _
                                                                                                           ByRef firmwareVersion As String, _
                                                                                                           ByRef pFirmwareVersionLen As Integer) As Integer

    Public Declare Function ACR122_Close Lib "acr122.dll" (ByVal phReader As Integer) As Integer

    Public Declare Function ACR122_DirectTransmit Lib "acr122.dll" (ByVal phReader As Integer, ByRef Sendbuff As Byte, ByVal SendBuffLen As Integer, ByRef RecvBuff As Byte, ByRef RecvBuffLen As Integer) As Integer

    Public Declare Function ACR122_GetNumSlots Lib "acr122.dll" (ByVal phReader As Integer, ByRef pNumSlots As Integer) As Integer

    Public Declare Function ACR122_GetBaudRate Lib "acr122.dll" (ByVal phReader As Integer, ByRef pBaudRate As Integer) As Integer

    Public Declare Function ACR122_SetBaudRate Lib "acr122.dll" (ByVal phReader As Integer, ByVal baudRate As Integer) As Integer

    'UPGRADE_WARNING: Structure ACR122_TIMEOUTS may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
    Public Declare Function ACR122_GetTimeouts Lib "acr122.dll" (ByVal phReader As Integer, ByRef pTimeouts As ACR122_TIMEOUTS) As Integer

    'UPGRADE_WARNING: Structure ACR122_TIMEOUTS may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
    Public Declare Function ACR122_SetTimeouts Lib "acr122.dll" (ByVal phReader As Integer, ByRef pTimeouts As ACR122_TIMEOUTS) As Integer

    'UPGRADE_WARNING: Structure ACR122_LED_CONTROL may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
    Public Declare Function ACR122_SetLedStatesWithBeep Lib "acr122.dll" (ByVal phReader As Integer, ByRef controls As ACR122_LED_CONTROL, ByVal numControls As Integer, ByVal t1 As Integer, ByVal t2 As Integer, ByVal numTimes As Integer, ByVal buzzerMode As Integer) As Integer

    Public Declare Function ACR122_PowerOnIcc Lib "acr122.dll" (ByVal phReader As Integer, ByVal slotNum As Integer, ByRef atr As Byte, ByRef pAtrLen As Integer) As Integer

    Public Declare Function ACR122_PowerOffIcc Lib "acr122.dll" (ByVal phReader As Integer, ByVal slotNum As Integer) As Integer


    Public Declare Function ACR122_ExchangeApdu Lib "acr122.dll" (ByVal phReader As Integer, ByVal slotNum As Object, ByRef Sendbuff As Byte, ByVal SendBuffLen As Integer, ByRef RecvBuff As Byte, ByRef RecvBuffLen As Integer) As Integer
End Module
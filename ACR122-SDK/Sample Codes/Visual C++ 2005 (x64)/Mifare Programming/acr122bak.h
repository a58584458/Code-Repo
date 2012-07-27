/**
 * @file
 * ACR122 API library header file.
 * @version 1.0
 * @date    14 Sep 2009
 * @warning Copyright (C) 2009 Advanced Card Systems Ltd. All rights reserved.
 */
 
/**
 * @mainpage
 * This documentation covers the APIs provided by ACR122 API library.
 */

#ifndef ACR122_H
#define ACR122_H

#include <windows.h>

// Error codes
#define ACR122_ERROR_NO_MORE_HANDLES   ((DWORD) 0x20000001L)   ///< There are no more handles.
#define ACR122_ERROR_UNKNOWN_STATUS    ((DWORD) 0x20000002L)   ///< The status of response is unknown or not returned.
#define ACR122_ERROR_OPERATION_FAILURE ((DWORD) 0x20000003L)   ///< The operation failed.
#define ACR122_ERROR_OPERATION_TIMEOUT ((DWORD) 0x20000004L)   ///< The operation timed out.
#define ACR122_ERROR_INVALID_CHECKSUM  ((DWORD) 0x20000005L)   ///< The checksum of response is invalid.
#define ACR122_ERROR_INVALID_PARAMETER ((DWORD) 0x20000006L)   ///< The command is invalid.

// LED States
#define ACR122_LED_STATE_OFF           0   ///< Turn on LED.
#define ACR122_LED_STATE_ON            1   ///< Turn off LED.

// Buzzer Mode
#define ACR122_BUZZER_MODE_OFF         0x00    ///< The buzzer will not turn on.
#define ACR122_BUZZER_MODE_ON_T1       0x01    ///< The buzzer will turn on during T1 duration.
#define ACR122_BUZZER_MODE_ON_T2       0x02    ///< The buzzer will turn on during T2 duration.

// LED Control
typedef struct _ACR122_LED_CONTROL {
    /**
     * Final state. Possible values are ACR122_LED_STATE_OFF and
     * ACR122_LED_STATE_ON.
     */
    DWORD finalState;
    
    /**
     * Enable update. Set to TRUE to update the state. Otherwise, set to FALSE
     * to keep the state unchanged.
     */
    BOOL updateEnabled;
    
    /**
     * Initial blinking state. Possible values are ACR122_LED_STATE_OFF and
     * ACR122_LED_STATE_ON.
     */
    DWORD initialBlinkingState;
    
    /**
     * Enable blink. Set to TRUE to enable blink. Otherwise, set to FALSE.
     */
    BOOL blinkEnabled;          
} ACR122_LED_CONTROL, *PACR122_LED_CONTROL;

/**
 * @struct _ACR122_LED_CONTROL
 * LED Control. This data structure is used in ACR122_SetLedStatesWithBeep()
 * function.
 */

/**
 * @typedef ACR122_LED_CONTROL
 * Create a type name for _ACR122_LED_CONTROL.
 */

/**
 * @typedef PACR122_LED_CONTROL
 * Create a type name for pointer to _ACR122_LED_CONTROL data structure.
 */

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Open reader (ANSI). The ACR122_OpenA() function opens a reader and returns a
 * handle value as reference.
 * @param[in]  portName Port name. "\\.\COM1" means that the reader is connected to COM1 in Windows.
 * @param[out] phReader A Pointer to the HANDLE variable.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_OpenA(LPSTR portName, LPHANDLE phReader);

/**
 * Open reader (Unicode). The ACR122_OpenW() function opens a reader and returns a
 * handle value as reference.
 * @param[in]  portName Port name. "\\.\COM1" means that the reader is connected to COM1 in Windows.
 * @param[out] phReader A Pointer to the HANDLE variable.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_OpenW(LPWSTR portName, LPHANDLE phReader);

/**
 * @def ACR122_Open
 * ACR122_Open will be mapped to ACR122_OpenW()
 * function if UNICODE is defined. Otherwise, it will be mapped to
 * ACR122_OpenA() function.
 */
#ifdef UNICODE
#define ACR122_Open  ACR122_OpenW
#else
#define ACR122_Open  ACR122_OpenA
#endif

/**
 * Close reader. The ACR122_Close() function closes the reader and releases the
 * resources.
 * @param[in] hReader A reference value returned from ACR122_Open() function.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_Close(HANDLE hReader);

/**
 * Set baud rate. The ACR122_SetBaudRate() function sets the baud rate of
 * reader. Actully, the reader supports 9600 bps and 115200 bps.
 * @param[in] hReader  A reference value returned from ACR122_Open() function.
 * @param[in] baudRate Baud rate must be 9600 bps or 115200 bps.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_SetBaudRate(HANDLE hReader, DWORD baudRate);

/**
 * Get firmware version (ANSI). The ACR122_GetFirmwareVersionA() function
 * returns the firmware version in ANSI string of the slot.
 * @param[in]     hReader             A reference value returned from ACR122_Open() function.
 * @param[in]     slotNum             Slot number.
 * @param[out]    firmwareVersion     A pointer to the buffer that receives the firmware version returned from the reader.
 * @param[in,out] pFirmwareVersionLen The length in number of bytes of the firmwareVersion parameter and receives the actual number of bytes received from the reader.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_GetFirmwareVersionA(HANDLE hReader, DWORD slotNum, LPSTR firmwareVersion, LPDWORD pFirmwareVersionLen);

/**
 * Get firmware version (Unicode). The ACR122_GetFirmwareVersionW() function
 * returns the firmware version in Unicode string of the slot.
 * @param[in]     hReader             A reference value returned from ACR122_Open() function.
 * @param[in]     slotNum             Slot number.
 * @param[out]    firmwareVersion     A pointer to the buffer that receives the firmware version returned from the reader.
 * @param[in,out] pFirmwareVersionLen The length in number of bytes of the firmwareVersion parameter and receives the actual number of bytes received from the reader.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_GetFirmwareVersionW(HANDLE hReader, DWORD slotNum, LPWSTR firmwareVersion, LPDWORD pFirmwareVersionLen);

/**
 * @def ACR122_GetFirmwareVersion
 * ACR122_GetFirmwareVersion will be mapped to ACR122_GetFirmwareVersionW()
 * function if UNICODE is defined. Otherwise, it will be mapped to
 * ACR122_GetFirmwareVersionA() function.
 */
#ifdef UNICODE
#define ACR122_GetFirmwareVersion  ACR122_GetFirmwareVersionW
#else
#define ACR122_GetFirmwareVersion  ACR122_GetFirmwareVersionA
#endif

/**
 * Display LCD message (ANSI). The ACR122_DisplayLcdMessageA() function
 * displays LCD message in the reader.
 * @param[in] hReader A reference value returned from ACR122_Open() function.
 * @param[in] row     Row number must be from 0 to 1.
 * @param[in] col     Column number must be from 0 to 15.
 * @param[in] message Message for display. The length of message must be 16 characters.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_DisplayLcdMessageA(HANDLE hReader, DWORD row, DWORD col, LPCSTR message);

/**
 * Display LCD message (Unicode). The ACR122_DisplayLcdMessageW() function
 * displays LCD message in the reader.
 * @param[in] hReader A reference value returned from ACR122_Open() function.
 * @param[in] row     Row number must be from 0 to 1.
 * @param[in] col     Column number must be from 0 to 15.
 * @param[in] message Message for display. The length of message must be 16 characters.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_DisplayLcdMessageW(HANDLE hReader, DWORD row, DWORD col, LPCWSTR message);

/**
 * @def ACR122_DisplayLcdMessage
 * ACR122_DisplayLcdMessage will be mapped to ACR122_DisplayLcdMessageW()
 * function if UNICODE is defined. Otherwise, it will be mapped to
 * ACR122_DisplayLcdMessageA() function.
 */
#ifdef UNICODE
#define ACR122_DisplayLcdMessage   ACR122_DisplayLcdMessageW
#else
#define ACR122_DisplayLcdMessage   ACR122_DisplayLcdMessageA
#endif

/**
 * Clear LCD. The ACR122_ClearLcd() function clears the LCD display of the
 * reader.
 * @param[in] hReader A reference value returned from ACR122_Open() function.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_ClearLcd(HANDLE hReader);

/**
 * Enable LCD backlight. The ACR122_EnableLcdBacklight() enables or disables
 * the LCD backlight of the reader.
 * @param[in] hReader A reference value returned from ACR122_Open() function.
 * @param[in] enabled Set to TRUE to enable backlight. Otherwise, set to FALSE.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_EnableLcdBacklight(HANDLE hReader, BOOL enabled);

/**
 * Enable LED. The ACR122_EnableLed() function enables or disables LED control
 * to the application. By default, LED is controlled by the firmware. Before
 * calling ACR122_SetLedStatesWithBeep() and ACR122_SetLedStates(), the
 * application needs to call this function in order to control the LED.
 * @param[in] hReader  A reference value returned from ACR122_Open() function.
 * @param[in] enabled Set to TRUE to enable LED. Otherwise, set to FALSE.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_EnableLed(HANDLE hReader, BOOL enabled);

/**
 * Set LED states with beep. The ACR122_SetLedStatesWithBeep() controls LED0,
 * LED1 and buzzer operation in the reader.
 * @param[in] hReader     A reference value returned from ACR122_Open() function.
 * @param[in] controls    A pointer to the array of _ACR122_LED_CONTROL data structure.
 * @param[in] numControls Number of controls must be 2.
 * @param[in] t1          T1 in milliseconds. The value must be from 0 to 2550.
 * @param[in] t2          T2 in milliseconds. The value must be from 0 to 2550.
 * @param[in] numTimes    Number of times. The values must be from 0 to 255.
 * @param[in] buzzerMode  A bitmask of buzzer mode. Possible values may be combined with the OR operation.
 * <table>
 * <tr>
 * <td><b>Value</b></td>
 * <td><b>Meaning</b></td>
 * </tr>
 * <tr>
 * <td>ACR122_BUZZER_MODE_OFF</td>
 * <td>The buzzer will not turn on.</td>
 * </tr>
 * <tr>
 * <td>ACR122_BUZZER_MODE_ON_T1</td>
 * <td>The buzzer will turn on during T1 duration.</td>
 * </tr>
 * <tr>
 * <td>ACR122_BUZZER_MODE_ON_T2</td>
 * <td>The buzzer will turn on during T2 duration.</td>
 * </tr>
 * </table>
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_SetLedStatesWithBeep(HANDLE hReader, PACR122_LED_CONTROL controls, DWORD numControls, DWORD t1, DWORD t2, DWORD numTimes, DWORD buzzerMode);

/**
 * Set LED states. The ACR122_SetLedStates() function turns on or off the LEDs
 * in the reader. LED0, LED1, LED2 and LED3 can be controlled.
 * @param[in] hReader   A reference value returned from ACR122_Open() function.
 * @param[in] states    A pointer to the array of states. Possible values are ACR122_LED_STATE_OFF and ACR122_LED_STATE_ON.
 * @param[in] numStates Number of states must be 4.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_SetLedStates(HANDLE hReader, DWORD *states, DWORD numStates);

/**
 * Beep. The ACR122_Beep() function controls the buzzer in the reader to
 * generate the beep sound and it does not return control to its caller until
 * the sound finishes.
 * @param[in] hReader           A reference value returned from ACR122_Open() function.
 * @param[in] buzzerOnDuration  Buzzer ON duration in milliseconds.
 * @param[in] buzzerOffDuration Buzzer OFF duration in milliseconds.
 * @param[in] numTimes          Number of times
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_Beep(HANDLE hReader, DWORD buzzerOnDuration, DWORD buzzerOffDuration, DWORD numTimes);

/**
 * Direct transmit PN532 and TAG command. The ACR122_DirectTransmit() function
 * sends PN532 and TAG command and receives response from the reader.
 * @param[in]     hReader        A reference value returned from ACR122_Open() function.
 * @param[in]     sendBuffer     A pointer to the actual data to be written to the card.
 * @param[in]     sendBufferLen  The length in number of bytes of the sendBuffer parameter.
 * @param[out]    recvBuffer     A pointer to any data returned from the card.
 * @param[in,out] pRecvBufferLen The length in number of bytes of the recvBuffer parameter and receives the actual number of bytes received from the card.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_DirectTransmit(HANDLE hReader, const LPBYTE sendBuffer, DWORD sendBufferLen, LPBYTE recvBuffer, LPDWORD pRecvBufferLen);

/**
 * Power on ICC in slot. The ACR122_PowerOnIcc function powers on the card in
 * the slot and returns the ATR string from the card.
 * @param[in]     hReader A reference value returned from ACR122_Open() function.
 * @param[in]     slotNum Slot number.
 * @param[out]    atr     A pointer to the buffer that receives the ATR string returned from the card.
 * @param[in,out] pAtrLen The length in number of bytes of the atr parameter and receives the actual number of bytes received from the card.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_PowerOnIcc(HANDLE hReader, DWORD slotNum, LPBYTE atr, LPDWORD pAtrLen);

/**
 * Power off ICC in slot. The ACR122_PowerOffIcc() function powers off the card
 * in the slot.
 * @param[in] hReader A reference value returned from ACR122_Open() function.
 * @param[in] slotNum Slot number.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_PowerOffIcc(HANDLE hReader, DWORD slotNum);

/**
 * Exchange APDU. The ACR122_ExchangeApdu() function sends APDU command and
 * receives APDU response from the card.
 * @param[in]     hReader        A reference value returned from ACR122_Open() function.
 * @param[in]     slotNum        Slot number.
 * @param[in]     sendBuffer     A pointer to the actual data to be written to the card.
 * @param[in]     sendBufferLen  The length in number of bytes of the sendBuffer parameter.
 * @param[out]    recvBuffer     A pointer to any data returned from the card.
 * @param[in,out] pRecvBufferLen The length in number of bytes of the recvBuffer parameter and receives the actual number of bytes received from the card.
 * @return Error code.
 * @retval ERROR_SUCCESS The operation completed successfully.
 * @retval Failure       An error code. See Windows API error codes and ACR122 error codes.
 */
DWORD WINAPI ACR122_ExchangeApdu(HANDLE hReader, DWORD slotNum, const LPBYTE sendBuffer, DWORD sendBufferLen, LPBYTE recvBuffer, LPDWORD pRecvBufferLen);

#ifdef __cplusplus
}
#endif

#endif

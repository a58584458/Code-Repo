Attribute VB_Name = "global"
Option Explicit
Public ret, hReader, fwLen As Long
Public fwVersion As String * 256
Public Sendbuff(0 To 262) As Byte
Public RecvBuff(0 To 262) As Byte
Public SendLen, RecvLen As Long
Public GlobalPIN(0 To 8) As Byte
Public conn As Boolean
Public port As String
Public UID(0 To 4) As Byte

Public Sub ClearBuffers()
Dim intIndx As Long
  
  For intIndx = 0 To 262
  
    RecvBuff(intIndx) = &H0
    Sendbuff(intIndx) = &H0
    
  Next intIndx
End Sub


Public Sub DisplayMsg(ByVal mType, ByVal msgCode As Long, ByVal PrintText As String)

    Select Case mType
        'Notification
        Case 0
            keyMgt.mMsg.SelColor = &H4000
        'Error Message
        Case 1
            keyMgt.mMsg.SelColor = vbRed
            PrintText = "Error: " & msgCode
        'input data
        Case 2
            keyMgt.mMsg.SelColor = vbBlack
            PrintText = "< " & PrintText
            
        'output data
        Case 3
            keyMgt.mMsg.SelColor = vbBlack
            PrintText = "> " & PrintText
            
    End Select
    
    keyMgt.mMsg.SelText = PrintText & vbCrLf
    keyMgt.mMsg.SelStart = Len(keyMgt.mMsg.Text)
    keyMgt.mMsg.SelColor = vbBlack

End Sub

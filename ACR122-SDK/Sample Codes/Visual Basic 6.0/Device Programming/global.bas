Attribute VB_Name = "global"
Option Explicit
Public ret, hReader, fwLen As Long
Public fwVersion As String * 256
Public Sendbuff(0 To 262) As Byte
Public RecvBuff(0 To 262) As Byte
Public SendLen, RecvLen As Long
Public conn As Boolean

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
            devProg.mMsg.SelColor = &H4000
        'Error Message
        Case 1
            devProg.mMsg.SelColor = vbRed
            PrintText = "Error: " & msgCode
        'input data
        Case 2
            devProg.mMsg.SelColor = vbBlack
            PrintText = "< " & PrintText
            
        'output data
        Case 3
            devProg.mMsg.SelColor = vbBlack
            PrintText = "> " & PrintText
            
    End Select
    
    devProg.mMsg.SelText = PrintText & vbCrLf
    devProg.mMsg.SelStart = Len(devProg.mMsg.Text)
    devProg.mMsg.SelColor = vbBlack

End Sub

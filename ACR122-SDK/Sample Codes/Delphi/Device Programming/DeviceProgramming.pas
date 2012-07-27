unit DeviceProgramming;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ACR122s, Dialog, Dialogs, StdCtrls, ComCtrls;

type
    TDeviceProgram = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    cbPort: TComboBox;
    cbBaudRate: TComboBox;
    bConnect: TButton;
    bSetBaud: TButton;
    bSetTimeout: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    tbT1: TEdit;
    tbT2: TEdit;
    tbTimes: TEdit;
    cT1: TCheckBox;
    cT2: TCheckBox;
    GroupBox3: TGroupBox;
    cEnableUp1: TCheckBox;
    cEnableBlink1: TCheckBox;
    bSetLedBuzz: TButton;
    bClear: TButton;
    bReset: TButton;
    bQuit: TButton;
    mMsg: TRichEdit;
    GroupBox6: TGroupBox;
    rbOn1: TRadioButton;
    rbOff1: TRadioButton;
    Label7: TLabel;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    rbOn2: TRadioButton;
    rbOff2: TRadioButton;
    GroupBox4: TGroupBox;
    cEnableUp2: TCheckBox;
    cEnableBlink2: TCheckBox;
    GroupBox7: TGroupBox;
    Label9: TLabel;
    rbOn3: TRadioButton;
    rbOff3: TRadioButton;
    GroupBox8: TGroupBox;
    Label10: TLabel;
    rbOn4: TRadioButton;
    rbOff4: TRadioButton;
    procedure FormActivate(Sender: TObject);
    procedure bConnectClick(Sender: TObject);
    procedure bSetBaudClick(Sender: TObject);
    procedure bQuitClick(Sender: TObject);
    procedure bResetClick(Sender: TObject);
    procedure bClearClick(Sender: TObject);
    procedure bSetLedBuzzClick(Sender: TObject);
    procedure bSetTimeoutClick(Sender: TObject);
    procedure tbT1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public

  end;

var
  DeviceProgram: TDeviceProgram;
  hReader : SCARDHANDLE;
  connActive :BOOL;
  PrintText : String;
  SendBuff : array [0..256] of Byte;
  RecvBuff : array [0..256] of Byte;
  retCode  : DWORD;
  SendLen : smallint;
  RecvLen : DWORD;
  tmpBaud  : DWORD;

procedure InitMenu();
procedure displayOut(errType: Integer; retVal: Integer; PrintText: String);
procedure EnableAll(Option : BOOL);
implementation

{$R *.dfm}

procedure TDeviceProgram.bClearClick(Sender: TObject);
begin
     DeviceProgram.mMsg.Clear;
end;

procedure TDeviceProgram.bConnectClick(Sender: TObject);
var
FWLEN : DWORD;
tempstr : array [0..256] of char;
begin
    PrintText := DeviceProgram.cbPort.Text;

    retCode := ACR122_OpenA( PrintText, @hReader);
    if retCode = 0  then
    begin
      ConnActive := True;
      DeviceProgram.bConnect.Enabled := False;
      EnableAll(True);

      PrintText := 'Connection to ' + PrintText + ' success';
      displayOut( 0, 0, PrintText);

      PrintText := '';
      
      retCode := ACR122_GetFirmwareVersionA(hReader, 0, tempstr, @FWLEN);
      if retCode = 0 then
      begin
        PrintText := 'Firmware Version: ' + tempstr;
        displayOut(5, 0, PrintText);
      end
      else
      begin
        displayOut( 1, 0, 'Get Firmware Version failed');
      end;
    end
    else
    begin
      PrintText := 'Connection to ' + PrintText + ' failed';
      displayOut( 1, 0, PrintText);
    end;
end;

procedure TDeviceProgram.bQuitClick(Sender: TObject);
begin
    if ConnActive = true then
     begin
        retCode := ACR122_Close(hReader);
     end;
    Application.Terminate;
end;

procedure TDeviceProgram.bResetClick(Sender: TObject);
begin
     if ConnActive = true then
     begin
        retCode := ACR122_Close(hReader);
        if retCode = 0 then
        begin
             InitMenu();
        end;

     end;
end;

procedure TDeviceProgram.bSetBaudClick(Sender: TObject);
begin

    tmpBaud := StrToInt(cbBaudRate.Text);

    retCode := ACR122_SetBaudRate(hReader, tmpBaud);

    if retCode = 0 then
    begin
        DisplayOut( 0, 0, 'Set baud rate success');
    end
    else
        DisplayOut( 0, 0, 'Set baud rate failed');
    begin

    end;
end;

procedure TDeviceProgram.bSetLedBuzzClick(Sender: TObject);
var
ledCtrl : array [0 .. 2 ] of ACR122_LED_CONTROL;
t1 : Integer;
t2 : Integer;
num : Integer;
buzzmode : DWORD;
begin

   // L0 Final State
   if rbOn1.Checked = True then begin
      ledCtrl[0].finalState := ACR122_LED_STATE_ON;
   end
   else begin
      ledCtrl[0].finalState := ACR122_LED_STATE_OFF;
   end;

   // L0 Initial Blinking State
   if rbOn2.Checked = True then begin
      ledCtrl[0].initialBlinkingState := ACR122_LED_STATE_ON;
   end
   else begin
      ledCtrl[0].initialBlinkingState := ACR122_LED_STATE_OFF;
   end;

   // L1 Final State
   if rbOn3.Checked = True then begin
      ledCtrl[1].finalState := ACR122_LED_STATE_ON;
   end
   else begin
      ledCtrl[1].finalState := ACR122_LED_STATE_OFF;
   end;

   // L1 Initial Blinking State
   if rbOn4.Checked = True then begin
      ledCtrl[1].initialBlinkingState := ACR122_LED_STATE_ON;
   end
   else begin
      ledCtrl[1].initialBlinkingState := ACR122_LED_STATE_OFF;
   end;

   // L0 Enable Blink
   if cEnableBlink1.Checked = True then begin
      ledCtrl[0].blinkEnabled := True;
   end
   else begin
      ledCtrl[0].blinkEnabled := False;
   end;

   // L1 Enable Blink
   if cEnableBlink2.Checked = True then begin
      ledCtrl[1].blinkEnabled := True;
   end
   else begin
      ledCtrl[1].blinkEnabled := False;
   end;

   // L0 Enable Update
   if cEnableUp1.Checked = True then begin
      ledCtrl[0].updateEnabled := True;
   end
   else begin
      ledCtrl[0].updateEnabled := False;
   end;

   // L1 Enable Update
   if cEnableUp2.Checked = True then begin
      ledCtrl[1].updateEnabled := True;
   end
   else begin
      ledCtrl[1].updateEnabled := False;
   end;

   if tbT1.Text = '' then begin
      tbT1.SetFocus;
      Exit;
   end;

   if tbT2.Text = '' then begin
      tbT2.SetFocus;
      Exit;
   end;

   if tbTimes.Text = '' then begin
      tbTimes.SetFocus;
      Exit;
   end;

   t1 := StrToInt(tbT1.Text);
   if t1 > 25500 then begin
      tbT1.Text := '25500';
      tbT1.SetFocus;
      Exit;
   end;

   t2 := StrToInt(tbT2.Text);
   if t2 > 25500 then begin
      tbT2.Text := '25500';
      tbT2.SetFocus;
      Exit;
   end;

   num := StrToInt(tbTimes.Text);
   if num > 255 then begin
      tbTimes.Text := '255';
      tbTimes.SetFocus;
      Exit;
   end;

   if cT1.Checked = True then begin
     buzzmode := ACR122_BUZZER_MODE_ON_T1;
   end;

   if cT2.Checked = True then begin
     buzzmode := ACR122_BUZZER_MODE_ON_T2;
   end;

   if (cT1.Checked = True) and (cT2.Checked = True) then begin
     buzzmode := ACR122_BUZZER_MODE_ON_T1 or ACR122_BUZZER_MODE_ON_T2;
   end;

   if (cT1.Checked = False) and (cT2.Checked = False) then begin
     buzzmode := ACR122_BUZZER_MODE_OFF;
   end;

   retCode := ACR122_SetLedStatesWithBeep(hReader, @ledCtrl, 2 , t1, t2, num, buzzmode);

   if retCode = 0 then begin
      DisplayOut( 0, 0, 'Set LED States with Beep success');
   end
   else begin
      DisplayOut( 1, 0, 'Set LED States with Beep failed');
   end;


end;

procedure TDeviceProgram.bSetTimeoutClick(Sender: TObject);
begin
   FDialog.Show;
end;

procedure TDeviceProgram.FormActivate(Sender: TObject);
begin
   InitMenu();
end;

procedure TDeviceProgram.tbT1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> chr($08) then
    if Not (Key in ['0'..'9'])then
      Key := Chr($00);
end;

procedure InitMenu();
var
indx : Integer;
begin

  connActive := False;

  DeviceProgram.mMsg.Clear;

  DisplayOut(0, 0, 'Program ready');

  DeviceProgram.cbPort.Clear;

  for indx := 1 to 10 do
  begin
    PrintText := 'COM' + IntToStr(indx);
    DeviceProgram.cbPort.AddItem( PrintText, TObject.NewInstance);
  end;

  DeviceProgram.cbPort.ItemIndex := 0;

  DeviceProgram.cbBaudRate.AddItem('9600', TObject.NewInstance);
  DeviceProgram.cbBaudRate.AddItem('115200', TObject.NewInstance);

  DeviceProgram.cbBaudRate.ItemIndex := 0;

  DeviceProgram.tbT1.Text := '';
  DeviceProgram.tbT2.Text := '';
  DeviceProgram.tbTimes.Text := '';

  DeviceProgram.cT1.Checked := True;
  DeviceProgram.cT2.Checked := True;

  DeviceProgram.rbON1.Checked := True;
  DeviceProgram.rbON2.Checked := True;
  DeviceProgram.rbON3.Checked := True;
  DeviceProgram.rbON4.Checked := True;

  DeviceProgram.bConnect.Enabled := True;

  EnableAll(False);

end;

procedure EnableAll(Option : BOOL);
begin

  DeviceProgram.bReset.Enabled := Option;
  DeviceProgram.bSetBaud.Enabled := Option;
  DeviceProgram.bSetTimeout.Enabled := Option;
  DeviceProgram.bSetLedBuzz.Enabled := Option;
  DeviceProgram.cT1.Enabled := Option;
  DeviceProgram.cT2.Enabled := Option;
  DeviceProgram.tbT1.Enabled := Option;
  DeviceProgram.tbT2.Enabled := Option;
  DeviceProgram.tbTimes.Enabled := Option;
  DeviceProgram.rbON1.Enabled := Option;
  DeviceProgram.rbON2.Enabled := Option;
  DeviceProgram.rbON3.Enabled := Option;
  DeviceProgram.rbON4.Enabled := Option;
  DeviceProgram.rbOFF1.Enabled := Option;
  DeviceProgram.rbOFF2.Enabled := Option;
  DeviceProgram.rbOFF3.Enabled := Option;
  DeviceProgram.rbOFF4.Enabled := Option;
  DeviceProgram.cEnableUp1.Enabled := Option;
  DeviceProgram.cEnableUp2.Enabled := Option;
  DeviceProgram.cEnableBlink1.Enabled := Option;
  DeviceProgram.cEnableBlink2.Enabled := Option;

end;

procedure displayOut(errType: Integer; retVal: Integer; PrintText: String);
begin

  case errType of
    0: DeviceProgram.mMsg.SelAttributes.Color := clTeal;      // Notifications
    1: begin                                                // Error Messages
         DeviceProgram.mMsg.SelAttributes.Color := clRed;
         //PrintText := GetScardErrMsg(retVal);
       end;
    2: begin
         DeviceProgram.mMsg.SelAttributes.Color := clBlack;
         PrintText := '< ' + PrintText;                      // Input data
       end;
    3: begin
         DeviceProgram.mMsg.SelAttributes.Color := clBlack;
         PrintText := '> ' + PrintText;                      // Output data
       end;
    4: DeviceProgram.mMsg.SelAttributes.Color := clRed;        // For ACOS1 error
    5: DeviceProgram.mMsg.SelAttributes.Color := clBlack;      // Normal Notification
  end;
  DeviceProgram.mMsg.Lines.Add(PrintText);
  DeviceProgram.mMsg.SelAttributes.Color := clBlack;
  DeviceProgram.mMsg.SetFocus;

end;

end.

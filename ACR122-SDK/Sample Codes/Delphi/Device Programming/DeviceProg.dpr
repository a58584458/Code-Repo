program DeviceProg;

uses
  Forms,
  DeviceProgramming in 'DeviceProgramming.pas' {DeviceProgram},
  Dialog in 'Dialog.pas' {FDialog},
  ACR122s in 'ACR122s.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDeviceProgram, DeviceProgram);
  Application.CreateForm(TFDialog, FDialog);
  Application.Run;
end.

program MifareCardProg;

uses
  Forms,
  MifareProg in 'MifareProg.pas' {MainMifareProg},
  ACR122s in 'ACR122s.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainMifareProg, MainMifareProg);
  Application.Run;
end.

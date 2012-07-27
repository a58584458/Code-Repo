program PICCCardPolling;

uses
  Forms,
  Polling in 'Polling.pas' {CardPolling},
  ACR122s in 'ACR122s.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TCardPolling, CardPolling);
  Application.Run;
end.

program KeyManagement;

uses
  Forms,
  KeyManage in 'KeyManage.pas' {fKeyManage},
  ACR122s in 'ACR122s.pas',
  MifareInit in 'MifareInit.pas' {fMifareInit},
  SamInit in 'SamInit.pas' {fInitSAM};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfKeyManage, fKeyManage);
  Application.CreateForm(TfMifareInit, fMifareInit);
  Application.CreateForm(TfInitSAM, fInitSAM);
  Application.Run;
end.

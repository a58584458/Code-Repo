unit Dialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ACR122s, Dialogs, StdCtrls;

type
    TFDialog = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    tbStatTO: TEdit;
    tbStatRe: TEdit;
    tbRespTO: TEdit;
    tbRespRe: TEdit;
    bOk: TButton;
    bCancel: TButton;
    procedure bCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bOkClick(Sender: TObject);
    procedure tbStatTOKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDialog: TFDialog;

implementation

uses DeviceProgramming;

{$R *.dfm}

procedure TFDialog.bCancelClick(Sender: TObject);
begin
    FDialog.Close;
end;

procedure TFDialog.bOkClick(Sender: TObject);
var
acrTO : ACR122_TIMEOUTS;
retCode : Integer;

begin

   if tbStatTo.Text = '' then begin
      tbStatTo.SetFocus;
      Exit;
   end;

   if tbStatRe.Text = '' then begin
      tbStatRe.SetFocus;
      Exit;
   end;

   if tbRespTo.Text = '' then begin
      tbRespTo.SetFocus;
      Exit;
   end;

   if tbRespRe.Text = '' then begin
      tbRespRe.SetFocus;
      Exit;
   end;

   acrTO.statusTimeOut := StrToInt(tbStatTo.Text);
   acrTO.numStatusRetries := StrToInt(tbStatRe.Text);
   acrTO.responseTimeout := StrToInt(tbRespTo.Text);
   acrTO.numResponseRetries := StrToInt(tbRespRe.Text);

   retCode := ACR122_SetTimeouts( DeviceProgramming.hReader, @acrTo);

   if retCode = 0 then begin
      displayOut( 0, 0, 'Set Timeouts success');
   end
   else begin
      displayOut( 1, 0, 'Set Timeouts failed');
   end;

end;

procedure TFDialog.FormShow(Sender: TObject);
begin
   tbStatTO.Text := '2000';
   tbStatRe.Text := '1';
   tbRespTo.Text := '10000';
   tbRespRe.Text := '1';
end;

procedure TFDialog.tbStatTOKeyPress(Sender: TObject; var Key: Char);
begin
  if Key <> chr($08) then
    if Not (Key in ['0'..'9'])then
      Key := Chr($00);
end;

end.

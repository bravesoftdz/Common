unit DownloadURL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.StdCtrls, Vcl.ComCtrls, JvExComCtrls,
  JvProgressBar, Vcl.ExtCtrls, Vcl.ExtActns, Dlg;

type
  TDownloadURLDialog = class(TDialog)
    ActionList: TActionList;
    Button: TButton;
    CancelAction: TAction;
    InformationLabel: TLabel;
    OKAction: TAction;
    Panel1: TPanel;
    ProgressBar: TJvProgressBar;
    ProgressPanel: TPanel;
    TopPanel: TPanel;
    procedure CancelActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OKActionExecute(Sender: TObject);
  private
    { Private declarations }
    FCancel: Boolean;
    procedure OnURLDownloadProgress(Sender: TDownLoadURL; Progress, ProgressMax: Cardinal;
      StatusCode: TURLDownloadStatus; StatusText: String; var Cancel: Boolean);
    procedure SetInformationText(Value: string);
  public
    { Public declarations }
    procedure Open(DefaultFileName: string; DownloadURL: string);
  end;

function DownloadURLDialog: TDownloadURLDialog;

implementation

{$R *.dfm}

uses
  Common, Language, Vcl.Themes, CommonDialogs;

var
  FDownloadURLDialog: TDownloadURLDialog;

function DownloadURLDialog: TDownloadURLDialog;
begin
  if not Assigned(FDownloadURLDialog) then
    Application.CreateForm(TDownloadURLDialog, FDownloadURLDialog);
  Result := FDownloadURLDialog;
end;

procedure TDownloadURLDialog.CancelActionExecute(Sender: TObject);
begin
  FCancel := True;
  InformationLabel.Caption := LanguageDataModule.GetConstant('DownloadCancelling');
  Repaint;
  Application.ProcessMessages;
  Close;
end;

procedure TDownloadURLDialog.FormDestroy(Sender: TObject);
begin
  FDownloadURLDialog := nil;
end;

procedure TDownloadURLDialog.SetInformationText(Value: string);
begin
  InformationLabel.Caption := Value;
  Invalidate;
  Application.ProcessMessages;
end;

procedure TDownloadURLDialog.Open(DefaultFileName: string; DownloadURL: string);
begin
  FCancel := False;
  Button.Action := CancelAction;
  if CommonDialogs.SaveFile(Handle, '', Trim(StringReplace(LanguageDataModule.GetFileTypes('Zip')
        , '|', #0, [rfReplaceAll])) + #0#0,
        LanguageDataModule.GetConstant('SaveAs'), DefaultFileName, 'zip') then
  begin
    SetInformationText(DownloadURL);
    Application.ProcessMessages;
    with TDownloadURL.Create(Self) do
    try
      URL := DownloadURL;
      FileName := CommonDialogs.Files[0];
      OnDownloadProgress := OnURLDownloadProgress;
      ExecuteTarget(nil);
    finally
      Free;
    end;
  end
  else
    Close;
  SetInformationText(LanguageDataModule.GetConstant('DownloadDone'));
  Button.Action := OKAction;
end;

procedure TDownloadURLDialog.OKActionExecute(Sender: TObject);
begin
  Close;
end;

procedure TDownloadURLDialog.OnURLDownloadProgress;
begin
  ProgressBar.Max := ProgressMax;
  ProgressBar.Position := Progress;
  Invalidate;
  Cancel := FCancel;
  Application.ProcessMessages;
end;

end.

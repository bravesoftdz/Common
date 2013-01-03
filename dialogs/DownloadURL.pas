unit DownloadURL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ActnList, Vcl.StdCtrls, Vcl.ComCtrls, JvExComCtrls,
  JvProgressBar, Vcl.ExtCtrls, Vcl.ExtActns, Dlg;

type
  TDownloadURLDialog = class(TDialog)
    TopPanel: TPanel;
    InformationLabel: TLabel;
    ProgressBar: TJvProgressBar;
    ProgressPanel: TPanel;
    Button: TButton;
    ActionList: TActionList;
    CancelAction: TAction;
    SaveDialog: TSaveDialog;
    OKAction: TAction;
    Panel1: TPanel;
    procedure FormDestroy(Sender: TObject);
    procedure CancelActionExecute(Sender: TObject);
    procedure OKActionExecute(Sender: TObject);
  private
    { Private declarations }
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
  Common, Language, Vcl.Themes;

var
  FDownloadURLDialog: TDownloadURLDialog;

function DownloadURLDialog: TDownloadURLDialog;
begin
  if FDownloadURLDialog = nil then
    Application.CreateForm(TDownloadURLDialog, FDownloadURLDialog);
  Result := FDownloadURLDialog;
end;

procedure TDownloadURLDialog.CancelActionExecute(Sender: TObject);
begin
  InformationLabel.Caption := LanguageDataModule.ConstantMultiStringHolder.StringsByName['DownloadCancelling'].Text;
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
  Button.Action := CancelAction;
  with SaveDialog do
  begin
    FileName := DefaultFileName;
    if Execute then
    begin
      SetInformationText(DownloadURL);
      Application.ProcessMessages;
      with TDownloadURL.Create(Self) do
      try
        URL := DownloadURL;
        FileName := SaveDialog.FileName;
        OnDownloadProgress := OnURLDownloadProgress;
        ExecuteTarget(nil);
      finally
        Free;
      end;
    end
    else
      Close;
  end;
  SetInformationText(LanguageDataModule.ConstantMultiStringHolder.StringsByName['DownloadDone'].Text);
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
  Application.ProcessMessages;
end;

end.

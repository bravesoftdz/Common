unit BCDialogs.DownloadURL;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ActnList, Vcl.StdCtrls, Vcl.ComCtrls,
  JvExComCtrls, BCControls.ProgressBar, Vcl.ExtCtrls, Vcl.ExtActns, BCDialogs.Dlg, System.Actions, JvProgressBar;

type
  TDownloadURLDialog = class(TDialog)
    ActionList: TActionList;
    Button: TButton;
    CancelAction: TAction;
    InformationLabel: TLabel;
    OKAction: TAction;
    Panel1: TPanel;
    ProgressBar: TBCProgressBar;
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
    function Open(DefaultFileName: string; DownloadURL: string): string;
  end;

procedure CheckForUpdates(AppName: string; AboutVersion: string);

function DownloadURLDialog: TDownloadURLDialog;

implementation

{$R *.dfm}

uses
  Winapi.Windows, Winapi.WinInet, Winapi.ShellApi, System.StrUtils, BCCommon.Messages, BCCommon.Lib,
  BCCommon.LanguageStrings, BCCommon.Dialogs;

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

function TDownloadURLDialog.Open(DefaultFileName: string; DownloadURL: string): string;
var
  FilterIndex: Cardinal;
begin
  FCancel := False;
  Result := '';
  Button.Action := CancelAction;
  Application.ProcessMessages;
  if BCCommon.Dialogs.SaveFile(Handle, '', Trim(StringReplace(LanguageDataModule.GetFileTypes('Zip')
        , '|', #0, [rfReplaceAll])) + #0#0,
        LanguageDataModule.GetConstant('SaveAs'), FilterIndex, DefaultFileName, 'zip') then
  begin
    SetInformationText(DownloadURL);
    Application.ProcessMessages;
    with TDownloadURL.Create(Self) do
    try
      URL := DownloadURL;
      FileName := BCCommon.Dialogs.Files[0];
      Result := FileName;
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

function GetAppVersion(const Url:string):string;
const
  BuffSize = 64*1024;
  TitleTagBegin = '<p>';
  TitleTagEnd = '</p>';
var
  hInter: HINTERNET;
  UrlHandle: HINTERNET;
  BytesRead: Cardinal;
  Buffer: Pointer;
  i,f: Integer;
begin
  Result:='';
  hInter := InternetOpen('', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  if Assigned(hInter) then
  begin
    GetMem(Buffer,BuffSize);
    try
       UrlHandle := InternetOpenUrl(hInter, PChar(Url), nil, 0, INTERNET_FLAG_RELOAD,0);
       try
        if Assigned(UrlHandle) then
        begin
          InternetReadFile(UrlHandle, Buffer, BuffSize, BytesRead);
          if BytesRead > 0 then
          begin
            SetString(Result, PAnsiChar(Buffer), BytesRead);
            i := Pos(TitleTagBegin,Result);
            if i > 0 then
            begin
              f := PosEx(TitleTagEnd,Result,i+Length(TitleTagBegin));
              Result := Copy(Result,i+Length(TitleTagBegin),f-i-Length(TitleTagBegin));
            end;
          end;
        end;
       finally
         InternetCloseHandle(UrlHandle);
       end;
    finally
      FreeMem(Buffer);
    end;
    InternetCloseHandle(hInter);
  end
end;

procedure CheckForUpdates(AppName: string; AboutVersion: string);
var
  Version: string;
  FileName: string;
begin
  try
    try
      Screen.Cursor := crHourGlass;
      Version := GetAppVersion(Format('%s/newversioncheck.php?a=%s&v=%s', [BONECODE_URL, LowerCase(AppName), AboutVersion]));
    finally
      Screen.Cursor := crDefault;
    end;

    if (Trim(Version) <> '') and (Version <> AboutVersion) then
    begin
      if AskYesOrNo(Format(LanguageDataModule.GetYesOrNoMessage('NewVersion'), [Version, AppName, CHR_DOUBLE_ENTER])) then
      begin
        {$IFDEF WIN64}
        AppName := AppName + '64';
        {$ENDIF}
        FileName := DownloadURLDialog.Open(Format('%s.zip', [AppName]), Format('%s/downloads/%s.zip', [BONECODE_URL, AppName]));
        ShellExecute(Application.Handle, PChar('explore'), nil, nil, PChar(ExtractFilePath(FileName)), SW_SHOWNORMAL);
      end;
    end
    else
      ShowMessage(LanguageDataModule.GetMessage('LatestVersion'));
  except
    on E: Exception do
      ShowErrorMessage(E.Message);
  end;
end;

end.

unit BCCommon.Forms.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCComponents.SkinProvider, BCComponents.TitleBar,
  BCComponents.SkinManager, Vcl.ComCtrls, BCControls.StatusBar, System.Actions, Vcl.ActnList, BCControls.ProgressBar,
  Vcl.AppEvnts, Vcl.Menus, sSkinManager, System.Win.TaskbarCore, Vcl.Taskbar, sSkinProvider, acTitleBar, sStatusBar;

type
  TBCForm = class(TForm)
    ActionFileExit: TAction;
    ActionList: TActionList;
    ApplicationEvents: TApplicationEvents;
    MainMenu: TMainMenu;
    SkinManager: TBCSkinManager;
    SkinProvider: TBCSkinProvider;
    StatusBar: TBCStatusBar;
    TitleBar: TBCTitleBar;
    procedure ActionFileExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SkinMenuClick(Sender: TObject);
    procedure ProgressBarHide(Sender: TObject);
    procedure ProgressBarShow(Sender: TObject);
    procedure ProgressBarStepChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FProgressBar: TBCProgressBar;
    FSkinChange: TNotifyEvent;
    FTaskbar: TTaskbar;
    procedure CreateProgressBar;
    procedure ResizeProgressBar;
  protected
    procedure CreateSkinsMenu(AMenuItem: TMenuItem);
  public
    property ProgressBar: TBCProgressBar read FProgressBar write FProgressBar;
    property OnSkinChange: TNotifyEvent read FSkinChange write FSkinChange;
  end;

implementation

{$R *.dfm}

uses
  BCCommon.StringUtils, Winapi.CommCtrl;

procedure TBCForm.ActionFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TBCForm.FormCreate(Sender: TObject);
begin
  inherited;
  SkinManager.SkinName := 'MetroUI';
  SkinManager.Active := True;
  FTaskbar := TTaskBar.Create(Self);
  CreateProgressBar;
end;

procedure TBCForm.FormDestroy(Sender: TObject);
begin
  FTaskbar.Free;
  FProgressBar.Free;
end;

procedure TBCForm.CreateSkinsMenu(AMenuItem: TMenuItem);
var
  i: integer;
  LStringList: TStringList;
  LMenuItem: TMenuItem;
begin
  AMenuItem.Clear;
  LStringList := TStringList.Create;
  SkinManager.GetExternalSkinNames(LStringList);
  if LStringList.Count > 0 then
  try
    LStringList.Sort;
    for i := 0 to LStringList.Count - 1 do
    begin
      LMenuItem := TMenuItem.Create(Application);
      LMenuItem.Caption := LStringList[i];
      if LMenuItem.Caption = SkinManager.SkinName then
        LMenuItem.Checked := True;

      LMenuItem.OnClick := SkinMenuClick;
      LMenuItem.RadioItem := True;
      if (i <> 0) and (i mod 20 = 0) then
        LMenuItem.Break := mbBreak;

      AMenuItem.Add(LMenuItem);
    end;
  finally
    FreeAndNil(LStringList);
  end;
end;

procedure TBCForm.SkinMenuClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := True;
  SkinManager.SkinName := DeleteChars(TMenuItem(Sender).Caption, '&');
  SkinManager.Active := True;
  if Assigned(FSkinChange) then
    FSkinChange(Sender);
end;

procedure TBCForm.ResizeProgressBar;
var
  LRect: TRect;
begin
  if Assigned(FProgressBar) then
  begin
    Statusbar.Perform(SB_GETRECT, 4, Integer(@LRect));
    FProgressBar.Top := LRect.Top + 3;
    FProgressBar.Left := LRect.Left;
    FProgressBar.Width := LRect.Right - LRect.Left - 3;
    FProgressBar.Height := LRect.Bottom - LRect.Top - 3;
  end;
end;

procedure TBCForm.ProgressBarStepChange(Sender: TObject);
begin
  FTaskbar.ProgressValue := FProgressBar.Progress;
end;

procedure TBCForm.ProgressBarShow(Sender: TObject);
begin
  ResizeProgressBar;
  FTaskbar.ProgressMaxValue := FProgressBar.MaxValue;
  FTaskbar.ProgressState := TTaskBarProgressState.Normal;
end;

procedure TBCForm.ProgressBarHide(Sender: TObject);
begin
  FTaskbar.ProgressState := TTaskBarProgressState.None;
end;

procedure TBCForm.CreateProgressBar;
begin
  FProgressBar := TBCProgressBar.Create(StatusBar);
  FProgressBar.OnStepChange := ProgressBarStepChange;
  FProgressBar.OnShow := ProgressBarShow;
  FProgressBar.OnHide := ProgressBarHide;
  FProgressBar.Hide;
  FProgressBar.Parent := Statusbar;
end;

end.

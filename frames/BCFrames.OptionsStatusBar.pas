unit BCFrames.OptionsStatusBar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  BCControls.CheckBox, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList, System.Actions, BCCommon.OptionsContainer,
  BCFrames.OptionsFrame;

type
  TOptionsStatusBarFrame = class(TOptionsFrame)
    Panel: TPanel;
    SelectFontSpeedButton: TSpeedButton;
    FontLabel: TLabel;
    UseSystemFontCheckBox: TBCCheckBox;
    ActionList: TActionList;
    SelectFontAction: TAction;
    FontDialog: TFontDialog;
    procedure SelectFontActionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure PutData; override;
  end;

function OptionsStatusBarFrame(AOwner: TComponent): TOptionsStatusBarFrame;

implementation

{$R *.dfm}

var
  FOptionsStatusBarFrame: TOptionsStatusBarFrame;

function OptionsStatusBarFrame(AOwner: TComponent): TOptionsStatusBarFrame;
begin
  if not Assigned(FOptionsStatusBarFrame) then
    FOptionsStatusBarFrame := TOptionsStatusBarFrame.Create(AOwner);
  Result := FOptionsStatusBarFrame;
end;

destructor TOptionsStatusBarFrame.Destroy;
begin
  inherited;
  FOptionsStatusBarFrame := nil;
end;

procedure TOptionsStatusBarFrame.SelectFontActionExecute(Sender: TObject);
begin
  FontDialog.Font.Name := FontLabel.Font.Name;
  FontDialog.Font.Size := FontLabel.Font.Size;
  if FontDialog.Execute then
  begin
    FontLabel.Font.Assign(FontDialog.Font);
    FontLabel.Caption := Format('%s %dpt', [FontLabel.Font.Name, FontLabel.Font.Size]);
  end;
end;

procedure TOptionsStatusBarFrame.PutData;
begin
  OptionsContainer.StatusBarUseSystemFont := UseSystemFontCheckBox.Checked;
  OptionsContainer.StatusBarFontName := FontLabel.Font.Name;
  OptionsContainer.StatusBarFontSize := FontLabel.Font.Size;
end;

procedure TOptionsStatusBarFrame.GetData;
begin
  UseSystemFontCheckBox.Checked := OptionsContainer.StatusBarUseSystemFont;
  FontLabel.Font.Name := OptionsContainer.StatusBarFontName;
  FontLabel.Font.Size := OptionsContainer.StatusBarFontSize;
  FontLabel.Caption := Format('%s %dpt', [FontLabel.Font.Name, FontLabel.Font.Size]);
end;

end.

unit BCFrames.OptionsMainMenu;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  BCControls.CheckBox, Vcl.Buttons, BCControls.ComboBox, BCControls.Edit, Vcl.ActnList, System.Actions,
  BCCommon.OptionsContainer, BCFrames.OptionsFrame;

type
  TOptionsMainMenuFrame = class(TOptionsFrame)
    Panel: TPanel;
    PersistentHotKeysCheckBox: TBCCheckBox;
    ShadowsCheckBox: TBCCheckBox;
    UseSystemFontCheckBox: TBCCheckBox;
    FontLabel: TLabel;
    AnimationStyleLabel: TLabel;
    AnimationStyleComboBox: TBCComboBox;
    AnimationDurationLabel: TLabel;
    AnimationDurationEdit: TBCEdit;
    FontDialog: TFontDialog;
    ActionList: TActionList;
    SelectFontAction: TAction;
    SelectFontSpeedButton: TSpeedButton;
    procedure SelectFontActionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure Init; override;
    procedure GetData; override;
    procedure PutData; override;
  end;

function OptionsMainMenuFrame(AOwner: TComponent): TOptionsMainMenuFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Lib, Vcl.ActnMenus;

var
  FOptionsMainMenuFrame: TOptionsMainMenuFrame;

function OptionsMainMenuFrame(AOwner: TComponent): TOptionsMainMenuFrame;
begin
  if not Assigned(FOptionsMainMenuFrame) then
    FOptionsMainMenuFrame := TOptionsMainMenuFrame.Create(AOwner);
  Result := FOptionsMainMenuFrame;
end;

destructor TOptionsMainMenuFrame.Destroy;
begin
  inherited;
  FOptionsMainMenuFrame := nil;
end;

procedure TOptionsMainMenuFrame.Init;
var
  i: TAnimationStyle;
begin
  for i := Low(TAnimationStyle) to High(TAnimationStyle) do
    AnimationStyleComboBox.Items.Add(TAnimationStyleStr[TAnimationStyle(i)]);
end;

procedure TOptionsMainMenuFrame.SelectFontActionExecute(Sender: TObject);
begin
  FontDialog.Font.Name := FontLabel.Font.Name;
  FontDialog.Font.Size := FontLabel.Font.Size;
  if FontDialog.Execute then
  begin
    FontLabel.Font.Assign(FontDialog.Font);
    FontLabel.Caption := Format('%s %dpt', [FontLabel.Font.Name, FontLabel.Font.Size]);
  end;
end;

procedure TOptionsMainMenuFrame.PutData;
begin
  OptionsContainer.PersistentHotKeys := PersistentHotKeysCheckBox.Checked;
  OptionsContainer.Shadows := ShadowsCheckBox.Checked;
  OptionsContainer.MainMenuUseSystemFont := UseSystemFontCheckBox.Checked;
  OptionsContainer.MainMenuFontName := FontLabel.Font.Name;
  OptionsContainer.MainMenuFontSize := FontLabel.Font.Size;
  OptionsContainer.AnimationStyle := AnimationStyleComboBox.ItemIndex;
  OptionsContainer.AnimationDuration := StrToIntDef(AnimationDurationEdit.Text, 150);
end;

procedure TOptionsMainMenuFrame.GetData;
begin
  PersistentHotKeysCheckBox.Checked := OptionsContainer.PersistentHotKeys;
  ShadowsCheckBox.Checked := OptionsContainer.Shadows;
  UseSystemFontCheckBox.Checked := OptionsContainer.MainMenuUseSystemFont;
  FontLabel.Font.Name := OptionsContainer.MainMenuFontName;
  FontLabel.Font.Size := OptionsContainer.MainMenuFontSize;
  FontLabel.Caption := Format('%s %dpt', [FontLabel.Font.Name, FontLabel.Font.Size]);
  AnimationStyleComboBox.ItemIndex := OptionsContainer.AnimationStyle;
  AnimationDurationEdit.Text := IntToStr(OptionsContainer.AnimationDuration);
end;

end.

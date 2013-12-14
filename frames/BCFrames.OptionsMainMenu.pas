unit BCFrames.OptionsMainMenu;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  BCControls.CheckBox, Vcl.Buttons, BCControls.ComboBox, BCControls.Edit, Vcl.ActnList, System.Actions,
  BCCommon.OptionsContainer;

type
  TMainMenuFrame = class(TFrame)
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
    constructor Create(AOwner: TComponent); override;
    procedure PutData(OptionsContainer: TOptionsContainer);
  end;

implementation

{$R *.dfm}

uses
  BCCommon.Lib, Vcl.ActnMenus;

constructor TMainMenuFrame.Create(AOwner: TComponent);
var
  i: TAnimationStyle;
begin
  inherited;
  for i := Low(TAnimationStyle) to High(TAnimationStyle) do
    AnimationStyleComboBox.Items.Add(TAnimationStyleStr[TAnimationStyle(i)]);
end;

procedure TMainMenuFrame.SelectFontActionExecute(Sender: TObject);
begin
  FontDialog.Font.Name := FontLabel.Font.Name;
  FontDialog.Font.Size := FontLabel.Font.Size;
  if FontDialog.Execute then
  begin
    FontLabel.Font.Assign(FontDialog.Font);
    FontLabel.Caption := Format('%s %dpt', [FontLabel.Font.Name, FontLabel.Font.Size]);
  end;
end;

procedure TMainMenuFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.PersistentHotKeys := PersistentHotKeysCheckBox.Checked;
  OptionsContainer.Shadows := ShadowsCheckBox.Checked;
  OptionsContainer.MainMenuUseSystemFont := UseSystemFontCheckBox.Checked;
  OptionsContainer.MainMenuFontName := FontLabel.Font.Name;
  OptionsContainer.MainMenuFontSize := FontLabel.Font.Size;
  OptionsContainer.AnimationStyle := TAnimationStyle(AnimationStyleComboBox.ItemIndex);
  OptionsContainer.AnimationDuration := StrToIntDef(AnimationDurationEdit.Text, 150);
end;

end.

unit BCCommon.Frames.Options.MainMenu;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  BCControls.CheckBox, Vcl.Buttons, BCControls.ComboBox, BCControls.Edit, Vcl.ActnList, System.Actions,
  BCCommon.Options.Container, BCCommon.Frames.Options.Base, sEdit, sComboBox, sCheckBox, BCControls.Panel, sPanel,
  sFrameAdapter, sFontCtrls;

type
  TOptionsMainMenuFrame = class(TBCOptionsBaseFrame)
    ActionList: TActionList;
    CheckBoxUseSystemFont: TBCCheckBox;
    EditFontSize: TBCEdit;
    FontComboBoxFont: TBCFontComboBox;
    Panel: TBCPanel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsMainMenuFrame(AOwner: TComponent): TOptionsMainMenuFrame;

implementation

{$R *.dfm}

uses
  Vcl.ActnMenus;

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

procedure TOptionsMainMenuFrame.PutData;
begin
  OptionsContainer.MainMenuUseSystemFont := CheckBoxUseSystemFont.Checked;
  OptionsContainer.MainMenuFontName := FontComboBoxFont.Text;
  OptionsContainer.MainMenuFontSize := EditFontSize.ValueInt;
end;

procedure TOptionsMainMenuFrame.GetData;
begin
  CheckBoxUseSystemFont.Checked := OptionsContainer.MainMenuUseSystemFont;
  FontComboBoxFont.ItemIndex := FontComboBoxFont.Items.IndexOf(OptionsContainer.MainMenuFontName);
  EditFontSize.ValueInt := OptionsContainer.MainMenuFontSize;
end;

end.

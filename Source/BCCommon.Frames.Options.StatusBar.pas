unit BCCommon.Frames.Options.StatusBar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  BCControls.CheckBox, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList, System.Actions, BCCommon.Options.Container,
  BCCommon.Frames.Options.Base, sCheckBox, BCControls.Panel, sPanel, sFrameAdapter, sEdit, BCControls.Edit, sComboBox,
  sFontCtrls, BCControls.ComboBox;

type
  TOptionsStatusBarFrame = class(TBCOptionsBaseFrame)
    ActionList: TActionList;
    EditFontSize: TBCEdit;
    FontComboBoxFont: TBCFontComboBox;
    Panel: TBCPanel;
    UseSystemFontCheckBox: TBCCheckBox;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
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

procedure TOptionsStatusBarFrame.PutData;
begin
  OptionsContainer.StatusBarUseSystemFont := UseSystemFontCheckBox.Checked;
  OptionsContainer.StatusBarFontName := FontComboBoxFont.Text;
  OptionsContainer.StatusBarFontSize := EditFontSize.ValueInt;
end;

procedure TOptionsStatusBarFrame.GetData;
begin
  UseSystemFontCheckBox.Checked := OptionsContainer.StatusBarUseSystemFont;
  FontComboBoxFont.ItemIndex := FontComboBoxFont.Items.IndexOf(OptionsContainer.StatusBarFontName);
  EditFontSize.ValueInt := OptionsContainer.StatusBarFontSize;
end;

end.

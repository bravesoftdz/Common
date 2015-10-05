unit BCCommon.Frames.Options.MainMenu;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons, BCControls.ComboBox, BCControls.Edit, Vcl.ActnList, System.Actions,
  BCCommon.Options.Container, BCCommon.Frames.Options.Base, sEdit, sComboBox, BCControls.Panel, sPanel,
  sFrameAdapter, sFontCtrls, acSlider, sLabel;

type
  TOptionsMainMenuFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    StickyLabelUseSystemFont: TsStickyLabel;
    SliderUseSystemFont: TsSlider;
    FontComboBoxFont: TBCFontComboBox;
    EditFontSize: TBCEdit;
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
  BCCommon.Utils;

var
  FOptionsMainMenuFrame: TOptionsMainMenuFrame;

function OptionsMainMenuFrame(AOwner: TComponent): TOptionsMainMenuFrame;
begin
  if not Assigned(FOptionsMainMenuFrame) then
    FOptionsMainMenuFrame := TOptionsMainMenuFrame.Create(AOwner);
  Result := FOptionsMainMenuFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsMainMenuFrame.Destroy;
begin
  inherited;
  FOptionsMainMenuFrame := nil;
end;

procedure TOptionsMainMenuFrame.PutData;
begin
  OptionsContainer.MainMenuUseSystemFont := SliderUseSystemFont.SliderOn;
  OptionsContainer.MainMenuFontName := FontComboBoxFont.Text;
  OptionsContainer.MainMenuFontSize := EditFontSize.ValueInt;
end;

procedure TOptionsMainMenuFrame.GetData;
begin
  SliderUseSystemFont.SliderOn := OptionsContainer.MainMenuUseSystemFont;
  FontComboBoxFont.ItemIndex := FontComboBoxFont.Items.IndexOf(OptionsContainer.MainMenuFontName);
  EditFontSize.ValueInt := OptionsContainer.MainMenuFontSize;
end;

end.

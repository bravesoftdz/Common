unit BCCommon.Frame.Options.StatusBar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Frame.Options.Base,
  BCControl.Panel, BCControl.Edit, sFontCtrls, BCControl.ComboBox, acSlider, sLabel, Vcl.StdCtrls, sEdit, sComboBox,
  Vcl.ExtCtrls, sPanel, sFrameAdapter;

type
  TOptionsStatusBarFrame = class(TBCOptionsBaseFrame)
    EditFontSize: TBCEdit;
    FontComboBoxFont: TBCFontComboBox;
    Panel: TBCPanel;
    StickyLabelUseSystemFont: TsStickyLabel;
    SliderUseSystemFont: TsSlider;
    SliderShowMacro: TsSlider;
    StickyLabelShowMacro: TsStickyLabel;
    SliderShowCaretPosition: TsSlider;
    StickyLabelShowCaretPosition: TsStickyLabel;
    SliderShowKeyState: TsSlider;
    StickyLabelShowKeyState: TsStickyLabel;
    SliderShowModified: TsSlider;
    StickyLabelShowModified: TsStickyLabel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsStatusBarFrame(AOwner: TComponent): TOptionsStatusBarFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Utils, BCCommon.Options.Container;

var
  FOptionsStatusBarFrame: TOptionsStatusBarFrame;

function OptionsStatusBarFrame(AOwner: TComponent): TOptionsStatusBarFrame;
begin
  if not Assigned(FOptionsStatusBarFrame) then
    FOptionsStatusBarFrame := TOptionsStatusBarFrame.Create(AOwner);
  Result := FOptionsStatusBarFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsStatusBarFrame.Destroy;
begin
  inherited;
  FOptionsStatusBarFrame := nil;
end;

procedure TOptionsStatusBarFrame.PutData;
begin
  with OptionsContainer do
  begin
    StatusBarUseSystemFont := SliderUseSystemFont.SliderOn;
    StatusBarFontName := FontComboBoxFont.Text;
    StatusBarFontSize := EditFontSize.ValueInt;
    StatusBarShowMacro := SliderShowMacro.SliderOn;
    StatusBarShowCaretPosition := SliderShowCaretPosition.SliderOn;
    StatusBarShowKeyState := SliderShowKeyState.SliderOn;
    StatusBarShowModified := SliderShowModified.SliderOn;
  end;
end;

procedure TOptionsStatusBarFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderUseSystemFont.SliderOn := StatusBarUseSystemFont;
    FontComboBoxFont.ItemIndex := FontComboBoxFont.Items.IndexOf(StatusBarFontName);
    EditFontSize.ValueInt := StatusBarFontSize;
    SliderShowMacro.SliderOn := StatusBarShowMacro;
    SliderShowCaretPosition.SliderOn := StatusBarShowCaretPosition;
    SliderShowKeyState.SliderOn := StatusBarShowKeyState;
    SliderShowModified.SliderOn := StatusBarShowModified;
  end;
end;

end.

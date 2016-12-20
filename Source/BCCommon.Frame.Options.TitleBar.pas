unit BCCommon.Frame.Options.TitleBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Frame.Options.Base, sFrameAdapter, acSlider, Vcl.StdCtrls, sEdit,
  BCControl.Edit, sComboBox, sFontCtrls, BCControl.ComboBox, sLabel, Vcl.ExtCtrls, sPanel, BCControl.Panel;

type
  TOptionsTitleBarFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    StickyLabelUseSystemFontName: TsStickyLabel;
    StickyLabelUseSystemSize: TsStickyLabel;
    StickyLabelUseSystemStyle: TsStickyLabel;
    FontComboBoxFont: TBCFontComboBox;
    EditFontSize: TBCEdit;
    SliderUseSystemFontName: TsSlider;
    SliderUseSystemSize: TsSlider;
    SliderUseSystemStyle: TsSlider;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsTitleBarFrame(AOwner: TComponent): TOptionsTitleBarFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Utils, BCCommon.Options.Container;

var
  FOptionsTitleBarFrame: TOptionsTitleBarFrame;

function OptionsTitleBarFrame(AOwner: TComponent): TOptionsTitleBarFrame;
begin
  if not Assigned(FOptionsTitleBarFrame) then
    FOptionsTitleBarFrame := TOptionsTitleBarFrame.Create(AOwner);
  Result := FOptionsTitleBarFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsTitleBarFrame.Destroy;
begin
  inherited;
  FOptionsTitleBarFrame := nil;
end;

procedure TOptionsTitleBarFrame.PutData;
begin
  with OptionsContainer do
  begin
    TitleBarUseSystemFontName := SliderUseSystemFontName.SliderOn;
    TitleBarFontName := FontComboBoxFont.Text;
    TitleBarFontSize := EditFontSize.ValueInt;
    TitleBarUseSystemSize := SliderUseSystemSize.SliderOn;
    TitleBarUseSystemStyle := SliderUseSystemStyle.SliderOn;
  end;
end;

procedure TOptionsTitleBarFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderUseSystemFontName.SliderOn := TitleBarUseSystemFontName;
    FontComboBoxFont.ItemIndex := FontComboBoxFont.Items.IndexOf(TitleBarFontName);
    EditFontSize.ValueInt := TitleBarFontSize;
    SliderUseSystemSize.SliderOn := TitleBarUseSystemSize;
    SliderUseSystemStyle.SliderOn := TitleBarUseSystemStyle;
  end;
end;

end.

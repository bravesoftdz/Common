unit BCCommon.Frame.Options.TitleBar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Frame.Options.Base, sFrameAdapter, acSlider, Vcl.StdCtrls, sEdit,
  BCControl.Edit, sComboBox, sFontCtrls, BCControl.ComboBox, sLabel, Vcl.ExtCtrls, sPanel, BCControl.Panel;

type
  TBCOptionsBaseFrame1 = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    StickyLabelUseSystemFontName: TsStickyLabel;
    StickyLabelUseSystemSize: TsStickyLabel;
    StickyLabelUseSystemStyle: TsStickyLabel;
    FontComboBoxFont: TBCFontComboBox;
    EditFontSize: TBCEdit;
    SliderUseSystemFontName: TsSlider;
    SliderUseSystemSize: TsSlider;
    SliderUseSystemStyle: TsSlider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BCOptionsBaseFrame1: TBCOptionsBaseFrame1;

implementation

{$R *.dfm}

end.

unit BCCommon.Dialog.Options.Search;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCEditor.Types, BCEditor.Editor,
  BCCommon.Dialog.Base, BCControl.Panel, BCControl.Button, acSlider,
  sLabel, Vcl.StdCtrls, sButton, Vcl.ExtCtrls, sPanel, sSkinProvider;

type
  TSearchOptionsDialog = class(TBCBaseDialog)
    ButtonCancel: TBCButton;
    ButtonOK: TBCButton;
    PanelButton: TBCPanel;
    StickyLabelBeepIfSearchStringNotFound: TsStickyLabel;
    SliderBeepIfSearchStringNotFound: TsSlider;
    StickyLabelEntireScope: TsStickyLabel;
    StickyLabelHighlightResult: TsStickyLabel;
    StickyLabelSearchOnTyping: TsStickyLabel;
    StickyLabelShowSearchStringNotFound: TsStickyLabel;
    StickyLabelWholeWordsOnly: TsStickyLabel;
    SliderEntireScope: TsSlider;
    SliderHighlightResult: TsSlider;
    SliderSearchOnTyping: TsSlider;
    SliderShowSearchStringNotFound: TsSlider;
    SliderWholeWordsOnly: TsSlider;
    Panel: TBCPanel;
    SliderShowSearchMatchNotFound: TsSlider;
    StickyLabelShowSearchMatchNotFound: TsStickyLabel;
    SliderWrapAround: TsSlider;
    StickyLabelWrapAround: TsStickyLabel;
    procedure FormShow(Sender: TObject);
  private
    procedure SetOptions(AEditor: TBCEditor);
    procedure GetOptions(AEditor: TBCEditor);
    procedure WriteIniFile;
  public
    class procedure ClassShowModal(AEditor: TBCEditor);
  end;

implementation

{$R *.dfm}

uses
  System.IniFiles, BCCommon.Utils, BCCommon.FileUtils;

class procedure TSearchOptionsDialog.ClassShowModal(AEditor: TBCEditor);
var
  FSearchOptionsDialog: TSearchOptionsDialog;
begin
  Application.CreateForm(TSearchOptionsDialog, FSearchOptionsDialog);

  with FSearchOptionsDialog do
  begin
    SetOptions(AEditor);
    if ShowModal = mrOk then
    begin
      GetOptions(AEditor);
      WriteIniFile;
    end;
    Free;
  end;
  FSearchOptionsDialog := nil;
end;

procedure TSearchOptionsDialog.WriteIniFile;
begin
  with TIniFile.Create(GetIniFilename) do
  try
    WriteBool('Options', 'SearchBeepIfSearchStringNotFound', SliderBeepIfSearchStringNotFound.SliderOn);
    WriteBool('Options', 'SearchEntireScope', SliderEntireScope.SliderOn);
    WriteBool('Options', 'SearchHighlightResult', SliderHighlightResult.SliderOn);
    WriteBool('Options', 'SearchOnTyping', SliderSearchOnTyping.SliderOn);
    WriteBool('Options', 'SearchShowSearchMatchNotFound', SliderShowSearchMatchNotFound.SliderOn);
    WriteBool('Options', 'SearchShowSearchStringNotFound', SliderShowSearchStringNotFound.SliderOn);
    WriteBool('Options', 'SearchWholeWordsOnly', SliderWholeWordsOnly.SliderOn);
    WriteBool('Options', 'SearchWrapAround', SliderWrapAround.SliderOn);
  finally
    Free;
  end;
end;

procedure TSearchOptionsDialog.SetOptions(AEditor: TBCEditor);
begin
  SliderBeepIfSearchStringNotFound.SliderOn := soBeepIfStringNotFound in AEditor.Search.Options;
  SliderEntireScope.SliderOn := soEntireScope in AEditor.Search.Options;
  SliderHighlightResult.SliderOn := soHighlightResults in AEditor.Search.Options;
  SliderSearchOnTyping.SliderOn := soSearchOnTyping in AEditor.Search.Options;
  SliderShowSearchMatchNotFound.SliderOn := soShowSearchMatchNotFound in AEditor.Search.Options;
  SliderShowSearchStringNotFound.SliderOn := soShowStringNotFound in AEditor.Search.Options;
  SliderWholeWordsOnly.SliderOn := soWholeWordsOnly in AEditor.Search.Options;
  SliderWrapAround.SliderOn := soWrapAround in AEditor.Search.Options;
end;

procedure TSearchOptionsDialog.FormShow(Sender: TObject);
begin
  inherited;
  AlignSliders(Panel, 8);
  Width := SliderBeepIfSearchStringNotFound.Left + SliderBeepIfSearchStringNotFound.Width + 12;
end;

procedure TSearchOptionsDialog.GetOptions(AEditor: TBCEditor);
begin
  AEditor.Search.SetOption(soBeepIfStringNotFound, SliderBeepIfSearchStringNotFound.SliderOn);
  AEditor.Search.SetOption(soEntireScope, SliderEntireScope.SliderOn);
  AEditor.Search.SetOption(soHighlightResults, SliderHighlightResult.SliderOn);
  AEditor.Search.SetOption(soSearchOnTyping, SliderSearchOnTyping.SliderOn);
  AEditor.Search.SetOption(soShowSearchMatchNotFound, SliderShowSearchMatchNotFound.SliderOn);
  AEditor.Search.SetOption(soShowStringNotFound, SliderShowSearchStringNotFound.SliderOn);
  AEditor.Search.SetOption(soWholeWordsOnly, SliderWholeWordsOnly.SliderOn);
  AEditor.Search.SetOption(soWrapAround, SliderWrapAround.SliderOn);
end;

end.

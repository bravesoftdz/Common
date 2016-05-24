unit BCCommon.Frame.Options.Editor.Font;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls,
  BCControl.ImageList, BCControl.Edit, BCControl.Panel,
  BCCommon.Frame.Options.Base, sComboBox,
  BCControl.ComboBox, sFontCtrls, BCEditor.JsonDataObjects, System.ImageList, Vcl.ImgList, acAlphaImageList, sEdit,
  Vcl.ExtCtrls, sPanel, sFrameAdapter;

type
  TOptionsEditorFontFrame = class(TBCOptionsBaseFrame)
    BookmarkImagesList: TBCImageList;
    ComboBoxColor: TBCComboBox;
    ComboBoxElement: TBCComboBox;
    EditFontSize: TBCEdit;
    FontComboBoxFont: TBCFontComboBox;
    Panel: TBCPanel;
    procedure ComboBoxElementChange(Sender: TObject);
    procedure ComboBoxColorChange(Sender: TObject);
    procedure EditFontSizeExit(Sender: TObject);
    procedure FontComboBoxFontChange(Sender: TObject);
  private
    FFileName: string;
    FJSONObject: TJsonObject;
    FModified: Boolean;
    function AskSaving: Boolean;
    procedure FreeJSONObject;
    procedure SaveFont(ADoChange: Boolean = True);
  protected
    procedure Init; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorFontFrame(AOwner: TComponent): TOptionsEditorFontFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.StringUtils, BCCommon.FileUtils, BCCommon.Messages, BCCommon.Language.Strings;

var
  FOptionsEditorFontFrame: TOptionsEditorFontFrame;

function OptionsEditorFontFrame(AOwner: TComponent): TOptionsEditorFontFrame;
begin
  if not Assigned(FOptionsEditorFontFrame) then
    FOptionsEditorFontFrame := TOptionsEditorFontFrame.Create(AOwner);
  Result := FOptionsEditorFontFrame;
end;

function TOptionsEditorFontFrame.AskSaving: Boolean;
begin
  Result := False;
  if IsOriginalColor(ComboBoxColor.Text) then
    if not AskYesOrNo(LanguageDataModule.GetYesOrNoMessage('ChangeColorFile')) then
    begin
      ComboBoxElementChange(nil);
      Exit;
    end;
  Result := True;
end;

procedure TOptionsEditorFontFrame.FontComboBoxFontChange(Sender: TObject);
begin
  inherited;
  if not AskSaving then
    Exit;

  FModified := True;
  FJSONObject['Colors']['Editor']['Fonts'][CapitalizeText(ComboBoxElement.Text)] := FontComboBoxFont.Text;
  SaveFont(False);
end;

procedure TOptionsEditorFontFrame.FreeJSONObject;
begin
  if Assigned(FJSONObject) then
  begin
    FJSONObject.Free;
    FJSONObject := nil;
  end;
end;

procedure TOptionsEditorFontFrame.SaveFont(ADoChange: Boolean = True);
begin
  if Assigned(FJSONObject) then
  begin
    JsonSerializationConfig.IndentChar := '    ';
    FFileName := GetColorSaveFileName(FFileName);
    FJSONObject.SaveToFile(FFileName, False);
    OptionsContainer.HighlighterColorStrings.Free;
    OptionsContainer.HighlighterColorStrings := GetHighlighterColors;
    FModified := False;
    FFileName := ChangeFileExt(ExtractFileName(FFileName), '');
    ComboBoxColor.Items := OptionsContainer.HighlighterColorStrings;
    ComboBoxColor.ItemIndex := ComboBoxColor.IndexOf(FFileName);
    if ADoChange then
      ComboBoxElementChange(Self);
  end;
end;

procedure TOptionsEditorFontFrame.ComboBoxColorChange(Sender: TObject);
var
  LFileName: string;
begin
  if FModified then
    SaveFont(False);

  FFileName := ComboBoxColor.Text;
  LFileName := GetColorLoadFileName(FFileName);

  FModified := False;
  FreeJSONObject;
  FJSONObject := TJsonObject.ParseFromFile(LFileName) as TJsonObject;

  ComboBoxElementChange(Self);
end;

procedure TOptionsEditorFontFrame.ComboBoxElementChange(Sender: TObject);
var
  LFont: string;
begin
  LFont := FJSONObject['Colors']['Editor']['Fonts'][CapitalizeText(ComboBoxElement.Text)];
  if LFont <> '' then
    FontComboBoxFont.ItemIndex := FontComboBoxFont.Items.IndexOf(LFont);
  EditFontSize.Text := FJSONObject['Colors']['Editor']['FontSizes'][CapitalizeText(ComboBoxElement.Text)];
end;

destructor TOptionsEditorFontFrame.Destroy;
begin
  FreeJSONObject;
  FOptionsEditorFontFrame := nil;
  inherited;
end;

procedure TOptionsEditorFontFrame.EditFontSizeExit(Sender: TObject);
begin
  inherited;
  if not AskSaving then
    Exit;

  FModified := True;
  FJSONObject['Colors']['Editor']['FontSizes'][CapitalizeText(ComboBoxElement.Text)] := EditFontSize.Text;
  SaveFont(False);
end;

procedure TOptionsEditorFontFrame.Init;
begin
  FModified := False;
  ComboBoxColor.Items := OptionsContainer.HighlighterColorStrings;
  ComboBoxColor.ItemIndex := ComboBoxColor.Items.IndexOf(OptionsContainer.DefaultColor);
  FFileName := ComboBoxColor.Text;
  ComboBoxColorChange(Self);
end;

end.

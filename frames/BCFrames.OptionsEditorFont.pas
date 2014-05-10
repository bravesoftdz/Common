unit BCFrames.OptionsEditorFont;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ActnList, BCControls.SynEdit, System.Actions, SynEdit, Vcl.ComCtrls, Vcl.ImgList,
  BCControls.ImageList, SynEditHighlighter, SynHighlighterURI, SynURIOpener, BCControls.Edit, BCCommon.OptionsContainer,
  BCFrames.OptionsFrame;

type
  TOptionsEditorFontFrame = class(TOptionsFrame)
    Panel: TPanel;
    FontDialog: TFontDialog;
    ActionList: TActionList;
    SelectEditorFontAction: TAction;
    TopPanel: TPanel;
    SelectEditorFontSpeedButton: TSpeedButton;
    EditorFontLabel: TLabel;
    BottomPanel: TPanel;
    SynEdit: TBCSynEdit;
    MarginFontLabel: TLabel;
    SelecMarginFontSpeedButton: TSpeedButton;
    EditorLabel: TLabel;
    MarginLabel: TLabel;
    SelectMarginFontAction: TAction;
    MinimapLabel: TLabel;
    SelecMinimapFontSpeedButton: TSpeedButton;
    MinimapFontLabel: TLabel;
    SelectMinimapFontAction: TAction;
    BookmarkImagesList: TBCImageList;
    SynURIOpener: TSynURIOpener;
    SynURISyn: TSynURISyn;
    MinimapWidthLabel: TLabel;
    MinimapWidthEdit: TBCEdit;
    ActiveLineColorBrightnessLabel: TLabel;
    BrightnessTrackBar: TTrackBar;
    procedure SelectEditorFontActionExecute(Sender: TObject);
    procedure SelectMarginFontActionExecute(Sender: TObject);
    procedure SelectMinimapFontActionExecute(Sender: TObject);
    procedure MinimapWidthEditChange(Sender: TObject);
    procedure BrightnessTrackBarChange(Sender: TObject);
  public
    { Public declarations }
    destructor Destroy; override;
    procedure Init; override;
    procedure GetData; override;
    procedure PutData; override;
  end;

function OptionsEditorFontFrame(AOwner: TComponent): TOptionsEditorFontFrame;

implementation

{$R *.dfm}

uses
  BCCommon.StyleUtils, BCCommon.LanguageUtils;

var
  FOptionsEditorFontFrame: TOptionsEditorFontFrame;

function OptionsEditorFontFrame(AOwner: TComponent): TOptionsEditorFontFrame;
begin
  if not Assigned(FOptionsEditorFontFrame) then
    FOptionsEditorFontFrame := TOptionsEditorFontFrame.Create(AOwner);
  Result := FOptionsEditorFontFrame;
end;

destructor TOptionsEditorFontFrame.Destroy;
begin
  inherited;
  FOptionsEditorFontFrame := nil;
end;

procedure TOptionsEditorFontFrame.Init;
begin
  UpdateMarginAndColors(SynEdit);
  OptionsContainer.AssignTo(SynEdit);
  SynEdit.ActiveLineColor := LightenColor(SynEdit.Color, 1 - (10 - OptionsContainer.ColorBrightness) / 10);
  SynEdit.Minimap.Visible := True;
end;

procedure TOptionsEditorFontFrame.MinimapWidthEditChange(Sender: TObject);
begin
  SynEdit.Minimap.Width := StrToInt(MinimapWidthEdit.Text);
end;

procedure TOptionsEditorFontFrame.SelectEditorFontActionExecute(Sender: TObject);
begin
  FontDialog.Font.Name := EditorFontLabel.Font.Name;
  FontDialog.Font.Size := EditorFontLabel.Font.Size;
  if FontDialog.Execute then
  begin
    EditorFontLabel.Font.Assign(FontDialog.Font);
    EditorFontLabel.Caption := Format('%s %dpt', [EditorFontLabel.Font.Name, EditorFontLabel.Font.Size]);
    SynEdit.Text := EditorFontLabel.Caption;
    SynEdit.Font.Assign(FontDialog.Font);
  end;
end;

procedure TOptionsEditorFontFrame.SelectMarginFontActionExecute(Sender: TObject);
begin
  FontDialog.Font.Name := MarginFontLabel.Font.Name;
  FontDialog.Font.Size := MarginFontLabel.Font.Size;
  if FontDialog.Execute then
  begin
    MarginFontLabel.Font.Assign(FontDialog.Font);
    MarginFontLabel.Caption := Format('%s %dpt', [MarginFontLabel.Font.Name, MarginFontLabel.Font.Size]);
    SynEdit.Gutter.Font.Assign(FontDialog.Font);
  end;
end;

procedure TOptionsEditorFontFrame.SelectMinimapFontActionExecute(Sender: TObject);
begin
  FontDialog.Font.Name := MinimapFontLabel.Font.Name;
  FontDialog.Font.Size := MinimapFontLabel.Font.Size;
  if FontDialog.Execute then
  begin
    MinimapFontLabel.Font.Assign(FontDialog.Font);
    MinimapFontLabel.Caption := Format('%s %dpt', [MinimapFontLabel.Font.Name, MinimapFontLabel.Font.Size]);
    SynEdit.Minimap.Font.Assign(FontDialog.Font);
    SynEdit.Invalidate;
  end;
end;

procedure TOptionsEditorFontFrame.PutData;
begin
  OptionsContainer.FontName := EditorFontLabel.Font.Name;
  OptionsContainer.FontSize := EditorFontLabel.Font.Size;
  OptionsContainer.MarginFontName := MarginFontLabel.Font.Name;
  OptionsContainer.MarginFontSize := MarginFontLabel.Font.Size;
  OptionsContainer.MinimapFontName := MinimapFontLabel.Font.Name;
  OptionsContainer.MinimapFontSize := MinimapFontLabel.Font.Size;
  OptionsContainer.MinimapWidth := StrToIntDef(MinimapWidthEdit.Text, 100);
  OptionsContainer.ColorBrightness := BrightnessTrackBar.Position;
end;

procedure TOptionsEditorFontFrame.BrightnessTrackBarChange(Sender: TObject);
begin
  SynEdit.ActiveLineColor := LightenColor(SynEdit.Color, 1 - (10 - BrightnessTrackBar.Position)/10);
end;

procedure TOptionsEditorFontFrame.GetData;
begin
  EditorFontLabel.Font.Name := OptionsContainer.FontName;
  EditorFontLabel.Font.Size := OptionsContainer.FontSize;
  EditorFontLabel.Caption := Format('%s %dpt', [EditorFontLabel.Font.Name, EditorFontLabel.Font.Size]);
  SynEdit.Text := EditorFontLabel.Caption;
  MarginFontLabel.Font.Name := OptionsContainer.MarginFontName;
  MarginFontLabel.Font.Size := OptionsContainer.MarginFontSize;
  MarginFontLabel.Caption := Format('%s %dpt', [MarginFontLabel.Font.Name, MarginFontLabel.Font.Size]);
  MinimapFontLabel.Font.Name := OptionsContainer.MinimapFontName;
  MinimapFontLabel.Font.Size := OptionsContainer.MinimapFontSize;
  MinimapFontLabel.Caption := Format('%s %dpt', [MinimapFontLabel.Font.Name, MinimapFontLabel.Font.Size]);
  MinimapWidthEdit.Text := IntToStr(OptionsContainer.MinimapWidth);
  BrightnessTrackBar.Position := OptionsContainer.ColorBrightness;
end;

end.

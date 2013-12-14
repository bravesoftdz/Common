unit BCFrames.OptionsEditorFont;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.StdCtrls, Vcl.ActnList, BCControls.SynEdit, System.Actions, SynEdit, Vcl.ComCtrls, Vcl.ImgList,
  BCControls.ImageList, SynEditHighlighter, SynHighlighterURI, SynURIOpener, BCControls.Edit, BCCommon.OptionsContainer;

type
  TEditorFontFrame = class(TFrame)
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
    procedure SelectEditorFontActionExecute(Sender: TObject);
    procedure SelectMarginFontActionExecute(Sender: TObject);
    procedure SelectMinimapFontActionExecute(Sender: TObject);
    procedure MinimapWidthEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetData(OptionsContainer: TOptionsContainer);
    procedure PutData(OptionsContainer: TOptionsContainer);
  end;

implementation

{$R *.dfm}

procedure TEditorFontFrame.MinimapWidthEditChange(Sender: TObject);
begin
  SynEdit.Minimap.Width := StrToInt(MinimapWidthEdit.Text);
end;

procedure TEditorFontFrame.SelectEditorFontActionExecute(Sender: TObject);
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

procedure TEditorFontFrame.SelectMarginFontActionExecute(Sender: TObject);
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

procedure TEditorFontFrame.SelectMinimapFontActionExecute(Sender: TObject);
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

procedure TEditorFontFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.FontName := EditorFontLabel.Font.Name;
  OptionsContainer.FontSize := EditorFontLabel.Font.Size;
  OptionsContainer.MarginFontName := MarginFontLabel.Font.Name;
  OptionsContainer.MarginFontSize := MarginFontLabel.Font.Size;
  OptionsContainer.MinimapFontName := MinimapFontLabel.Font.Name;
  OptionsContainer.MinimapFontSize := MinimapFontLabel.Font.Size;
  OptionsContainer.MinimapWidth := StrToIntDef(MinimapWidthEdit.Text, 100);
end;

procedure TEditorFontFrame.GetData(OptionsContainer: TOptionsContainer);
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
end;

end.

unit BCFrames.OptionsEditorLeftMargin;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCControls.Edit, Vcl.Buttons, JvEdit, BCCommon.OptionsContainer, BCFrames.OptionsFrame;

type

  TOptionsEditorLeftMarginFrame = class(TOptionsFrame)
    Panel: TPanel;
    VisibleCheckBox: TBCCheckBox;
    AutoSizeCheckBox: TBCCheckBox;
    WidthLabel: TLabel;
    LeftMarginWidthEdit: TBCEdit;
    ShowLineModifiedCheckBox: TBCCheckBox;
    LineModifiedColorBox: TColorBox;
    LineModifiedColorLabel: TLabel;
    LineNormalColorLabel: TLabel;
    LineNormalColorBox: TColorBox;
    InTensCheckBox: TBCCheckBox;
    ZeroStartCheckBox: TBCCheckBox;
    ShowBookmarkPanelCheckBox: TBCCheckBox;
    ShowBookmarksCheckBox: TBCCheckBox;
    ShowLineNumbersAfterLastLineCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure PutData; override;
  end;

function OptionsEditorLeftMarginFrame(AOwner: TComponent): TOptionsEditorLeftMarginFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils;

var
  FOptionsEditorLeftMarginFrame: TOptionsEditorLeftMarginFrame;

function OptionsEditorLeftMarginFrame(AOwner: TComponent): TOptionsEditorLeftMarginFrame;
begin
  if not Assigned(FOptionsEditorLeftMarginFrame) then
    FOptionsEditorLeftMarginFrame := TOptionsEditorLeftMarginFrame.Create(AOwner);
  Result := FOptionsEditorLeftMarginFrame;
end;

destructor TOptionsEditorLeftMarginFrame.Destroy;
begin
  inherited;
  FOptionsEditorLeftMarginFrame := nil;
end;

procedure TOptionsEditorLeftMarginFrame.PutData;
begin
  OptionsContainer.MarginVisibleLeftMargin := VisibleCheckBox.Checked;
  OptionsContainer.MarginLeftMarginAutoSize := AutoSizeCheckBox.Checked;
  OptionsContainer.MarginInTens := InTensCheckBox.Checked;
  OptionsContainer.MarginZeroStart := ZeroStartCheckBox.Checked;
  OptionsContainer.MarginShowBookmarks := ShowBookmarksCheckBox.Checked;
  OptionsContainer.MarginShowBookmarkPanel := ShowBookmarkPanelCheckBox.Checked;
  OptionsContainer.MarginLineModified := ShowLineModifiedCheckBox.Checked;
  OptionsContainer.MarginModifiedColor := ColorToString(LineModifiedColorBox.Selected);
  OptionsContainer.MarginNormalColor := ColorToString(LineNormalColorBox.Selected);
  OptionsContainer.MarginLeftMarginWidth := StrToIntDef(LeftMarginWidthEdit.Text, 30);
  OptionsContainer.MarginShowLineNumbersAfterLastLine := ShowLineNumbersAfterLastLineCheckBox.Checked;
end;

procedure TOptionsEditorLeftMarginFrame.GetData;
begin
  AutoSizeCheckBox.Checked := OptionsContainer.MarginLeftMarginAutoSize;
  VisibleCheckBox.Checked := OptionsContainer.MarginVisibleLeftMargin;
  InTensCheckBox.Checked := OptionsContainer.MarginInTens;
  ZeroStartCheckBox.Checked := OptionsContainer.MarginZeroStart;
  ShowBookmarksCheckBox.Checked := OptionsContainer.MarginShowBookmarks;
  ShowBookmarkPanelCheckBox.Checked := OptionsContainer.MarginShowBookmarkPanel;
  ShowLineModifiedCheckBox.Checked := OptionsContainer.MarginLineModified;
  LineModifiedColorBox.Selected := StringToColor(OptionsContainer.MarginModifiedColor);
  LineNormalColorBox.Selected := StringToColor(OptionsContainer.MarginNormalColor);
  LeftMarginWidthEdit.Text := IntToStr(OptionsContainer.MarginLeftMarginWidth);
  ShowLineNumbersAfterLastLineCheckBox.Checked := OptionsContainer.MarginShowLineNumbersAfterLastLine;
end;

end.

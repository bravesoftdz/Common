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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetData(OptionsContainer: TOptionsContainer); override;
    procedure PutData(OptionsContainer: TOptionsContainer); override;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils;

procedure TOptionsEditorLeftMarginFrame.PutData(OptionsContainer: TOptionsContainer);
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
end;

procedure TOptionsEditorLeftMarginFrame.GetData(OptionsContainer: TOptionsContainer);
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
end;

end.

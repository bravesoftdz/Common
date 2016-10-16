unit BCCommon.Frame.Options.Editor.Options;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  BCControl.Edit, BCCommon.Options.Container, BCCommon.Frame.Options.Base,
  BCControl.Panel, acSlider, sLabel, sEdit, Vcl.ExtCtrls, sPanel, sFrameAdapter;

type
  TOptionsEditorOptionsFrame = class(TBCOptionsBaseFrame)
    EditLineSpacing: TBCEdit;
    Panel: TBCPanel;
    StickyLabelAutoIndent: TsStickyLabel;
    SliderAutoIndent: TsSlider;
    SliderAutoSave: TsSlider;
    StickyLabelAutoSave: TsStickyLabel;
    StickyLabelDragDropEditing: TsStickyLabel;
    SliderDragDropEditing: TsSlider;
    SliderDropFiles: TsSlider;
    StickyLabelDropFiles: TsStickyLabel;
    StickyLabelGroupUndo: TsStickyLabel;
    SliderGroupUndo: TsSlider;
    StickyLabelTrimTrailingSpaces: TsStickyLabel;
    SliderTrimTrailingSpaces: TsSlider;
    StickyLabelUndoAfterSave: TsStickyLabel;
    SliderUndoAfterSave: TsSlider;
    EditClipboardHistoryItemsCount: TBCEdit;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorOptionsFrame(AOwner: TComponent): TOptionsEditorOptionsFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, BCCommon.Utils;

var
  FOptionsEditorOptionsFrame: TOptionsEditorOptionsFrame;

function OptionsEditorOptionsFrame(AOwner: TComponent): TOptionsEditorOptionsFrame;
begin
  if not Assigned(FOptionsEditorOptionsFrame) then
    FOptionsEditorOptionsFrame := TOptionsEditorOptionsFrame.Create(AOwner);
  Result := FOptionsEditorOptionsFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsEditorOptionsFrame.Destroy;
begin
  inherited;
  FOptionsEditorOptionsFrame := nil;
end;

procedure TOptionsEditorOptionsFrame.PutData;
begin
  with OptionsContainer do
  begin
    AutoIndent := SliderAutoIndent.SliderOn;
    AutoSave := SliderAutoSave.SliderOn;
    DragDropEditing := SliderDragDropEditing.SliderOn;
    DropFiles := SliderDropFiles.SliderOn;
    GroupUndo := SliderGroupUndo.SliderOn;
    TrimTrailingSpaces := SliderTrimTrailingSpaces.SliderOn;
    UndoAfterSave := SliderUndoAfterSave.SliderOn;
    LineSpacing := StrToIntDef(EditLineSpacing.Text, 1);
    ClipboardHistoryItemsCount := StrToIntDef(EditClipboardHistoryItemsCount.Text, 16);
  end;
end;

procedure TOptionsEditorOptionsFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderAutoIndent.SliderOn := AutoIndent;
    SliderAutoSave.SliderOn := AutoSave;
    SliderDragDropEditing.SliderOn := DragDropEditing;
    SliderDropFiles.SliderOn := DropFiles;
    SliderGroupUndo.SliderOn := GroupUndo;
    SliderTrimTrailingSpaces.SliderOn := TrimTrailingSpaces;
    SliderUndoAfterSave.SliderOn := UndoAfterSave;
    EditLineSpacing.Text := IntToStr(LineSpacing);
    EditClipboardHistoryItemsCount.Text := IntToStr(ClipboardHistoryItemsCount);
  end;
end;

end.

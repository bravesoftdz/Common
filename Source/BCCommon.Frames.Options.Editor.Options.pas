unit BCCommon.Frames.Options.Editor.Options;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  BCControls.CheckBox, BCControls.Edit, Vcl.ComCtrls, BCCommon.Options.Container, BCCommon.Frames.Options.Base,
  sEdit, sCheckBox, BCControls.Panel, sPanel, sFrameAdapter;

type
  TOptionsEditorOptionsFrame = class(TBCOptionsBaseFrame)
    CheckBoxAutoIndent: TBCCheckBox;
    CheckBoxAutoSave: TBCCheckBox;
    CheckBoxDragDropEditing: TBCCheckBox;
    CheckBoxDropFiles: TBCCheckBox;
    CheckBoxGroupUndo: TBCCheckBox;
    CheckBoxTrimTrailingSpaces: TBCCheckBox;
    CheckBoxUndoAfterSave: TBCCheckBox;
    EditLineSpacing: TBCEdit;
    Panel: TBCPanel;
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
  System.SysUtils, BCCommon.Language.Strings;

var
  FOptionsEditorOptionsFrame: TOptionsEditorOptionsFrame;

function OptionsEditorOptionsFrame(AOwner: TComponent): TOptionsEditorOptionsFrame;
begin
  if not Assigned(FOptionsEditorOptionsFrame) then
    FOptionsEditorOptionsFrame := TOptionsEditorOptionsFrame.Create(AOwner);
  Result := FOptionsEditorOptionsFrame;
end;

destructor TOptionsEditorOptionsFrame.Destroy;
begin
  inherited;
  FOptionsEditorOptionsFrame := nil;
end;

procedure TOptionsEditorOptionsFrame.PutData;
begin
  OptionsContainer.AutoIndent := CheckBoxAutoIndent.Checked;
  OptionsContainer.AutoSave := CheckBoxAutoSave.Checked;
  OptionsContainer.DragDropEditing := CheckBoxDragDropEditing.Checked;
  OptionsContainer.DropFiles := CheckBoxDropFiles.Checked;
  OptionsContainer.GroupUndo := CheckBoxGroupUndo.Checked;
  OptionsContainer.TrimTrailingSpaces := CheckBoxTrimTrailingSpaces.Checked;
  OptionsContainer.UndoAfterSave := CheckBoxUndoAfterSave.Checked;
  OptionsContainer.LineSpacing := StrToIntDef(EditLineSpacing.Text, 0);
end;

procedure TOptionsEditorOptionsFrame.GetData;
begin
  CheckBoxAutoIndent.Checked := OptionsContainer.AutoIndent;
  CheckBoxAutoSave.Checked := OptionsContainer.AutoSave;
  CheckBoxDragDropEditing.Checked := OptionsContainer.DragDropEditing;
  CheckBoxDropFiles.Checked := OptionsContainer.DropFiles;
  CheckBoxGroupUndo.Checked := OptionsContainer.GroupUndo;
  CheckBoxTrimTrailingSpaces.Checked := OptionsContainer.TrimTrailingSpaces;
  CheckBoxUndoAfterSave.Checked := OptionsContainer.UndoAfterSave;
  EditLineSpacing.Text := IntToStr(OptionsContainer.LineSpacing);
end;

end.

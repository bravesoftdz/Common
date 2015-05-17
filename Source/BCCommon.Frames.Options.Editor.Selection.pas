unit BCCommon.Frames.Options.Editor.Selection;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sCheckBox, BCControls.CheckBox, Vcl.ExtCtrls,
  sPanel, BCControls.Panel, BCCommon.Frames.Options.Base, sFrameAdapter;

type
  TOptionsEditorSelectionFrame = class(TBCOptionsBaseFrame)
    CheckBoxALTSetsColumnMode: TBCCheckBox;
    CheckBoxHighlightSimilarTerms: TBCCheckBox;
    CheckBoxTripleClickRowSelect: TBCCheckBox;
    CheckBoxVisible: TBCCheckBox;
    Panel: TBCPanel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorSelectionFrame(AOwner: TComponent): TOptionsEditorSelectionFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container;

var
  FOptionsEditorSelectionFrame: TOptionsEditorSelectionFrame;

function OptionsEditorSelectionFrame(AOwner: TComponent): TOptionsEditorSelectionFrame;
begin
  if not Assigned(FOptionsEditorSelectionFrame) then
    FOptionsEditorSelectionFrame := TOptionsEditorSelectionFrame.Create(AOwner);
  Result := FOptionsEditorSelectionFrame;
end;

destructor TOptionsEditorSelectionFrame.Destroy;
begin
  inherited;
  FOptionsEditorSelectionFrame := nil;
end;

procedure TOptionsEditorSelectionFrame.PutData;
begin
  OptionsContainer.SelectionVisible := CheckBoxVisible.Checked;
  OptionsContainer.ALTSetsColumnMode := CheckBoxALTSetsColumnMode.Checked;
  OptionsContainer.HighlightSimilarTerms := CheckBoxHighlightSimilarTerms.Checked;
  OptionsContainer.TripleClickRowSelect := CheckBoxTripleClickRowSelect.Checked;
end;

procedure TOptionsEditorSelectionFrame.GetData;
begin
  CheckBoxVisible.Checked := OptionsContainer.SelectionVisible;
  CheckBoxALTSetsColumnMode.Checked := OptionsContainer.ALTSetsColumnMode;
  CheckBoxHighlightSimilarTerms.Checked := OptionsContainer.HighlightSimilarTerms;
  CheckBoxTripleClickRowSelect.Checked := OptionsContainer.TripleClickRowSelect;
end;

end.

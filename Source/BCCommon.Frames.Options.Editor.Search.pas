unit BCCommon.Frames.Options.Editor.Search;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCCommon.Frames.Options.Base, sCheckBox, BCControls.Panel, sPanel, sFrameAdapter;

type
  TOptionsEditorSearchFrame = class(TBCOptionsBaseFrame)
    CheckBoxDocumentSpecificSearch: TBCCheckBox;
    CheckBoxHighlightResults: TBCCheckBox;
    CheckBoxShowSearchMap: TBCCheckBox;
    Panel: TBCPanel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorSearchFrame(AOwner: TComponent): TOptionsEditorSearchFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container;

var
  FOptionsEditorSearchFrame: TOptionsEditorSearchFrame;

function OptionsEditorSearchFrame(AOwner: TComponent): TOptionsEditorSearchFrame;
begin
  if not Assigned(FOptionsEditorSearchFrame) then
    FOptionsEditorSearchFrame := TOptionsEditorSearchFrame.Create(AOwner);
  Result := FOptionsEditorSearchFrame;
end;

destructor TOptionsEditorSearchFrame.Destroy;
begin
  inherited;
  FOptionsEditorSearchFrame := nil;
end;

procedure TOptionsEditorSearchFrame.PutData;
begin
  OptionsContainer.DocumentSpecificSearch := CheckBoxDocumentSpecificSearch.Checked;
  OptionsContainer.ShowSearchMap := CheckBoxShowSearchMap.Checked;
  OptionsContainer.ShowSearchHighlighter := CheckBoxHighlightResults.Checked;
end;

procedure TOptionsEditorSearchFrame.GetData;
begin
  CheckBoxDocumentSpecificSearch.Checked := OptionsContainer.DocumentSpecificSearch;
  CheckBoxShowSearchMap.Checked := OptionsContainer.ShowSearchMap;
  CheckBoxHighlightResults.Checked := OptionsContainer.ShowSearchHighlighter;
end;

end.

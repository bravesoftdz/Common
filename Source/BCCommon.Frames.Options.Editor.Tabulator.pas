unit BCCommon.Frames.Options.Editor.Tabulator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  sEdit, BCControls.Edit, sCheckBox, BCControls.CheckBox, Vcl.ExtCtrls, sPanel,
  BCControls.Panel, BCCommon.Frames.Options.Base, sFrameAdapter;

type
  TOptionsEditorTabulatorFrame = class(TBCOptionsBaseFrame)
    CheckBoxSelectedBlockIndent: TBCCheckBox;
    CheckBoxTabsToSpaces: TBCCheckBox;
    EditWidth: TBCEdit;
    Panel: TBCPanel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorTabulatorFrame(AOwner: TComponent): TOptionsEditorTabulatorFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container;

var
  FOptionsEditorTabulatorFrame: TOptionsEditorTabulatorFrame;

function OptionsEditorTabulatorFrame(AOwner: TComponent): TOptionsEditorTabulatorFrame;
begin
  if not Assigned(FOptionsEditorTabulatorFrame) then
    FOptionsEditorTabulatorFrame := TOptionsEditorTabulatorFrame.Create(AOwner);
  Result := FOptionsEditorTabulatorFrame;
end;

destructor TOptionsEditorTabulatorFrame.Destroy;
begin
  inherited;
  FOptionsEditorTabulatorFrame := nil;
end;

procedure TOptionsEditorTabulatorFrame.PutData;
begin
  OptionsContainer.SelectedBlockIndent := CheckBoxSelectedBlockIndent.Checked;
  OptionsContainer.TabsToSpaces := CheckBoxTabsToSpaces.Checked;
  OptionsContainer.TabWidth := StrToIntDef(EditWidth.Text, 2);
end;

procedure TOptionsEditorTabulatorFrame.GetData;
begin
  CheckBoxSelectedBlockIndent.Checked := OptionsContainer.SelectedBlockIndent;
  CheckBoxTabsToSpaces.Checked := OptionsContainer.TabsToSpaces;
  EditWidth.Text := IntToStr(OptionsContainer.LeftMarginWidth);
end;

end.

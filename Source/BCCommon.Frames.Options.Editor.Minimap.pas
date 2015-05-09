unit BCCommon.Frames.Options.Editor.Minimap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sEdit, BCControls.Edit, Vcl.ExtCtrls, sPanel,
  BCControls.Panel, sCheckBox, BCControls.CheckBox, BCCommon.Frames.Options.Base, sFrameAdapter;

type
  TOptionsEditorMinimapFrame = class(TBCOptionsBaseFrame)
    CheckBoxShowIndentGuides: TBCCheckBox;
    CheckBoxVisible: TBCCheckBox;
    EditWidth: TBCEdit;
    TopPanel: TBCPanel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorMinimapFrame(AOwner: TComponent): TOptionsEditorMinimapFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, BCCommon.Options.Container;

var
  FOptionsEditorMinimapFrame: TOptionsEditorMinimapFrame;

function OptionsEditorMinimapFrame(AOwner: TComponent): TOptionsEditorMinimapFrame;
begin
  if not Assigned(FOptionsEditorMinimapFrame) then
    FOptionsEditorMinimapFrame := TOptionsEditorMinimapFrame.Create(AOwner);
  Result := FOptionsEditorMinimapFrame;
end;

destructor TOptionsEditorMinimapFrame.Destroy;
begin
  inherited;
  FOptionsEditorMinimapFrame := nil;
end;

procedure TOptionsEditorMinimapFrame.PutData;
begin
  OptionsContainer.MinimapVisible := CheckBoxVisible.Checked;
  OptionsContainer.MinimapShowIndentGuides := CheckBoxShowIndentGuides.Checked;
  OptionsContainer.MinimapWidth := StrToIntDef(EditWidth.Text, 100);
end;

procedure TOptionsEditorMinimapFrame.GetData;
begin
  CheckBoxVisible.Checked := OptionsContainer.MinimapVisible;
  CheckBoxShowIndentGuides.Checked := OptionsContainer.MinimapShowIndentGuides;
  EditWidth.Text := IntToStr(OptionsContainer.MinimapWidth);
end;

end.

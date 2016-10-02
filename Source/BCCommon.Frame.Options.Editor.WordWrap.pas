unit BCCommon.Frame.Options.Editor.WordWrap;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Frame.Options.Base, sFrameAdapter, Vcl.StdCtrls, sComboBox,
  BCControl.ComboBox, Vcl.ExtCtrls, sPanel, BCControl.Panel;

type
  TOptionsEditorWordWrapFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    ComboBoxWidth: TBCComboBox;
  protected
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorWordWrapFrame(AOwner: TComponent): TOptionsEditorWordWrapFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Options.Container, BCCommon.Language.Strings;

var
  FOptionsEditorWordWrapFrame: TOptionsEditorWordWrapFrame;

function OptionsEditorWordWrapFrame(AOwner: TComponent): TOptionsEditorWordWrapFrame;
begin
  if not Assigned(FOptionsEditorWordWrapFrame) then
    FOptionsEditorWordWrapFrame := TOptionsEditorWordWrapFrame.Create(AOwner);
  Result := FOptionsEditorWordWrapFrame;
end;

destructor TOptionsEditorWordWrapFrame.Destroy;
begin
  inherited;
  FOptionsEditorWordWrapFrame := nil;
end;

procedure TOptionsEditorWordWrapFrame.Init;
begin
  with ComboBoxWidth.Items do
  begin
    Add(LanguageDatamodule.GetConstant('Page'));
    Add(LanguageDatamodule.GetConstant('RightMargin'));
  end;
end;

procedure TOptionsEditorWordWrapFrame.PutData;
begin
  OptionsContainer.WordWrapWidth := ComboBoxWidth.ItemIndex;
end;

procedure TOptionsEditorWordWrapFrame.GetData;
begin
  ComboBoxWidth.ItemIndex := OptionsContainer.WordWrapWidth;
end;

end.

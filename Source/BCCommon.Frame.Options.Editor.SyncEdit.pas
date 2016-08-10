unit BCCommon.Frame.Options.Editor.SyncEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, BCControl.Edit, BCControl.Panel, BCCommon.Frame.Options.Base, acSlider, sLabel, sEdit, Vcl.ExtCtrls,
  sPanel, sFrameAdapter, sComboBox, BCControl.ComboBox;

type
  TOptionsEditorSyncEditFrame = class(TBCOptionsBaseFrame)
    Panel: TBCPanel;
    StickyLabelEnabled: TsStickyLabel;
    SliderEnabled: TsSlider;
    StickyLabelShowActivateIcon: TsStickyLabel;
    SliderShowActivateIcon: TsSlider;
    SliderCaseSensitive: TsSlider;
    StickyLabelCaseSensitive: TsStickyLabel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsEditorSyncEditFrame(AOwner: TComponent): TOptionsEditorSyncEditFrame;

implementation

{$R *.dfm}

uses
  System.SysUtils, BCCommon.Options.Container, BCCommon.Utils;

var
  FOptionsEditorSyncEditFrame: TOptionsEditorSyncEditFrame;

function OptionsEditorSyncEditFrame(AOwner: TComponent): TOptionsEditorSyncEditFrame;
begin
  if not Assigned(FOptionsEditorSyncEditFrame) then
    FOptionsEditorSyncEditFrame := TOptionsEditorSyncEditFrame.Create(AOwner);
  Result := FOptionsEditorSyncEditFrame;
  AlignSliders(Result.Panel);
end;

destructor TOptionsEditorSyncEditFrame.Destroy;
begin
  inherited;
  FOptionsEditorSyncEditFrame := nil;
end;

procedure TOptionsEditorSyncEditFrame.PutData;
begin
  with OptionsContainer do
  begin
    SyncEditEnabled := SliderEnabled.SliderOn;
    SyncEditCaseSensitive := SliderCaseSensitive.SliderOn;
    SyncEditShowActivateIcon := SliderShowActivateIcon.SliderOn;
  end;
end;

procedure TOptionsEditorSyncEditFrame.GetData;
begin
  with OptionsContainer do
  begin
    SliderEnabled.SliderOn := SyncEditEnabled;
    SliderCaseSensitive.SliderOn := SyncEditCaseSensitive;
    SliderShowActivateIcon.SliderOn := SyncEditShowActivateIcon;
  end;
end;

end.

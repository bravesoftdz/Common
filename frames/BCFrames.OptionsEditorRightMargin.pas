unit BCFrames.OptionsEditorRightMargin;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCControls.Edit, Vcl.Buttons, JvEdit, BCCommon.OptionsContainer;

type
  TEditorRightMarginFrame = class(TFrame)
    Panel: TPanel;
    PositionLabel: TLabel;
    PositionEdit: TBCEdit;
    VisibleCheckBox: TBCCheckBox;
    MouseMoveCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetData(OptionsContainer: TOptionsContainer);
    procedure PutData(OptionsContainer: TOptionsContainer);
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils;

procedure TEditorRightMarginFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.MarginVisibleRightMargin := VisibleCheckBox.Checked;
  OptionsContainer.MarginRightMargin := StrToIntDef(PositionEdit.Text, 80);
  OptionsContainer.MarginLeftMarginMouseMove := MouseMoveCheckBox.Checked;
end;

procedure TEditorRightMarginFrame.GetData(OptionsContainer: TOptionsContainer);
begin
  VisibleCheckBox.Checked := OptionsContainer.MarginVisibleRightMargin;
  PositionEdit.Text := IntToStr(OptionsContainer.MarginRightMargin);
  MouseMoveCheckBox.Checked := OptionsContainer.MarginLeftMarginMouseMove;
end;

end.

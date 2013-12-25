unit BCFrames.OptionsEditorRightMargin;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCControls.Edit, Vcl.Buttons, JvEdit, BCCommon.OptionsContainer, BCFrames.OptionsFrame;

type
  TOptionsEditorRightMarginFrame = class(TOptionsFrame)
    Panel: TPanel;
    PositionLabel: TLabel;
    PositionEdit: TBCEdit;
    VisibleCheckBox: TBCCheckBox;
    MouseMoveCheckBox: TBCCheckBox;
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

procedure TOptionsEditorRightMarginFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.MarginVisibleRightMargin := VisibleCheckBox.Checked;
  OptionsContainer.MarginRightMargin := StrToIntDef(PositionEdit.Text, 80);
  OptionsContainer.MarginLeftMarginMouseMove := MouseMoveCheckBox.Checked;
end;

procedure TOptionsEditorRightMarginFrame.GetData(OptionsContainer: TOptionsContainer);
begin
  VisibleCheckBox.Checked := OptionsContainer.MarginVisibleRightMargin;
  PositionEdit.Text := IntToStr(OptionsContainer.MarginRightMargin);
  MouseMoveCheckBox.Checked := OptionsContainer.MarginLeftMarginMouseMove;
end;

end.

unit BCFrames.OptionsOutput;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.Edit,
  BCControls.CheckBox, Vcl.ExtCtrls, BCCommon.OptionsContainer;

type
  TOptionsOutputFrame = class(TFrame)
    Panel: TPanel;
    IndentLabel: TLabel;
    ShowTreeLinesCheckBox: TBCCheckBox;
    IndentEdit: TBCEdit;
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

procedure TOptionsOutputFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.OutputShowTreeLines := ShowTreeLinesCheckBox.Checked;
  OptionsContainer.OutputIndent := StrToIntDef(IndentEdit.Text, 16);
end;

procedure TOptionsOutputFrame.GetData(OptionsContainer: TOptionsContainer);
begin
  ShowTreeLinesCheckBox.Checked := OptionsContainer.OutputShowTreeLines;
  IndentEdit.Text := IntToStr(OptionsContainer.OutputIndent);
end;

end.

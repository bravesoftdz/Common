unit BCCommon.Frames.Options.SQL.Indentation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCCommon.Options.Container.SQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Frames.Options.Base, Vcl.StdCtrls, BCControls.Edit,
  BCControls.CheckBox, Vcl.ExtCtrls, sEdit, sCheckBox, BCControls.Panel, sPanel, sFrameAdapter;

type
  TOptionsSQLIndentationFrame = class(TBCOptionsBaseFrame)
    CheckBoxBlockOnNewLine: TBCCheckBox;
    CheckBoxUseTab: TBCCheckBox;
    EditBlockIndentSize: TBCEdit;
    EditBlockLeftIndentSize: TBCEdit;
    EditBlockRightIndentSize: TBCEdit;
    EditFunctionBodyIndent: TBCEdit;
    EditIndentLength: TBCEdit;
    EditSingleStatementIndent: TBCEdit;
    EditTabSize: TBCEdit;
    Panel: TBCPanel;
  protected
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsSQLIndentationFrame(AOwner: TComponent): TOptionsSQLIndentationFrame;

implementation

{$R *.dfm}

var
  FOptionsSQLIndentationFrame: TOptionsSQLIndentationFrame;

function OptionsSQLIndentationFrame(AOwner: TComponent): TOptionsSQLIndentationFrame;
begin
  if not Assigned(FOptionsSQLIndentationFrame) then
    FOptionsSQLIndentationFrame := TOptionsSQLIndentationFrame.Create(AOwner);
  Result := FOptionsSQLIndentationFrame;
end;

destructor TOptionsSQLIndentationFrame.Destroy;
begin
  inherited;
  FOptionsSQLIndentationFrame := nil;
end;

procedure TOptionsSQLIndentationFrame.GetData;
begin
  EditIndentLength.Text := IntToStr(SQLFormatterOptionsContainer.IndentationIndentLength);
  CheckBoxUseTab.Checked := SQLFormatterOptionsContainer.IndentationUseTab;
  EditTabSize.Text := IntToStr(SQLFormatterOptionsContainer.IndentationTabSize);
  EditFunctionBodyIndent.Text := IntToStr(SQLFormatterOptionsContainer.IndentationFunctionBodyIndent);
  CheckBoxBlockOnNewLine.Checked := SQLFormatterOptionsContainer.IndentationBlockLeftOnNewline;
  EditBlockLeftIndentSize.Text := IntToStr(SQLFormatterOptionsContainer.IndentationBlockLeftIndentSize);
  EditBlockRightIndentSize.Text := IntToStr(SQLFormatterOptionsContainer.IndentationBlockRightIndentSize);
  EditBlockIndentSize.Text := IntToStr(SQLFormatterOptionsContainer.IndentationBlockIndentSize);
  EditSingleStatementIndent.Text := IntToStr(SQLFormatterOptionsContainer.IndentationIfElseSingleStmtIndentSize);
end;

procedure TOptionsSQLIndentationFrame.PutData;
begin
  SQLFormatterOptionsContainer.IndentationIndentLength := StrToIntDef(EditIndentLength.Text, 2);
  SQLFormatterOptionsContainer.IndentationUseTab := CheckBoxUseTab.Checked;
  SQLFormatterOptionsContainer.IndentationTabSize := StrToIntDef(EditTabSize.Text, 2);
  SQLFormatterOptionsContainer.IndentationFunctionBodyIndent := StrToIntDef(EditFunctionBodyIndent.Text, 2);
  SQLFormatterOptionsContainer.IndentationBlockLeftOnNewline := CheckBoxBlockOnNewLine.Checked;
  SQLFormatterOptionsContainer.IndentationBlockLeftIndentSize := StrToIntDef(EditBlockLeftIndentSize.Text, 2);
  SQLFormatterOptionsContainer.IndentationBlockRightIndentSize := StrToIntDef(EditBlockRightIndentSize.Text, 2);
  SQLFormatterOptionsContainer.IndentationBlockIndentSize := StrToIntDef(EditBlockIndentSize.Text, 2);
  SQLFormatterOptionsContainer.IndentationIfElseSingleStmtIndentSize := StrToIntDef(EditSingleStatementIndent.Text, 2);
end;

end.

unit BCFrames.OptionsSQLIndentation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCFrames.OptionsFrame, Vcl.StdCtrls, BCControls.Edit,
  BCControls.CheckBox, Vcl.ExtCtrls;

type
  TOptionsSQLIndentationFrame = class(TOptionsFrame)
    Panel: TPanel;
    IndentLengthLabel: TLabel;
    TabSizeLabel: TLabel;
    FunctionBodyIndentLabel: TLabel;
    BlockLeftIndentSizeLabel: TLabel;
    BlockRightIndentSizeLabel: TLabel;
    UseTabCheckBox: TBCCheckBox;
    IndentLengthEdit: TBCEdit;
    TabSizeEdit: TBCEdit;
    FunctionBodyIndentEdit: TBCEdit;
    BlockOnNewLineCheckBox: TBCCheckBox;
    BlockLeftIndentSizeEdit: TBCEdit;
    BlockRightIndentSizeEdit: TBCEdit;
    BlockIndentSizeLabel: TLabel;
    BlockIndentSizeEdit: TBCEdit;
    SingleStatementIndentLabel: TLabel;
    SingleStatementIndentEdit: TBCEdit;
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure PutData; override;
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
  IndentLengthEdit.Text := IntToStr(SQLFormatterOptions.IndentationIndentLength);
  UseTabCheckBox.Checked := SQLFormatterOptions.IndentationUseTab;
  TabSizeEdit.Text := IntToStr(SQLFormatterOptions.IndentationTabSize);
  FunctionBodyIndentEdit.Text := IntToStr(SQLFormatterOptions.IndentationFunctionBodyIndent);
  BlockOnNewLineCheckBox.Checked := SQLFormatterOptions.IndentationBlockLeftOnNewline;
  BlockLeftIndentSizeEdit.Text := IntToStr(SQLFormatterOptions.IndentationBlockLeftIndentSize);
  BlockRightIndentSizeEdit.Text := IntToStr(SQLFormatterOptions.IndentationBlockRightIndentSize);
  BlockIndentSizeEdit.Text := IntToStr(SQLFormatterOptions.IndentationBlockIndentSize);
  SingleStatementIndentEdit.Text := IntToStr(SQLFormatterOptions.IndentationIfElseSingleStmtIndentSize);
end;

procedure TOptionsSQLIndentationFrame.PutData;
begin
  SQLFormatterOptions.IndentationIndentLength := StrToIntDef(IndentLengthEdit.Text, 2);
  SQLFormatterOptions.IndentationUseTab := UseTabCheckBox.Checked;
  SQLFormatterOptions.IndentationTabSize := StrToIntDef(TabSizeEdit.Text, 2);
  SQLFormatterOptions.IndentationFunctionBodyIndent := StrToIntDef(FunctionBodyIndentEdit.Text, 2);
  SQLFormatterOptions.IndentationBlockLeftOnNewline := BlockOnNewLineCheckBox.Checked;
  SQLFormatterOptions.IndentationBlockLeftIndentSize := StrToIntDef(BlockLeftIndentSizeEdit.Text, 2);
  SQLFormatterOptions.IndentationBlockRightIndentSize := StrToIntDef(BlockRightIndentSizeEdit.Text, 2);
  SQLFormatterOptions.IndentationBlockIndentSize := StrToIntDef(BlockIndentSizeEdit.Text, 2);
  SQLFormatterOptions.IndentationIfElseSingleStmtIndentSize := StrToIntDef(SingleStatementIndentEdit.Text, 2);
end;

end.

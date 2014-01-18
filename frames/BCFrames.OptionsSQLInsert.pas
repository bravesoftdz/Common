unit BCFrames.OptionsSQLInsert;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, BCSQL.Formatter,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCFrames.OptionsFrame, Vcl.StdCtrls, BCControls.ComboBox, BCControls.CheckBox,
  Vcl.ExtCtrls, BCControls.Edit;

type
  TOptionsSQLInsertFrame = class(TOptionsFrame)
    Panel: TPanel;
    ColumnListStyleLabel: TLabel;
    ParenthesisInSeparateLinesCheckBox: TBCCheckBox;
    ColumnListStyleComboBox: TBCComboBox;
    ValueListStyleLabel: TLabel;
    ValueListStyleComboBox: TBCComboBox;
    InsertColumnsPerLineEdit: TBCEdit;
    InsertColumnsPerLineLabel: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  end;

function OptionsSQLInsertFrame(AOwner: TComponent): TOptionsSQLInsertFrame;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

var
  FOptionsSQLInsertFrame: TOptionsSQLInsertFrame;

function OptionsSQLInsertFrame(AOwner: TComponent): TOptionsSQLInsertFrame;
begin
  if not Assigned(FOptionsSQLInsertFrame) then
    FOptionsSQLInsertFrame := TOptionsSQLInsertFrame.Create(AOwner);
  Result := FOptionsSQLInsertFrame;
end;

destructor TOptionsSQLInsertFrame.Destroy;
begin
  inherited;
  FOptionsSQLInsertFrame := nil;
end;

procedure TOptionsSQLInsertFrame.Init;
begin
  with ColumnListStyleComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with ValueListStyleComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
end;

procedure TOptionsSQLInsertFrame.GetData;
begin
  ColumnListStyleComboBox.ItemIndex := SQLFormatterOptions.InsertColumnListStyle;
  ValueListStyleComboBox.ItemIndex := SQLFormatterOptions.InsertValueListStyle;
  InsertColumnsPerLineEdit.Text := IntToStr(SQLFormatterOptions.InsertColumnsPerLine);
  ParenthesisInSeparateLinesCheckBox.Checked := SQLFormatterOptions.InsertParenthesisInSeparateLine;
end;

procedure TOptionsSQLInsertFrame.PutData;
begin
  SQLFormatterOptions.InsertColumnListStyle := ColumnListStyleComboBox.ItemIndex;
  SQLFormatterOptions.InsertValueListStyle := ValueListStyleComboBox.ItemIndex;
  SQLFormatterOptions.InsertColumnsPerLine := StrToIntDef(InsertColumnsPerLineEdit.Text, 0);
  SQLFormatterOptions.InsertParenthesisInSeparateLine := ParenthesisInSeparateLinesCheckBox.Checked;
end;


end.

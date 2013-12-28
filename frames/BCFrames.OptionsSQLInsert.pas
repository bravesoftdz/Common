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
  ColumnListStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.InsertColumnListStyle;
  ValueListStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.InsertValueListStyle;
  InsertColumnsPerLineEdit.Text := IntToStr(SQLFormatterOptionsWrapper.InsertColumnsPerLine);
  ParenthesisInSeparateLinesCheckBox.Checked := SQLFormatterOptionsWrapper.InsertParenthesisInSeparateLine;
end;

procedure TOptionsSQLInsertFrame.PutData;
begin
  SQLFormatterOptionsWrapper.InsertColumnListStyle := ColumnListStyleComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.InsertValueListStyle := ValueListStyleComboBox.ItemIndex;
  SQLFormatterOptionsWrapper.InsertColumnsPerLine := StrToInt(InsertColumnsPerLineEdit.Text);
  SQLFormatterOptionsWrapper.InsertParenthesisInSeparateLine := ParenthesisInSeparateLinesCheckBox.Checked;
end;


end.

unit BCCommon.Frames.Options.SQL.Insert;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, BCCommon.Options.Container.SQL.Formatter,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Frames.Options.Base, Vcl.StdCtrls, BCControls.ComboBox, BCControls.CheckBox,
  Vcl.ExtCtrls, BCControls.Edit, sEdit, sComboBox, sCheckBox, BCControls.Panel, sPanel, sFrameAdapter;

type
  TOptionsSQLInsertFrame = class(TBCOptionsBaseFrame)
    CheckBoxParenthesisInSeparateLines: TBCCheckBox;
    ComboBoxColumnListStyle: TBCComboBox;
    ComboBoxValueListStyle: TBCComboBox;
    EditInsertColumnsPerLine: TBCEdit;
    Panel: TBCPanel;
  protected
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsSQLInsertFrame(AOwner: TComponent): TOptionsSQLInsertFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Language.Strings;

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
  with ComboBoxColumnListStyle.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
  with ComboBoxValueListStyle.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
end;

procedure TOptionsSQLInsertFrame.GetData;
begin
  ComboBoxColumnListStyle.ItemIndex := SQLFormatterOptionsContainer.InsertColumnListStyle;
  ComboBoxValueListStyle.ItemIndex := SQLFormatterOptionsContainer.InsertValueListStyle;
  EditInsertColumnsPerLine.Text := IntToStr(SQLFormatterOptionsContainer.InsertColumnsPerLine);
  CheckBoxParenthesisInSeparateLines.Checked := SQLFormatterOptionsContainer.InsertParenthesisInSeparateLine;
end;

procedure TOptionsSQLInsertFrame.PutData;
begin
  SQLFormatterOptionsContainer.InsertColumnListStyle := ComboBoxColumnListStyle.ItemIndex;
  SQLFormatterOptionsContainer.InsertValueListStyle := ComboBoxValueListStyle.ItemIndex;
  SQLFormatterOptionsContainer.InsertColumnsPerLine := StrToIntDef(EditInsertColumnsPerLine.Text, 0);
  SQLFormatterOptionsContainer.InsertParenthesisInSeparateLine := CheckBoxParenthesisInSeparateLines.Checked;
end;


end.

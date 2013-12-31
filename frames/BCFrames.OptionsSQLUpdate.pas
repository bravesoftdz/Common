unit BCFrames.OptionsSQLUpdate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, BCSQL.Formatter,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCFrames.OptionsFrame, Vcl.StdCtrls, BCControls.ComboBox, Vcl.ExtCtrls;

type
  TOptionsSQLUpdateFrame = class(TOptionsFrame)
    Panel: TPanel;
    ColumnListStyleLabel: TLabel;
    ColumnListStyleComboBox: TBCComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  end;

function OptionsSQLUpdateFrame(AOwner: TComponent): TOptionsSQLUpdateFrame;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

var
  FOptionsSQLUpdateFrame: TOptionsSQLUpdateFrame;

function OptionsSQLUpdateFrame(AOwner: TComponent): TOptionsSQLUpdateFrame;
begin
  if not Assigned(FOptionsSQLUpdateFrame) then
    FOptionsSQLUpdateFrame := TOptionsSQLUpdateFrame.Create(AOwner);
  Result := FOptionsSQLUpdateFrame;
end;

destructor TOptionsSQLUpdateFrame.Destroy;
begin
  inherited;
  FOptionsSQLUpdateFrame := nil;
end;

procedure TOptionsSQLUpdateFrame.Init;
begin
  with ColumnListStyleComboBox.Items do
  begin
    Add(LanguageDatamodule.GetSQLFormatter('Stacked'));
    Add(LanguageDatamodule.GetSQLFormatter('Wrapped'));
  end;
end;

procedure TOptionsSQLUpdateFrame.GetData;
begin
  ColumnListStyleComboBox.ItemIndex := SQLFormatterOptionsWrapper.UpdateColumnListStyle;
end;

procedure TOptionsSQLUpdateFrame.PutData;
begin
  SQLFormatterOptionsWrapper.UpdateColumnListStyle := ColumnListStyleComboBox.ItemIndex;
end;

end.

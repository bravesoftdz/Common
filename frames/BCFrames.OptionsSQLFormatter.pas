unit BCFrames.OptionsSQLFormatter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, BCSQL.Formatter,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls,
  BCControls.ComboBox, BCFrames.OptionsFrame;

type
  TOptionsSQLFormatterFrame = class(TOptionsFrame)
    Panel: TPanel;
    VendorLabel: TLabel;
    SQLVendorComboBox: TBCComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure GetData; override;
    procedure Init; override;
    procedure PutData; override;
  end;

function OptionsSQLFormatterFrame(AOwner: TComponent): TOptionsSQLFormatterFrame;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

var
  FOptionsSQLFormatterFrame: TOptionsSQLFormatterFrame;

function OptionsSQLFormatterFrame(AOwner: TComponent): TOptionsSQLFormatterFrame;
begin
  if not Assigned(FOptionsSQLFormatterFrame) then
    FOptionsSQLFormatterFrame := TOptionsSQLFormatterFrame.Create(AOwner);
  Result := FOptionsSQLFormatterFrame;
end;

destructor TOptionsSQLFormatterFrame.Destroy;
begin
  inherited;
  FOptionsSQLFormatterFrame := nil;
end;

procedure TOptionsSQLFormatterFrame.Init;
begin
  { 0 = MSSql; 1 = Oracle; 2 = MySQL; 3 = Access; 4 = Generic; 5 = DB2; 6 = Sybase; 7 = Informix; 8 = PostgreSQL;
    9 = Firebird; 10 = Mdx }
  with SQLVendorComboBox.Items do
  begin
    Add('MSSQL');
    Add('Oracle');
    Add('MySQL');
    Add('MSAccess');
    Add('Generic');
    Add('DB2');
    Add('Sybase');
    Add('Informix');
    Add('PostgreSQL');
    Add('Firebird');
    Add('Mdx');
  end;
end;

procedure TOptionsSQLFormatterFrame.GetData;
begin
  SQLVendorComboBox.ItemIndex := SQLFormatterOptions.SQLVendor;
end;

procedure TOptionsSQLFormatterFrame.PutData;
begin
  SQLFormatterOptions.SQLVendor := SQLVendorComboBox.ItemIndex;
end;

end.

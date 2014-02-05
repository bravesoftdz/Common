unit BCForms.Convert;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  BCControls.ComboBox, BCControls.Edit, System.Actions, Vcl.ActnList;

type
  TConvertForm = class(TForm)
    ValueLabel: TLabel;
    ValueEdit: TBCEdit;
    ResultLabel: TLabel;
    ResultEdit: TBCEdit;
    TypeLabel: TLabel;
    TypeComboBox: TBCComboBox;
    FromLabel: TLabel;
    FromComboBox: TBCComboBox;
    ToLabel: TLabel;
    ToComboBox: TBCComboBox;
    ActionList: TActionList;
    ConvertAction: TAction;
    ResetAction: TAction;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ConvertActionExecute(Sender: TObject);
    procedure TypeComboBoxChange(Sender: TObject);
  private
    { Private declarations }
    function BinToHex(BinStr: string): string; overload;
    function HexToBin(HexStr: string): string; overload;
    procedure AddConvertFamilies;
    procedure AddConvertTypes; overload;
    procedure AddConvertTypes(ComboBox: TComboBox); overload;
    procedure ReadIniFile;
    procedure WriteIniFile;
    procedure DecToHex;
    procedure HexToDec;
    procedure DecToBin;
    procedure BinToDec;
    procedure HexToBin; overload;
    procedure BinToHex; overload;
    procedure SameSame;
  public
    { Public declarations }
    procedure Open;
  end;

function ConvertForm: TConvertForm;

implementation

{$R *.dfm}

uses
  System.IniFiles, BCCommon.FileUtils, System.ConvUtils, System.StdConvs, BCCommon.LanguageStrings,
  BCCommon.Messages, BCCommon.LanguageUtils, BCCommon.Math, BCCommon.Lib;

const
  DistanceItemIndex = 0;
  AreaItemIndex = 1;
  VolumeItemIndex = 2;
  MassItemIndex = 3;
  NumeralSystemItemIndex = 4;
  TempereatureItemIndex = 5;
  TimeItemIndex = 6;

var
  FConvertForm: TConvertForm;

function ConvertForm: TConvertForm;
begin
  if not Assigned(FConvertForm) then
    Application.CreateForm(TConvertForm, FConvertForm);
  Result := FConvertForm;
  UpdateLanguage(FConvertForm, GetSelectedLanguage);
end;

procedure TConvertForm.ConvertActionExecute(Sender: TObject);
begin
  if (TypeComboBox.ItemIndex = -1) or
     (FromComboBox.ItemIndex = -1) or
     (ToComboBox.ItemIndex = -1) or
     (ValueEdit.Text = '') then
  begin
    ResultEdit.Text := '';
    Exit;
  end;
  try
    if TypeComboBox.ItemIndex <> NumeralSystemItemIndex then
      ResultEdit.Text := FloatToStr(System.ConvUtils.Convert(StrToFloat(ValueEdit.Text),
        TConvType(FromComboBox.Items.Objects[FromComboBox.ItemIndex]),
        TConvType(ToComboBox.Items.Objects[ToComboBox.ItemIndex])))
    else
    begin
      case FromComboBox.ItemIndex of
        0: case ToComboBox.ItemIndex of
             0: SameSame;
             1: BinToDec;
             2: BinToHex;
           end;
        1: case ToComboBox.ItemIndex of
             0: DecToBin;
             1: SameSame;
             2: DecToHex;
           end;
        2: case ToComboBox.ItemIndex of
             0: HexToBin;
             1: HexToDec;
             2: SameSame;
           end;
      end;
    end;
  except
    ResultEdit.Text := '###';
  end;
end;

procedure TConvertForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteIniFile;
  Action := caFree;
end;

procedure TConvertForm.FormDestroy(Sender: TObject);
begin
  FConvertForm := nil;
end;

procedure TConvertForm.Open;
begin
  AddConvertFamilies;
  ReadIniFile;
  Show;
end;

procedure TConvertForm.AddConvertTypes;
begin
  AddConvertTypes(FromComboBox);
  AddConvertTypes(ToComboBox);
end;

procedure TConvertForm.TypeComboBoxChange(Sender: TObject);
begin
  AddConvertTypes;
  ValueEdit.Text := '';
  ResultEdit.Text := '';
end;

procedure TConvertForm.ReadIniFile;
begin
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Position }
    Left := ReadInteger('ConvertPosition', 'Left', (Screen.Width - Width) div 2);
    Top := ReadInteger('ConvertPosition', 'Top', (Screen.Height - Height) div 2);
    { Check if the form is outside the workarea }
    Left := SetFormInsideWorkArea(Left, Width);
    TypeComboBox.ItemIndex := ReadInteger('ConvertPosition', 'TypeItemIndex', -1);
    AddConvertTypes;
    FromComboBox.ItemIndex := ReadInteger('ConvertPosition', 'FromItemIndex', -1);
    ToComboBox.ItemIndex := ReadInteger('ConvertPosition', 'ToItemIndex', -1);
    ValueEdit.Text := ReadString('ConvertPosition', 'Value', '');
    ResultEdit.Text := ReadString('ConvertPosition', 'Result', '');
  finally
    Free;
  end;
end;

procedure TConvertForm.WriteIniFile;
begin
  if Windowstate = wsNormal then
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Position }
    WriteInteger('ConvertPosition', 'Left', Left);
    WriteInteger('ConvertPosition', 'Top', Top);
    WriteInteger('ConvertPosition', 'TypeItemIndex', TypeComboBox.ItemIndex);
    WriteInteger('ConvertPosition', 'FromItemIndex', FromComboBox.ItemIndex);
    WriteInteger('ConvertPosition', 'ToItemIndex', ToComboBox.ItemIndex);
    WriteString('ConvertPosition', 'Value', ValueEdit.Text);
    WriteString('ConvertPosition', 'Result', ResultEdit.Text);
  finally
    UpdateFile;
    Free;
  end;
end;

procedure TConvertForm.AddConvertFamilies;
begin
  with TypeComboBox.Items do
  begin
    Clear;
    Add(LanguageDataModule.GetConvertConstant('Distance'));
    Add(LanguageDataModule.GetConvertConstant('Area'));
    Add(LanguageDataModule.GetConvertConstant('Volume'));
    Add(LanguageDataModule.GetConvertConstant('Mass'));
    Add(LanguageDataModule.GetConvertConstant('NumeralSystem'));
    Add(LanguageDataModule.GetConvertConstant('Temperature'));
    Add(LanguageDataModule.GetConvertConstant('Time'));
  end;
end;

procedure TConvertForm.AddConvertTypes(ComboBox: TComboBox);
var
  i: Integer;
  LTypes: TConvTypeArray;
  ConvFamily: TConvFamily;
begin
  ConvFamily := 0;
  with ComboBox.Items do
  begin
    Clear;
    case TypeComboBox.ItemIndex of
      DistanceItemIndex: ConvFamily := cbDistance;
      AreaItemIndex: ConvFamily := cbArea;
      VolumeItemIndex: ConvFamily := cbVolume;
      MassItemIndex: ConvFamily := cbMass;
      NumeralSystemItemIndex:
        begin
          Add(LanguageDataModule.GetConvertConstant('Binary'));
          Add(LanguageDataModule.GetConvertConstant('Decimal'));
          Add(LanguageDataModule.GetConvertConstant('Hexadecimal'));
        end;
      TempereatureItemIndex: ConvFamily := cbTemperature;
      TimeItemIndex: ConvFamily := cbTime;
    end;

    if TypeComboBox.ItemIndex <> NumeralSystemItemIndex then
    begin
      GetConvTypes(ConvFamily, LTypes);
      for i := 0 to Length(LTypes) - 1 do
        AddObject(LanguageDataModule.GetConvertConstant(ConvTypeToDescription(LTypes[i])), TObject(LTypes[i]));
    end;
  end;
  ComboBox.DropDownCount := ComboBox.Items.Count;
end;

procedure TConvertForm.DecToHex;
begin
  ResultEdit.Text := IntToHex(StrToInt(ValueEdit.Text), 2);
end;

procedure TConvertForm.HexToDec;
begin
  ResultEdit.Text := IntToStr(StrToInt('$' + ValueEdit.Text));
end;

procedure TConvertForm.DecToBin;
begin
  ResultEdit.Text := IntToBin(StrToInt(ValueEdit.Text), Length(ValueEdit.Text) * 4);
end;

procedure TConvertForm.BinToDec;
begin
  ResultEdit.Text := IntToStr(BinToInt(ValueEdit.Text));
end;

function TConvertForm.HexToBin(HexStr: string): string;
const
  BinArray: array[0..15, 0..1] of string =
    (('0000', '0'), ('0001', '1'), ('0010', '2'), ('0011', '3'),
     ('0100', '4'), ('0101', '5'), ('0110', '6'), ('0111', '7'),
     ('1000', '8'), ('1001', '9'), ('1010', 'A'), ('1011', 'B'),
     ('1100', 'C'), ('1101', 'D'), ('1110', 'E'), ('1111', 'F'));
  HexAlpha: set of AnsiChar = ['0'..'9', 'A'..'F'];
var
  i, j: Integer;
begin
  Result := '';
  HexStr := AnsiUpperCase(HexStr);
  for i:= 1 to Length(HexStr) do
    if CharInSet(HexStr[i], HexAlpha) then
    begin
      for j := 1 to 16 do
        if HexStr[i] = BinArray[j - 1, 1] then
          Result := Result + BinArray[j - 1, 0];
    end
    else
    begin
      Result := '';
      ShowErrorMessage('This is not hexadecimal number.');
      Exit;
    end;
  if Result <> '' then
    while (Result[1] = '0') and (Length(Result) > 1) do
      Delete(Result, 1, 1);
end;

procedure TConvertForm.HexToBin;
begin
  ResultEdit.Text := HexToBin(ValueEdit.Text);
end;

function TConvertForm.BinToHex(BinStr: string): string;
const
  BinArray: array[0..15, 0..1] of string =
    (('0000', '0'), ('0001', '1'), ('0010', '2'), ('0011', '3'),
     ('0100', '4'), ('0101', '5'), ('0110', '6'), ('0111', '7'),
     ('1000', '8'), ('1001', '9'), ('1010', 'A'), ('1011', 'B'),
     ('1100', 'C'), ('1101', 'D'), ('1110', 'E'), ('1111', 'F'));
var
  j: Integer;
  BinPart: string;
begin
  Result := '';

  for j := 1 to Length(BinStr) do
    if not CharInSet(BinStr[j], ['0', '1']) then
    begin
      ShowErrorMessage('This is not binary number');
      Exit;
    end;

  case Length(BinStr) mod 4 of
    1: BinStr := '000'+BinStr;
    2: BinStr := '00'+BinStr;
    3: BinStr := '0'+BinStr;
  end;

  while Length(BinStr) > 0 do
  begin
    BinPart := Copy(BinStr, Length(BinStr) - 3, 4);
    Delete(BinStr, Length(BinStr) - 3, 4);
    for j := 1 to 16 do
      if BinPart = BinArray[j - 1, 0] then
        Result := BinArray[j - 1, 1] + Result;
  end;
end;

procedure TConvertForm.BinToHex;
begin
  ResultEdit.Text := BinToHex(ValueEdit.Text);
end;

procedure TConvertForm.SameSame;
begin
  ResultEdit.Text := ValueEdit.Text;
end;

end.

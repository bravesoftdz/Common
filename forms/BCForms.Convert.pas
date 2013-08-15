unit BCForms.Convert;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.ComboBox, Vcl.ExtCtrls, BCControls.Edit,
  System.Actions, Vcl.ActnList;

type
  TConvertForm = class(TForm)
    ValueLabel: TLabel;
    ValueEdit: TBCEdit;
    ResultLabel: TLabel;
    ResultEdit: TBCEdit;
    ButtonPanel: TPanel;
    ConvertButton: TButton;
    CancelButton: TButton;
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
    procedure ResetActionExecute(Sender: TObject);
  private
    { Private declarations }
    procedure AddConvertFamilies;
    procedure AddConvertTypes; overload;
    procedure AddConvertTypes(ComboBox: TComboBox); overload;
    procedure ReadIniFile;
    procedure WriteIniFile;
  public
    { Public declarations }
    procedure Open;
  end;

function ConvertForm: TConvertForm;

implementation

{$R *.dfm}

uses
  System.IniFiles, BCCommon.FileUtils, System.ConvUtils, System.StdConvs, BCCommon.LanguageStrings;

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
  if FConvertForm = nil then
    Application.CreateForm(TConvertForm, FConvertForm);
  Result := FConvertForm;
end;

procedure TConvertForm.ConvertActionExecute(Sender: TObject);
begin
  if (TypeComboBox.ItemIndex = -1) or (FromComboBox.ItemIndex = -1) or (ToComboBox.ItemIndex = -1) then
    Exit;
  try
    if TypeComboBox.ItemIndex <> NumeralSystemItemIndex then
      ResultEdit.Text := FloatToStr(System.ConvUtils.Convert(StrToFloat(ValueEdit.Text),
        TConvType(FromComboBox.Items.Objects[FromComboBox.ItemIndex]),
        TConvType(ToComboBox.Items.Objects[ToComboBox.ItemIndex])))
    else
    begin
      { binary decimal hexadecimal }
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

procedure TConvertForm.ResetActionExecute(Sender: TObject);
begin
  TypeComboBox.ItemIndex := -1;
  TypeComboBoxChange(nil);
  ValueEdit.Text := '';
  ResultEdit.Text := '';
end;

procedure TConvertForm.AddConvertTypes;
begin
  AddConvertTypes(FromComboBox);
  AddConvertTypes(ToComboBox);
end;

procedure TConvertForm.TypeComboBoxChange(Sender: TObject);
begin
  AddConvertTypes;
end;

procedure TConvertForm.ReadIniFile;
begin
  with TMemIniFile.Create(GetINIFilename) do
  try
    { Position }
    Left := ReadInteger('ConvertPosition', 'Left', (Screen.Width - Width) div 2);
    Top := ReadInteger('ConvertPosition', 'Top', (Screen.Height - Height) div 2);
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
  with TMemIniFile.Create(GetINIFilename) do
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

end.

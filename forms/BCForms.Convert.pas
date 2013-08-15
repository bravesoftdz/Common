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
    ButtonDividerPanel: TPanel;
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
    procedure AddConvertTypes(ComboBox: TComboBox);
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
  try
    ResultEdit.Text := FormatFloat('#,0.00', System.ConvUtils.Convert(StrToFloat(ValueEdit.Text),
      TConvType(FromComboBox.Items.Objects[FromComboBox.ItemIndex]),
      TConvType(ToComboBox.Items.Objects[ToComboBox.ItemIndex])));
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

procedure TConvertForm.ReadIniFile;
begin
  with TMemIniFile.Create(GetINIFilename) do
  try
    { Position }
    Left := ReadInteger('ConvertPosition', 'Left', (Screen.Width - Width) div 2);
    Top := ReadInteger('ConvertPosition', 'Top', (Screen.Height - Height) div 2);
  finally
    Free;
  end;
end;

procedure TConvertForm.ResetActionExecute(Sender: TObject);
begin
  TypeComboBox.ItemIndex := -1;
  TypeComboBoxChange(nil);
  ValueEdit.Text := '';
  ResultEdit.Text := '';
end;

procedure TConvertForm.TypeComboBoxChange(Sender: TObject);
begin
  AddConvertTypes(FromComboBox);
  AddConvertTypes(ToComboBox);
end;

procedure TConvertForm.WriteIniFile;
begin
  if Windowstate = wsNormal then
  with TMemIniFile.Create(GetINIFilename) do
  try
    { Position }
    WriteInteger('ConvertPosition', 'Left', Left);
    WriteInteger('ConvertPosition', 'Top', Top);
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
begin
  with ComboBox.Items do
  begin
    Clear;
    {}
    case TypeComboBox.ItemIndex of
    DistanceItemIndex:
      begin
        AddObject(LanguageDataModule.GetConvertConstant('Micromicrons'), TObject(duMicromicrons));
        AddObject(LanguageDataModule.GetConvertConstant('Angstroms'), TObject(duAngstroms));
        AddObject(LanguageDataModule.GetConvertConstant('Millimicrons'), TObject(duMillimicrons));
        AddObject(LanguageDataModule.GetConvertConstant('Microns'), TObject(duMicrons));
        AddObject(LanguageDataModule.GetConvertConstant('Millimeters'), TObject(duMillimeters));
         {
          duCentimeters: TConvType;
          duDecimeters: TConvType;
          duMeters: TConvType;
          duDecameters: TConvType;
          duHectometers: TConvType;
          duKilometers: TConvType;
          duMegameters: TConvType;
          duGigameters: TConvType;
          duInches: TConvType;
          duFeet: TConvType;
          duYards: TConvType;
          duMiles: TConvType;
          duNauticalMiles: TConvType;
          duAstronomicalUnits: TConvType;
          duLightYears: TConvType;
          duParsecs: TConvType;
          duCubits: TConvType;
          duFathoms: TConvType;
          duFurlongs: TConvType;
          duHands: TConvType;
          duPaces: TConvType;
          duRods: TConvType;
          duChains: TConvType;
          duLinks: TConvType;
          duPicas: TConvType;
          duPoints: TConvType; }
        end;
      AreaItemIndex: ;
        begin
          {auSquareMillimeters: TConvType;
  auSquareCentimeters: TConvType;
  auSquareDecimeters: TConvType;
  auSquareMeters: TConvType;
  auSquareDecameters: TConvType;
  auSquareHectometers: TConvType;
  auSquareKilometers: TConvType;
  auSquareInches: TConvType;
  auSquareFeet: TConvType;
  auSquareYards: TConvType;
  auSquareMiles: TConvType;
  auAcres: TConvType;
  auCentares: TConvType;
  auAres: TConvType;
  auHectares: TConvType;
  auSquareRods: TConvType;}
        end;
      VolumeItemIndex:
        begin
          (*vuCubicMillimeters: TConvType;
  vuCubicCentimeters: TConvType;
  vuCubicDecimeters: TConvType;
  vuCubicMeters: TConvType;
  vuCubicDecameters: TConvType;
  vuCubicHectometers: TConvType;
  vuCubicKilometers: TConvType;
  vuCubicInches: TConvType;
  vuCubicFeet: TConvType;
  vuCubicYards: TConvType;
  vuCubicMiles: TConvType;
  vuMilliLiters: TConvType;
  vuCentiLiters: TConvType;
  vuDeciLiters: TConvType;
  vuLiters: TConvType;
  vuDecaLiters: TConvType;
  vuHectoLiters: TConvType;
  vuKiloLiters: TConvType;
  vuAcreFeet: TConvType;
  vuAcreInches: TConvType;
  vuCords: TConvType;
  vuCordFeet: TConvType;
  vuDecisteres: TConvType;
  vuSteres: TConvType;
  vuDecasteres: TConvType;

  vuFluidGallons: TConvType; { American Fluid Units }
  vuFluidQuarts: TConvType;
  vuFluidPints: TConvType;
  vuFluidCups: TConvType;
  vuFluidGills: TConvType;
  vuFluidOunces: TConvType;
  vuFluidTablespoons: TConvType;
  vuFluidTeaspoons: TConvType;

  vuDryGallons: TConvType; { American Dry Units }
  vuDryQuarts: TConvType;
  vuDryPints: TConvType;
  vuDryPecks: TConvType;
  vuDryBuckets: TConvType;
  vuDryBushels: TConvType;

  vuUKGallons: TConvType; { English Imperial Fluid/Dry Units }
  vuUKPottles: TConvType;
  vuUKQuarts: TConvType;
  vuUKPints: TConvType;
  vuUKGills: TConvType;
  vuUKOunces: TConvType;
  vuUKPecks: TConvType;
  vuUKBuckets: TConvType;
  vuUKBushels: TConvType;*)
        end;
      MassItemIndex:
        begin
          {muNanograms: TConvType;
  muMicrograms: TConvType;
  muMilligrams: TConvType;
  muCentigrams: TConvType;
  muDecigrams: TConvType;
  muGrams: TConvType;
  muDecagrams: TConvType;
  muHectograms: TConvType;
  muKilograms: TConvType;
  muMetricTons: TConvType;
  muDrams: TConvType; // Avoirdupois Units
  muGrains: TConvType;
  muLongTons: TConvType;
  muTons: TConvType;
  muOunces: TConvType;
  muPounds: TConvType;
  muStones: TConvType;}
        end;
      NumeralSystemItemIndex:
        begin

        end;
      TempereatureItemIndex:
        begin
          {tuCelsius: TConvType;
  tuKelvin: TConvType;
  tuFahrenheit: TConvType;
  tuRankine: TConvType;
  tuReaumur: TConvType;}
        end;
      TimeItemIndex:
        begin
          {tuMilliSeconds: TConvType;
  tuSeconds: TConvType;
  tuMinutes: TConvType;
  tuHours: TConvType;
  tuDays: TConvType;
  tuWeeks: TConvType;
  tuFortnights: TConvType;
  tuMonths: TConvType;
  tuYears: TConvType;
  tuDecades: TConvType;
  tuCenturies: TConvType;
  tuMillennia: TConvType;
  tuDateTime: TConvType;
  tuJulianDate: TConvType;
  tuModifiedJulianDate: TConvType; }
        end;
    end;
  end;
end;

{procedure SetConvertTypes(ComboBox TBCComboBox);
begin
  if ConvertType = ctDistance then

  duMicromicrons: TConvType;
  duAngstroms: TConvType;
  duMillimicrons: TConvType;
  duMicrons: TConvType;
  duMillimeters: TConvType;
  duCentimeters: TConvType;
  duDecimeters: TConvType;
  duMeters: TConvType;
  duDecameters: TConvType;
  duHectometers: TConvType;
  duKilometers: TConvType;
  duMegameters: TConvType;
  duGigameters: TConvType;
  duInches: TConvType;
  duFeet: TConvType;
  duYards: TConvType;
  duMiles: TConvType;
  duNauticalMiles: TConvType;
  duAstronomicalUnits: TConvType;
  duLightYears: TConvType;
  duParsecs: TConvType;
  duCubits: TConvType;
  duFathoms: TConvType;
  duFurlongs: TConvType;
  duHands: TConvType;
  duPaces: TConvType;
  duRods: TConvType;
  duChains: TConvType;
  duLinks: TConvType;
  duPicas: TConvType;
  duPoints: TConvType;
end; }

end.

unit BCFrames.OptionsPrint;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.ComboBox, Vcl.ExtCtrls,
  BCControls.CheckBox, BCCommon.OptionsContainer, BCFrames.OptionsFrame;

type
  TOptionsPrintFrame = class(TOptionsFrame)
    Panel: TPanel;
    DateTimeLabel: TLabel;
    PrintedByLabel: TLabel;
    DocumentNameLabel: TLabel;
    PageNumberLabel: TLabel;
    DateTimeComboBox: TBCComboBox;
    PrintedByComboBox: TBCComboBox;
    DocumentNameComboBox: TBCComboBox;
    PageNumberComboBox: TBCComboBox;
    ShowHeaderLineCheckBox: TBCCheckBox;
    ShowFooterLineCheckBox: TBCCheckBox;
    ShowLineNumbersCheckBox: TBCCheckBox;
    WordWrapCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
    procedure Init; override;
    procedure GetData; override;
    procedure PutData; override;
  end;

function OptionsPrintFrame(AOwner: TComponent): TOptionsPrintFrame;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

var
  FOptionsPrintFrame: TOptionsPrintFrame;

function OptionsPrintFrame(AOwner: TComponent): TOptionsPrintFrame;
begin
  if not Assigned(FOptionsPrintFrame) then
    FOptionsPrintFrame := TOptionsPrintFrame.Create(AOwner);
  Result := FOptionsPrintFrame;
end;

destructor TOptionsPrintFrame.Destroy;
begin
  inherited;
  FOptionsPrintFrame := nil;
end;

procedure TOptionsPrintFrame.Init;
begin
  with DocumentNameComboBox.Items do
  begin
    Add(LanguageDatamodule.GetConstant('FooterLeft'));
    Add(LanguageDatamodule.GetConstant('FooterRight'));
    Add(LanguageDatamodule.GetConstant('HeaderLeft'));
    Add(LanguageDatamodule.GetConstant('HeaderRight'));
    Add(LanguageDatamodule.GetConstant('Hide'));
  end;
  PageNumberComboBox.Items.Text := DocumentNameComboBox.Items.Text;
  PrintedByComboBox.Items.Text := DocumentNameComboBox.Items.Text;
  DateTimeComboBox.Items.Text := DocumentNameComboBox.Items.Text;
end;

procedure TOptionsPrintFrame.PutData;
begin
  OptionsContainer.PrintDocumentName := DocumentNameComboBox.ItemIndex;
  OptionsContainer.PrintPageNumber := PageNumberComboBox.ItemIndex;
  OptionsContainer.PrintPrintedBy := PrintedByComboBox.ItemIndex;
  OptionsContainer.PrintDateTime := DateTimeComboBox.ItemIndex;
  OptionsContainer.PrintShowHeaderLine := ShowHeaderLineCheckBox.Checked;
  OptionsContainer.PrintShowFooterLine := ShowFooterLineCheckBox.Checked;
  OptionsContainer.PrintShowLineNumbers := ShowLineNumbersCheckBox.Checked;
  OptionsContainer.PrintWordWrapLine := WordWrapCheckBox.Checked;
end;

procedure TOptionsPrintFrame.GetData;
begin
  DocumentNameComboBox.ItemIndex := OptionsContainer.PrintDocumentName;
  PageNumberComboBox.ItemIndex := OptionsContainer.PrintPageNumber;
  PrintedByComboBox.ItemIndex := OptionsContainer.PrintPrintedBy;
  DateTimeComboBox.ItemIndex := OptionsContainer.PrintDateTime;
  ShowHeaderLineCheckBox.Checked := OptionsContainer.PrintShowHeaderLine;
  ShowFooterLineCheckBox.Checked := OptionsContainer.PrintShowFooterLine;
  ShowLineNumbersCheckBox.Checked := OptionsContainer.PrintShowLineNumbers;
  WordWrapCheckBox.Checked := OptionsContainer.PrintWordWrapLine;
end;

end.

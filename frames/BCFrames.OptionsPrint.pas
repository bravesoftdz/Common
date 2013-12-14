unit BCFrames.OptionsPrint;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.ComboBox, Vcl.ExtCtrls,
  BCControls.CheckBox, BCCommon.OptionsContainer;

type
  TOptionsPrintFrame = class(TFrame)
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
    constructor Create(AOwner: TComponent); override;
    procedure PutData(OptionsContainer: TOptionsContainer);
  end;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageStrings;

constructor TOptionsPrintFrame.Create(AOwner: TComponent);
begin
  inherited;
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

procedure TOptionsPrintFrame.PutData(OptionsContainer: TOptionsContainer);
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

end.

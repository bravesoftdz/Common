unit BCCommon.Frames.Options.Print;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.ComboBox, Vcl.ExtCtrls,
  BCControls.CheckBox, BCCommon.Options.Container, BCCommon.Frames.Options.Base, sCheckBox,
  sComboBox, BCControls.Panel, sPanel, sFrameAdapter;

type
  TOptionsPrintFrame = class(TBCOptionsBaseFrame)
    CheckBoxShowFooterLine: TBCCheckBox;
    CheckBoxShowHeaderLine: TBCCheckBox;
    CheckBoxShowLineNumbers: TBCCheckBox;
    CheckBoxWordWrap: TBCCheckBox;
    ComboBoxDateTime: TBCComboBox;
    ComboBoxDocumentName: TBCComboBox;
    ComboBoxPageNumber: TBCComboBox;
    ComboBoxPrintedBy: TBCComboBox;
    Panel: TBCPanel;
  protected
    procedure Init; override;
    procedure GetData; override;
    procedure PutData; override;
  public
    destructor Destroy; override;
  end;

function OptionsPrintFrame(AOwner: TComponent): TOptionsPrintFrame;

implementation

{$R *.dfm}

uses
  BCCommon.Language.Strings;

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
  with ComboBoxDocumentName.Items do
  begin
    Add(LanguageDatamodule.GetConstant('FooterLeft'));
    Add(LanguageDatamodule.GetConstant('FooterRight'));
    Add(LanguageDatamodule.GetConstant('HeaderLeft'));
    Add(LanguageDatamodule.GetConstant('HeaderRight'));
    Add(LanguageDatamodule.GetConstant('Hide'));
  end;
  ComboBoxPageNumber.Items.Text := ComboBoxDocumentName.Items.Text;
  ComboBoxPrintedBy.Items.Text := ComboBoxDocumentName.Items.Text;
  ComboBoxDateTime.Items.Text := ComboBoxDocumentName.Items.Text;
end;

procedure TOptionsPrintFrame.PutData;
begin
  OptionsContainer.PrintDocumentName := ComboBoxDocumentName.ItemIndex;
  OptionsContainer.PrintPageNumber := ComboBoxPageNumber.ItemIndex;
  OptionsContainer.PrintPrintedBy := ComboBoxPrintedBy.ItemIndex;
  OptionsContainer.PrintDateTime := ComboBoxDateTime.ItemIndex;
  OptionsContainer.PrintShowHeaderLine := CheckBoxShowHeaderLine.Checked;
  OptionsContainer.PrintShowFooterLine := CheckBoxShowFooterLine.Checked;
  OptionsContainer.PrintShowLineNumbers := CheckBoxShowLineNumbers.Checked;
  OptionsContainer.PrintWordWrapLine := CheckBoxWordWrap.Checked;
end;

procedure TOptionsPrintFrame.GetData;
begin
  ComboBoxDocumentName.ItemIndex := OptionsContainer.PrintDocumentName;
  ComboBoxPageNumber.ItemIndex := OptionsContainer.PrintPageNumber;
  ComboBoxPrintedBy.ItemIndex := OptionsContainer.PrintPrintedBy;
  ComboBoxDateTime.ItemIndex := OptionsContainer.PrintDateTime;
  CheckBoxShowHeaderLine.Checked := OptionsContainer.PrintShowHeaderLine;
  CheckBoxShowFooterLine.Checked := OptionsContainer.PrintShowFooterLine;
  CheckBoxShowLineNumbers.Checked := OptionsContainer.PrintShowLineNumbers;
  CheckBoxWordWrap.Checked := OptionsContainer.PrintWordWrapLine;
end;

end.

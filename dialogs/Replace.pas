unit Replace;

{$I SynEdit.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Dlg, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, JvExStdCtrls, JvCombobox, BCComboBox;

type
  TReplaceDialog = class(TDialog)
    Panel1: TPanel;
    CancelButton: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    SearchForLabel: TLabel;
    Panel5: TPanel;
    ReplaceWithLabel: TLabel;
    Panel4: TPanel;
    Panel6: TPanel;
    SearchForComboBox: TBCComboBox;
    Panel7: TPanel;
    ReplaceWithComboBox: TBCComboBox;
    Panel8: TPanel;
    OptionsGroupBox: TGroupBox;
    CaseSensitiveCheckBox: TCheckBox;
    WholeWordsCheckBox: TCheckBox;
    Panel9: TPanel;
    ReplaceInRadioGroup: TRadioGroup;
    Panel10: TPanel;
    FindButton: TButton;
    Panel11: TPanel;
    ReplaceAllButton: TButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure SearchForComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function GetReplaceText: string;
    function GetSearchCaseSensitive: Boolean;
    function GetSearchText: string;
    function GetSearchWholeWords: Boolean;
    function GetReplaceInWholeFile: Boolean;
  public
    property SearchCaseSensitive: Boolean read GetSearchCaseSensitive;
    property SearchWholeWords: Boolean read GetSearchWholeWords;
    property SearchText: string read GetSearchText;
    property ReplaceText: string read GetReplaceText;
    property ReplaceInWholeFile: Boolean read GetReplaceInWholeFile;
  end;

function ReplaceDialog: TReplaceDialog;

implementation

{$R *.DFM}

uses
  Common, Lib, Vcl.Themes;

var
  FReplaceDialog: TReplaceDialog;

function ReplaceDialog: TReplaceDialog;
begin
  if FReplaceDialog = nil then
    Application.CreateForm(TReplaceDialog, FReplaceDialog);
  Result := FReplaceDialog;
  Common.SetStyledFormSize(Result);
end;

procedure TReplaceDialog.FormDestroy(Sender: TObject);
begin
  FReplaceDialog := nil;
end;

function TReplaceDialog.GetReplaceText: string;
begin
  Result := ReplaceWithComboBox.Text;
end;

function TReplaceDialog.GetSearchCaseSensitive: Boolean;
begin
  Result := CaseSensitiveCheckBox.Checked;
end;

function TReplaceDialog.GetSearchText: string;
begin
  Result := SearchForComboBox.Text;
end;

function TReplaceDialog.GetSearchWholeWords: Boolean;
begin
  Result := WholeWordsCheckBox.Checked;
end;

procedure TReplaceDialog.SearchForComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FindButton.Enabled := (Trim(SearchForComboBox.Text) <> '');
  ReplaceAllButton.Enabled := FindButton.Enabled;
end;

function TReplaceDialog.GetReplaceInWholeFile: Boolean;
begin
  Result := ReplaceInRadioGroup.ItemIndex = 0;
end;

procedure TReplaceDialog.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if ModalResult = mrOK then
  begin
    Common.InsertTextToCombo(SearchForComboBox);
    Common.InsertTextToCombo(ReplaceWithComboBox);
  end;
end;

end.

 
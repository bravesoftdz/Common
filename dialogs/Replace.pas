unit Replace;

{$I SynEdit.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, JvExStdCtrls, JvCombobox, BCComboBox;

type
  TReplaceDialog = class(TForm)
    ReplaceWithLabel: TLabel;
    ReplaceWithComboBox: TBCComboBox;
    SearchForLabel: TLabel;
    SearchForComboBox: TBCComboBox;
    OptionsGroupBox: TGroupBox;
    CaseSensitiveCheckBox: TCheckBox;
    WholeWordsCheckBox: TCheckBox;
    ReplaceInRadioGroup: TRadioGroup;
    Panel1: TPanel;
    FindButton: TButton;
    ReplaceAllButton: TButton;
    CancelButton: TButton;
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
  Result.Width := 404;
  Result.Height := 165;
  if Assigned(TStyleManager.ActiveStyle) then
    if TStyleManager.ActiveStyle.Name <> 'Windows' then
    begin
      Result.Width := Result.Width + 6;
      Result.Height := Result.Height + 8
    end;
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

 
unit Replace;

{$I SynEdit.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Dlg, Vcl.ExtCtrls, JvExStdCtrls, JvCombobox, BCComboBox, Vcl.StdCtrls;

type
  TReplaceDialog = class(TDialog)
    RightPanel: TPanel;
    CancelButton: TButton;
    LeftPanel: TPanel;
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
    procedure FormShow(Sender: TObject);
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
  Common, Lib, Vcl.Themes, StyleHooks, System.Math;

var
  FReplaceDialog: TReplaceDialog;

function ReplaceDialog: TReplaceDialog;
begin
  if FReplaceDialog = nil then
    Application.CreateForm(TReplaceDialog, FReplaceDialog);
  Result := FReplaceDialog;
  StyleHooks.SetStyledFormSize(Result);
end;

procedure TReplaceDialog.FormDestroy(Sender: TObject);
begin
  FReplaceDialog := nil;
end;

procedure TReplaceDialog.FormShow(Sender: TObject);
begin
  inherited;
  LeftPanel.Width := Max(SearchForLabel.Width + 12, ReplaceWithLabel.Width + 12);
  RightPanel.Width := Max(Max(Length(FindButton.Caption), Length(ReplaceAllButton.Caption)), Length(CancelButton.Caption)) * 7;
  if SearchForComboBox.CanFocus then
    SearchForComboBox.SetFocus;
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
  FindButton.Enabled := SearchForComboBox.Text <> '';
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

 
unit BCDialogs.Replace;

{$I SynEdit.inc}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, BCDialogs.Dlg, Vcl.ExtCtrls, BCControls.ComboBox, Vcl.StdCtrls;

type
  TReplaceDialog = class(TDialog)
    CancelButton: TButton;
    CaseSensitiveCheckBox: TCheckBox;
    FindButton: TButton;
    LeftPanel: TPanel;
    OptionsGroupBox: TGroupBox;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    ReplaceAllButton: TButton;
    ReplaceInRadioGroup: TRadioGroup;
    ReplaceWithComboBox: TBCComboBox;
    ReplaceWithLabel: TLabel;
    RightPanel: TPanel;
    SearchForComboBox: TBCComboBox;
    SearchForLabel: TLabel;
    WholeWordsCheckBox: TCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SearchForComboBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function GetReplaceInWholeFile: Boolean;
    function GetReplaceText: string;
    function GetSearchCaseSensitive: Boolean;
    function GetSearchText: string;
    function GetSearchWholeWords: Boolean;
  public
    property ReplaceInWholeFile: Boolean read GetReplaceInWholeFile;
    property ReplaceText: string read GetReplaceText;
    property SearchCaseSensitive: Boolean read GetSearchCaseSensitive;
    property SearchText: string read GetSearchText;
    property SearchWholeWords: Boolean read GetSearchWholeWords;
  end;

function ReplaceDialog: TReplaceDialog;

implementation

{$R *.DFM}

uses
  Lib, Vcl.Themes, BCCommon.StyleUtils, System.Math, BCCommon.Lib;

var
  FReplaceDialog: TReplaceDialog;

function ReplaceDialog: TReplaceDialog;
begin
  if not Assigned(FReplaceDialog) then
    Application.CreateForm(TReplaceDialog, FReplaceDialog);
  Result := FReplaceDialog;
  SetStyledFormSize(Result);
end;

procedure TReplaceDialog.FormDestroy(Sender: TObject);
begin
  FReplaceDialog := nil;
end;

procedure TReplaceDialog.FormShow(Sender: TObject);
var
  i: Integer;
begin
  i := ReplaceInRadioGroup.ItemIndex; { language update will set the itemindex to -1 }
  inherited;
  ReplaceInRadioGroup.ItemIndex := i;
  LeftPanel.Width := Max(SearchForLabel.Width + 12, ReplaceWithLabel.Width + 12);
  RightPanel.Width := Max(Max(Canvas.TextWidth(FindButton.Caption), Max(Canvas.TextWidth(ReplaceAllButton.Caption), Canvas.TextWidth(CancelButton.Caption))) + 14, 83);

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
    InsertTextToCombo(SearchForComboBox);
    InsertTextToCombo(ReplaceWithComboBox);
  end;
end;

end.

 
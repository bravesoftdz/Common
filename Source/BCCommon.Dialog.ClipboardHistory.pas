unit BCCommon.Dialog.ClipboardHistory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, BCEditor.Editor,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Dialog.Base, Vcl.StdCtrls, sListBox, Vcl.Buttons, sSpeedButton,
  BCControl.SpeedButton, Vcl.ExtCtrls, sPanel, BCControl.Panel, System.Actions, Vcl.ActnList, VirtualTrees;

type
  TClipboardHistoryDialog = class(TBCBaseDialog)
    ActionList: TActionList;
    ActionCopyToClipboard: TAction;
    ActionDelete: TAction;
    ActionClearAll: TAction;
    ActionInsertInEditor: TAction;
    PanelTop: TBCPanel;
    SpeedButtonDivider1: TBCSpeedButton;
    SpeedButtonDelete: TBCSpeedButton;
    SpeedButtonInsert: TBCSpeedButton;
    SpeedButtonClear: TBCSpeedButton;
    PanelButtons: TBCPanel;
    ButtonFind: TButton;
    ButtonCancel: TButton;
    BCSpeedButton1: TBCSpeedButton;
    VirtualDrawTree: TVirtualDrawTree;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FEditor: TBCEditor;
    //procedure ReadIniFile;
    procedure ReadSizePosIniFile;
    procedure WriteIniFile;
  public
    procedure Open(AEditor: TBCEditor);
  end;

function ClipboardHistoryDialog: TClipboardHistoryDialog;

implementation

{$R *.dfm}

uses
  System.IniFiles, BCCommon.Utils, BCCommon.FileUtils, BCCommon.Language.Utils;

var
  FClipboardHistoryDialog: TClipboardHistoryDialog;

function ClipboardHistoryDialog: TClipboardHistoryDialog;
begin
  if not Assigned(FClipboardHistoryDialog) then
    Application.CreateForm(TClipboardHistoryDialog, FClipboardHistoryDialog);
  Result := FClipboardHistoryDialog;
end;

procedure TClipboardHistoryDialog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  WriteIniFile;
  Action := caFree;
end;

procedure TClipboardHistoryDialog.FormDestroy(Sender: TObject);
begin
  inherited;
  FClipboardHistoryDialog := nil;
end;

procedure TClipboardHistoryDialog.Open(AEditor: TBCEditor);
begin
  FEditor := AEditor;
  UpdateLanguage(Self, GetSelectedLanguage);
  ReadSizePosIniFile;
  Show;
end;

procedure TClipboardHistoryDialog.ReadSizePosIniFile;
begin
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Size }
    Width := ReadInteger('ClipboardHistorySize', 'Width', Width);
    Height := ReadInteger('ClipboardHistorySize', 'Height', Height);
    { Position }
    Left := ReadInteger('ClipboardHistoryPosition', 'Left', (Screen.Width - Width) div 2);
    Top := ReadInteger('ClipboardHistoryPosition', 'Top', (Screen.Height - Height) div 2);
    { Check if the form is outside the workarea }
    Left := SetFormInsideWorkArea(Left, Width);
  finally
    Free;
  end;
end;

procedure TClipboardHistoryDialog.WriteIniFile;
begin
  if Windowstate = wsNormal then
  with TMemIniFile.Create(GetIniFilename) do
  try
    { Size }
    WriteInteger('ClipboardHistorySize', 'Width', Width);
    WriteInteger('ClipboardHistorySize', 'Height', Height);
    { Position }
    WriteInteger('ClipboardHistoryPosition', 'Left', Left);
    WriteInteger('ClipboardHistoryPosition', 'Top', Top);
  finally
    UpdateFile;
    Free;
  end;
end;


end.

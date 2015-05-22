unit BCCommon.Dialogs.ItemList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, BCCommon.Images,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Dialogs.Base, Vcl.StdCtrls, Vcl.ExtCtrls, sPanel, BCControls.Panel,
  Vcl.Buttons, sSpeedButton, BCControls.SpeedButton, sListBox, System.Actions, Vcl.ActnList;

type
  TItemListDialog = class(TBCBaseDialog)
    PanelButtons: TBCPanel;
    ButtonFind: TButton;
    ButtonCancel: TButton;
    ListBox: TsListBox;
    PanelTop: TBCPanel;
    SpeedButtonDivider: TBCSpeedButton;
    SpeedButtonDelete: TBCSpeedButton;
    SpeedButtonInsert: TBCSpeedButton;
    SpeedButtonClear: TBCSpeedButton;
    ActionList: TActionList;
    ActionInsert: TAction;
    ActionDelete: TAction;
    ActionClearAll: TAction;
    procedure ActionInsertExecute(Sender: TObject);
    procedure ActionDeleteExecute(Sender: TObject);
    procedure ActionClearAllExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  BCCommon.Dialogs.InputQuery, BCCommon.Language.Strings;

{$R *.dfm}

procedure TItemListDialog.ActionClearAllExecute(Sender: TObject);
begin
  ListBox.Clear;
end;

procedure TItemListDialog.ActionDeleteExecute(Sender: TObject);
begin
  ListBox.Items.Delete(ListBox.ItemIndex);
end;

procedure TItemListDialog.ActionInsertExecute(Sender: TObject);
var
  LValue: string;
begin
  if TInputQueryDialog.ClassShowModal(Self, LanguageDataModule.GetConstant('Insert'), LValue) = mrOk then
    ListBox.Items.Insert(ListBox.ItemIndex, LValue);
end;

end.

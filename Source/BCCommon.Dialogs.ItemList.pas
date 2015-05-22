unit BCCommon.Dialogs.ItemList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Dialogs.Base, Vcl.StdCtrls, Vcl.ExtCtrls, sPanel, BCControls.Panel,
  Vcl.Buttons, sSpeedButton, BCControls.SpeedButton, sListBox;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.

unit BCFrames.OptionsStatusBar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  BCControls.CheckBox, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList, System.Actions, BCCommon.OptionsContainer;

type
  TStatusBarFrame = class(TFrame)
    Panel: TPanel;
    SelectFontSpeedButton: TSpeedButton;
    FontLabel: TLabel;
    UseSystemFontCheckBox: TBCCheckBox;
    ActionList: TActionList;
    SelectFontAction: TAction;
    FontDialog: TFontDialog;
    procedure SelectFontActionExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PutData(OptionsContainer: TOptionsContainer);
  end;

implementation

{$R *.dfm}

procedure TStatusBarFrame.SelectFontActionExecute(Sender: TObject);
begin
  FontDialog.Font.Name := FontLabel.Font.Name;
  FontDialog.Font.Size := FontLabel.Font.Size;
  if FontDialog.Execute then
  begin
    FontLabel.Font.Assign(FontDialog.Font);
    FontLabel.Caption := Format('%s %dpt', [FontLabel.Font.Name, FontLabel.Font.Size]);
  end;
end;

procedure TStatusBarFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.StatusBarUseSystemFont := UseSystemFontCheckBox.Checked;
  OptionsContainer.StatusBarFontName := FontLabel.Font.Name;
  OptionsContainer.StatusBarFontSize := FontLabel.Font.Size;
end;

end.

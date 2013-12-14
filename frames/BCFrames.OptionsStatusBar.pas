unit BCFrames.OptionsStatusBar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  BCControls.CheckBox, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList, System.Actions, BCCommon.OptionsContainer;

type
  TOptionsStatusBarFrame = class(TFrame)
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
    procedure GetData(OptionsContainer: TOptionsContainer);
    procedure PutData(OptionsContainer: TOptionsContainer);
  end;

implementation

{$R *.dfm}

procedure TOptionsStatusBarFrame.SelectFontActionExecute(Sender: TObject);
begin
  FontDialog.Font.Name := FontLabel.Font.Name;
  FontDialog.Font.Size := FontLabel.Font.Size;
  if FontDialog.Execute then
  begin
    FontLabel.Font.Assign(FontDialog.Font);
    FontLabel.Caption := Format('%s %dpt', [FontLabel.Font.Name, FontLabel.Font.Size]);
  end;
end;

procedure TOptionsStatusBarFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.StatusBarUseSystemFont := UseSystemFontCheckBox.Checked;
  OptionsContainer.StatusBarFontName := FontLabel.Font.Name;
  OptionsContainer.StatusBarFontSize := FontLabel.Font.Size;
end;

procedure TOptionsStatusBarFrame.GetData(OptionsContainer: TOptionsContainer);
begin
  UseSystemFontCheckBox.Checked := OptionsContainer.StatusBarUseSystemFont;
  FontLabel.Font.Name := OptionsContainer.StatusBarFontName;
  FontLabel.Font.Size := OptionsContainer.StatusBarFontSize;
  FontLabel.Caption := Format('%s %dpt', [FontLabel.Font.Name, FontLabel.Font.Size]);
end;

end.

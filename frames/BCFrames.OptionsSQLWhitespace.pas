unit BCFrames.OptionsSQLWhitespace;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, BCControls.CheckBox, Vcl.ExtCtrls;

type
  TFrame1 = class(TFrame)
    Panel: TPanel;
    SpaceAroundOperatorCheckBox: TBCCheckBox;
    SpaceInsideCreateCheckBox: TBCCheckBox;
    SpaceInsideExpressionCheckBox: TBCCheckBox;
    SpaceInsideSubqueryCheckBox: TBCCheckBox;
    SpaceInsideFunctionCheckBox: TBCCheckBox;
    SpaceInsideTypenameCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.

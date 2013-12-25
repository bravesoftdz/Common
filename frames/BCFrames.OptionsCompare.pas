unit BCFrames.OptionsCompare;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, BCControls.CheckBox,
  BCCommon.OptionsContainer, BCFrames.OptionsFrame;

type
  TOptionsCompareFrame = class(TOptionsFrame)
    Panel: TPanel;
    IgnoreCaseCheckBox: TBCCheckBox;
    IgnoreBlanksCheckBox: TBCCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetData(OptionsContainer: TOptionsContainer); override;
    procedure PutData(OptionsContainer: TOptionsContainer); override;
  end;

implementation

{$R *.dfm}

procedure TOptionsCompareFrame.PutData(OptionsContainer: TOptionsContainer);
begin
  OptionsContainer.IgnoreCase := IgnoreCaseCheckBox.Checked;
  OptionsContainer.IgnoreBlanks := IgnoreBlanksCheckBox.Checked;
end;

procedure TOptionsCompareFrame.GetData(OptionsContainer: TOptionsContainer);
begin
  IgnoreCaseCheckBox.Checked := OptionsContainer.IgnoreCase;
  IgnoreBlanksCheckBox.Checked := OptionsContainer.IgnoreBlanks;
end;

end.

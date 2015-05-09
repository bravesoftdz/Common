unit BCCommon.Dialogs.InputQuery;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, BCCommon.Dialogs.Base, Vcl.StdCtrls, BCControls.Edit,
  Vcl.ExtCtrls, sEdit, BCControls.Panel, sPanel;

type
  TInputQueryDialog = class(TBCBaseDialog)
    ButtonCancel: TButton;
    ButtonOK: TButton;
    EditValue: TBCEdit;
    PanelButton: TBCPanel;
    PanelTop: TBCPanel;
  public
    class function ClassShowModal(AOwner: TComponent; const ACaption: string; var Value: string): Integer; overload;
    class function ClassShowModal(AOwner: TComponent; const ACaption: string; var Value: Integer): Integer; overload;
  end;

implementation

{$R *.dfm}

class function TInputQueryDialog.ClassShowModal(AOwner: TComponent; const ACaption: string; var Value: string): Integer;
begin
  with TInputQueryDialog.Create(AOwner) do
  try
    Caption := ACaption;
    Result := ShowModal;
    Value := EditValue.Text;
  finally
    Free;
  end;
end;

class function TInputQueryDialog.ClassShowModal(AOwner: TComponent; const ACaption: string; var Value: Integer): Integer;
begin
  with TInputQueryDialog.Create(AOwner) do
  try
    Caption := ACaption;
    EditValue.OnlyNumbers := True;
    Result := ShowModal;
    Value := EditValue.ValueInt;
  finally
    Free;
  end;
end;

end.

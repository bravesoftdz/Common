unit BCFrames.OptionsFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.OptionsContainer;

type
  TOptionsFrame = class(TFrame)
  private
    { Private declarations }
    FOwnerForm: TForm;
    procedure WMDestroy(var Msg: TWMDestroy); message WM_DESTROY;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure Init; virtual;
    procedure GetData; virtual;
    procedure PutData; virtual;
  end;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageUtils;

constructor TOptionsFrame.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
  //Assert(not (AOwner is TForm), 'Owner must be a form');
  FOwnerForm := AOwner as TForm;
  { find the scroll box }
  for i := 0 to FOwnerForm.ComponentCount - 1 do
    if FOwnerForm.Components[i] is TScrollBox then
    begin
       Parent := FOwnerForm.Components[i] as TWinControl;
       Break;
    end;
  UpdateLanguage(TForm(Self), GetSelectedLanguage);
  Init;
  GetData;
end;

procedure TOptionsFrame.WMDestroy(var Msg: TWMDestroy);
begin
  if (csDestroying in ComponentState) then
    if FOwnerForm.ModalResult = mrOk then
      PutData;
  inherited;
end;

procedure TOptionsFrame.Init;
begin
  //
end;

procedure TOptionsFrame.GetData;
begin
  //
end;

procedure TOptionsFrame.PutData;
begin
  //
end;

end.

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
    procedure PutData; virtual; abstract;
    procedure ShowFrame;
  end;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageUtils, Vcl.ExtCtrls, BCControls.CheckBox;

constructor TOptionsFrame.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(AOwner);
  //Assert(not (AOwner is TForm), 'Owner must be a form');
  FOwnerForm := AOwner as TForm;
  { find the scroll box }
  for i := 0 to FOwnerForm.ComponentCount - 1 do
    if FOwnerForm.Components[i] is TScrollBox then
    begin
       Parent := FOwnerForm.Components[i] as TWinControl;
       Break;
    end;
  {$ifdef EDITBONE}
  UpdateLanguage(TForm(Self), GetSelectedLanguage);
  {$endif}
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
  // not abstract because this is not always implemented
end;

procedure TOptionsFrame.GetData;
begin
  // not abstract because this is not always implemented
end;

procedure TOptionsFrame.ShowFrame;
var
  i: Integer;
begin
  Show;
  { Autosize panels. This is stupid but TPanel can't be autosized before it's visible. }
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TPanel then
      (Components[i] as TPanel).AutoSize := True;
end;

end.

unit BCCommon.Dialog.Base;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, sSkinProvider;

type
  TDialogType = (dtOpen, dtEdit);

  TBCBaseDialog = class(TForm)
    SkinProvider: TsSkinProvider;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FOrigCaption: string;
    FOrigHeight: Integer;
    FOrigWidth: Integer;
  protected
    procedure LockPaint;
    procedure UnlockPaint;
    property OrigCaption: string read FOrigCaption write FOrigCaption;
  public
    constructor Create(AOwner: TComponent); override;
    property OrigHeight: Integer read FOrigHeight write FOrigHeight;
    property OrigWidth: Integer read FOrigWidth write FOrigWidth;
  end;

implementation

{$R *.dfm}

{$IFDEF EDITBONE}
uses
  Winapi.Messages, BCCommon.Language.Utils;
{$ENDIF}

constructor TBCBaseDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOrigWidth := Width;
  FOrigHeight := Height;
end;

procedure TBCBaseDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    Key := #0; { no beep }
    Close;
  end;
end;

procedure TBCBaseDialog.FormShow(Sender: TObject);
begin
  {$IFDEF EDITBONE}
  BCCommon.Language.Utils.UpdateLanguage(Self);
  {$ENDIF}
  FOrigCaption := Caption;
end;

procedure TBCBaseDialog.LockPaint;
begin
  SkinProvider.SkinData.BeginUpdate;
  SkinProvider.Form.Perform(WM_SETREDRAW, 0, 0);
end;

procedure TBCBaseDialog.UnlockPaint;
begin
  SkinProvider.SkinData.EndUpdate;
  SkinProvider.Form.Perform(WM_SETREDRAW, 1, 0);
end;

end.

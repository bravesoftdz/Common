unit BCCommon.Dialogs.SkinSelect;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCCommon.Dialogs.Base, Vcl.StdCtrls, sButton, BCControls.Button, Vcl.ExtCtrls,
  sPanel, BCControls.Panel, sListBox, sSplitter, acSkinPreview, BCControls.Splitter, BCComponents.SkinManager;

type
  TSkinSelectDialog = class(TBCBaseDialog)
    ListBoxSkins: TsListBox;
    PanelButtons: TBCPanel;
    ButtonOK: TBCButton;
    ButtonCancel: TBCButton;
    PanelPreviewArea: TBCPanel;
    BCSplitter1: TBCSplitter;
    procedure ListBoxSkinsClick(Sender: TObject);
  private
    { Private declarations }
    FPreviewForm: TFormSkinPreview;
  public
    { Public declarations }
    class procedure ClassShowModal(ASkinManager: TBCSkinManager);
  end;

implementation

{$R *.dfm}

class procedure TSkinSelectDialog.ClassShowModal(ASkinManager: TBCSkinManager);
var
  LSkinSelectDialog: TSkinSelectDialog;
begin
  Application.CreateForm(TSkinSelectDialog, LSkinSelectDialog);

  with LSkinSelectDialog do
  try
    ASkinManager.GetExternalSkinNames(ListBoxSkins.Items);
    ListBoxSkins.ItemIndex := ListBoxSkins.Items.IndexOf(ASkinManager.SkinName);
    FPreviewForm := TFormSkinPreview.Create(nil); // Form will be freed automatically together with this frame
    try
      FPreviewForm.Align := alClient;
      FPreviewForm.Parent := PanelPreviewArea;
      FPreviewForm.Name := 'FormSkinPreview';
      FPreviewForm.PreviewManager.SkinDirectory := ASkinManager.SkinDirectory;
      FPreviewForm.PreviewManager.SkinName := ListBoxSkins.Items[ListBoxSkins.ItemIndex];
      FPreviewForm.PreviewManager.Active := True;
      FPreviewForm.Visible := True;
      if ShowModal = mrOk then
        ASkinManager.SkinName := ListBoxSkins.Items[ListBoxSkins.ItemIndex];
    finally
      FPreviewForm.Free;
    end;
  finally
    Free;
    LSkinSelectDialog := nil;
  end;
end;

procedure TSkinSelectDialog.ListBoxSkinsClick(Sender: TObject);
begin
  inherited;
  FPreviewForm.PreviewManager.SkinName := ListBoxSkins.Items[ListBoxSkins.ItemIndex];
end;

end.

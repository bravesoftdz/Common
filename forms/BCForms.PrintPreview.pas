unit BCForms.PrintPreview;

interface

uses
  System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.ToolWin, Vcl.ActnList, Vcl.ImgList, SynEditPrintPreview, Vcl.Menus, Vcl.AppEvnts, Vcl.Printers, BCCommon.Images,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, BCControls.PopupMenu, BCControls.ToolBar, System.Actions, Vcl.Grids,
  System.Types;

type
  TPrintPreviewDialog = class(TForm)
    ActionList: TActionList;
    ApplicationEvents: TApplicationEvents;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel7: TBevel;
    ButtonPanel: TPanel;
    FirstAction: TAction;
    FirstToolButton: TToolButton;
    LastAction: TAction;
    LasttToolButton: TToolButton;
    LineNumbersAction: TAction;
    LineNumbersToolButton: TToolButton;
    ModeToolBar: TBCToolBar;
    NextAction: TAction;
    NextToolButton: TToolButton;
    Percent100MenuItem: TMenuItem;
    Percent200MenuItem: TMenuItem;
    Percent25MenuItem: TMenuItem;
    Percent400MenuItem: TMenuItem;
    Percent50MenuItem: TMenuItem;
    PopupMenu: TBCPopupMenu;
    PrevAction: TAction;
    PrevioustToolButton: TToolButton;
    PrintAction: TAction;
    PrintSetupAction: TAction;
    PrintSetupToolButton: TToolButton;
    PrintToolBar: TBCToolBar;
    PrintToolButton: TToolButton;
    StatusBar: TStatusBar;
    SynEditPrintPreview: TSynEditPrintPreview;
    ToolBar: TBCToolBar;
    WordWrapAction: TAction;
    WordWrapToolButton: TToolButton;
    ZoomAction: TAction;
    ZoomToolBar: TBCToolBar;
    ZoomToolButton: TToolButton;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FirstActionExecute(Sender: TObject);
    procedure PercentClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LastActionExecute(Sender: TObject);
    procedure LineNumbersActionExecute(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure PrevActionExecute(Sender: TObject);
    procedure PrintActionExecute(Sender: TObject);
    procedure PrintSetupActionExecute(Sender: TObject);
    procedure SynEditPrintPreviewMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SynEditPrintPreviewPreviewPage(Sender: TObject; PageNumber: Integer);
    procedure WordWrapActionExecute(Sender: TObject);
    procedure ZoomActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FLeft: Integer;
    FTop: Integer;
  public
    { Public declarations }
  end;

function PrintPreviewDialog: TPrintPreviewDialog;

implementation

{$R *.DFM}

uses
  Vcl.Themes, UxTheme, BCCommon.LanguageUtils, BCCommon.Dialogs, WinApi.CommDlg, BCCommon.LanguageStrings,
  BCControls.StyleHooks, Winapi.Windows, Math;

var
  FPrintPreviewDialog: TPrintPreviewDialog;

function PrintPreviewDialog: TPrintPreviewDialog;
begin
  if not Assigned(FPrintPreviewDialog) then
    Application.CreateForm(TPrintPreviewDialog, FPrintPreviewDialog);
  Result := FPrintPreviewDialog;
end;

procedure TPrintPreviewDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPrintPreviewDialog.FormCreate(Sender: TObject);
begin
  { IDE can lose there properties }
  ActionList.Images := ImagesDataModule.ImageList;
  PopupMenu.Images := ImagesDataModule.ImageList;
  ToolBar.Images := ImagesDataModule.ImageList;
  ZoomToolBar.Images := ImagesDataModule.ImageList;
  ModeToolBar.Images := ImagesDataModule.ImageList;
  PrintToolBar.Images := ImagesDataModule.ImageList;
end;

procedure TPrintPreviewDialog.FormDestroy(Sender: TObject);
begin
  FPrintPreviewDialog := nil;
end;

procedure TPrintPreviewDialog.FormShow(Sender: TObject);
var
  LStyles: TCustomStyleServices;
begin
  SynEditPrintPreview.UpdatePreview;
  SynEditPrintPreview.FirstPage;
  if Printer.PrinterIndex >= 0 then
    PrintAction.Hint := Format(LanguageDataModule.GetConstant('PreviewPrintDocument'),
      [Printer.Printers[Printer.PrinterIndex], Printer.Printers[Printer.PrinterIndex]]);
  SynEditPrintPreview.ScalePercent := 100;
  LineNumbersToolButton.Down := SynEditPrintPreview.SynEditPrint.LineNumbers;
  WordWrapToolButton.Down := SynEditPrintPreview.SynEditPrint.Wrap;

  FLeft := SynEditPrintPreview.SynEditPrint.Margins.PLeft;
  FTop := SynEditPrintPreview.SynEditPrint.Margins.PTop;

  StatusBar.Font.Name := 'Tahoma'; // IDE is losing this for some reason... :/
  StatusBar.Font.Size := 8;

  LStyles := StyleServices;
  if LStyles.Enabled then
    SynEditPrintPreview.Color := LStyles.GetStyleColor(scPanel);

  UpdateLanguage(Self);
  Caption := Format('%s - [%s]', [Caption, SynEditPrintPreview.SynEditPrint.Title]);
end;

procedure TPrintPreviewDialog.FirstActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.FirstPage;
end;

procedure TPrintPreviewDialog.PrevActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.PreviousPage;
end;

procedure TPrintPreviewDialog.NextActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.NextPage;
end;

procedure TPrintPreviewDialog.LastActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.LastPage;
end;

procedure TPrintPreviewDialog.LineNumbersActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.SynEditPrint.LineNumbers := not SynEditPrintPreview.SynEditPrint.LineNumbers;
  SynEditPrintPreview.SynEditPrint.LineNumbersInMargin := SynEditPrintPreview.SynEditPrint.LineNumbers;
  SynEditPrintPreview.Refresh;
end;

procedure TPrintPreviewDialog.ZoomActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.ScaleMode := pscWholePage;
end;

procedure TPrintPreviewDialog.PrintActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.Print;
end;

procedure TPrintPreviewDialog.PrintSetupActionExecute(Sender: TObject);
var
  PrintDlg: TPrintDlg;
begin
  if BCCommon.Dialogs.Print(SynEditPrintPreview.Handle, PrintDlg, True) then
  begin
    Application.ProcessMessages; { style fix }
    SynEditPrintPreview.FirstPage;
    SynEditPrintPreview.UpdatePreview;
  end;
end;

procedure TPrintPreviewDialog.PercentClick(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    -1: SynEditPrintPreview.ScaleMode := pscPageWidth;
  else
    SynEditPrintPreview.ScalePercent := (Sender as TMenuItem).Tag;
  end;
end;

procedure TPrintPreviewDialog.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Format('  %s', [Application.Hint]);
end;

procedure TPrintPreviewDialog.SynEditPrintPreviewMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  FScale: Integer;
begin
  FScale := SynEditPrintPreview.ScalePercent;
  if Button = mbLeft then
  begin
    if SynEditPrintPreview.ScaleMode = pscWholePage then
      SynEditPrintPreview.ScalePercent := 100
    else
    begin
      FScale := FScale * 2;
      if FScale > 400 then
        FScale := 400;
      SynEditPrintPreview.ScalePercent := FScale;
    end;
  end
  else
  begin
    FScale := FScale div 2;
    if FScale < 25 then
      FScale := 25;
    SynEditPrintPreview.ScalePercent := FScale;
  end;
  { fix for scrollbar resize bug }
  SetWindowPos(SynEditPrintPreview.Handle, 0, 0, SynEditPrintPreview.Top, SynEditPrintPreview.Width, SynEditPrintPreview.Height, SWP_DRAWFRAME);
end;

procedure TPrintPreviewDialog.SynEditPrintPreviewPreviewPage(
  Sender: TObject; PageNumber: Integer);
begin
  StatusBar.Panels[1].Text := Format(LanguageDataModule.GetConstant('PreviewPage'), [SynEditPrintPreview.PageNumber]);
end;

procedure TPrintPreviewDialog.WordWrapActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.SynEditPrint.Wrap := not SynEditPrintPreview.SynEditPrint.Wrap;
  SynEditPrintPreview.Refresh;
end;

initialization

  if Assigned(TStyleManager.Engine) then
    TStyleManager.Engine.RegisterStyleHook(TSynEditPrintPreview, TSynEditStyleHook);

end.


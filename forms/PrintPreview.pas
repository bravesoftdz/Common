unit PrintPreview;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnList, Vcl.ImgList,
  Vcl.Dialogs, SynEditPrintPreview, Vcl.Menus, Vcl.AppEvnts, Vcl.Printers, SynEditPrint,
  JvExButtons, JvBitBtn, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnPopup, BCPopupMenu,
  JvExComCtrls, JvToolBar, BCToolBar, BCImageList;

type
  TPrintPreviewDialog = class(TForm)
    ImageList: TBCImageList;
    ActionList: TActionList;
    FirstAction: TAction;
    PrevAction: TAction;
    NextAction: TAction;
    LastAction: TAction;
    ZoomAction: TAction;
    PrintAction: TAction;
    StatusBar: TStatusBar;
    PopupMenu: TBCPopupMenu;
    PagewidthMenuItem: TMenuItem;
    SeparatorMenuItem: TMenuItem;
    Percent25MenuItem: TMenuItem;
    Percent50MenuItem: TMenuItem;
    Percent100MenuItem: TMenuItem;
    Percent200MenuItem: TMenuItem;
    Percent400MenuItem: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    SynEditPrintPreview: TSynEditPrintPreview;
    LineNumbersAction: TAction;
    WordWrapAction: TAction;
    PrinterSetupDialog: TPrinterSetupDialog;
    PrintSetupAction: TAction;
    ButtonPanel: TPanel;
    ToolBar: TBCToolBar;
    FirstToolButton: TToolButton;
    PrevioustToolButton: TToolButton;
    NextToolButton: TToolButton;
    LasttToolButton: TToolButton;
    ZoomToolBar: TBCToolBar;
    ZoomToolButton: TToolButton;
    Bevel7: TBevel;
    Bevel1: TBevel;
    ModeToolBar: TBCToolBar;
    LineNumbersToolButton: TToolButton;
    WordWrapToolButton: TToolButton;
    Bevel2: TBevel;
    PrintToolBar: TBCToolBar;
    PrintSetupToolButton: TToolButton;
    PrintToolButton: TToolButton;

    procedure FirstActionExecute(Sender: TObject);
    procedure PrevActionExecute(Sender: TObject);
    procedure NextActionExecute(Sender: TObject);
    procedure LastActionExecute(Sender: TObject);
    procedure ZoomActionExecute(Sender: TObject);
    procedure PrintActionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Fitto1Click(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure SynEditPrintPreviewMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SynEditPrintPreviewPreviewPage(Sender: TObject;
      PageNumber: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure LineNumbersActionExecute(Sender: TObject);
    procedure WordWrapActionExecute(Sender: TObject);
    procedure PrintSetupActionExecute(Sender: TObject);
  private
    { Private declarations }
    FLeft, FTop: Integer;
  public
    { Public declarations }
  end;

function PrintPreviewDialog: TPrintPreviewDialog;

implementation

{$R *.DFM}

uses
  Vcl.Themes, StyleHooks;

var
  FPrintPreviewDialog: TPrintPreviewDialog;

function PrintPreviewDialog: TPrintPreviewDialog;
begin
  if FPrintPreviewDialog = nil then
    Application.CreateForm(TPrintPreviewDialog, FPrintPreviewDialog);
  Result := FPrintPreviewDialog;
end;

procedure TPrintPreviewDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPrintPreviewDialog.FormDestroy(Sender: TObject);
begin
  FPrintPreviewDialog := nil;
end;

procedure TPrintPreviewDialog.FormShow(Sender: TObject);
begin
  SynEditPrintPreview.UpdatePreview;
  SynEditPrintPreview.FirstPage;
  if Printer.PrinterIndex >= 0 then
    PrintAction.Hint := 'Print (' + Printer.Printers[Printer.PrinterIndex] +
      ')|Print the document on ' + Printer.Printers[Printer.PrinterIndex];
  SynEditPrintPreview.ScalePercent := 100;
  LineNumbersToolButton.Down := SynEditPrintPreview.SynEditPrint.LineNumbers;
  WordWrapToolButton.Down := SynEditPrintPreview.SynEditPrint.Wrap;

  FLeft := SynEditPrintPreview.SynEditPrint.Margins.PLeft;
  FTop := SynEditPrintPreview.SynEditPrint.Margins.PTop;
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
begin
  if PrinterSetupDialog.Execute then
  begin
    SynEditPrintPreview.FirstPage;
    SynEditPrintPreview.UpdatePreview;
  end;
end;

procedure TPrintPreviewDialog.Fitto1Click(Sender: TObject);
begin
  case (Sender as TMenuItem).Tag of
    -1: SynEditPrintPreview.ScaleMode := pscPageWidth;
  else
    SynEditPrintPreview.ScalePercent := (Sender as TMenuItem).Tag;
  end;
end;

procedure TPrintPreviewDialog.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := '  ' + Application.Hint;
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
end;

procedure TPrintPreviewDialog.SynEditPrintPreviewPreviewPage(
  Sender: TObject; PageNumber: Integer);
begin
  StatusBar.Panels[1].Text := ' Page: ' + IntToStr(SynEditPrintPreview.PageNumber);
end;

procedure TPrintPreviewDialog.WordWrapActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.SynEditPrint.Wrap := not SynEditPrintPreview.SynEditPrint.Wrap;
  SynEditPrintPreview.Refresh;
end;

initialization

  TStyleManager.Engine.RegisterStyleHook(TSynEditPrintPreview, TSynEditStyleHook);

end.


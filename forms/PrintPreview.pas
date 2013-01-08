unit PrintPreview;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Forms, Vcl.Controls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnList, Vcl.ImgList,
  SynEditPrintPreview, Vcl.Menus, Vcl.AppEvnts, Vcl.Printers, SynEditPrint,
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
  Vcl.Themes, StyleHooks, Common, Language, CommonDialogs, WinApi.CommDlg;

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
    PrintAction.Hint := Format(LanguageDataModule.ConstantMultiStringHolder.StringsByName['PreviewPrintDocument'].Text,
      [Printer.Printers[Printer.PrinterIndex], Printer.Printers[Printer.PrinterIndex]]);
  SynEditPrintPreview.ScalePercent := 100;
  LineNumbersToolButton.Down := SynEditPrintPreview.SynEditPrint.LineNumbers;
  WordWrapToolButton.Down := SynEditPrintPreview.SynEditPrint.Wrap;

  FLeft := SynEditPrintPreview.SynEditPrint.Margins.PLeft;
  FTop := SynEditPrintPreview.SynEditPrint.Margins.PTop;

  StatusBar.Font.Name := 'Tahoma'; // IDE is losing this for some reason... :/
  StatusBar.Font.Size := 8;

  Common.UpdateLanguage(Self);
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

{function TQRPrintDialog.Execute: Boolean;
const
  PrintRanges: array[TPrintRange] of Integer =
    (PD_ALLPAGES, PD_SELECTION, PD_PAGENUMS);
var
  PrintDlgRec: TPrintDlg;
  DevHandle: THandle;
  pDevMode: PDeviceMode;
begin
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hInstance := SysInit.HInstance;
    GetPrinter(DevHandle, hDevNames);
    hDevMode := CopyData(DevHandle);
    Flags := PrintRanges[FPrintRange] or (PD_ENABLEPRINTHOOK or
      PD_ENABLESETUPHOOK);
    if FCollate<>0 then Inc(Flags, PD_COLLATE);
    if not (poPrintToFile in FOptions) then Inc(Flags, PD_HIDEPRINTTOFILE);
    if not (poPageNums in FOptions) then Inc(Flags, PD_NOPAGENUMS);
    if not (poSelection in FOptions) then Inc(Flags, PD_NOSELECTION);
    if poDisablePrintToFile in FOptions then Inc(Flags, PD_DISABLEPRINTTOFILE);
    if FPrintToFile then Inc(Flags, PD_PRINTTOFILE);
    if poHelp in FOptions then Inc(Flags, PD_SHOWHELP);
    if not (poWarning in FOptions) then Inc(Flags, PD_NOWARNING);
    nFromPage := FFromPage;
    nToPage := FToPage;
    nMinPage := FMinPage;
    nMaxPage := FMaxPage;
    HookCtl3D := Ctl3D;
    lpfnPrintHook := DialogHook;
    lpfnSetupHook := DialogHook;
    hWndOwner := Application.Handle;
    Result := TaskModalDialog(@PrintDlg, PrintDlgRec);
    if Result then
    begin
      SetPrinter(hDevMode, hDevNames);
      FPrintToFile := Flags and PD_PRINTTOFILE <> 0;
      if Flags and PD_SELECTION <> 0 then FPrintRange := prSelection
      else
        if Flags and PD_PAGENUMS <> 0 then FPrintRange := prPageNums
      else
          FPrintRange := prAllPages;
      FFromPage := nFromPage;
      FToPage := nToPage;
      if nCopies = 1 then
        Copies := FPrinter.Copies
      else
        Copies := nCopies;
      pDevMode := GlobalLock(hDevmode);
      FdmFields := TDeviceMode(pDevmode^).dmFields;
      FOutputBin := TDeviceMode(pDevmode^).dmDefaultSource;
      FpaperSize := TDeviceMode(pDevmode^).dmpaperSize;
      FPaperwidth := TDeviceMode(pDevmode^).dmpaperWidth;
      FPaperlength := TDeviceMode(pDevmode^).dmpaperLength;
      FOrientation := TDeviceMode(pDevmode^).dmOrientation;
      FPrintquality := TDeviceMode(pDevmode^).dmPrintquality;
      FColorOption := TDeviceMode(pDevmode^).dmColor;
      FDuplexCode :=  TDeviceMode(pDevmode^).dmDuplex;
      FDuplex :=  TDeviceMode(pDevmode^).dmDuplex <> 1;
      FCollate := TDeviceMode(pDevmode^).dmCollate;
      FOrientation := TDeviceMode(pDevmode^).dmOrientation;
    end
    else
    begin
      if hDevMode <> 0 then GlobalFree(hDevMode);
      if hDevNames <> 0 then GlobalFree(hDevNames);
    end;
  end;
end;}

procedure TPrintPreviewDialog.PrintSetupActionExecute(Sender: TObject);
var
  PrintDlg: TPrintDlg;
begin
  //if PrinterSetupDialog.Execute then
  if CommonDialogs.Print(SynEditPrintPreview.Handle, PrintDlg, True) then
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
end;

procedure TPrintPreviewDialog.SynEditPrintPreviewPreviewPage(
  Sender: TObject; PageNumber: Integer);
begin
  StatusBar.Panels[1].Text := Format(LanguageDataModule.ConstantMultiStringHolder.StringsByName['PreviewPage'].Text, [SynEditPrintPreview.PageNumber]);
end;

procedure TPrintPreviewDialog.WordWrapActionExecute(Sender: TObject);
begin
  SynEditPrintPreview.SynEditPrint.Wrap := not SynEditPrintPreview.SynEditPrint.Wrap;
  SynEditPrintPreview.Refresh;
end;

initialization

  TStyleManager.Engine.RegisterStyleHook(TSynEditPrintPreview, TSynEditStyleHook);

end.


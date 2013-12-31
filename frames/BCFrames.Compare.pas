unit BCFrames.Compare;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Diff,
  Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, JvSpeedButton, JvStringGrid, BCControls.StringGrid, Vcl.ActnList,
  JvExGrids, BCControls.ComboBox, System.Actions, JvExControls, BCControls.ImageList;

type
  TSyncKind = (skBoth, skVScroll, skHScroll);

  TCompareFrame = class(TFrame)
    ActionList: TActionList;
    BitBtn1: TJvSpeedButton;
    BottomPanel: TPanel;
    BottomRightPanel: TPanel;
    CancelLeftRowAction: TAction;
    CancelLeftSpeedButton: TJvSpeedButton;
    CancelRightRowAction: TAction;
    CancelRightSpeedButton: TJvSpeedButton;
    CopyLeftSpeedButton: TJvSpeedButton;
    CopyRightSpeedButton: TJvSpeedButton;
    CopySelectionLeftAction: TAction;
    CopySelectionRightAction: TAction;
    DrawBarPanel: TPanel;
    DrawGrid: TBCStringGrid;
    FilenameLeftMemo: TMemo;
    FilenameRightMemo: TMemo;
    FindNextDifferenceAction: TAction;
    FindNextDifferenceSpeedButton: TJvSpeedButton;
    JvSpeedButton1: TJvSpeedButton;
    LeftComboBox: TBCComboBox;
    LeftComboBoxChangeAction: TAction;
    LeftDocumentButtonClickAction: TAction;
    LeftGrid: TBCStringGrid;
    LeftGridOnChangeAction: TAction;
    LeftLabel: TLabel;
    LeftMemo: TMemo;
    LeftPanel: TPanel;
    LeftRightPanel: TPanel;
    LeftScrollBox: TScrollBox;
    LeftTopPanel: TPanel;
    OpenDocumentsLeftAction: TAction;
    OpenDocumentsLeftSpeedButton: TJvSpeedButton;
    OpenDocumentsRightAction: TAction;
    OpenDocumentsRightSpeedButton: TJvSpeedButton;
    Panel: TPanel;
    RefreshAction: TAction;
    RefreshSpeedButton: TJvSpeedButton;
    RightComboBox: TBCComboBox;
    RightComboBoxChangeAction: TAction;
    RightDocumentButtonClickAction: TAction;
    RightGrid: TBCStringGrid;
    RightGridOnChangeAction: TAction;
    RightLabel: TLabel;
    RightMemo: TMemo;
    RightPanel: TPanel;
    RightScrollBox: TScrollBox;
    RightTopPanel: TPanel;
    SaveLeftGridAction: TAction;
    SaveRightGridAction: TAction;
    SaveSpeedButton1: TJvSpeedButton;
    SaveSpeedButton2: TJvSpeedButton;
    TopMiddlePanel: TPanel;
    UpdateLeftRowAction: TAction;
    UpdateLeftSpeedButton: TJvSpeedButton;
    UpdateRightRowAction: TAction;
    UpdateRightSpeedButton: TJvSpeedButton;
    procedure CancelLeftRowActionExecute(Sender: TObject);
    procedure CancelRightRowActionExecute(Sender: TObject);
    procedure CopySelectionLeftActionExecute(Sender: TObject);
    procedure CopySelectionRightActionExecute(Sender: TObject);
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure DrawGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DrawGridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DrawGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FilenameEditLeftKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FilenameEditRightKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FindNextDifferenceActionExecute(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure LeftComboBoxChangeActionExecute(Sender: TObject);
    procedure LeftComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure LeftDocumentButtonClickActionExecute(Sender: TObject);
    procedure LeftGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure LeftGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LeftGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LeftGridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LeftGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure LeftMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OpenDocumentsLeftActionExecute(Sender: TObject);
    procedure OpenDocumentsRightActionExecute(Sender: TObject);
    procedure RefreshActionExecute(Sender: TObject);
    procedure RightComboBoxChangeActionExecute(Sender: TObject);
    procedure RightDocumentButtonClickActionExecute(Sender: TObject);
    procedure RightGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure RightGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RightGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RightGridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RightGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure RightMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SaveLeftGridActionExecute(Sender: TObject);
    procedure SaveRightGridActionExecute(Sender: TObject);
    procedure UpdateLeftRowActionExecute(Sender: TObject);
    procedure UpdateRightRowActionExecute(Sender: TObject);
    procedure DrawGridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure DrawGridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure LeftGridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure LeftGridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure RightGridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure RightGridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure DrawGridVerticalScroll(Sender: TObject);
  private
    { Private declarations }
    FDiff: TDiff;
    FHashListLeft, FHashListRight: TList;
    FResultLeft, FResultRight: TStringList;
    FSourceLeft, FSourceRight: TStringList;
    FSpecialChars: Boolean;
    FLineNumbers: Boolean;
    OldLeftGridProc, OldRightGridProc, OldDrawGridProc, OldLeftScrollBoxProc, OldRightScrollBoxProc: TWndMethod;
    function CheckIfFileExists(Filename: string): Boolean;
    function FormatText(Text: string): string;
    function GetComparedFilesSet: Boolean;
    procedure BuildHashListLeft;
    procedure BuildHashListRight;
    procedure ClearLeftGrid;
    procedure ClearRightGrid;
    procedure Compare;
    procedure DrawGridWindowProc(var Message: TMessage);
    procedure FillLeftGridFromSource;
    procedure FillRightGridFromSource;
    procedure LeftGridWindowProc(var Message: TMessage);
    procedure LeftScrollBoxWindowProc(var Message: TMessage);
    procedure OpenFileToLeftGrid(Filename: string);
    procedure OpenFileToRightGrid(Filename: string);
    procedure RightGridWindowProc(var Message: TMessage);
    procedure RightScrollBoxWindowProc(var Message: TMessage);
    procedure SaveGridChanges;
    procedure ScrollGrids(Row: Integer);
    procedure SetMaxCounts;
    procedure SetOpenDocumentsList(Value: TStringList);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetCompareFile(Filename: string; AFileDragDrop: Boolean = False);
    procedure RepaintFrame;
    function ToggleSpecialChars: Boolean;
    function ToggleLineNumbers: Boolean;
    procedure UpdateLanguage(SelectedLanguage: string);
    property ComparedFilesSet: Boolean read GetComparedFilesSet;
    property OpenDocumentsList: TStringList write SetOpenDocumentsList;
    property SpecialChars: Boolean write FSpecialChars;
    property LineNumbers: Boolean write FLineNumbers;
  end;

implementation

{$R *.dfm}

uses
  BCCommon.Hash, System.Math, System.Types, Vcl.Themes, BCCommon.LanguageStrings, BCCommon.Dialogs,
  BCCommon.OptionsContainer, BCCommon.Messages, BCCommon.Lib, BCCommon.LanguageUtils, BCCommon.StyleUtils;

const
  TabChar = WideChar($2192);       //'->'
  LineBreakChar = WideChar($00B6); //'¶'
  SpaceChar = WideChar($2219);     //'·'

procedure TCompareFrame.LeftScrollBoxWindowProc(var Message: TMessage);
begin
  OldLeftScrollBoxProc(Message);
  if (Message.Msg = WM_HSCROLL) or (Message.msg = WM_Mousewheel) then
    OldRightScrollBoxProc(Message);
end;

procedure TCompareFrame.RightScrollBoxWindowProc(var Message: TMessage);
begin
  OldRightScrollBoxProc(Message);
  if (Message.Msg = WM_HSCROLL) or (Message.msg = WM_Mousewheel) then
    OldLeftScrollBoxProc(Message);
end;

procedure TCompareFrame.LeftGridWindowProc(var Message: TMessage);
begin
  OldLeftGridProc(Message);
  if (Message.Msg = WM_VSCROLL) or (Message.msg = WM_Mousewheel) then
    OldRightGridProc(Message);
end;

procedure TCompareFrame.RightGridWindowProc(var Message: TMessage);
begin
  OldRightGridProc(Message);
  if (Message.Msg = WM_VSCROLL) or (Message.msg = WM_Mousewheel) then
    OldLeftGridProc(Message);
end;

procedure TCompareFrame.DrawGridWindowProc(var Message: TMessage);
begin
  OldDrawGridProc(Message);
  if (Message.Msg = WM_VSCROLL) or (Message.msg = WM_Mousewheel) then
  begin
    //DrawGrid.Invalidate;
    OldLeftGridProc(Message);
    OldRightGridProc(Message);
    //DrawGrid.Invalidate;
  end;
end;

constructor TCompareFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDiff := TDiff.Create(self);
  FSourceLeft := TStringList.Create;
  FSourceRight := TStringList.Create;
  FResultLeft := TStringList.Create;
  FResultRight := TStringList.Create;
  FHashListLeft := TList.Create;
  FHashListRight := TList.Create;

  OldLeftGridProc := LeftGrid.WindowProc;
  OldRightGridProc := RightGrid.WindowProc;
  OldDrawGridProc := DrawGrid.WindowProc;
  LeftGrid.WindowProc := LeftGridWindowProc;
  RightGrid.WindowProc := RightGridWindowProc;
  DrawGrid.WindowProc := DrawGridWindowProc;
  OldLeftScrollBoxProc := LeftScrollBox.WindowProc;
  OldRightScrollBoxProc := RightScrollBox.WindowProc;
  LeftScrollBox.WindowProc := LeftScrollBoxWindowProc;
  RightScrollBox.WindowProc := RightScrollBoxWindowProc;

  Panel.Padding.Right := GetRightPadding;
end;

function TCompareFrame.ToggleSpecialChars: Boolean;
begin
  FSpecialChars := not FSpecialChars;
  LeftGrid.Invalidate;
  RightGrid.Invalidate;
  Result := FSpecialChars;
end;

function TCompareFrame.ToggleLineNumbers: Boolean;
begin
  FLineNumbers := not FLineNumbers;
  LeftGrid.Invalidate;
  RightGrid.Invalidate;
  Result := FLineNumbers;
end;

destructor TCompareFrame.Destroy;
begin
  FSourceLeft.Free;
  FSourceRight.Free;
  FResultLeft.Free;
  FResultRight.Free;
  FHashListLeft.Free;
  FHashListRight.Free;
  inherited Destroy;
end;

procedure TCompareFrame.DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const
  PaleRed: TColor = $9999FF;
  PaleBlue: TColor = $FF9999;
  PaleGray: TColor = $D0D0D0;
var
  LeftRowColor, RightRowColor: TColor;
  LStyles: TCustomStyleServices;
  RowInsideVisibleRows: Boolean;
begin
  LStyles := StyleServices;
  LeftRowColor := clNone;
  RightRowColor := clNone;
  RowInsideVisibleRows := (ARow >= LeftGrid.TopRow) and (ARow < LeftGrid.TopRow + LeftGrid.VisibleRowCount);
  if FDiff.Count = 0 then
  with DrawGrid.Canvas do
  begin
    if LStyles.Enabled then
      Brush.Color := LStyles.GetStyleColor(scPanel)
    else
      Brush.Color := clWhite;
    FillRect(Rect);
  end
  else
  begin
    if (ARow < FDiff.Count) then
    case FDiff.Compares[ARow].Kind of
      ckNone:
        begin
          if LStyles.Enabled then
          begin
            LeftRowColor := LStyles.GetStyleColor(scPanel);
            RightRowColor := LStyles.GetStyleColor(scPanel);
          end
          else
          begin
            LeftRowColor := clWhite;
            RightRowColor := clWhite;
          end;

          if RowInsideVisibleRows then
          begin
            if LStyles.Enabled then
            begin
              LeftRowColor := LStyles.GetStyleColor(scEdit);
              RightRowColor := LStyles.GetStyleColor(scEdit);
            end
            else
            begin
              LeftRowColor := clSilver;
              RightRowColor := clSilver;
            end;
          end;
        end;
      ckModify:
        begin
          LeftRowColor := PaleRed;
          RightRowColor := PaleRed;
          if RowInsideVisibleRows then
          begin
            LeftRowColor := clRed;
            RightRowColor := clRed;
          end;
        end;
      ckDelete:
        begin
          if LStyles.Enabled then
            RightRowColor := LStyles.GetStyleColor(scEdit)
          else
            RightRowColor := PaleGray;
          LeftRowColor := PaleBlue;
          if RowInsideVisibleRows then
          begin
            LeftRowColor := clBlue;
            if LStyles.Enabled then
              RightRowColor := LStyles.GetStyleColor(scPanel)
            else
              RightRowColor := clBtnShadow;
          end;
        end;
      ckAdd:
        begin
          if LStyles.Enabled then
            LeftRowColor := LStyles.GetStyleColor(scEdit)
          else
            LeftRowColor := PaleGray;
          RightRowColor := PaleBlue;
          if RowInsideVisibleRows then
          begin
            if LStyles.Enabled then
              LeftRowColor := LStyles.GetStyleColor(scPanel)
            else
              LeftRowColor := clBtnShadow;
            RightRowColor := clBlue;
          end;
        end;
    end;

    with DrawGrid.Canvas do
    begin
      if RowInsideVisibleRows then
      begin
        if LStyles.Enabled then
          Brush.Color := LStyles.GetStyleColor(scBorder)
        else
          Brush.Color := clBlack;
        FillRect(System.Types.Rect(0, Rect.top, 1, Rect.bottom));
        if LStyles.Enabled then
          Brush.Color := LStyles.GetStyleColor(scBorder)
        else
          Brush.Color := clBlack;
        FillRect(System.Types.Rect(21, Rect.top, 22, Rect.bottom));
      end;

      { Draw grids }
      Brush.Color := LeftRowColor;
      FillRect(System.Types.Rect(1, Rect.top, 11, Rect.bottom));
      Brush.Color := RightRowColor;
      FillRect(System.Types.Rect(11, Rect.top, 21, Rect.bottom));

      if ARow = LeftGrid.Row then
      begin
        if LStyles.Enabled then
          Brush.Color := LStyles.GetSystemColor(clHighlight)
        else
          Brush.Color := clHighlight;

        FillRect(System.Types.Rect(1, Rect.top, 21, Rect.bottom));
      end;

      { Draw a rectangle around visible area }
      if LeftGrid.TopRow + LeftGrid.VisibleRowCount = ARow then
      begin
        if LStyles.Enabled then
          Brush.Color := LStyles.GetStyleColor(scBorder)
        else
          Brush.Color := clBlack;
        FillRect(System.Types.Rect(0, Rect.top, 22, Rect.bottom));
      end;
      if LeftGrid.TopRow - 1 = ARow then
      begin
        if LStyles.Enabled then
          Brush.Color := LStyles.GetStyleColor(scBorder)
        else
          Brush.Color := clBlack;
        FillRect(System.Types.Rect(0, Rect.top, 22, Rect.bottom));
      end;
    end;
  end;
end;

procedure TCompareFrame.DrawGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) then
    ScrollGrids(DrawGrid.Row);
end;

procedure TCompareFrame.ScrollGrids(Row: Integer);
begin
  if (LeftGrid.RowCount = 1) and (RightGrid.RowCount = 1) then
    Exit;

  DrawGrid.Row := Row;
  DrawGrid.Invalidate;
  LeftGrid.Row := Row;
  RightGrid.Row := Row;

  LeftMemo.Text := LeftGrid.Cells[1, Row];
  RightMemo.Text := RightGrid.Cells[1, Row];
end;

procedure TCompareFrame.DrawGridMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ScrollGrids(DrawGrid.Row);
end;

procedure TCompareFrame.DrawGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Shift = [ssLeft] then
    ScrollGrids(DrawGrid.Row);
end;

procedure TCompareFrame.DrawGridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  ScrollGrids(DrawGrid.Row);
end;

procedure TCompareFrame.DrawGridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  ScrollGrids(DrawGrid.Row);
end;

procedure TCompareFrame.DrawGridVerticalScroll(Sender: TObject);
begin
  DrawGrid.Invalidate;
end;

procedure TCompareFrame.FilenameEditLeftKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OpenFileToLeftGrid(FilenameLeftMemo.Text);
end;

procedure TCompareFrame.FilenameEditRightKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    OpenFileToRightGrid(FilenameRightMemo.Text);
end;

procedure TCompareFrame.LeftComboBoxChangeActionExecute(Sender: TObject);
begin
  FilenameLeftMemo.Text := LeftComboBox.Text;
  OpenFileToLeftGrid(FilenameLeftMemo.Text);
end;

procedure TCompareFrame.LeftComboBoxKeyPress(Sender: TObject; var Key: Char);
begin
  Key := #0;
end;

procedure TCompareFrame.LeftDocumentButtonClickActionExecute(Sender: TObject);
begin
  if BCCommon.Dialogs.OpenFile(Handle, FilenameLeftMemo.Text,
    Format('%s'#0'*.*'#0#0, [LanguageDataModule.GetConstant('AllFiles')]),
    LanguageDataModule.GetConstant('Open')) then
  begin
    Application.ProcessMessages; { style fix }
    FilenameLeftMemo.Text := BCCommon.Dialogs.Files[0];
    OpenFileToLeftGrid(BCCommon.Dialogs.Files[0]);
  end;
end;

procedure TCompareFrame.LeftMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if AnsiCompareStr(LeftGrid.Cells[1, LeftGrid.Row], LeftMemo.Text)<> 0 then
  begin
    UpdateLeftRowAction.Enabled := True;
    CancelLeftRowAction.Enabled := True;

    if Key = VK_RETURN then
      UpdateLeftRowAction.Execute;
  end;
end;

function TCompareFrame.FormatText(Text: string): string;
begin
  Result := Text;
  if FSpecialChars then
  begin
    Result := StringReplace(Result, #9, TabChar, [rfReplaceAll]);
    Result := StringReplace(Result, #32, SpaceChar, [rfReplaceAll]);
    Result := Result + LineBreakChar;
  end;
end;

procedure TCompareFrame.LeftGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const
  PaleRed: TColor = $6666FF;
  PaleBlue: TColor = $FF6666;
var
  s: string;
  clr: TColor;
  LStyles: TCustomStyleServices;
  LColor: TColor;
begin
  LStyles := StyleServices;

  if FDiff.Count = 0 then
  begin
    if LStyles.Enabled then
      clr := LStyles.GetStyleColor(scEdit)
    else
      clr := clWhite
  end
  else
  begin
    if LStyles.Enabled then
      clr := LStyles.GetSystemColor(clBtnFace)
    else
      clr := clBtnFace;
  end;

  if (ACol = 1) and (ARow < FDiff.Count) then
    case FDiff.Compares[ARow].Kind of
      ckNone:
        if LStyles.Enabled then
          clr := LStyles.GetStyleColor(scEdit)
        else
          clr := clWhite;
      ckModify:
        if LStyles.Enabled then
          clr := LStyles.GetSystemColor(PaleRed)
        else
          clr := PaleRed;
      ckDelete:
        if LStyles.Enabled then
          clr := LStyles.GetSystemColor(PaleBlue)
        else
          clr := PaleBlue;
      ckAdd:
        if LStyles.Enabled then
          clr := LStyles.GetSystemColor(clBtnFace)
        else
          clr := clBtnFace;
    end;

  with LeftGrid.Canvas do
  begin
    if not LStyles.GetElementColor(LStyles.GetElementDetails(tgCellNormal), ecTextColor, LColor) or  (LColor = clNone) then
      LColor := LStyles.GetSystemColor(clWindowText);
    //get and set the background color
    Brush.Color := LStyles.GetStyleColor(scListView);
    Font.Color := LColor;
    if (gdSelected in State) then
    begin
      if LStyles.Enabled then
      begin
        Brush.Color := LStyles.GetSystemColor(clHighlight);
        Font.Color := LStyles.GetSystemColor(clHighlightText);
      end
      else
      begin
        Brush.Color := clHighlight;
        Font.Color := clHighlightText;
      end;
    end
    else
      Brush.Color := clr;
    FillRect(Rect);
    s := LeftGrid.Cells[ACol, ARow];
    if ACol = 1 then
      s := FormatText(s);
    if (ACol = 0) and not FLineNumbers then
      s := '';
    TextRect(Rect, Rect.Left + 3, Rect.top + 2, s);

    if FSourceLeft.Count = 0 then
      Exit;

    if ACol = 0 then
    begin
      if LStyles.Enabled then
        Pen.Color := LStyles.GetStyleColor(scEdit)
      else
        Pen.Color := clWhite;
      MoveTo(Rect.Right - 1, 0);
      LineTo(Rect.Right - 1, Rect.bottom);
    end
    else
    begin
      if (ACol = 1) then
      begin
        if LStyles.Enabled then
          Pen.Color := LStyles.GetSystemColor($333333)
        else
          Pen.Color := $333333;
        MoveTo(Rect.Right - 1, 0);
        LineTo(Rect.Right - 1, Rect.bottom);
      end;
      if LStyles.Enabled then
        Pen.Color := LStyles.GetStyleColor(scPanel)
      else
        Pen.Color := clSilver;
      MoveTo(Rect.Left, 0);
      LineTo(Rect.Left, Rect.bottom);
    end;
  end;
end;

procedure TCompareFrame.LeftGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_PRIOR then
    LeftGrid.Row := Max(LeftGrid.Row - LeftGrid.VisibleRowCount, 0);
  if Key = VK_NEXT then
    LeftGrid.Row := Min(LeftGrid.Row + LeftGrid.VisibleRowCount, LeftGrid.RowCount - 1);
  if (Key = VK_PRIOR) or (Key = VK_NEXT) then 
    Key := 0;
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT) then  
    ScrollGrids(LeftGrid.Row);
end;

procedure TCompareFrame.LeftGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT) then 
    ScrollGrids(LeftGrid.Row);
end;

procedure TCompareFrame.LeftGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ScrollGrids(LeftGrid.Row);
end;

procedure TCompareFrame.LeftGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Shift = [ssLeft] then
    ScrollGrids(LeftGrid.Row);
end;

procedure TCompareFrame.LeftGridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  ScrollGrids(LeftGrid.Row);
  Handled := True;
end;

procedure TCompareFrame.LeftGridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  ScrollGrids(LeftGrid.Row);
  Handled := True;
end;

procedure TCompareFrame.RightMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if AnsiCompareStr(RightGrid.Cells[1, RightGrid.Row], RightMemo.Text)<> 0 then
  begin
    UpdateRightRowAction.Enabled := True;
    CancelRightRowAction.Enabled := True;

    if Key = VK_RETURN then
      UpdateRightRowAction.Execute;
  end;
end;

procedure TCompareFrame.RightGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const
  PaleRed: TColor = $6666FF;
  PaleBlue: TColor = $FF6666;
var
  s: string;
  clr: TColor;
  LStyles: TCustomStyleServices;
  LColor: TColor;
begin
  LStyles := StyleServices;

  if FDiff.Count = 0 then
  begin
    if LStyles.Enabled then
      clr := LStyles.GetStyleColor(scEdit)
    else
      clr := clWhite
  end
  else
  begin
    if LStyles.Enabled then
      clr := LStyles.GetSystemColor(clBtnFace)
    else
      clr := clBtnFace;
  end;

  if (ACol in [1, 3]) and (ARow < FDiff.Count) then
    case FDiff.Compares[ARow].Kind of
      ckNone:
        if LStyles.Enabled then
          clr := LStyles.GetStyleColor(scEdit)
        else
          clr := clWhite;
      ckModify:
        if LStyles.Enabled then
          clr := LStyles.GetSystemColor(PaleRed)
        else
          clr := PaleRed;
      ckDelete:
        if LStyles.Enabled then
          clr := LStyles.GetSystemColor(clBtnFace)
        else
          clr := clBtnFace;
      ckAdd:
        if LStyles.Enabled then
          clr := LStyles.GetSystemColor(PaleBlue)
        else
          clr := PaleBlue;
    end;

  with RightGrid.Canvas do
  begin
    if not LStyles.GetElementColor(LStyles.GetElementDetails(tgCellNormal), ecTextColor, LColor) or  (LColor = clNone) then
      LColor := LStyles.GetSystemColor(clWindowText);
    //get and set the background color
    Brush.Color := LStyles.GetStyleColor(scListView);
    Font.Color := LColor;
    if (gdSelected in State) then
    begin
      if LStyles.Enabled then
      begin
        Brush.Color := LStyles.GetSystemColor(clHighlight);
        Font.Color := LStyles.GetSystemColor(clHighlightText);
      end
      else
      begin
        Brush.Color := clHighlight;
        Font.Color := clHighlightText;
      end;
    end
    else
      Brush.Color := clr;
    FillRect(Rect);
    s := RightGrid.Cells[ACol, ARow];
    if ACol = 1 then
      s := FormatText(s);
    if (ACol = 0) and not FLineNumbers then
      s := '';
    TextRect(Rect, Rect.Left + 3, Rect.top + 2, s);

    if FSourceRight.Count = 0 then
      Exit;

    if ACol = 0 then
    begin
      if LStyles.Enabled then
        Pen.Color := LStyles.GetStyleColor(scEdit)
      else
        Pen.Color := clWhite;
      MoveTo(Rect.Right - 1, 0);
      LineTo(Rect.Right - 1, Rect.bottom);
    end
    else
    begin
      if (ACol = 1) then
      begin
        if LStyles.Enabled then
          Pen.Color := LStyles.GetSystemColor($333333)
        else
          Pen.Color := $333333;
        MoveTo(Rect.Right - 1, 0);
        LineTo(Rect.Right - 1, Rect.bottom);
      end;
      if LStyles.Enabled then
        Pen.Color := LStyles.GetStyleColor(scPanel)
      else
        Pen.Color := clSilver;
      MoveTo(Rect.Left, 0);
      LineTo(Rect.Left, Rect.bottom);
    end;
  end;
end;

procedure TCompareFrame.RightGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_PRIOR then
    RightGrid.Row := Max(RightGrid.Row - RightGrid.VisibleRowCount, 0);
  if Key = VK_NEXT then
    RightGrid.Row := Min(RightGrid.Row + RightGrid.VisibleRowCount, RightGrid.RowCount - 1);
  if (Key = VK_PRIOR) or (Key = VK_NEXT) then 
    Key := 0;
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT) then 
    ScrollGrids(RightGrid.Row);
end;

procedure TCompareFrame.RightGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT) then
    ScrollGrids(RightGrid.Row);
end;

procedure TCompareFrame.RightGridMouseDown
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ScrollGrids(RightGrid.Row);
end;

procedure TCompareFrame.RightGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Shift = [ssLeft] then
    ScrollGrids(RightGrid.Row);
end;

procedure TCompareFrame.RightGridMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  ScrollGrids(RightGrid.Row);
  Handled := True;
end;

procedure TCompareFrame.RightGridMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  ScrollGrids(RightGrid.Row);
  Handled := True;
end;

procedure TCompareFrame.SaveGridChanges;
begin
  if SaveLeftGridAction.Enabled then
    if SaveChanges(False) = mrYes then
      SaveLeftGridAction.Execute;
  if SaveRightGridAction.Enabled then
    if SaveChanges(False) = mrYes then
      SaveRightGridAction.Execute;
end;

procedure TCompareFrame.RefreshActionExecute(Sender: TObject);
begin
  SaveGridChanges;
  OpenFileToLeftGrid(FilenameLeftMemo.Text);
  OpenFileToRightGrid(FilenameRightMemo.Text);
end;

procedure TCompareFrame.SaveLeftGridActionExecute(Sender: TObject);
begin
  FSourceLeft.SaveToFile(FilenameLeftMemo.Text);
  SaveLeftGridAction.Enabled := False;
end;

procedure TCompareFrame.SaveRightGridActionExecute(Sender: TObject);
begin
  FSourceRight.SaveToFile(FilenameRightMemo.Text);
  SaveRightGridAction.Enabled := False;
end;

procedure TCompareFrame.CancelLeftRowActionExecute(Sender: TObject);
begin
  LeftMemo.Text := LeftGrid.Cells[1, LeftGrid.Row];
  UpdateLeftRowAction.Enabled := False;
  CancelLeftRowAction.Enabled := False;
end;

procedure TCompareFrame.CancelRightRowActionExecute(Sender: TObject);
begin
  RightMemo.Text := RightGrid.Cells[1, RightGrid.Row];
  UpdateRightRowAction.Enabled := False;
  CancelRightRowAction.Enabled := False;
end;

function TCompareFrame.CheckIfFileExists(Filename: string): Boolean;
begin
  Result := FileExists(Filename);
  if not Result then
    ShowErrorMessage(Format(LanguageDataModule.GetErrorMessage('FileNotFound'), [Filename]))
end;

procedure TCompareFrame.OpenDocumentsLeftActionExecute(Sender: TObject);
begin
  LeftComboBox.DroppedDown := not LeftComboBox.DroppedDown;
end;

procedure TCompareFrame.OpenDocumentsRightActionExecute(Sender: TObject);
begin
  RightComboBox.DroppedDown := not RightComboBox.DroppedDown;
end;

procedure TCompareFrame.OpenFileToLeftGrid(Filename: string);
var
  FName: string;
begin
  ClearLeftGrid;

  FName := Trim(System.SysUtils.StringReplace(Filename, '"', '', [rfReplaceAll]));
  if FName = '' then
    Exit;

  if not CheckIfFileExists(FName) then
    Exit;

  FSourceLeft.LoadFromFile(FName);
  BuildHashListLeft;
  SetMaxCounts;
  FillLeftGridFromSource;
  if LeftComboBox.Items.IndexOf(FName) = -1 then
    LeftComboBox.Items.Add(FName);
  Compare;
  FindNextDifferenceAction.Enabled := ((FDiff.DiffStats.adds <> 0) or
    (FDiff.DiffStats.deletes <> 0) or (FDiff.DiffStats.modifies <> 0)) and
    (FSourceRight.Count <> 0) and (FSourceLeft.Count <> 0);
  RefreshAction.Enabled := (FSourceRight.Count <> 0) and (FSourceLeft.Count <> 0);
  CopySelectionRightAction.Enabled := (FSourceRight.Count <> 0) and (FSourceLeft.Count <> 0);
  CopySelectionLeftAction.Enabled := (FSourceRight.Count <> 0) and (FSourceLeft.Count <> 0);
  AutoSizeCol(LeftGrid);
  if FSourceRight.Count <> 0 then
    AutoSizeCol(RightGrid);

  LeftMemo.Enabled := True;
  LeftMemo.Text := LeftGrid.Cells[1, 0];

  DrawGrid.Enabled := True;
  DrawGrid.RowCount := Max(LeftGrid.RowCount, RightGrid.RowCount);
  SetMaxCounts;
  DrawGrid.Invalidate;
end;

procedure TCompareFrame.OpenFileToRightGrid(Filename: string);
var
  FName: string;
begin
  ClearRightGrid;

  FName :=  Trim(System.SysUtils.StringReplace(Filename, '"', '', [rfReplaceAll]));
  if FName = '' then
    Exit;

  if not CheckIfFileExists(FName) then
    Exit;

  FSourceRight.LoadFromFile(FName);
  BuildHashListRight;
  SetMaxCounts;
  FillRightGridFromSource;
  if RightComboBox.Items.IndexOf(FName) = -1 then
    RightComboBox.Items.Add(FName);
  Compare;
  FindNextDifferenceAction.Enabled := ((FDiff.DiffStats.adds <> 0) or
    (FDiff.DiffStats.deletes <> 0) or (FDiff.DiffStats.modifies <> 0)) and
    (FSourceRight.Count <> 0) and (FSourceLeft.Count <> 0);
  RefreshAction.Enabled := (FSourceRight.Count <> 0) and (FSourceLeft.Count <> 0);
  CopySelectionRightAction.Enabled := (FSourceRight.Count <> 0) and (FSourceLeft.Count <> 0);
  CopySelectionLeftAction.Enabled := (FSourceRight.Count <> 0) and (FSourceLeft.Count <> 0);
  AutoSizeCol(RightGrid);

  if FSourceLeft.Count <> 0 then
    AutoSizeCol(LeftGrid);

  RightMemo.Enabled := True;
  RightMemo.Text := RightGrid.Cells[1, 0];

  DrawGrid.Enabled := True;
  DrawGrid.RowCount := Max(LeftGrid.RowCount, RightGrid.RowCount);
  DrawGrid.Invalidate;
end;

procedure TCompareFrame.ClearLeftGrid;
begin
  FSourceLeft.Clear;
  FResultLeft.Clear;
  FHashListLeft.Clear;
  LeftGrid.Clear;
  LeftGrid.RowCount := 0;
  SaveLeftGridAction.Enabled := False;
  CopySelectionRightAction.Enabled := False;
  UpdateLeftRowAction.Enabled := False;
  CancelLeftRowAction.Enabled := False;
  FDiff.Clear;
  FindNextDifferenceAction.Enabled := False;
  RefreshAction.Enabled := False;
  LeftMemo.Text := '';
  LeftMemo.Enabled := False;
end;

procedure TCompareFrame.ClearRightGrid;
begin
  FSourceRight.Clear;
  FResultRight.Clear;
  FHashListRight.Clear;
  RightGrid.Clear;
  RightGrid.RowCount := 0;
  SaveRightGridAction.Enabled := False;
  CopySelectionLeftAction.Enabled := False;
  UpdateRightRowAction.Enabled := False;
  CancelRightRowAction.Enabled := False;
  FDiff.Clear;
  FindNextDifferenceAction.Enabled := False;
  RefreshAction.Enabled := False;
  RightMemo.Text := '';
  RightMemo.Enabled := False;
end;

procedure TCompareFrame.RightComboBoxChangeActionExecute(Sender: TObject);
begin
  FilenameRightMemo.Text := RightComboBox.Text;
  OpenFileToRightGrid(FilenameRightMemo.Text);
end;

procedure TCompareFrame.RightDocumentButtonClickActionExecute(Sender: TObject);
begin
  if BCCommon.Dialogs.OpenFile(Handle, FilenameRightMemo.Text,
    Format('%s'#0'*.*'#0#0, [LanguageDataModule.GetConstant('AllFiles')]),
    LanguageDataModule.GetConstant('Open')) then
  begin
    Application.ProcessMessages; { style fix }
    FilenameRightMemo.Text := BCCommon.Dialogs.Files[0];
    OpenFileToRightGrid(BCCommon.Dialogs.Files[0]);
  end;
end;

procedure TCompareFrame.BuildHashListLeft;
var
  i: Integer;
begin
  FHashListLeft.Clear;
  for i := 0 to FSourceLeft.Count - 1 do
    FHashListLeft.Add(HashLine(FSourceLeft[i], OptionsContainer.IgnoreCase, OptionsContainer.IgnoreBlanks));
end;

procedure TCompareFrame.BuildHashListRight;
var
  i: Integer;
begin
  FHashListRight.Clear;
  for i := 0 to FSourceRight.Count - 1 do
    FHashListRight.Add(HashLine(FSourceRight[i], OptionsContainer.IgnoreCase, OptionsContainer.IgnoreBlanks));
end;

procedure TCompareFrame.SetMaxCounts;
begin
  LeftGrid.RowCount := Max(FSourceLeft.Count, FSourceRight.Count);
  RightGrid.RowCount := LeftGrid.RowCount;
  DrawGrid.RowCount := LeftGrid.RowCount;
end;

procedure TCompareFrame.UpdateLeftRowActionExecute(Sender: TObject);
var
  i: Integer;
begin
  SaveLeftGridAction.Enabled := True;
  LeftGrid.Cells[1, LeftGrid.Row] := LeftMemo.Text;
  if LeftGrid.Cells[0, LeftGrid.Row] = '' then
    LeftGrid.Cells[0, LeftGrid.Row] := '+';

  FSourceLeft.Clear;
  for i := 0 to LeftGrid.RowCount - 1 do
  begin
    if LeftGrid.Cells[0, i] <> '' then
      FSourceLeft.Add(LeftGrid.Cells[1, i]);
  end;
  BuildHashListLeft;
  Compare;
  DrawGrid.Invalidate;

  UpdateLeftRowAction.Enabled := False;
  CancelLeftRowAction.Enabled := False;
end;

procedure TCompareFrame.UpdateRightRowActionExecute(Sender: TObject);
var
  i: Integer;
begin
  SaveRightGridAction.Enabled := True;
  RightGrid.Cells[1, RightGrid.Row] := RightMemo.Text;
  if RightGrid.Cells[0, RightGrid.Row] = '' then
    RightGrid.Cells[0, RightGrid.Row] := '+';

  FSourceRight.Clear;
  for i := 0 to RightGrid.RowCount - 1 do
  begin
    if RightGrid.Cells[0, i] <> '' then
      FSourceRight.Add(RightGrid.Cells[1, i]);
  end;
  BuildHashListRight;
  Compare;
  DrawGrid.Invalidate;

  UpdateRightRowAction.Enabled := False;
  CancelRightRowAction.Enabled := False;
end;

procedure TCompareFrame.FillLeftGridFromSource;
var
  i: Integer;
begin
  for i := 0 to 1 do
    LeftGrid.Cols[i].BeginUpdate;
  try
    for i := 0 to FSourceLeft.Count - 1 do
    begin
      LeftGrid.Cells[0, i] := IntToStr(i + 1);
      LeftGrid.Cells[1, i] := FSourceLeft[i];
    end;
  finally
    for i := 0 to 1 do
      LeftGrid.Cols[i].EndUpdate;
  end;
end;

procedure TCompareFrame.FillRightGridFromSource;
var
  i: Integer;
begin
  for i := 0 to 1 do
    RightGrid.Cols[i].BeginUpdate;
  try
    for i := 0 to FSourceRight.Count - 1 do
    begin
      RightGrid.Cells[0, i] := IntToStr(i + 1);
      RightGrid.Cells[1, i] := FSourceRight[i];
    end;
  finally
    for i := 0 to 1 do
      RightGrid.Cols[i].EndUpdate;
  end;
end;

procedure TCompareFrame.FindNextDifferenceActionExecute(Sender: TObject);
var
  Row: Integer;
begin
  if (FDiff.DiffStats.adds = 0) and
     (FDiff.DiffStats.deletes = 0) and
     (FDiff.DiffStats.modifies = 0)then
    Exit;
  Row := Min(LeftGrid.Row + 1, LeftGrid.RowCount - 1);
  while (Row < LeftGrid.RowCount - 1) and (FDiff.Compares[Row].Kind = ckNone) do
    Inc(Row);
  if FDiff.Compares[Row].Kind <> ckNone then
    ScrollGrids(Row);
end;

procedure TCompareFrame.FrameResize(Sender: TObject);
begin
  LeftPanel.Width := ((Width - DrawBarPanel.Width) div 2);
  RightPanel.Width := LeftPanel.Width;
  if Width mod 2 <> 0 then
    RightPanel.Width := RightPanel.Width - 1;
  DrawGrid.Invalidate;
  FilenameLeftMemo.Repaint;
  FilenameRightMemo.Repaint;
  Invalidate;
end;

procedure TCompareFrame.Compare;
var
  i: Integer;
begin
  if (FHashListLeft.Count = 0) or (FHashListRight.Count = 0) then
    Exit;
  FDiff.Clear;
  Screen.Cursor := crHourGlass;
  try
    //FDiff.Execute(PInteger(FHashListLeft.List), PInteger(FHashListRight.List),
    //  FHashListLeft.Count, FHashListRight.Count);
    FDiff.Execute(FHashListLeft.List, FHashListRight.List,
      FHashListLeft.Count, FHashListRight.Count);
    if FDiff.Cancelled then
      Exit;

    { fill ResultGrid with the differences }
    for i := 0 to 1 do
    begin
      LeftGrid.Cols[i].BeginUpdate;
      LeftGrid.Cols[i].Clear;
      RightGrid.Cols[i].BeginUpdate;
      RightGrid.Cols[i].Clear;
    end;
    try
      LeftGrid.RowCount := FDiff.Count;
      RightGrid.RowCount := FDiff.Count;
      for i := 0 to FDiff.Count - 1 do
        with FDiff.Compares[i] do
        begin
          if Kind <> ckAdd then
          begin
            LeftGrid.Cells[0, i] := IntToStr(oldIndex1 + 1);
            LeftGrid.Cells[1, i] := FSourceLeft[oldIndex1];
          end;
          if Kind <> ckDelete then
          begin
            RightGrid.Cells[0, i] := IntToStr(oldIndex2 + 1);
            RightGrid.Cells[1, i] := FSourceRight[oldIndex2];
          end;
        end;
    finally
      for i := 0 to 1 do
      begin
        LeftGrid.Cols[i].EndUpdate;
        RightGrid.Cols[i].EndUpdate;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCompareFrame.CopySelectionLeftActionExecute(Sender: TObject);
var
  i: Integer;
begin
  SaveLeftGridAction.Enabled := True;
  for i := RightGrid.Selection.bottom downto RightGrid.Selection.top do
  begin
    case FDiff.Compares[i].Kind of
      ckNone, ckModify:
        LeftGrid.Cells[1, i] := RightGrid.Cells[1, i];
      ckAdd:
      begin
        LeftGrid.Cells[0, i] := '+';
        LeftGrid.Cells[1, i] := RightGrid.Cells[1, i];
      end;
      ckDelete:
        LeftGrid.RemoveRow(i);
    end;
  end;
  FSourceLeft.Clear;
  for i := 0 to LeftGrid.RowCount - 1 do
  begin
    if LeftGrid.Cells[0, i] <> '' then
      FSourceLeft.Add(LeftGrid.Cells[1, i]);
  end;
  BuildHashListLeft;
  SetMaxCounts;
  Compare;
  AutoSizeCol(LeftGrid);
  LeftMemo.Text := LeftGrid.Cells[1, LeftGrid.Row];
  DrawGrid.Invalidate;
end;

procedure TCompareFrame.CopySelectionRightActionExecute(Sender: TObject);
var
  i: Integer;
begin
  SaveRightGridAction.Enabled := True;
  for i := LeftGrid.Selection.Bottom downto LeftGrid.Selection.Top do
  begin
    case FDiff.Compares[i].Kind of
      ckNone, ckModify:
        RightGrid.Cells[1, i] := LeftGrid.Cells[1, i];
      ckDelete:
      begin
        RightGrid.Cells[0, i] := '+';
        RightGrid.Cells[1, i] := LeftGrid.Cells[1, i];
      end;
      ckAdd:
        RightGrid.RemoveRow(i);
    end;
  end;
  FSourceRight.Clear;
  for i := 0 to RightGrid.RowCount - 1 do
  begin
    if RightGrid.Cells[0, i] <> '' then
      FSourceRight.Add(RightGrid.Cells[1, i]);
  end;
  BuildHashListRight;
  SetMaxCounts;
  Compare;
  AutoSizeCol(RightGrid);
  RightMemo.Text := RightGrid.Cells[1, RightGrid.Row];
  DrawGrid.Invalidate;
end;

procedure TCompareFrame.SetOpenDocumentsList(Value: TStringList);
begin
  Value.Sort;
  LeftComboBox.Items := Value;
  RightComboBox.Items := Value;
end;

function TCompareFrame.GetComparedFilesSet: Boolean;
begin
  Result := (FilenameLeftMemo.Text <> '') and (FilenameRightMemo.Text <> '');
end;

procedure TCompareFrame.SetCompareFile(Filename: string; AFileDragDrop: Boolean);
begin
  if (not AFileDragDrop and (FilenameLeftMemo.Text = '')) or
    (AFileDragDrop and LeftScrollBox.MouseInClient) then
  begin
    FilenameLeftMemo.Text := Filename;
    OpenFileToLeftGrid(FilenameLeftMemo.Text);
  end
  else
  if (not AFileDragDrop and (FilenameRightMemo.Text = '')) or
    (AFileDragDrop and RightScrollBox.MouseInClient) then
  begin
    FilenameRightMemo.Text := Filename;
    OpenFileToRightGrid(FilenameRightMemo.Text);;
  end;
end;

procedure TCompareFrame.UpdateLanguage(SelectedLanguage: string);
begin
  BCCommon.LanguageUtils.UpdateLanguage(TForm(Self), SelectedLanguage);
  LeftRightPanel.Width := Max(LeftLabel.Width + 10, RightLabel.Width + 10);
end;

procedure TCompareFrame.RepaintFrame;
begin
  FilenameLeftMemo.Repaint;
  FilenameRightMemo.Repaint;
  LeftGrid.Repaint;
  RightGrid.Repaint;
  LeftMemo.Repaint;
  RightMemo.Repaint;
end;

end.

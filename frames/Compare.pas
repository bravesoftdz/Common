unit Compare;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Diff, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls, JvExStdCtrls,
  Vcl.Mask, JvExMask, JvToolEdit, Vcl.Buttons, JvExControls, JvSpeedButton, BCEdit, JvStringGrid,
  BCStringGrid, Vcl.ActnList, JvScrollBar, JvExForms, JvExExtCtrls, JvSplitter, JvExtComponent,
  JvContentScroller, JvExGrids, JvEdit, JvCombobox, BCComboBox, Vcl.ImgList;

type
  TGridEventType = (etNone, etMouse, etKey);

  TSyncKind = (skBoth, skVScroll, skHScroll);

  TCompareFrame = class(TFrame)
    LeftPanel: TPanel;
    BottomPanel: TPanel;
    ActionList: TActionList;
    RefreshAction: TAction;
    SaveLeftGridAction: TAction;
    SaveRightGridAction: TAction;
    LeftGridOnChangeAction: TAction;
    RightGridOnChangeAction: TAction;
    RightPanel: TPanel;
    RightTopPanel: TPanel;
    SaveSpeedButton2: TJvSpeedButton;
    LeftTopPanel: TPanel;
    SaveSpeedButton1: TJvSpeedButton;
    FindNextDifferenceAction: TAction;
    CopyRightSpeedButton: TJvSpeedButton;
    CopyLeftSpeedButton: TJvSpeedButton;
    CopySelectionRightAction: TAction;
    CopySelectionLeftAction: TAction;
    UpdateLeftRowAction: TAction;
    UpdateRightRowAction: TAction;
    CancelLeftRowAction: TAction;
    CancelRightRowAction: TAction;
    LeftScrollBox: TScrollBox;
    LeftGrid: TBCStringGrid;
    DrawBarPanel: TPanel;
    RightScrollBox: TScrollBox;
    RightGrid: TBCStringGrid;
    TopMiddlePanel: TPanel;
    FindNextDifferenceSpeedButton: TJvSpeedButton;
    RefreshSpeedButton: TJvSpeedButton;
    DrawGrid: TJvStringGrid;
    LeftComboBox: TBCComboBox;
    LeftComboBoxChangeAction: TAction;
    RightComboBoxChangeAction: TAction;
    RightComboBox: TBCComboBox;
    OpenDocumentsLeftSpeedButton: TJvSpeedButton;
    OpenDocumentsRightSpeedButton: TJvSpeedButton;
    OpenDocumentsLeftAction: TAction;
    OpenDocumentsRightAction: TAction;
    ImageList: TImageList;
    BitBtn1: TJvSpeedButton;
    FilenameLeftMemo: TMemo;
    LeftDocumentButtonClickAction: TAction;
    FilenameRightMemo: TMemo;
    JvSpeedButton1: TJvSpeedButton;
    RightDocumentButtonClickAction: TAction;
    LeftRightPanel: TPanel;
    LeftLabel: TLabel;
    RightLabel: TLabel;
    Panel2: TPanel;
    LeftMemo: TMemo;
    RightMemo: TMemo;
    UpdateLeftSpeedButton: TJvSpeedButton;
    CancelLeftSpeedButton: TJvSpeedButton;
    CancelRightSpeedButton: TJvSpeedButton;
    UpdateRightSpeedButton: TJvSpeedButton;
    procedure DrawGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RefreshActionExecute(Sender: TObject);
    procedure SaveLeftGridActionExecute(Sender: TObject);
    procedure SaveRightGridActionExecute(Sender: TObject);
    procedure LeftGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure RightGridDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FrameResize(Sender: TObject);
    procedure DrawGridMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure DrawGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RightGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RightGridMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure LeftGridMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure LeftGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LeftGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LeftGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RightGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RightGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DrawGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FindNextDifferenceActionExecute(Sender: TObject);
    procedure FilenameEditRightKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FilenameEditLeftKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CopySelectionRightActionExecute(Sender: TObject);
    procedure CopySelectionLeftActionExecute(Sender: TObject);
    procedure UpdateLeftRowActionExecute(Sender: TObject);
    procedure UpdateRightRowActionExecute(Sender: TObject);
    procedure CancelLeftRowActionExecute(Sender: TObject);
    procedure CancelRightRowActionExecute(Sender: TObject);
    procedure VerticalScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode; var ScrollPos: Integer);
    procedure LeftComboBoxChangeActionExecute(Sender: TObject);
    procedure RightComboBoxChangeActionExecute(Sender: TObject);
    procedure LeftComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure OpenDocumentsLeftActionExecute(Sender: TObject);
    procedure OpenDocumentsRightActionExecute(Sender: TObject);
    procedure LeftMemoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RightMemoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LeftDocumentButtonClickActionExecute(Sender: TObject);
    procedure RightDocumentButtonClickActionExecute(Sender: TObject);
  private
    { Private declarations }
    FDiff: TDiff;
    FSourceLeft, FSourceRight: TStringList;
    FResultLeft, FResultRight: TStringList;
    FHashListLeft, FHashListRight: TList;
    FPreviousRow: Integer;
    OldLeftGridProc, OldRightGridProc, OldDrawGridProc, OldLeftScrollBoxProc, OldRightScrollBoxProc: TWndMethod;
    procedure SetOpenDocumentsList(Value: TStringList);
    procedure LeftGridWindowProc(var Message: TMessage);
    procedure RightGridWindowProc(var Message: TMessage);
    procedure DrawGridWindowProc(var Message: TMessage);
//    procedure ScrollGridWindowProc(var Message: TMessage);
    procedure LeftScrollBoxWindowProc(var Message: TMessage);
    procedure RightScrollBoxWindowProc(var Message: TMessage);

    procedure OpenFileToLeftGrid(Filename: string);
    procedure OpenFileToRightGrid(Filename: string);
    function CheckIfFileExists(Filename: string): Boolean;
    procedure ClearLeftGrid;
    procedure ClearRightGrid;
    procedure BuildHashListLeft;
    procedure BuildHashListRight;
    procedure SetMaxCounts;
    procedure FillLeftGridFromSource;
    procedure FillRightGridFromSource;
    procedure Compare;
    procedure ScrollGrids(Row: Integer; EventType: TGridEventType = etNone);
    procedure SaveGridChanges;
    function GetComparedFilesSet: Boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property OpenDocumentsList: TStringList write SetOpenDocumentsList;
    property ComparedFilesSet: Boolean read GetComparedFilesSet;
    procedure SetCompareFile(Filename: string);
    procedure UpdateLanguage(SelectedLanguage: string);
  end;

implementation

{$R *.dfm}

uses
  Common, Hash, System.Math, System.Types, Vcl.Themes, Language, CommonDialogs;

procedure TCompareFrame.LeftScrollBoxWindowProc(var Message: TMessage);
begin
  OldLeftScrollBoxProc(Message);
  if  (Message.Msg = WM_HSCROLL) or (Message.msg = WM_Mousewheel) then
    OldRightScrollBoxProc(Message);
end;

procedure TCompareFrame.RightScrollBoxWindowProc(var Message: TMessage);
begin
  OldRightScrollBoxProc(Message);
  if  (Message.Msg = WM_HSCROLL) or (Message.msg = WM_Mousewheel) then
    OldLeftScrollBoxProc(Message);
end;

procedure TCompareFrame.LeftGridWindowProc(var Message: TMessage);
begin
  OldLeftGridProc(Message);
  if ((Message.Msg = WM_VSCROLL) or //(Message.Msg = WM_HSCROLL) or
      (Message.msg = WM_Mousewheel)) then
  begin
    OldRightGridProc(Message);
    //OldDrawGridProc(Message);
    //DrawGrid.Invalidate;

  end;
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
    OldLeftGridProc(Message);
    OldRightGridProc(Message);
    DrawGrid.Invalidate;
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
  PaleRed: TColor = $6666FF;
  PaleBlue: TColor = $FF6666;
  PaleGray: TColor = $D0D0D0;
var
  lclr, rclr: TColor;
  LStyles: TCustomStyleServices;
begin
  LStyles := StyleServices;
  lclr := clNone;
  rclr := clNone;
  if FDiff.Count = 0 then
    with DrawGrid.Canvas do
    begin
      if LStyles.Enabled then
        Brush.Color := LStyles.GetSystemColor(clBtnFace)
      else
        Brush.Color := clBtnFace;
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
                lclr := LStyles.GetStyleColor(scEdit);
                rclr := LStyles.GetStyleColor(scEdit);
              end
              else
              begin
                lclr := clSilver;
                rclr := clSilver;
              end;

              //if (ARow < FGridVisibleBottom) and (ARow >= FGridVisibleTop) then
              if (ARow < LeftGrid.TopRow + LeftGrid.VisibleRowCount) and (ARow >= LeftGrid.TopRow) then
              begin
                if LStyles.Enabled then
                begin
                  lclr := LStyles.GetStyleColor(scPanel);
                  rclr := LStyles.GetStyleColor(scPanel);
                end
                else
                begin
                  lclr := clWhite;
                  rclr := clWhite;
                end;
              end;
            end;
          ckModify:
            begin
              lclr := clRed;
              rclr := clRed;
             // if (ARow < FGridVisibleBottom) and (ARow >= FGridVisibleTop) then
              if (ARow < LeftGrid.TopRow + LeftGrid.VisibleRowCount) and (ARow >= LeftGrid.TopRow) then
              begin
                lclr := PaleRed;
                rclr := PaleRed;
              end;
            end;
          ckDelete:
            begin
              if LStyles.Enabled then
                rclr := LStyles.GetStyleColor(scPanel)
              else
                rclr := clBtnShadow;
              lclr := clBlue;
              if (ARow < LeftGrid.TopRow + LeftGrid.VisibleRowCount) and (ARow >= LeftGrid.TopRow) then
              begin
                lclr := PaleBlue;
                if LStyles.Enabled then
                  rclr := LStyles.GetStyleColor(scEdit)
                else
                  rclr := PaleGray;
              end;
            end;
          ckAdd:
            begin
              if LStyles.Enabled then
                  lclr := LStyles.GetStyleColor(scPanel)
                else
                  lclr := clBtnShadow;
              rclr := clBlue;
              if (ARow < LeftGrid.TopRow + LeftGrid.VisibleRowCount) and (ARow >= LeftGrid.TopRow) then
              begin
                if LStyles.Enabled then
                  lclr := LStyles.GetStyleColor(scEdit)
                else
                  lclr := PaleGray;
                rclr := PaleBlue;
              end;
            end;
        end;

      with DrawGrid.Canvas do
      begin
        if (ARow < LeftGrid.TopRow + LeftGrid.VisibleRowCount) and (ARow >= LeftGrid.TopRow) then
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
        Brush.Color := lclr;
        FillRect(System.Types.Rect(1, Rect.top, 11, Rect.bottom));
        Brush.Color := rclr;
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

procedure TCompareFrame.VerticalScrollBarScroll(Sender: TObject; ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  if (LeftGrid.RowCount = 1) and (RightGrid.RowCount = 1) then
    Exit;

  DrawGrid.Row := ScrollPos;
  DrawGrid.Invalidate;
  LeftGrid.Row := ScrollPos;
  RightGrid.Row := ScrollPos;
end;

procedure TCompareFrame.ScrollGrids(Row: Integer; EventType: TGridEventType);
begin
  if Row = FPreviousRow then
    Exit;
  if LeftGrid.RowCount <> RightGrid.RowCount then
    Exit;

  LeftGrid.Row := Row;
  RightGrid.Row := Row;
  DrawGrid.Row := Row;

  LeftMemo.Text := LeftGrid.Cells[1, Row];
  RightMemo.Text := RightGrid.Cells[1, Row];

  DrawGrid.Invalidate;
  FPreviousRow := Row;
end;

procedure TCompareFrame.DrawGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (LeftGrid.RowCount = 1) and (RightGrid.RowCount = 1) then
    Exit;
  ScrollGrids(DrawGrid.Row);
end;

procedure TCompareFrame.DrawGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (LeftGrid.RowCount = 1) and (RightGrid.RowCount = 1) then
    Exit;
  if Shift = [ssLeft] then
    ScrollGrids(DrawGrid.Row);
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
  if CommonDialogs.OpenFile(FilenameLeftMemo.Text,
    Format('%s'#0'*.*'#0, [LanguageDataModule.GetConstant('AllFiles')]),
    LanguageDataModule.GetConstant('Open')) then
  begin
    Application.ProcessMessages; { style fix }
    FilenameLeftMemo.Text := CommonDialogs.Files[0];
    OpenFileToLeftGrid(CommonDialogs.Files[0]);
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

procedure TCompareFrame.LeftGridDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
const
  PaleRed: TColor = $6666FF;
  PaleBlue: TColor = $FF6666;
var
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
    TextRect(Rect, Rect.Left + 3, Rect.top + 2, LeftGrid.Cells[ACol, ARow]);

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
    ScrollGrids(LeftGrid.Row, etKey);
end;

procedure TCompareFrame.LeftGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT) then 
    ScrollGrids(LeftGrid.Row, etKey);
end;

procedure TCompareFrame.LeftGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ScrollGrids(LeftGrid.Row, etMouse);
end;

procedure TCompareFrame.LeftGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Shift = [ssLeft] then
    ScrollGrids(LeftGrid.Row, etMouse);
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
    TextRect(Rect, Rect.Left + 3, Rect.top + 2, RightGrid.Cells[ACol, ARow]);

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
    ScrollGrids(RightGrid.Row, etKey);
end;

procedure TCompareFrame.RightGridKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_UP) or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT) then 
    ScrollGrids(RightGrid.Row, etKey);
end;

procedure TCompareFrame.RightGridMouseDown
  (Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ScrollGrids(RightGrid.Row, etMouse);
end;

procedure TCompareFrame.RightGridMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Shift = [ssLeft] then
    ScrollGrids(RightGrid.Row, etMouse); 
end;

procedure TCompareFrame.SaveGridChanges;
begin
  if SaveLeftGridAction.Enabled then
    if Common.SaveChanges(False) = mrYes then
      SaveLeftGridAction.Execute;
  if SaveRightGridAction.Enabled then
    if Common.SaveChanges(False) = mrYes then
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
    Common.ShowErrorMessage(Format(LanguageDataModule.GetErrorMessage('FileNotFound'), [Filename]))
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
  Common.AutoSizeCol(LeftGrid);
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
  if CommonDialogs.OpenFile(FilenameRightMemo.Text,
    Format('%s'#0'*.*'#0, [LanguageDataModule.GetConstant('AllFiles')]),
    LanguageDataModule.GetConstant('Open')) then
  begin
    Application.ProcessMessages; { style fix }
    FilenameRightMemo.Text := CommonDialogs.Files[0];
    OpenFileToRightGrid(CommonDialogs.Files[0]);
  end;
end;

procedure TCompareFrame.BuildHashListLeft;
var
  i: Integer;
begin
  FHashListLeft.Clear;
  for i := 0 to FSourceLeft.Count - 1 do
    FHashListLeft.Add(HashLine(FSourceLeft[i], True, True));
end;

procedure TCompareFrame.BuildHashListRight;
var
  i: Integer;
begin
  FHashListRight.Clear;
  for i := 0 to FSourceRight.Count - 1 do
    FHashListRight.Add(HashLine(FSourceRight[i], True, True));
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
    ScrollGrids(Row, etMouse);
end;

procedure TCompareFrame.FrameResize(Sender: TObject);
begin
  LeftPanel.Width := ((Width - DrawBarPanel.Width) div 2);
  RightPanel.Width := LeftPanel.Width;
  if Width mod 2 <> 0 then
    RightPanel.Width := RightPanel.Width - 1;
  DrawGrid.Invalidate;
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
    FDiff.Execute(PInteger(FHashListLeft.List), PInteger(FHashListRight.List),
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

procedure TCompareFrame.SetCompareFile(Filename: string);
begin
  if FilenameLeftMemo.Text = '' then
  begin
    FilenameLeftMemo.Text := Filename;
    OpenFileToLeftGrid(FilenameLeftMemo.Text);
  end
  else
  if FilenameRightMemo.Text = '' then
  begin
    FilenameRightMemo.Text := Filename;
    OpenFileToRightGrid(FilenameRightMemo.Text);;
  end;
end;

procedure TCompareFrame.UpdateLanguage(SelectedLanguage: string);
begin
  Common.UpdateLanguage(Self, SelectedLanguage);
  LeftRightPanel.Width := Max(LeftLabel.Width + 10, RightLabel.Width + 10);
end;

end.

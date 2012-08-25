{******************************************************************************
 Tekijä:
   Lasse Rautiainen / Ohjelmointipalvelu Luokkapolku Oy

 Päivämäärä:
   20.07.2005

</FD>
 Kuvaus:
   MenuManager -luokan avulla voi tehdä ohjelmallisesti näytölle valikoita. 

 Parametrit:
<FD/>

</FM>
 Kutsuttavat näytöt/dialogit/raportit:
<FM/>

 Muutokset:

******************************************************************************}
unit MenuManager;

interface

uses
  Classes, Controls, JvCoolBar, JvPanel, ActnMan, ActnMenus, ActnList,
  ActnColorMaps, BCComboBox, JvToolBar;

type
  TMenuManager = class(TPersistent)
  private
    FOwner: TComponent;
    FActionButtonsToolBar: TJvToolBar;
    FLastToolButtonLeft: Integer;
    FMenuPanel: TJvPanel;
    FActionManager: TActionManager;
    FActionMainMenuBar: TActionMainMenuBar;
    FComboBox: TBCComboBox;
    procedure SetImageList(const Value: TImageList);
    function GetHeight: Integer;
    procedure SetHeight(Value: Integer);
    function GetDummyAction(ActionEnabled: Boolean): TAction;
    procedure ActDummyExecute(Sender : TObject);
    procedure SetColorMap(Value: TXPColorMap);
  public
    constructor Create(aOwner: TComponent);
    destructor Destroy; override;
    function AddRootItem(aparent: TActionClientItem; Position: Integer; CaptionText: string;
      RootEnabled: Boolean = True): TActionClientItem;
    procedure AddMenuItem(aparent: TActionClientItem; position: integer; AAction: TAction);
    procedure AddSeparatorItem(AParent: TActionClientItem; Position: Integer);
    function AddComboBox(DefaultText: string; PosLeft: Integer; ComboWidth: Integer = 145): TBCComboBox;
    procedure AddActionButton(AAction: TAction);
    property ImageList: TImageList write SetImageList;
    property ColorMap: TXPColorMap write SetColorMap;
    property Height: Integer read GetHeight write SetHeight;
  end;

implementation

uses
  ToolWin, SysUtils, Graphics, ComCtrls, Forms;

constructor TMenuManager.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
  FLastToolButtonLeft := 0;

  FMenuPanel := TJvPanel.Create(AOwner);
  with FMenuPanel do
  begin
    Parent := AOwner as TWinControl;;
    Height := 26;
    Align := alTop;
    BevelOuter := bvNone;
    TabOrder := 1;
  end;

  FActionManager := TActionManager.Create(AOwner);
  FActionMainMenuBar := TActionMainMenuBar.Create(FMenuPanel);
  with FActionMainMenuBar do
  begin
    Parent := FMenuPanel;
    Left := 0;
    Top := 0;
    Width := 297;
    Height := 26;
    ParentFont := False;
    Name := 'MainMenuBar';
    ActionManager := FActionManager;
    Align := alTop;
    Visible := true;
    EdgeInner := esNone;
    EdgeOuter := esNone;
    UseSystemFont := False;
    Align := alNone;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'Tahoma';
    Font.Style := [];
    HorzMargin := 2;
    ParentBackground := True;
    Spacing := 2;
  end;
  with FActionManager do
  begin
    ActionBars.Add.ActionBar := FActionMainMenuBar;
    Style := ActionBarStyles.Style[0];
  end;
end;

function TMenuManager.AddComboBox(DefaultText: string; PosLeft: Integer; ComboWidth: Integer): TBCComboBox;
begin
  FComboBox := TBCComboBox.Create(FMenuPanel);
  with FComboBox do
  begin
    Parent := FMenuPanel;
    Top := 2;
    Left := PosLeft;
    Width := ComboWidth;
    Height := 22;
    AutoComplete := False;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    //Ctl3D := True;
    DropDownCount := 10;
    ItemHeight := 14;
    //ParentCtl3D := False;
    ParentFont := False;
    TabOrder := 0;
    TabStop := False;
    Font.Height := -12;
    Font.Name := 'Tahoma';
    Font.Style := [];
    Text := DefaultText;
    EditColor := clWindow;
    DeniedKeyStrokes := True;
    //TextCompletion := False;
    ReadOnly := False;
  end;
  Result := FComboBox;
end;

procedure TMenuManager.AddActionButton(AAction: TAction);
var
  FButton: TToolButton;
begin
  if not Assigned(FActionButtonsToolBar) then
  begin
    FActionButtonsToolBar := TJvToolBar.Create(FOwner);
    with FActionButtonsToolBar do
    begin
      Parent := FMenuPanel;
      Align := alNone;
      Left := 450; // TODO: Tee tästä dynaamisempi...
      Top := 2;
      Height := 22;
      Caption := 'PikakuvakeToolBar';
      EdgeBorders := [];
      Flat := True;
      Images := FActionManager.Images;
      Indent := 4;
      TabOrder := 2;
      Transparent := true;
    end;
  end;
  FButton := TToolButton.Create(FOwner);
  with FButton do
  begin
    Left := FLastToolButtonLeft;
    Top := 0;
    Height := 22;
    if Assigned(AAction) then
    begin
      Action := AAction;
      Width := 23;
      Inc(FLastToolButtonLeft, 23);
    end
    else
    begin
      Style := tbsSeparator;
      Width := 8;
      Inc(FLastToolButtonLeft, 9);
    end;
    Caption := '';
  end;
  FActionButtonsToolBar.InsertControl(FButton);
end;

destructor TMenuManager.Destroy;
begin
  FreeAndNil(FComboBox);
  FreeAndNil(FActionManager);
  FreeAndNil(FActionMainMenuBar);
  FreeAndNil(FMenuPanel);
  inherited;
end;

procedure TMenuManager.SetColorMap(Value: TXPColorMap);
begin
  FActionMainMenuBar.ColorMap := Value;
end;

procedure TMenuManager.SetImageList(const Value: TImageList);
begin
  FActionManager.Images := Value;
end;

function TMenuManager.GetHeight: Integer;
begin
  Result := FMenuPanel.Height;
end;

procedure TMenuManager.SetHeight(Value: Integer);
begin
  FMenuPanel.Height := Value;
end;

procedure TMenuManager.ActDummyExecute(Sender : TObject);
begin
  ;
end;

function  TMenuManager.GetDummyAction(ActionEnabled: Boolean): TAction;
begin
  Result := TAction.Create(nil);
  Result.OnExecute := ActDummyExecute;
  Result.Enabled := ActionEnabled;
end;

function TMenuManager.AddRootItem(AParent: TActionClientItem; Position: Integer; CaptionText: string;
  RootEnabled: Boolean = True): TActionClientItem;
var
  Client: TActionClientItem;
  iPos: integer;
begin
  if Assigned(AParent) then
  begin
    if Position = -1 then
      iPos := AParent.Items.Count
    else
      iPos := Position;
    Client := TActionClientItem(AParent.Items.Insert(iPos));
  end
  else
  begin
    if Position = -1 then
      iPos := FActionMainMenuBar.ActionClient.Items.Count
    else
      iPos := Position;
    Client :=  TActionClientItem(FActionMainMenuBar.ActionClient.Items.insert(ipos));
  end;
  Client.Action := GetDummyAction(RootEnabled); // Tarvitaan, jotta root näkyy valikossa. Ei muuta merkitystä.
  Client.Caption := CaptionText;

  Result := Client;
end;

procedure TMenuManager.AddMenuItem(AParent: TActionClientItem; Position: Integer; AAction: TAction);
var
  Client: TActionClientItem;
  iPos: integer;
begin
  if not Assigned(AParent) then
    Exit;

  if position = -1 then
    iPos := AParent.Items.Count
  else
    iPos := position;
  Client := TActionClientItem(AParent.Items.Insert(iPos));

  Client.Action := AAction;
  Client.ImageIndex := AAction.ImageIndex;
end;

procedure TMenuManager.AddSeparatorItem(AParent: TActionClientItem; Position: Integer);
var
  Client: TActionClientItem;
  iPos: integer;
begin
  if not Assigned(AParent) then
    Exit;

  if position = -1 then
    iPos := AParent.Items.Count
  else
    iPos := Position;
  Client := TActionClientItem(AParent.Items.Insert(iPos));
  Client.Caption := '-';
end;

end.

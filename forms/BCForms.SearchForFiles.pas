unit BCForms.SearchForFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.ImgList, BCControls.ImageList,
  Vcl.StdCtrls, VirtualTrees;

type
  TSearchForFilesForm = class(TForm)
    SearchForEdit: TButtonedEdit;
    ActionList: TActionList;
    VirtualDrawTree1: TVirtualDrawTree;
    ImageList: TBCImageList;
    ClearAction: TAction;
    SearchAction: TAction;
    procedure ClearActionExecute(Sender: TObject);
    procedure SearchActionExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Open(RootDirectory: string);
  end;

function SearchForFilesForm: TSearchForFilesForm;

implementation

{$R *.dfm}

uses
  BCCommon.LanguageUtils;

var
  FSearchForFilesForm: TSearchForFilesForm;

function SearchForFilesForm: TSearchForFilesForm;
begin
  if FSearchForFilesForm = nil then
    Application.CreateForm(TSearchForFilesForm, FSearchForFilesForm);
  Result := FSearchForFilesForm;
  UpdateLanguage(FSearchForFilesForm, GetSelectedLanguage);
end;

procedure TSearchForFilesForm.ClearActionExecute(Sender: TObject);
begin
  SearchForEdit.Text := '';
end;

procedure TSearchForFilesForm.SearchActionExecute(Sender: TObject);
begin
  SearchForEdit.RightButton.Visible := Trim(SearchForEdit.Text) <> '';
end;

procedure TSearchForFilesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //WriteIniFile;
  Action := caFree;
end;

procedure TSearchForFilesForm.FormDestroy(Sender: TObject);
begin
  FSearchForFilesForm := nil;
end;

procedure TSearchForFilesForm.Open(RootDirectory: string);
begin
  //ReadIniFile;
  Show;
  //ReadFiles(RootDirectory);
end;

end.

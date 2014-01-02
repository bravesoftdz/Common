unit BCCommon.Images;

interface

uses
  System.SysUtils, System.Classes, Vcl.ImgList, Vcl.Controls, BCControls.ImageList;

type
  TImagesDataModule = class(TDataModule)
    ImageList: TBCImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ImagesDataModule: TImagesDataModule;

implementation

uses
  Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

initialization

  Application.CreateForm(TImagesDataModule, ImagesDataModule);

end.

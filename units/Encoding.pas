unit Encoding;

interface

uses
  System.SysUtils;

type
  TUTF8EncodingWithoutBOM = class(TUTF8Encoding)
  public
    function GetPreamble: TBytes; override;
  end;

  function GetUTF8WithoutBOM: TEncoding;

implementation

uses
  Winapi.Windows;

var
  FUTF8EncodingWithoutBOM: TEncoding;

{ TUTF8EncodingWithoutBOM }

function TUTF8EncodingWithoutBOM.GetPreamble: TBytes;
begin
  SetLength(Result, 0);
end;

function GetUTF8WithoutBOM: TEncoding;
var
  LEncoding: TEncoding;
begin
  if not Assigned(FUTF8EncodingWithoutBOM) then
  begin
    LEncoding := TUTF8EncodingWithoutBOM.Create;
    if Assigned(InterlockedCompareExchangePointer(Pointer(FUTF8EncodingWithoutBOM), LEncoding, nil)) then
      LEncoding.Free;
  end;
  Result := FUTF8EncodingWithoutBOM;
end;


end.

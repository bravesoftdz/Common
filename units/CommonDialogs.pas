unit CommonDialogs;

interface

uses
  Winapi.Windows, System.Classes;

  function OpenFiles(const IniDirPath, Filter, Title: string): Boolean;
  function OpenFile(const IniDirPath, AFilter, ATitle: string; const DefaultExt: string = ''): Boolean;
  function SaveFile(const IniDirPath, AFilter, ATitle: string; const FileName: string = ''; const DefaultExt: string = ''): Boolean;
  function Print(Handle: HWND): Boolean;

var
  Files: TstringList;

implementation

uses
  System.SysUtils, Winapi.Messages, Winapi.CommDlg, Vcl.StdCtrls;

const
  Zero = 0;
  One = 1;

type
  { TDlgOptions are the 11 members which control the dialog creation Flags
     in the TDlgSetUp-record Options set}
  TDlgOptions = (doSave, doReadOnlyCB, doCheckRead, doFileExist, doPathExist, doOverWrite,
    doCreatePompt, doLinks, doNoChangeDir, doTrackFolder, doCusFilter);

  TDlgSetUp = record // used for dialog Settings in the OpenDlgOpt function
    hOwner: Cardinal; // replaced with the Filter Index when OpenDlgOpt returns
    iniDirPath, iniFileName, Filter, Title, DefExt: string;
    // the four strings above are optional
    Options: set of TDlgOptions;
  end;

 { setting the Options Set to include a TDlgOptions -
    doSave - Makes a Save dialog, otherwize an Open dialog is shown
    doReadOnlyCB - will show the Read-Only check box at bottom of dialog
    doCheckRead - will check the read-Only check box, included in Option if user checks
    doFileExist - system checks to see if file name exists, then asks user
    doPathExist - system checks to see if file path exists, then asks user
    doOverWrite - if file name exists, asks user if OK to over-write
    doCreatePompt - if file name does not exist, asks if OK to create file
    doLinks - will return the link .lnk file name, instead of the file it is linked to
    doNoChangeDir - the current folder will not change with the dialog folder
    doTrackFolder - places the folder path in the OpenFolder string when dialog closes }

  TMultiResult = record // result record of the OpenMultiSel function
    fOffSet: Integer; // File Name character off-set in fNames
    fNames: string; // #0 delimited string with multi-FileNames
  end;

(*  // the OpenSavDlg is a simple Open-Save dialog creation function
  function OpenSavDlg(hOwner: Cardinal; const iniDirPath, Filter: string; Open: BOOL): string;

  // the OpenDlgOpt can set many more dialog options with the DlgSetUp record
  function OpenDlgOpt(var DlgSetUp: TDlgSetUp; FilterIndex: Cardinal = 1): string;

  // the OpenMultiSel is a Multi-Selection Open dialog that returns a TMultiResult
  function OpenMultiSel(hOwner: Cardinal; const iniDirPath, Filter, Title: string): TMultiResult; *)

var
  OpenFolder: string = 'C:'; // contains the Last Open Folder if doTrackFolder
  //CustomFilter: array[0..511] of Char; // records the user custom filter if doCusFilter

function OpenSavDlg(hOwner: Cardinal; const iniDirPath, Filter: string; Open: BOOL): string;
var
  OFName : TOpenFileName;
  FileName: Array[Zero..2047] of Char;
begin
  // basic open-save dialog creation
  ZeroMemory(@FileName, SizeOf(FileName));
  ZeroMemory(@OFName, SizeOf(OFName));

  with OFName do
  begin
    lStructSize := sizeof(ofName);
    hwndowner := hOwner;
    nMaxFile := SizeOf(FileName);
    lpstrFile := @FileName;
    nFilterIndex := One;
    if Length(iniDirPath) > One then
      lpstrInitialDir := PChar(iniDirPath)
    else
      lpstrInitialDir := PChar(ExtractFilePath(ParamStr(Zero)));

    lpstrFilter := PChar(Filter);

    if Open then
      Flags := OFN_EXPLORER or OFN_FILEMUSTEXIST or OFN_HIDEREADONLY
    else
      Flags := OFN_EXPLORER or OFN_PATHMUSTEXIST or OFN_OVERWRITEPROMPT or OFN_HIDEREADONLY;
  end;

  Result := '';

  if Open then
  begin
    if GetOpenFileName(OFName) then
      Result := FileName;
  end
  else
  if GetSaveFileName(OFName) then
    Result := FileName;
end;

function OpenDlgOpt(var DlgSetUp: TDlgSetUp; FilterIndex: Cardinal = One): string;
const
  // this FlagValues holds some of the constants for the OFName.Flags
  FlagValues: array[TDlgOptions] of Cardinal = (Zero, Zero, OFN_READONLY, OFN_FILEMUSTEXIST,
    OFN_PATHMUSTEXIST, OFN_OVERWRITEPROMPT, OFN_CREATEPROMPT, OFN_NODEREFERENCELINKS,
    OFN_NOCHANGEDIR, Zero, Zero);
var
  OFName : TOpenFileName;
  FilePath: array[Zero..2047] of Char;
  i: TDlgOptions;

  procedure SetResult;
  begin
    { this procedure is used to set Result for both the Open and Save dialogs }
    Result := FilePath;
    { place the current Filter Index into the hOwner incase you need to reset it to user's Index}
    DlgSetUp.hOwner := OFName.nFilterIndex;
    { the doTrackFolder will record the folder path, so you can open the next
      open-save Dlg in the same folder as the last open save}
    if doTrackFolder in DlgSetUp.Options then
      OpenFolder := ExtractFilePath(Result);
    { the OFName.Flags will have the OFN_READONLY bit if the check box was checked }
    if OFName.Flags and OFN_READONLY <> Zero then
      DlgSetUp.Options := [doCheckRead];
  end;

begin
  {this is a more flexable open dlg function, it has a TDlgSetUp record to
  change the dialog with Owner, Title, Filter and other Options}
  ZeroMemory(@FilePath, SizeOf(FilePath));
  ZeroMemory(@OFname, SizeOf(OFName));

  with OFName, DlgSetUp do
  begin
    lStructSize := SizeOf(OFName);
    hwndOwner := hOwner; // the owner is set to DlgSetUp.hOwner
    nMaxFile := SizeOf(FilePath);
    lpstrFile := @FilePath;
    if Length(iniFileName) > One then
      StrCopy(lpstrFile, PChar(iniFileName)); // set first file name here

    if Length(iniDirPath) > One then
      lpstrInitialDir := PChar(iniDirPath)
    else // set default initial Folder to this programs folder
      lpstrInitialDir := PChar(ExtractFilePath(ParamStr(0)));

    lpstrFilter := PChar(Filter);
    nFilterIndex := FilterIndex;

    if length(Title) > Zero then
      lpstrTitle := PChar(Title); // set dlg Title to OpenSet.Title

    if length(DefExt) > One then
      lpstrDefExt := PChar(DefExt); {lpstrDefExt will automatically add that file
                                      ext to a file name with no ext}

    Flags := OFN_EXPLORER or OFN_ENABLESIZING or OFN_HIDEREADONLY;
    // start with default Flags for Explorer, Sizing and no CheckBox
    if Options * [doCheckRead..doNoChangeDir] <> [] then
      for i := doCheckRead to doNoChangeDir do
        if i in Options then
          Flags := Flags or FlagValues[i];
    // the for loop above will place flag values in FlagValues array
    // into the OFName.Flags if that option is in the set

    if doReadOnlyCB in Options then // take out the read only checkbox
        Flags := Flags and (not OFN_HIDEREADONLY);

    (*if doCusFilter in Options then
    begin // make a Custom Filter recorder availible
      lpstrCustomFilter := @CustomFilter;
      nMaxCustFilter := SizeOf(CustomFilter);
    end; *)

    Exclude(Options, doCheckRead); // Take out the Check Read option
  end;

  Result := '';

  if doSave in DlgSetUp.Options then
  begin
    if GetSaveFileName(OFName) then
      SetResult; // places the file path into Result
  end
  else
  if GetOpenFileName(OFName) then
    SetResult;
end;

function OpenMultiSel(hOwner: Cardinal; const iniDirPath, Filter, Title: string): TMultiResult;
var
  OFName : TOpenFileName;
begin
  {this will create a Multi-Selection Open Dialg box, and the Result of this
   function is a TMultiResult record, which has the file-name OffSet as the
   fOffSet element, used to extract the file names from the #0 delimited result
   string in Result.fNames}
  SetLength(Result.fNames, 3070); // larger file name buffer for multi files
  ZeroMemory(@Result.fNames[One], Length(Result.fNames));
  Result.fOffSet := -1; // set Result.fOffSet to an error result of -1
  ZeroMemory(@OFName, SizeOf(OFName));

  with OFName do
  begin
    lStructSize := sizeof(OFName);
    hwndowner := hOwner;
    hInstance := SysInit.hInstance;
    nMaxFile := Length(Result.fNames);
    lpstrFile := PChar(Result.fNames);
    // adding the OFN_ALLOWMULTISELECT flag bit will change the file-path string returned
    Flags := OFN_ALLOWMULTISELECT or OFN_EXPLORER or OFN_FILEMUSTEXIST or OFN_ENABLESIZING or
      OFN_HIDEREADONLY;
    lpstrFilter := PChar(Filter);
    lpstrTitle := PChar(Title);
    nFilterIndex := One;
    lpstrInitialDir:= PChar(iniDirPath);
  end;

  if GetOpenFileName(OFName) then
    Result.fOffSet := OFName.nFileOffset // set fOffSet to the file name offset
  else
    Result.fNames := '';
end;

function OpenFiles(const iniDirPath, Filter, Title: string): Boolean;
var
  MultiRe: TMultiResult; // returned by the OpenMultiSel function
  pFileName: PChar;
begin
  Result := True;

  {the OpenMultiSel function uses a Multi-Selection dialog, the Result
   string is different than a normal open dialog, it has null #0 delimited
   file path and names}
  MultiRe := OpenMultiSel(0, IniDirPath, Filter, Title);
  { a TMultiResult is the result form a OpenMultiSel, the fOffSet will be
   -1 if it fails, or the File-Name charater offset if it succeeds}
  if MultiRe.fOffSet <> -1 then
  begin
    Files.Clear;
    if MultiRe.fNames[MultiRe.fOffSet] <> #0 then // true if single file name
      Files.Add(PChar(MultiRe.fNames))
    else
    begin
      pFileName := StrEnd(PChar(MultiRe.fNames));
      Inc(pFileName); // move to character after #0
      while pFileName^ <> #0 do // loop until there are two #0
      begin
        Files.Add(pFileName);
        pFileName := StrEnd(pFileName);
        Inc(pFileName);
      end;
    end;
  end
  else
    Result := False;
end;

function SaveFile(const IniDirPath, AFilter, ATitle, FileName, DefaultExt: string): Boolean;
var
  DlgSetUp: TDlgSetUp;
  AFileName: string;
begin
  with DlgSetUp do
  begin
    hOwner := 0;
    iniDirPath := IniDirPath;
    iniFileName := FileName;
    Filter := AFilter;
    Title := ATitle;
    //DefExt := DefaultExt;
    Options := [doSave, doPathExist, doOverWrite, doTrackFolder];
  end;
  Files.Clear;
  AFileName := OpenDlgOpt(DlgSetUp);
  if ExtractFileExt(AFileName) = '' then
    AFileName := Format('%s.%s', [AFileName, DefaultExt]);
  Files.Add(AFileName);
  Result := Files[0] <> '';
end;

function OpenFile(const IniDirPath, AFilter, ATitle, DefaultExt: string): Boolean;
var
  DlgSetUp: TDlgSetUp;
begin
  with DlgSetUp do
  begin
    hOwner := 0;
    iniDirPath := IniDirPath;
    Filter := AFilter;
    Title := ATitle;
    //DefExt := DefaultExt;
    Options := [doCreatePompt];
  end;
  Files.Clear;
  Files.Add(OpenDlgOpt(DlgSetUp));
  Result := Files[0] <> '';
end;

function Print(Handle: HWND): Boolean;
var
  PrintDlgRec: TPrintDlg;
begin
  //------------------------------
  FillChar(PrintDlgRec, SizeOf(PrintDlgRec), 0);
  with PrintDlgRec do
  begin
    lStructSize := SizeOf(PrintDlgRec);
    hWndOwner   := Handle;
    //------------------------------
    Flags       := 0;
  end;
  //------------------------------
  PrintDlg(PrintDlgRec);
end;

initialization

  Files := TStringList.Create;

finalization

  Files.Free;

end.

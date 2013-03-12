unit Diff;

(*******************************************************************************
* Component         TDiff                                                      *
* Version:          3.1                                                        *
* Date:             7 November 2009                                            *
* Compilers:        Delphi 7 - Delphi2009                                      *
* Author:           Angus Johnson - angusj-AT-myrealbox-DOT-com                *
* Copyright:        © 2001-2009 Angus Johnson                                  *
*                                                                              *
* Licence to use, terms and conditions:                                        *
*                   The code in the TDiff component is released as freeware    *
*                   provided you agree to the following terms & conditions:    *
*                   1. the copyright notice, terms and conditions are          *
*                   left unchanged                                             *
*                   2. modifications to the code by other authors must be      *
*                   clearly documented and accompanied by the modifier's name. *
*                   3. the TDiff component may be freely compiled into binary  *
*                   format and no acknowledgement is required. However, a      *
*                   discrete acknowledgement would be appreciated (eg. in a    *
*                   program's 'About Box').                                    *
*                                                                              *
* Description:      Component to list differences between two Integer arrays   *
*                   using a "longest common subsequence" algorithm.            *
*                   Typically, this component is used to diff 2 text files     *
*                   once their individuals lines have been hashed.             *
*                                                                              *
* Acknowledgements: The key algorithm in this component is based on:           *
*                   "An O(ND) Difference Algorithm and its Variations"         *
*                   By E Myers - Algorithmica Vol. 1 No. 2, 1986, pp. 251-266  *
*                   http://www.cs.arizona.edu/people/gene/                     *
*                   http://www.cs.arizona.edu/people/gene/PAPERS/diff.ps       *
*                                                                              *
*******************************************************************************)


(*******************************************************************************
* History:                                                                     *
* 13 December 2001 - Original Release                                          *
* 22 April 2008    - Complete rewrite to greatly improve the code and          *
*                    provide a much simpler view of differences through a new  *
*                    'Compares' property.                                      *
* 7 November 2009  - Updated so now compiles in newer versions of Delphi.      *
*******************************************************************************)

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, System.Math, Vcl.Forms;

const
  //Maximum realistic deviation from centre diagonal vector ...
  MAX_DIAGONAL = $FFFFFF; //~16 million

type

{$IFDEF UNICODE}
  P8Bits = PByte;
{$ELSE}
  P8Bits = PAnsiChar;
{$ENDIF}

  PDiags = ^TDiags;
  TDiags = array [-MAX_DIAGONAL..MAX_DIAGONAL] of Integer;

  PIntArray = ^TIntArray;
  TIntArray = array[0 .. MAXINT div SizeOf(Integer) -1] of Integer;
  PChrArray = ^TChrArray;
  TChrArray = array[0 .. MAXINT div SizeOf(Char) -1] of Char;

  TChangeKind = (ckNone, ckAdd, ckDelete, ckModify);

  PCompareRec = ^TCompareRec;
  TCompareRec = record
    Kind: TChangeKind;
    OldIndex1, OldIndex2: Integer;
    case Boolean of
      False: (chr1, chr2: Char);
      True: (int1, int2: Integer);
  end;

  TDiffStats = record
    Matches: Integer;
    Adds: Integer;
    Deletes: Integer;
    Modifies: Integer;
  end;

  TDiff = class(TComponent)
  private
    FCompareList: TList;
    FCancelled: Boolean;
    FExecuting: Boolean;
    FDiagBuffer, bDiagBuffer: pointer;
    Chrs1, Chrs2: PChrArray;
    Ints1, Ints2: PIntArray;
    LastCompareRec: TCompareRec;
    FDiag, BDiag: PDiags;
    FDiffStats: TDiffStats;
    procedure InitDiagArrays(MaxOscill, Len1, Len2: Integer);
    //nb: To optimize speed, separate functions are called for either
    //Integer or Character compares ...
    procedure RecursiveDiffChr(Offset1, Offset2, len1, Len2: Integer);
    procedure AddChangeChrs(Offset1, Range: Integer; ChangeKind: TChangeKind);
    procedure RecursiveDiffInt(Offset1, Offset2, len1, Len2: Integer);
    procedure AddChangeInts(Offset1, Range: Integer; ChangeKind: TChangeKind);

    function GetCompareCount: Integer;
    function GetCompare(Index: Integer): TCompareRec;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    //compare either and array of Characters or an array of Integers ...
    function Execute(PInts1, PInts2: PInteger; Len1, Len2: Integer): Boolean; overload;
    function Execute(PChrs1, PChrs2: PChar; Len1, Len2: Integer): Boolean; overload;

    //Cancel allows interrupting excessively prolonged comparisons
    procedure Cancel;
    procedure Clear;

    property Cancelled: Boolean read FCancelled;
    property Count: Integer read GetCompareCount;
    property Compares[index: Integer]: TCompareRec read GetCompare; default;
    property DiffStats: TDiffStats read FDiffStats;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('bonecode', [TDiff]);
end;

constructor TDiff.Create(aOwner: TComponent);
begin
  inherited;
  FCompareList := TList.create;
end;

destructor TDiff.Destroy;
begin
  Clear;
  FCompareList.free;
  inherited;
end;

function TDiff.Execute(PChrs1, PChrs2: PChar; Len1, Len2: Integer): Boolean;
var
  MaxOscill, x1,x2, SavedLen: Integer;
  CompareRec: PCompareRec;
begin
  Result := not fExecuting;
  if not Result then
    Exit;
  FExecuting := True;
  FCancelled := False;
  try
    Clear;

    //save first string length for later (ie for any trailing matches) ...
    SavedLen := Len1 - 1;

    //setup the Character arrays ...
    Chrs1 := Pointer(PChrs1);
    Chrs2 := Pointer(PChrs2);

    //ignore top matches ...
    x1 := 0; x2 := 0;
    while (Len1 > 0) and (Len2 > 0) and (Chrs1[Len1-1] = Chrs2[Len2-1]) do
    begin
      Dec(Len1); Dec(Len2);
    end;

    //if something doesn't match ...
    if (Len1 <> 0) or (Len2 <> 0) then
    begin
      //ignore bottom of matches too ...
      while (Len1 > 0) and (Len2 > 0) and (Chrs1[x1] = Chrs2[x2]) do
      begin
        Dec(Len1); Dec(Len2);
        Inc(x1); Inc(x2);
      end;

      MaxOscill := Min(Max(Len1, Len2), MAX_DIAGONAL);
      FCompareList.Capacity := Len1 + Len2;

      //nb: the Diag arrays are extended by 1 at each end to avoid testing
      //for array limits. Hence '+3' because will also includes Diag[0] ...
      GetMem(FDiagBuffer, SizeOf(Integer) * (MaxOscill * 2 + 3));
      GetMem(BDiagBuffer, SizeOf(Integer) * (MaxOscill * 2 + 3));
      try
        RecursiveDiffChr(x1, x2, Len1, Len2);
      finally
        FreeMem(FDiagBuffer);
        FreeMem(BDiagBuffer);
      end;
    end;

    if FCancelled then
    begin
      Result := False;
      Clear;
      Exit;
    end;

    //finally, append any trailing matches onto compareList ...
    while LastCompareRec.OldIndex1 < SavedLen do
    begin
      with LastCompareRec do
      begin
        Kind := ckNone;
        Inc(OldIndex1);
        Inc(OldIndex2);
        Chr1 := Chrs1[OldIndex1];
        Chr2 := Chrs2[OldIndex2];
      end;
      New(CompareRec);
      CompareRec^ := LastCompareRec;
      FCompareList.Add(CompareRec);
      Inc(FDiffStats.Matches);
    end;
  finally
    FExecuting := False;
  end;
end;

function TDiff.Execute(PInts1, PInts2: PInteger; Len1, Len2: Integer): Boolean;
var
  MaxOscill, x1,x2, SavedLen: Integer;
  CompareRec: PCompareRec;
begin
  Result := not FExecuting;
  if not Result then
    Exit;
  FExecuting := True;
  FCancelled := False;
  try
    Clear;

    //setup the Character arrays ...
    Ints1 := Pointer(PInts1);
    Ints2 := Pointer(PInts2);

    //save first string length for later (ie for any trailing matches) ...
    SavedLen := Len1 - 1;

    //ignore top matches ...
    x1 := 0; x2 := 0;
    while (Len1 > 0) and (Len2 > 0) and (Ints1[Len1-1] = Ints2[Len2-1]) do
    begin
      Dec(Len1); Dec(Len2);
    end;

    //if something doesn't match ...
    if (Len1 <> 0) or (Len2 <> 0) then
    begin
      //ignore bottom of matches too ...
      while (Len1 > 0) and (Len2 > 0) and (Ints1[x1] = Ints2[x2]) do
      begin
        Dec(Len1); Dec(Len2);
        Inc(x1); Inc(x2);
      end;

      MaxOscill := Min(Max(Len1, Len2), MAX_DIAGONAL);
      FCompareList.Capacity := Len1 + Len2;

      //nb: the Diag arrays are extended by 1 at each end to avoid testing
      //for array limits. Hence '+3' because will also includes Diag[0] ...
      GetMem(FDiagBuffer, SizeOf(Integer) * (MaxOscill * 2 + 3));
      GetMem(BDiagBuffer, SizeOf(Integer) * (MaxOscill * 2 + 3));
      try
        RecursiveDiffInt(x1, x2, Len1, Len2);
      finally
        FreeMem(FDiagBuffer);
        FreeMem(BDiagBuffer);
      end;
    end;

    if FCancelled then
    begin
      Result := False;
      Clear;
      Exit;
    end;

    //finally, append any trailing matches onto compareList ...
    while LastCompareRec.OldIndex1 < SavedLen do
    begin
      with LastCompareRec do
      begin
        Kind := ckNone;
        Inc(OldIndex1);
        Inc(OldIndex2);
        int1 := Ints1[OldIndex1];
        int2 := Ints2[OldIndex2];
      end;
      New(CompareRec);
      CompareRec^ := LastCompareRec;
      FCompareList.Add(CompareRec);
      Inc(FDiffStats.Matches);
    end;
  finally
    FExecuting := False;
  end;
end;

procedure TDiff.InitDiagArrays(MaxOscill, Len1, Len2: Integer);
var
  Diag: Integer;
begin
  Inc(MaxOscill); //for the extra diag at each end of the arrays ...
  P8Bits(FDiag) := P8Bits(FDiagBuffer) - SizeOf(Integer) * (MAX_DIAGONAL - MaxOscill);
  P8Bits(BDiag) := P8Bits(BDiagBuffer) - SizeOf(Integer) * (MAX_DIAGONAL - MaxOscill);
  //initialize Diag arrays (assumes 0 based arrays) ...
  for diag := -MaxOscill to MaxOscill do
    FDiag[diag] := -MAXINT;
  fDiag[0] := -1;
  for diag := -MaxOscill to MaxOscill do
    BDiag[diag] := MAXINT;
  BDiag[Len1 - Len2] := Len1-1;
end;

procedure TDiff.RecursiveDiffChr(Offset1, Offset2, Len1, Len2: Integer);
var
  diag, lenDelta, Oscill, MaxOscill, x1, x2: Integer;
begin
  //nb: the possible depth of recursion here is most unlikely to cause
  //    problems with stack overflows.
  Application.ProcessMessages;
  if FCancelled then exit;

  if Len1 = 0 then
  begin
    AddChangeChrs(Offset1, Len2, ckAdd);
    Exit;
  end
  else if Len2 = 0 then
  begin
    AddChangeChrs(Offset1, Len1, ckDelete);
    Exit;
  end
  else if (Len1 = 1) and (Len2 = 1) then
  begin
    AddChangeChrs(Offset1, 1, ckDelete);
    AddChangeChrs(Offset1, 1, ckAdd);
    Exit;
  end;

  MaxOscill := min(max(Len1,Len2), MAX_DIAGONAL);
  InitDiagArrays(MaxOscill, Len1, Len2);
  lenDelta := Len1 - Len2;

  Oscill := 1; //ie assumes prior filter of top and bottom matches
  while Oscill <= MaxOscill do
  begin
    if (Oscill mod 200) = 0 then
    begin
      Application.ProcessMessages;
      if FCancelled then
        Exit;
    end;

    //do forward oscillation (keeping diag within assigned grid)...
    Diag := Oscill;
    while Diag > Len1 do Dec(diag,2);
    while Diag >= Max(-Oscill, -Len2) do
    begin
      if FDiag[diag-1] < FDiag[diag+1] then
        x1 := FDiag[Diag+1]
      else
        x1 := FDiag[Diag-1]+1;
      x2 := x1 - Diag;
      while (x1 < Len1-1) and (x2 < Len2-1) and (Chrs1[Offset1 + x1 + 1] = Chrs2[Offset2 + x2 + 1]) do
      begin
        Inc(x1); Inc(x2);
      end;
      FDiag[diag] := x1;

      //nb: (fDiag[diag] is always < bDiag[diag]) here when NOT odd(lenDelta) ...
      if Odd(lenDelta) and (FDiag[Diag] >= BDiag[Diag]) then
      begin
        Inc(x1);Inc(x2);
        //save x1 & x2 for second recursive_diff() call by reusing no longer
        //needed variables (ie minimize variable allocation in recursive fn) ...
        Diag := x1; Oscill := x2;
        while (x1 > 0) and (x2 > 0) and (Chrs1[Offset1 + x1 - 1] = Chrs2[Offset2 + x2 - 1]) do
        begin
          Dec(x1); Dec(x2);
        end;
        RecursiveDiffChr(Offset1, Offset2, x1, x2);
        x1 := Diag; x2 := Oscill;
        RecursiveDiffChr(Offset1 + x1, Offset2 + x2, Len1 - x1, Len2 - x2);
        Exit; //ALL DONE
      end;
      Dec(diag,2);
    end;

    //do backward oscillation (keeping diag within assigned grid)...
    Diag := LenDelta + Oscill;
    while Diag > Len1 do
      Dec(diag,2);
    while Diag >= Max(LenDelta - Oscill, -Len2)  do
    begin
      if BDiag[Diag-1] < BDiag[Diag+1] then
        x1 := BDiag[Diag-1] else
        x1 := BDiag[Diag+1]-1;
      x2 := x1 - Diag;
      while (x1 > -1) and (x2 > -1) and (Chrs1[Offset1 + x1] = Chrs2[Offset2 + x2]) do
      begin
        Dec(x1); Dec(x2);
      end;
      BDiag[diag] := x1;

      if BDiag[diag] <= FDiag[diag] then
      begin
        //flag return value then ...
        Inc(x1); Inc(x2);
        RecursiveDiffChr(Offset1, Offset2, x1, x2);
        while (x1 < Len1) and (x2 < Len2) and (Chrs1[Offset1 + x1] = Chrs2[Offset2 + x2]) do
        begin
          Inc(x1); Inc(x2);
        end;
        RecursiveDiffChr(Offset1 + x1, Offset2 + x2, Len1 - x1, Len2 - x2);
        Exit; //ALL DONE
      end;
      Dec(Diag,2);
    end;
    Inc(Oscill);
  end; //while Oscill <= MaxOscill

  raise Exception.create('oops - error in RecursiveDiffChr()');
end;

procedure TDiff.RecursiveDiffInt(Offset1, Offset2, Len1, Len2: Integer);
var
  Diag, LenDelta, Oscill, MaxOscill, x1, x2: Integer;
begin
  //nb: the possible depth of recursion here is most unlikely to cause
  //    problems with stack overflows.
  Application.ProcessMessages;
  if FCancelled then
    exit;

  if Len1 = 0 then
  begin
    Assert(Len2 > 0, 'oops!');
    AddChangeInts(Offset1, Len2, ckAdd);
    Exit;
  end
  else if Len2 = 0 then
  begin
    AddChangeInts(Offset1, Len1, ckDelete);
    Exit;
  end
  else if (Len1 = 1) and (Len2 = 1) then
  begin
    Assert(Ints1[Offset1] <> Ints2[Offset2], 'oops!');
    AddChangeInts(Offset1, 1, ckDelete);
    AddChangeInts(Offset1, 1, ckAdd);
    Exit;
  end;

  MaxOscill := Min(Max(Len1,Len2), MAX_DIAGONAL);
  InitDiagArrays(MaxOscill, Len1, Len2);
  LenDelta := Len1 - Len2;

  Oscill := 1; //ie assumes prior filter of top and bottom matches
  while Oscill <= MaxOscill do
  begin
    if (Oscill mod 200) = 0 then
    begin
      Application.ProcessMessages;
      if FCancelled then
        Exit;
    end;

    //do forward oscillation (keeping diag within assigned grid)...
    Diag := Oscill;
    while Diag > Len1 do
      Dec(Diag,2);
    while Diag >= max(-Oscill, -Len2) do
    begin
      if FDiag[Diag-1] < FDiag[Diag+1] then
        x1 := FDiag[Diag+1] else
        x1 := FDiag[Diag-1]+1;
      x2 := x1 - Diag;
      while (x1 < Len1-1) and (x2 < Len2-1) and (Ints1[Offset1 + x1 + 1] = Ints2[Offset2 + x2 + 1]) do
      begin
        Inc(x1); Inc(x2);
      end;
      FDiag[Diag] := x1;

      //nb: (fDiag[diag] is always < bDiag[diag]) here when NOT odd(lenDelta) ...
      if Odd(LenDelta) and (FDiag[Diag] >= BDiag[Diag]) then
      begin
        Inc(x1);Inc(x2);
        //save x1 & x2 for second recursive_diff() call by reusing no longer
        //needed variables (ie minimize variable allocation in recursive fn) ...
        Diag := x1; Oscill := x2;
        while (x1 > 0) and (x2 > 0) and (Ints1[Offset1 + x1 - 1] = Ints2[Offset2 + x2 - 1]) do
        begin
          Dec(x1); Dec(x2);
        end;
        RecursiveDiffInt(Offset1, Offset2, x1, x2);
        x1 := Diag; x2 := Oscill;
        RecursiveDiffInt(Offset1 + x1, Offset2 + x2, Len1 - x1, Len2 - x2);
        Exit; //ALL DONE
      end;
      Dec(Diag, 2);
    end;

    //do backward oscillation (keeping diag within assigned grid)...
    Diag := LenDelta + Oscill;
    while Diag > Len1 do
      Dec(Diag, 2);
    while Diag >= Max(LenDelta - Oscill, -Len2) do
    begin
      if BDiag[Diag - 1] < BDiag[Diag + 1] then
        x1 := BDiag[Diag - 1] else
        x1 := BDiag[Diag + 1] - 1;
      x2 := x1 - diag;
      while (x1 > -1) and (x2 > -1) and (Ints1[Offset1 + x1] = Ints2[Offset2 + x2]) do
      begin
        Dec(x1); Dec(x2);
      end;
      BDiag[diag] := x1;

      if BDiag[Diag] <= FDiag[Diag] then
      begin
        //flag return value then ...
        Inc(x1); Inc(x2);
        RecursiveDiffInt(Offset1, Offset2, x1, x2);
        while (x1 < Len1) and (x2 < Len2) and (Ints1[Offset1 + x1] = Ints2[Offset2 + x2]) do
        begin
          Inc(x1); Inc(x2);
        end;
        RecursiveDiffInt(Offset1 + x1, Offset2 + x2, Len1 - x1, Len2 - x2);
        Exit; //ALL DONE
      end;
      Dec(Diag, 2);
    end;

    Inc(Oscill);
  end; //while Oscill <= MaxOscill

  raise Exception.Create('oops - error in RecursiveDiffInt()');
end;

procedure TDiff.Clear;
var
  i: Integer;
begin
  for i := 0 to FCompareList.Count-1 do
    Dispose(PCompareRec(FCompareList[i]));
  FCompareList.clear;
  LastCompareRec.Kind := ckNone;
  LastCompareRec.OldIndex1 := -1;
  LastCompareRec.OldIndex2 := -1;
  FDiffStats.Matches := 0;
  FDiffStats.Adds := 0;
  FDiffStats.Deletes := 0;
  FDiffStats.Modifies := 0;
  Chrs1 := nil; Chrs2 := nil; Ints1 := nil; Ints2 := nil;
end;

function TDiff.GetCompareCount: Integer;
begin
  Result := FCompareList.Count;
end;

function TDiff.GetCompare(Index: Integer): TCompareRec;
begin
  Result := PCompareRec(FCompareList[Index])^;
end;

procedure TDiff.AddChangeChrs(Offset1, Range: Integer; ChangeKind: TChangeKind);
var
  i,j: Integer;
  CompareRec: PCompareRec;
begin
  //first, add any unchanged items into this list ...
  while LastCompareRec.OldIndex1 < Offset1 -1 do
  begin
    with LastCompareRec do
    begin
      Kind := ckNone;
      Inc(OldIndex1);
      Inc(OldIndex2);
      Chr1 := Chrs1[OldIndex1];
      Chr2 := Chrs2[OldIndex2];
    end;
    New(CompareRec);
    CompareRec^ := LastCompareRec;
    FCompareList.Add(CompareRec);
    Inc(FDiffStats.Matches);
  end;

  case ChangeKind of
    ckAdd :
      begin
        for i := 1 to Range do
        begin
          with LastCompareRec do
          begin
            //check if a Range of adds are following a Range of deletes
            //and convert them to modifies ...
            if Kind = ckDelete then
            begin
              j := FCompareList.Count -1;
              while (j > 0) and (PCompareRec(FCompareList[j-1]).Kind = ckDelete) do
                Dec(j);
              PCompareRec(FCompareList[j]).Kind := ckModify;
              Dec(FDiffStats.Deletes);
              Inc(FDiffStats.Modifies);
              Inc(LastCompareRec.OldIndex2);
              PCompareRec(FCompareList[j]).OldIndex2 := LastCompareRec.OldIndex2;
              PCompareRec(FCompareList[j]).chr2 := Chrs2[OldIndex2];
              if j = FCompareList.Count-1 then
                LastCompareRec.Kind := ckModify;
              Continue;
            end;
            Kind := ckAdd;
            Chr1 := #0;
            Inc(OldIndex2);
            Chr2 := Chrs2[OldIndex2]; //ie what we added
          end;
          New(CompareRec);
          CompareRec^ := LastCompareRec;
          FCompareList.Add(CompareRec);
          Inc(FDiffStats.Adds);
        end;
      end;
    ckDelete :
      begin
        for i := 1 to Range do
        begin
          with LastCompareRec do
          begin
            //check if a Range of deletes are following a Range of adds
            //and convert them to modifies ...
            if Kind = ckAdd then
            begin
              j := FCompareList.Count -1;
              while (j > 0) and (PCompareRec(FCompareList[j-1]).Kind = ckAdd) do
                Dec(j);
              PCompareRec(FCompareList[j]).Kind := ckModify;
              Dec(FDiffStats.Adds);
              Inc(FDiffStats.Modifies);
              Inc(LastCompareRec.OldIndex1);
              PCompareRec(FCompareList[j]).OldIndex1 := LastCompareRec.OldIndex1;
              PCompareRec(FCompareList[j]).Chr1 := Chrs1[OldIndex1];
              if j = FCompareList.Count-1 then
                LastCompareRec.Kind := ckModify;
              Continue;
            end;
            Kind := ckDelete;
            Chr2 := #0;
            Inc(OldIndex1);
            Chr1 := Chrs1[OldIndex1]; //ie what we deleted
          end;
          New(CompareRec);
          CompareRec^ := LastCompareRec;
          FCompareList.Add(CompareRec);
          Inc(FDiffStats.Deletes);
        end;
      end;
  end;
end;

procedure TDiff.AddChangeInts(Offset1, Range: Integer; ChangeKind: TChangeKind);
var
  i, j: Integer;
  CompareRec: PCompareRec;
begin
  //first, add any unchanged items into this list ...
  while LastCompareRec.OldIndex1 < Offset1 - 1 do
  begin
    with LastCompareRec do
    begin
      Kind := ckNone;
      Inc(OldIndex1);
      Inc(OldIndex2);
      Int1 := Ints1[OldIndex1];
      Int2 := Ints2[OldIndex2];
    end;
    New(CompareRec);
    CompareRec^ := LastCompareRec;
    FCompareList.Add(CompareRec);
    Inc(FDiffStats.Matches);
  end;

  case ChangeKind of
    ckAdd:
      begin
        for i := 1 to Range do
        begin
          with LastCompareRec do
          begin
            //check if a Range of adds are following a Range of deletes
            //and convert them to modifies ...
            if Kind = ckDelete then
            begin
              j := FCompareList.Count -1;
              while (j > 0) and (PCompareRec(FCompareList[j-1]).Kind = ckDelete) do
                Dec(j);
              PCompareRec(FCompareList[j]).Kind := ckModify;
              Dec(FDiffStats.Deletes);
              Inc(FDiffStats.Modifies);
              Inc(LastCompareRec.OldIndex2);
              PCompareRec(FCompareList[j]).OldIndex2 := LastCompareRec.OldIndex2;
              PCompareRec(FCompareList[j]).Int2 := Ints2[OldIndex2];
              if j = FCompareList.Count-1 then
                LastCompareRec.Kind := ckModify;
              Continue;
            end;
            Kind := ckAdd;
            Int1 := $0;
            Inc(OldIndex2);
            Int2 := Ints2[OldIndex2]; //ie what we added
          end;
          New(CompareRec);
          CompareRec^ := LastCompareRec;
          FCompareList.Add(CompareRec);
          Inc(FDiffStats.Adds);
        end;
      end;
    ckDelete:
      begin
        for i := 1 to Range do
        begin
          with LastCompareRec do
          begin
            //check if a Range of deletes are following a Range of adds
            //and convert them to modifies ...
            if Kind = ckAdd then
            begin
              j := FCompareList.Count -1;
              while (j > 0) and (PCompareRec(FCompareList[j-1]).Kind = ckAdd) do
                Dec(j);
              PCompareRec(FCompareList[j]).Kind := ckModify;
              Dec(FDiffStats.Adds);
              Inc(FDiffStats.Modifies);
              Inc(LastCompareRec.OldIndex1);
              PCompareRec(FCompareList[j]).OldIndex1 := LastCompareRec.OldIndex1;
              PCompareRec(FCompareList[j]).Int1 := Ints1[OldIndex1];
              if j = FCompareList.Count-1 then
                LastCompareRec.Kind := ckModify;
              Continue;
            end;
            Kind := ckDelete;
            Int2 := $0;
            Inc(OldIndex1);
            Int1 := Ints1[OldIndex1]; //ie what we deleted
          end;
          New(CompareRec);
          CompareRec^ := LastCompareRec;
          FCompareList.Add(CompareRec);
          Inc(FDiffStats.Deletes);
        end;
      end;
  end;
end;

procedure TDiff.Cancel;
begin
  FCancelled := True;
end;

end.

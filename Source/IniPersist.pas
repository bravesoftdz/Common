unit IniPersist;

// MIT License
//
// Copyright (c) 2009 - Robert Love
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE
//
interface

{$TYPEINFO ON}

uses
  SysUtils, Classes, Rtti, TypInfo;

type
  IniValueAttribute = class(TCustomAttribute)
  private
    FName: string;
    FDefaultValue: string;
    FSection: string;
    FBooleanValue: Boolean;
  public
    constructor Create(const ASection: String; const AName: string; const ADefaultValue: String);
  published
    property Section: string read FSection write FSection;
    property Name: string read FName write FName;
    property DefaultValue: string read FDefaultValue write FDefaultValue;
    property BooleanValue: Boolean read FBooleanValue;
  end;

  EIniPersist = class(Exception);

  TIniPersist = class(TObject)
  private
    class procedure SetValue(const AData: String; var AValue: TValue);
    class function GetValue(var AValue: TValue): String;
    class function GetIniAttribute(Obj: TRttiObject): IniValueAttribute;
  public
    class procedure Load(const AFileName: String; Obj: TObject);
    class procedure Save(const AFileName: String; Obj: TObject);
  end;

implementation

uses
  IniFiles;

{ TIniValue }

constructor IniValueAttribute.Create(const ASection, AName, ADefaultValue: String); // FI:W525 FixInsight ignore
begin
  FBooleanValue := False;
  FSection := ASection;
  FName := AName;
  FDefaultValue := ADefaultValue;
end;

{ TIniPersist }

class function TIniPersist.GetIniAttribute(Obj: TRttiObject): IniValueAttribute;
var
  Attr: TCustomAttribute;
begin
  for Attr in Obj.GetAttributes do
    if Attr is IniValueAttribute then
      Exit(IniValueAttribute(Attr));
  Result := nil;
end;

class procedure TIniPersist.Load(const AFileName: String; Obj: TObject);
var
  ctx: TRttiContext;
  objType: TRttiType;
  Field: TRttiField;
  Prop: TRttiProperty;
  Value: TValue;
  IniValue: IniValueAttribute;
  Ini: TIniFile;
  Data: String;
begin
  ctx := TRttiContext.Create;
  try
    Ini := TIniFile.Create(AFileName);
    try
      objType := ctx.GetType(Obj.ClassInfo);
      for Prop in objType.GetProperties do
      begin
        IniValue := GetIniAttribute(Prop);
        if Assigned(IniValue) then
        begin
          Data := Ini.ReadString(IniValue.Section, IniValue.Name, IniValue.DefaultValue);
          if IniValue.BooleanValue then
          begin
            if Data = '0' then
              Data := 'False'
            else if Data = '1' then
              Data := 'True';
          end;
          Value := Prop.GetValue(Obj);
          SetValue(Data, Value);
          Prop.SetValue(Obj, Value);
        end;
      end;
      for Field in objType.GetFields do
      begin
        IniValue := GetIniAttribute(Field);
        if Assigned(IniValue) then
        begin
          Data := Ini.ReadString(IniValue.Section, IniValue.Name, IniValue.DefaultValue);
          Value := Field.GetValue(Obj);
          SetValue(Data, Value);
          Field.SetValue(Obj, Value);
        end;
      end;
    finally
      Ini.Free;
    end;
  finally
    ctx.Free;
  end;
end;

class procedure TIniPersist.SetValue(const AData: String; var AValue: TValue);
var
  I: Integer;
begin
  case AValue.Kind of
    tkWChar, tkLString, tkWString, tkString, tkChar, tkUString:
      AValue := AData;
    tkInteger, tkInt64:
      AValue := StrToInt(AData);
    tkFloat:
      AValue := StrToFloat(AData);
    tkEnumeration:
      AValue := TValue.FromOrdinal(AValue.TypeInfo, GetEnumValue(AValue.TypeInfo, AData));
    tkSet:
      begin
        I := StringToSet(AValue.TypeInfo, AData);
        TValue.Make(@I, AValue.TypeInfo, AValue);
      end;
  else
    raise EIniPersist.Create('Type not Supported');
  end;
end;

class procedure TIniPersist.Save(const AFileName: String; Obj: TObject);
var
  RttiContext: TRttiContext;
  objType: TRttiType;
  Field: TRttiField;
  Prop: TRttiProperty;
  Value: TValue;
  IniValue: IniValueAttribute;
  Ini: TIniFile;
  Data: String;
begin
  RttiContext := TRttiContext.Create;
  try
    Ini := TIniFile.Create(AFileName);
    try
      objType := RttiContext.GetType(Obj.ClassInfo);
      for Prop in objType.GetProperties do
      begin
        IniValue := GetIniAttribute(Prop);
        if Assigned(IniValue) then
        begin
          Value := Prop.GetValue(Obj);
          Data := GetValue(Value);
          Ini.WriteString(IniValue.Section, IniValue.Name, Data);
        end;
      end;
      for Field in objType.GetFields do
      begin
        IniValue := GetIniAttribute(Field);
        if Assigned(IniValue) then
        begin
          Value := Field.GetValue(Obj);
          Data := GetValue(Value);
          Ini.WriteString(IniValue.Section, IniValue.Name, Data);
        end;
      end;
    finally
      Ini.Free;
    end;
  finally
    RttiContext.Free;
  end;
end;

class function TIniPersist.GetValue(var AValue: TValue): string;
begin
  if AValue.Kind in [tkWChar, tkLString, tkWString, tkString, tkChar, tkUString, tkInteger, tkInt64, tkFloat,
    tkEnumeration, tkSet] then
    Result := AValue.ToString
  else
    raise EIniPersist.Create('Type not Supported');
end;

end.

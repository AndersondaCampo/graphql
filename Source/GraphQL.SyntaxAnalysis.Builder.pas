{******************************************************************************}
{                                                                              }
{  Delphi GraphQL                                                              }
{  Copyright (c) 2022 Luca Minuti                                              }
{  https://github.com/lminuti/graphql                                          }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  Licensed under the Apache License, Version 2.0 (the "License");             }
{  you may not use this file except in compliance with the License.            }
{  You may obtain a copy of the License at                                     }
{                                                                              }
{      http://www.apache.org/licenses/LICENSE-2.0                              }
{                                                                              }
{  Unless required by applicable law or agreed to in writing, software         }
{  distributed under the License is distributed on an "AS IS" BASIS,           }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.    }
{  See the License for the specific language governing permissions and         }
{  limitations under the License.                                              }
{                                                                              }
{******************************************************************************}
unit GraphQL.SyntaxAnalysis.Builder;

interface

uses
  System.Classes, System.SysUtils, System.Rtti,
  GraphQL.Core, GraphQL.Classes, GraphQL.Lexer.Core, GraphQL.SyntaxAnalysis.Core;

type
  TGraphQLBuilder = class(TSyntaxAnalysis)
  private
    FOwnsScanner: Boolean;

    { Rules }
    function ObjectArgumentStatement: TGraphQLArguments;
    function ArgumentStamement: IGraphQLArgument;
    procedure ArgumentsStatement(AArguments: IGraphQLList<IGraphQLArgument>);
    function FieldStatement(AParentField: IGraphQLField): IGraphQLField;
    function ObjectStatement(AParentField: IGraphQLField): IGraphQLObject;
    procedure Query(AGraphQL: IGraphQL);
    procedure GraphQL(AGraphQL: IGraphQL);
    procedure Variables(AGraphQL: IGraphQL);
    procedure Variable(AGraphQL: IGraphQL);
    function TypeName(AGraphQL: IGraphQL): TGraphQLVariableType;
    function ArrayArgumentStatement: TGraphQLArguments;
    function CreateArgument(const AName: string): IGraphQLArgument;
    function ArrayItemArgumentStatement(AIndex: Integer): IGraphQLArgument;
  public
    function Build: IGraphQL;
    constructor Create(const ASourceCode :string); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TSyntaxAnalysis }

// arguments = '(' argument [ ',' argument [...] ] } '}'
procedure TGraphQLBuilder.ArgumentsStatement(AArguments: IGraphQLList<IGraphQLArgument>);
begin
  Expect(TTokenKind.LeftParenthesis);

  (AArguments as IEditableList<IGraphQLArgument>).Add(ArgumentStamement);
  while FToken.Kind = TTokenKind.Comma do
  begin
    NextToken;
    (AArguments as IEditableList<IGraphQLArgument>).Add(ArgumentStamement);
  end;

  Expect(TTokenKind.RightParenthesis);
end;

// argument = identified : ( string | number | boolean | object | array | variable )
function TGraphQLBuilder.ArgumentStamement: IGraphQLArgument;
var
  LName: string;
begin
  Expect(TTokenKind.Identifier, False);
  LName := FToken.StringValue;
  NextToken;

  Expect(TTokenKind.Colon);

  Result := CreateArgument(LName);
end;

// array item = ( string | number | boolean | object | array | variable )
function TGraphQLBuilder.ArrayItemArgumentStatement(AIndex: Integer): IGraphQLArgument;
var
  LName: string;
begin
  LName := AIndex.ToString;

  Result := CreateArgument(LName);
end;

function TGraphQLBuilder.CreateArgument(const AName: string): IGraphQLArgument;
var
  LType: TGraphQLVariableType;
  LAttributes: TGraphQLArgumentAttributes;
  LValue: TValue;
begin
  LAttributes := [];

  case FToken.Kind of
    TTokenKind.LeftSquareBracket:
    begin
      LType := TGraphQLVariableType.ArrayType;
      LValue := ArrayArgumentStatement;
    end;
    TTokenKind.LeftCurlyBracket:
    begin
      LType := TGraphQLVariableType.ObjectType;
      LValue := ObjectArgumentStatement;
    end;
    TTokenKind.StringLiteral:
    begin
      LType := TGraphQLVariableType.StringType;
      LValue := FToken.StringValue;
      NextToken;
    end;
    TTokenKind.IntegerLiteral:
    begin
      LType := TGraphQLVariableType.IntType;
      LValue := FToken.IntegerValue;
      NextToken;
    end;
    TTokenKind.FloatLiteral:
    begin
      LType := TGraphQLVariableType.FloatType;
      LValue := FToken.FloatValue;
      NextToken;
    end;
    TTokenKind.Variable:
    begin
      LType := TGraphQLVariableType.UnknownType;
      LValue := FToken.StringValue;
      LAttributes := [TGraphQLArgumentAttribute.Variable];
      NextToken;
    end;
    TTokenKind.Identifier:
    begin
      if FToken.StringValue = 'true' then
      begin
        LType := TGraphQLVariableType.BooleanType;
        LValue := True
      end
      else if FToken.StringValue = 'false' then
      begin
        LType := TGraphQLVariableType.BooleanType;
        LValue := False
      end
      else
      begin
        raise ESyntaxError.Create(Format('String or number expected but identifier [%s] found', [FToken.StringValue]), FToken.LineNumber, FToken.ColumnNumber);
      end;
      NextToken;
    end
    else
      raise ESyntaxError.Create('String, number or object expected', FToken.LineNumber, FToken.ColumnNumber);

  end;

  Result := TGraphQLArgument.Create(AName, LType, LAttributes, LValue);
end;

function TGraphQLBuilder.Build: IGraphQL;
begin
  inherited;
  Result := TGraphQL.Create;
  GraphQL(Result);
end;

constructor TGraphQLBuilder.Create(const ASourceCode: string);
begin
  inherited Create(TScanner.CreateFromString(ASourceCode));
  FOwnsScanner := True;
end;

destructor TGraphQLBuilder.Destroy;
begin
  if FOwnsScanner then
    FScanner.Free;
  inherited;
end;

// field = [alias ':' ] fieldname [ arguments ] [object]
function TGraphQLBuilder.FieldStatement(AParentField: IGraphQLField): IGraphQLField;
var
  LFieldName: string;
  LFieldAlias: string;
  LValue: IGraphQLValue;
  LArguments: IGraphQLList<IGraphQLArgument>;
  LGraphQLField: IGraphQLField;
begin
  if FToken.Kind = TTokenKind.Ellipsis then
    raise ESyntaxError.Create(Format('Fragments not yet supported', [FToken.StringValue]), FToken.LineNumber, FToken.ColumnNumber);

  Expect(TTokenKind.Identifier, False);

  LFieldName := FToken.StringValue;
  LFieldAlias := LFieldName;

  NextToken;

  if FToken.Kind = TTokenKind.Colon then
  begin
    NextToken;
    LFieldName := FToken.StringValue;
    NextToken;
  end;

  LArguments := TInterfacedList<IGraphQLArgument>.Create;
  if FToken.Kind = TTokenKind.LeftParenthesis then
    ArgumentsStatement(LArguments);

  LGraphQLField := TGraphQLField.Create(AParentField, LFieldName, LFieldAlias, LArguments);

  if FToken.Kind = TTokenKind.LeftCurlyBracket then
    LValue := ObjectStatement(LGraphQLField as IGraphQLField)
  else
    LValue := TGraphQLNull.Create;

  (LGraphQLField as TGraphQLField).SetValue(LValue);

  Result := LGraphQLField;
end;

// TypeName = String | Int | Float | Boolean | ID
function TGraphQLBuilder.TypeName(AGraphQL: IGraphQL): TGraphQLVariableType;
begin
  if FToken.IsIdentifier('String') then
    Result := TGraphQLVariableType.StringType
  else if FToken.IsIdentifier('Int') then
    Result := TGraphQLVariableType.IntType
  else if FToken.IsIdentifier('Float') then
    Result := TGraphQLVariableType.FloatType
  else if FToken.IsIdentifier('Boolean') then
    Result := TGraphQLVariableType.BooleanType
  else if FToken.IsIdentifier('ID') then
    Result := TGraphQLVariableType.IdType
  else
    raise ESyntaxError.Create(
      Format('Unknown variable type [%s]', [FToken.StringValue]),
      FToken.LineNumber,
      FToken.ColumnNumber
    );

  NextToken;
end;

// Variables = $ identifier : typename [!] [ = defaultValue]
procedure TGraphQLBuilder.Variable(AGraphQL: IGraphQL);
var
  LParamName: string;
  LParamType: TGraphQLVariableType;
  LRequired: Boolean;
  LDefaultValue: TValue;
begin
  LRequired := False;
  LDefaultValue := TValue.Empty;
  LParamName := FToken.StringValue;
  Expect(TTokenKind.Variable);
  Expect(TTokenKind.Colon);
  LParamType := TypeName(AGraphQL);

  if FToken.Kind = TTokenKind.IdentifierNot then
  begin
    LRequired := True;
    NextToken;
  end;

  if FToken.Kind = TTokenKind.Assignment then
  begin
    NextToken;
    case LParamType of
      TGraphQLVariableType.StringType, TGraphQLVariableType.IdType:
      begin
        Expect(TTokenKind.StringLiteral, False);
        LDefaultValue := FToken.StringValue;
      end;
      TGraphQLVariableType.IntType:
      begin
        Expect(TTokenKind.IntegerLiteral, False);
        LDefaultValue := FToken.IntegerValue;
      end;
      TGraphQLVariableType.FloatType:
      begin
        Expect(TTokenKind.FloatLiteral, False);
        LDefaultValue := FToken.FloatValue;
      end;
      TGraphQLVariableType.BooleanType:
      begin
        Expect(TTokenKind.Identifier, False);
        LDefaultValue := StrToBool(FToken.StringValue);
      end;
      else
      begin
        raise ESyntaxError.Create(
          Format('Unsupported datatype for variable [%s]', [LParamName]),
          FToken.LineNumber,
          FToken.ColumnNumber
        );

      end;
    end;
    NextToken;

  end;


  AGraphQL.AddParam(TGraphQLParam.Create(LParamName, LParamType, LRequired, LDefaultValue));
end;

// Variables = [ variable [ variable ... ] ]
procedure TGraphQLBuilder.Variables(AGraphQL: IGraphQL);
begin
  if FToken.Kind = TTokenKind.LeftParenthesis then
  begin
    repeat
      NextToken;
      Variable(AGraphQL);
    until FToken.Kind <> TTokenKind.Comma;
    Expect(TTokenKind.RightParenthesis);    
  end;
end;


// GraphQL = 'query' [queryname] [ Variables ] query | query
procedure TGraphQLBuilder.GraphQL(AGraphQL: IGraphQL);
const
  DefaultQueryName = 'Anonymous';
begin
  NextToken;

  if FToken.IsIdentifier('query') then
  begin
    NextToken;
    if FToken.IsIdentifier then
    begin
      AGraphQL.Name := FToken.StringValue;
      NextToken;
    end
    else
      AGraphQL.Name := DefaultQueryName;
    Variables(AGraphQL);
    Query(AGraphQL);
  end
  else
  begin
    AGraphQL.Name := DefaultQueryName;
    Query(AGraphQL);
  end;

end;

// object = '{' { field [,] } '}'
function TGraphQLBuilder.ObjectArgumentStatement: TGraphQLArguments;
var
  LArguments: TGraphQLArguments;
begin
  LArguments := TGraphQLArguments.Create;
  try

    Expect(TTokenKind.LeftCurlyBracket);

    (LArguments as IEditableList<IGraphQLArgument>).Add(ArgumentStamement);
    while FToken.Kind = TTokenKind.Comma do
    begin
      NextToken;
      (LArguments as IEditableList<IGraphQLArgument>).Add(ArgumentStamement);
    end;

    Expect(TTokenKind.RightCurlyBracket);

    Result := LArguments;
  except
    LArguments.Free;
    raise;
  end;
end;

// object = '[' { field [,] } ']'
function TGraphQLBuilder.ArrayArgumentStatement: TGraphQLArguments;
var
  LArguments: TGraphQLArguments;
  LIndex: Integer;
begin
  LArguments := TGraphQLArguments.Create;
  try

    Expect(TTokenKind.LeftSquareBracket);
    LIndex := 0;

    (LArguments as IEditableList<IGraphQLArgument>).Add(ArrayItemArgumentStatement(LIndex));
    while FToken.Kind = TTokenKind.Comma do
    begin
      Inc(LIndex);
      NextToken;
      (LArguments as IEditableList<IGraphQLArgument>).Add(ArrayItemArgumentStatement(LIndex));
    end;

    Expect(TTokenKind.RightSquareBracket);

    Result := LArguments;
  except
    LArguments.Free;
    raise;
  end;
end;


function TGraphQLBuilder.ObjectStatement(AParentField: IGraphQLField): IGraphQLObject;
var
  LValue: TGraphQLObject;
begin
  Expect(TTokenKind.LeftCurlyBracket);

  LValue := TGraphQLObject.Create;
  Result := LValue;

  repeat
    LValue.Add(FieldStatement(AParentField));
    if FToken.Kind = TTokenKind.Comma then
      NextToken;

  until FToken.Kind = TTokenKind.RightCurlyBracket;

  Expect(TTokenKind.RightCurlyBracket);
end;

// query = '{' objectpair [ [','] objectpair [ [','] objectpair ] ] '}'
procedure TGraphQLBuilder.Query(AGraphQL: IGraphQL);
var
  LField: IGraphQLField;
begin
  Expect(TTokenKind.LeftCurlyBracket);

  repeat
    LField := FieldStatement(nil);
    AGraphQL.AddField(LField);

    if FToken.Kind = TTokenKind.Comma then
      NextToken;

  until FToken.Kind = TTokenKind.RightCurlyBracket;

  Expect(TTokenKind.RightCurlyBracket);
end;

end.

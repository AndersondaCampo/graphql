unit GraphQL.Entity;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  GraphQL.Core.Attributes;

type
  TPersonClass = Class(TObject)
  public
    Name: String;
    Email: String;
  End;

  TPersonClassList = TArray<TPersonClass>;

  [GraphQLEntityAttribute]
  TPersonManager = Class(TObject)
  private

  public
    [GraphQLEntity('person_getbyid')]
    function GetByID(ID: Integer): TPersonClass;

    [GraphQLEntity('person_getall')]
    function GetAll: TPersonClassList;
  End;

implementation

{ TEntity }

function TPersonManager.GetAll: TPersonClassList;
var
  Person: TPersonClass;
  Idx: Integer;
begin
  for Idx := 0 to 10 do
  begin
    Person := TPersonClass.Create;
    Person.Name := 'Person' + Idx.ToString;
    Person.Email := Person.Name + '@email.com';

    SetLength(Result, Idx +1);
    Result[Idx] := Person;
  end;
end;

function TPersonManager.GetByID(ID: Integer): TPersonClass;
begin
  if ID > 0 then
  begin
    Result := TPersonClass.Create;
    Result.Name := 'Person' + ID.ToString;
    Result.Email:= Result.Name +'@email.com';
  end;
end;

end.

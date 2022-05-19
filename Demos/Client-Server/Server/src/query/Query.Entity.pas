unit Query.Entity;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  GraphQL.Core.Attributes,
  Query.User;

type
  TPersonClass = Class(TObject)
  public
    Id: Integer;
    Name: String;
    Email: String;
    Users: TUserList;
  End;

  TPersonClassList = TArray<TPersonClass>;

  [GraphQLEntityAttribute]
  TPersonManager = Class(TObject)
  private

  public
    [GraphQLEntity('person_getbyid')]
    function GetByID(ID: Integer): TPersonClassList;

    [GraphQLEntity('person_getall')]
    function GetAll: TPersonClassList;
  End;

implementation

{ TEntity }

function TPersonManager.GetAll: TPersonClassList;
var
  Person: TPersonClass;
  User: TUserClass;
  Idx: Integer;
begin
  for Idx := 0 to 10 do
  begin
    Person := TPersonClass.Create;
    Person.Id := Idx;
    Person.Name := 'Person' + Idx.ToString;
    Person.Email := Person.Name + '@email.com';

    SetLength(Person.Users, 2);
    User := TUserClass.Create;
    User.Id := 1;
    User.Name := 'User1';
    Person.Users[0] := User;

    User := TUserClass.Create;
    User.Id := 2;
    User.Name := 'User2';
    Person.Users[1] := User;

    SetLength(Result, Idx +1);
    Result[Idx] := Person;
  end;
end;

function TPersonManager.GetByID(ID: Integer): TPersonClassList;
var
  User: TUserClass;
begin
  Result := [];

  if ID > 0 then
  begin
    SetLength(Result, 1);
    Result[0] := TPersonClass.Create;
    Result[0].Id := ID;
    Result[0].Name := 'Person' + ID.ToString;
    Result[0].Email:= Result[0].Name +'@email.com';

    SetLength(Result[0].Users, 2);

    User := TUserClass.Create;
    User.Id := 1;
    User.Name := 'User1';
    Result[0].Users[0] := User;

    User := TUserClass.Create;
    User.Id := 2;
    User.Name := 'User2';
    Result[0].Users[1] := User;
  end;
end;

end.

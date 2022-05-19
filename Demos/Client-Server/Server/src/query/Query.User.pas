unit Query.User;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  GraphQL.Core.Attributes;

type
  TUserClass = Class
  public
    Id: Integer;
    Name: String;
  End;

  TUserList = TArray<TUserClass>;

implementation

end.

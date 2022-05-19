unit GraphQL.Horse;

interface

uses
  Horse,
  GraphQL.Query;

var
  FQuery: TGraphQLQuery;

function GraphQLQuery(AGraphQL: TGraphQLQuery): THorseCallback;
procedure CallBack(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses
  Web.HTTPApp,
  System.SysUtils,
  GraphQL.Resolver.Core,
  GraphQL.Core;

function GraphQLQuery(AGraphQL: TGraphQLQuery): THorseCallback;
begin
  FQuery := AGraphQL;
  Result := CallBack;
end;

procedure CallBack(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LGraphQL: IGraphQL;
  LVars   : IGraphQLVariables;
  Idx: Integer;
begin
  if (Req.MethodType = mtPost) then
  begin
    try
      LGraphQL := FQuery.Parse(req.Body);
      LVars    := TGraphQLVariables.Create;

      for Idx := 0 to LGraphQL.Params.Count -1 do
        LVars.SetVariable(LGraphQL.Params[Idx].ParamName, LGraphQL.Params[Idx].DefaultValue);

      res.ContentType('application/json').Send(FQuery.Run(lGraphQL, LVars));
    except
      on E: Exception do
        res.Status(404).Send(E.Message);
    end;
  end;

  Next;
end;

initialization

finalization

if Assigned(FQuery) then
  FreeAndNil(FQuery);

end.

program Server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  Horse.Jhonson,
  GraphQL.Classes in '..\..\..\Source\GraphQL.Classes.pas',
  GraphQL.Core.Attributes in '..\..\..\Source\GraphQL.Core.Attributes.pas',
  GraphQL.Core in '..\..\..\Source\GraphQL.Core.pas',
  GraphQL.Lexer.Core in '..\..\..\Source\GraphQL.Lexer.Core.pas',
  GraphQL.Query in '..\..\..\Source\GraphQL.Query.pas',
  GraphQL.Resolver.Core in '..\..\..\Source\GraphQL.Resolver.Core.pas',
  GraphQL.Resolver.ReST in '..\..\..\Source\GraphQL.Resolver.ReST.pas',
  GraphQL.Resolver.Rtti in '..\..\..\Source\GraphQL.Resolver.Rtti.pas',
  GraphQL.SyntaxAnalysis.Builder in '..\..\..\Source\GraphQL.SyntaxAnalysis.Builder.pas',
  GraphQL.SyntaxAnalysis.Core in '..\..\..\Source\GraphQL.SyntaxAnalysis.Core.pas',
  GraphQL.Utils.JSON in '..\..\..\Source\GraphQL.Utils.JSON.pas',
  GraphQL.Utils.Rtti in '..\..\..\Source\GraphQL.Utils.Rtti.pas',
  GraphQL.Entity in 'src\GraphQL.Entity.pas';

var
  Query: TGraphQLQuery;

procedure Graphql(req: THorseRequest; res: THorseResponse);
var
  LGraphQL: IGraphQL;
  LVars   : IGraphQLVariables;
  Idx: Integer;
begin
  try
    LGraphQL := Query.Parse(req.Body);
    LVars    := TGraphQLVariables.Create;

    for Idx := 0 to LGraphQL.Params.Count -1 do
      LVars.SetVariable(LGraphQL.Params[Idx].ParamName, LGraphQL.Params[Idx].DefaultValue);

    res.Send(Query.Run(lGraphQL, LVars));
  except
    on E: Exception do
      res.Status(404).Send(E.Message);
  end;
end;

begin
  try
    Query := TGraphQLQuery.Create;
    try
      Query.RegisterResolver(TGraphQLRttiResolver.Create(TPersonManager, True));

//      THorse.Use(Jhonson);
      THorse.Post('/Query', Graphql);

      THorse.Listen(3000,
        procedure(App: THorse)
        begin
          Writeln('App listening on port ', App.Port);
          Writeln('Press ani key to exit...');
          Readln;
          THorse.StopListen;
        end);
    finally
      Query.DisposeOf;
    end;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

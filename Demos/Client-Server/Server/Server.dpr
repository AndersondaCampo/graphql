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
  GraphQL.Horse in '..\..\..\Source\GraphQL.Horse.pas',
  Query.User in 'src\query\Query.User.pas',
  Query.Entity in 'src\query\Query.Entity.pas';

var
  Query: TGraphQLQuery;

begin
  ReportMemoryLeaksOnShutdown := True;

  try
    Query := TGraphQLQuery.Create;
    Query.RegisterResolver(TGraphQLRttiResolver.Create(TPersonManager, True));

    THorse.Post('/Query', GraphQLQuery(Query));

    THorse.Listen(3000,
      procedure(App: THorse)
      begin
        Writeln('App listening on port ', App.Port);
        Writeln('Press ani key to exit...');
        Readln;
        THorse.StopListen;
      end);
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

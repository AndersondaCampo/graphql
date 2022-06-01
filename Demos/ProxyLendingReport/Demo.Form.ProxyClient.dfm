object MainProxyForm: TMainProxyForm
  Left = 0
  Top = 0
  Caption = 'ReST API Demo'
  ClientHeight = 631
  ClientWidth = 906
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyUp = FormKeyUp
  DesignSize = (
    906
    631)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 459
    Top = 70
    Width = 44
    Height = 19
    Caption = 'Token'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 87
    Width = 58
    Height = 16
    Caption = 'Proxy port'
  end
  object SourceMemo: TMemo
    Left = 8
    Top = 125
    Width = 433
    Height = 351
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      '{'
      '  Report {'
      '    Description'
      '    LongDescription'
      '    ReportGroup: ReportGroupRef {'
      '      Id,'
      '      ReportGroup {'
      '        Description'
      '      }'
      '    }'
      '    ReportCategory: ReportCategoryRef {'
      '      Id,'
      '      ReportCategory {'
      '        Description'
      '      }'
      '    }'
      '  }'
      '}')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object RunQueryButton: TButton
    Left = 8
    Top = 576
    Width = 153
    Height = 47
    Anchors = [akLeft, akBottom]
    Caption = 'Run GraphQL query (F5)'
    TabOrder = 1
    OnClick = RunQueryButtonClick
    ExplicitTop = 559
  end
  object ResultMemo: TMemo
    Left = 459
    Top = 125
    Width = 439
    Height = 351
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
    WordWrap = False
  end
  object btnStart: TButton
    Left = 213
    Top = 78
    Width = 89
    Height = 34
    Caption = 'Start'
    TabOrder = 3
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 308
    Top = 78
    Width = 89
    Height = 34
    Caption = 'Stop'
    TabOrder = 4
    OnClick = btnStopClick
  end
  object edtPort: TEdit
    Left = 86
    Top = 84
    Width = 121
    Height = 24
    NumbersOnly = True
    TabOrder = 5
    Text = '8081'
  end
  object memLog: TMemo
    Left = 8
    Top = 482
    Width = 890
    Height = 88
    Anchors = [akLeft, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 6
    WordWrap = False
    ExplicitTop = 465
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 906
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 7
    object Image1: TImage
      Left = 8
      Top = 3
      Width = 41
      Height = 46
      AutoSize = True
      Picture.Data = {
        0954506E67496D61676589504E470D0A1A0A0000000D49484452000000290000
        002E0806000000B565304E0000000970485973000006EB000006EB014C319E4A
        0000001974455874536F667477617265007777772E696E6B73636170652E6F72
        679BEE3C1A000006B54944415478DADD590D6C535514FEEE5BB72112220490BF
        AD05C31C8A3A05C41FB28009642AF1171188FF81B56340801005813004A26070
        8BB0B51D0A0615C34F14A382208A1832515140E547846CDD40A698628802EDB6
        F7FCEE5E1FBC757DEDD676CC7892977B7B7FCEF9EEB9E79C7BEEAD401248C3C6
        141FCECE12D026F3A7835F950694DBD1B558605C43A2FC453240FAE0799BC513
        11BADEB1C3F564BB83AC82772435F88555BF0A6D643F147CD9AE207DF02EE386
        3F1F45C4723B9C2FB433484F318B1951869470CB67B61BC89328CF6A80FA1EAB
        B74519F613CD6162260A7EBEA2207D28EB02280B599DC22F954C547AB3D27CA4
        A652846CAFE357C6618BEC9872B64D416A2852AAD1537AF1ABFC7AE8C23537D9
        F4667DAC06A1516BC228D9BE81C08EB29436D9819F9FDF4B99A82D1528AA4F3A
        48E9C52C4A28FCE650D3C70262060151B87A4002AE87186683A0F66C546CF05B
        098C4172703A1AFCF5B02DE5828C7074548332CB81FC6DAD02590DCF1072CF53
        A0A55178455F38B7B3D44EA134235C00F76F66065C9FEA5BEFD9C162145915D1
        8B1719FC7C7017B14D9AC49E4C387325AF4AB847A440947005B79817CAFE131A
        35EFC36ACA6FB85385080AA8DB681ADF3782D43B3D54BF28688A5EEC665F05AB
        33ADB68AF3C6B2D8C4EF643A3A66F7C453FF18F36BF0DA552AAE3EC2C5D9F9F3
        317AF8666B9351DFA4490F627D7853F34219173E55029CC6DFAF47D1B604B426
        15625E6F38FF341A2BB1B68382C06156FB713BC667C2B5217C6235DCE3690ED2
        FB6B383F9BF3CF9BE65FC3F973A087AF742BE19CDF0892AB45B685356829D0EE
        EE0BD7D7CD6DD4339FE016934D05010E97DB198903F9EF6691CBCE050EB89684
        F79F46F9D020D46F60E91FE2880419602DCD6A2534FC9CFE701D34B7D5C0DD87
        7643AF4547721E4690FBACE657C17D2B17F01DAB013AD6C0EBE0AC36F757A23C
        4781BA3FCA4E0624C813ACF4B718A0729BAE356FB3AE1DEF3ADD91B437EC2898
        8C1844275A4D8D4C428484E334D6740F22588B8871B65193C74535BC2FD24196
        46EC06DEA7961E6DBAF2B23B1428D2A1FE56D190D50F85B5B1401E87BB07177B
        8CD5CEE49A4B67D8D374119E2D2C1EB4003997865464AB41CF0DB49947C27A0F
        A4216D742F3C77C6689091808BDACBEAED34E8D90E3857C40268106D78B6D03D
        FA074688A18C10AA791136289F9962B0419B3976823084FB507E1F07AD97ABA5
        DEA79F4357EF8D181734CFA0B73E43706BE5160411183400D3032D0579081BD3
        3AC1FF23ABD753CEB33CCBDF0AEFEF0CBF53D523CD392A6D021D6D6B68479BA8
        BDD13EA9C11E660D4AFA03A59D2E40F9451E81043A865AFCA4A5002FF3778FE1
        FC8F58FD9D76983540EAC244BFC1DBAD0E9A945B49DBBDE4272D0649012F7338
        E39AB693CE32AAB5004DBBB1958BBC977C5E219FB94903C9AC87139443ACDA58
        E6D8917F285E9095F066F3E895DBAED1AC06F178FD35292069F41F70E043D440
        31B77956BC004D721A1365DADD16DADDC309836430BE87C1F87356FD0A6C0332
        30C99F284879240A5C3C46BEDDE9447974A2ED71839457D56AF8E569701377C7
        451BF2260AD020665D2E6A92B9280E9F81C81902675D5C20A9C5A95CED4A0E3A
        9881AE839371873648CF867A31E7D40633044E73A06055AB41067191D98F224F
        896EC9B89646221EAF4CCDB4AF58FD8B2752966C6B15C83A0417723B0AF97B13
        278C4B3640934C998F8E25905266F5452D06C9B379840A7527EBF5D4E2406AB1
        AAAD40EA997F8ACCA8D2B9EDA3434EDA1CA47E267BEE67887957E849804F66D4
        AC2F6182B1A0AD001A44D98BB96BF389C34790CCE4351E8BCA44C6E3AD324F15
        FBE04DED066DA38C83E689045CA741CD6A4B2D1AC4BB8F83601892906A6E9759
        58066A1F179733ECE6141E6CDB8AE8401F52DA0391FA087E5E8CA457C8A36B25
        EDF2421B62EC483953D1784F8F4827625E1FFE0314887A11D36F56C2CD251E68
        2B04BC5FE7F0BE5410E595E2B0304E95287C225E691325D39556DEEB2D7792E0
        0B438F03DE55427F7C32D32E7E7B11E571201E8AF2387003EBB9E6A1545E6906
        F2A75FD23273469ECD228FA1278D994905F3BC1D56CF2CAD79C73193D57B92F1
        CC5203CF68CABF8B6D011E26DB789EEF0F69B3E50298AC16477AC7312DB40BDB
        FA50E029F3135FACF7A4589494A7BF7A0457D890BE9CBFE5DB500ABF066A6453
        0A3ACC56717EF2157BFA3353B8D153BB75E1A745883D6F9B9A748A849C2FA1E7
        E82A940EE4B5673D6D2CC75AFB82E1AB7EA2038547E295F3FF7FD8D741C6FA8B
        04CB08724EBB8294AFB70AC42EAB7E999B32D6ED6E5790922EBFB235A375D4E2
        D389F24F0AC8D01FA0B44B2D9F0C1DF4F62AC6412F73C112F3C354BCF42F0DB7
        E82AFDD032BE0000000049454E44AE426082}
    end
    object Label4: TLabel
      Left = 59
      Top = 3
      Width = 181
      Height = 25
      Caption = 'GraphQL for Delphi'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9961697
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 59
      Top = 30
      Width = 99
      Height = 16
      Caption = 'ReST API Demo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 9961697
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object TokenEdit: TEdit
    Left = 459
    Top = 95
    Width = 439
    Height = 24
    TabOrder = 8
    Text = 
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJMQVNUX05BTUUiOiIiLCJGSVJ' +
      'TVF9OQU1FIjoiIiwiRU1BSUxfQUREUkVTUyI6IiIsIlJvbGVzIjoicmVhZGVyLHN' +
      '0YW5kYXJkLGFkbWluLHN5c3RlbSIsImR1cmF0aW9uIjoiMTg5OS0xMi0zMSIsIlB' +
      'ST0ZJTEVfSUQiOiJTWVNURU0iLCJMQU5HVUFHRV9JRCI6IkVOIiwiaXNzIjoiTUF' +
      'SUy1DdXJpb3NpdHkiLCJFTlZJUk9OTUVOVCI6InRlc3QiLCJpYXQiOjE2NTI3ODg' +
      '5ODUsImV4cCI6MTY1Mjg3NTM4NSwiVXNlck5hbWUiOiJTWVNEQkEifQ.2QLztb3p' +
      'YsVbnbc1LgVSXwZPL_3DsHrla9UsPRArwfc'
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams, hoNoParseMetaHTTPEquiv, hoNoProtocolErrorException, hoWantProtocolErrorContent]
    OnAuthorization = IdHTTP1Authorization
    Left = 384
    Top = 35
  end
  object IdHTTPServer1: TIdHTTPServer
    Bindings = <>
    Left = 408
    Top = 568
  end
end

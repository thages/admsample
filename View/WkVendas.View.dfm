object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Main'
  ClientHeight = 338
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 303
    Width = 692
    Height = 35
    Align = alBottom
    TabOrder = 0
    object Label1: TLabel
      Left = 364
      Top = 9
      Width = 70
      Height = 13
      Alignment = taRightJustify
      Caption = 'Total Venda:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Button1: TButton
      Left = 587
      Top = 1
      Width = 104
      Height = 33
      Align = alRight
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = Button1Click
      ExplicitLeft = 1
    end
    object DBEdit1: TDBEdit
      Left = 440
      Top = 6
      Width = 121
      Height = 21
      DataField = 'valor_total'
      DataSource = DsPedido
      ReadOnly = True
      TabOrder = 1
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 81
    Width = 692
    Height = 222
    Align = alClient
    DataSource = DsItem
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'codigo'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Descri'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 300
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'qtde'
        Title.Alignment = taCenter
        Title.Caption = 'Qtde.'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valor'
        Title.Alignment = taCenter
        Title.Caption = 'Valor (un)'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'valortotal'
        Title.Alignment = taCenter
        Title.Caption = 'Valor Total'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'Tahoma'
        Title.Font.Style = [fsBold]
        Width = 80
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 81
    Align = alTop
    TabOrder = 2
    ExplicitLeft = -1
    ExplicitTop = -6
    object edtCodCliente: TEdit
      Left = 16
      Top = 16
      Width = 81
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TextHint = 'C'#243'd. Cliente'
      OnExit = edtCodClienteExit
    end
    object edtClienteNome: TEdit
      Left = 112
      Top = 16
      Width = 265
      Height = 21
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      TextHint = 'Cliente'
    end
    object edtQtd: TEdit
      Left = 112
      Top = 43
      Width = 121
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      TextHint = 'Quantidade'
    end
    object edtCodProduto: TEdit
      Left = 16
      Top = 43
      Width = 81
      Height = 21
      Alignment = taRightJustify
      NumbersOnly = True
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      TextHint = 'C'#243'd. Produto'
    end
    object edtPrecoUn: TEdit
      Left = 256
      Top = 43
      Width = 121
      Height = 21
      Alignment = taRightJustify
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      TextHint = 'Pre'#231'o Unit'#225'rio'
    end
    object Button2: TButton
      Left = 383
      Top = 42
      Width = 98
      Height = 23
      Caption = 'Adicionar'
      TabOrder = 5
      OnClick = Button2Click
    end
  end
  object DsItem: TDataSource
    DataSet = CdsItem
    Left = 280
    Top = 160
  end
  object CdsItem: TClientDataSet
    PersistDataPacket.Data = {
      830000009619E0BD010000001800000006000000000003000000830006636F64
      69676F04000100000000000964657363726963616F0200490000000100055749
      44544802000200FF00047174646504000100000000000576616C6F7208000400
      000000000A76616C6F72746F74616C080004000000000005546F74616C080004
      00000000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'codigo'
        DataType = ftInteger
      end
      item
        Name = 'descricao'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'qtde'
        DataType = ftInteger
      end
      item
        Name = 'valor'
        DataType = ftFloat
      end
      item
        Name = 'valortotal'
        DataType = ftFloat
      end
      item
        Name = 'Total'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 208
    Top = 160
    object CdsItemcodigo: TIntegerField
      FieldName = 'codigo'
    end
    object CdsItemdescricao: TStringField
      FieldName = 'descricao'
      Size = 255
    end
    object CdsItemqtde: TIntegerField
      FieldName = 'qtde'
    end
    object CdsItemvalor: TFloatField
      FieldName = 'valor'
    end
    object CdsItemvalortotal: TFloatField
      FieldName = 'valortotal'
    end
    object CdsItemTotal: TFloatField
      FieldName = 'Total'
    end
  end
  object CdsPedido: TClientDataSet
    PersistDataPacket.Data = {
      810000009619E0BD02000000180000000400000000000300000081000D6E756D
      65726F5F70656469646F04000100000000000C646174615F656D697373616F10
      001100000001000753554254595045020049000A00466F726D61747465640007
      636C69656E746504000100000000000B76616C6F725F746F74616C0800040000
      0000000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'numero_pedido'
        DataType = ftInteger
      end
      item
        Name = 'data_emissao'
        DataType = ftTimeStamp
      end
      item
        Name = 'cliente'
        DataType = ftInteger
      end
      item
        Name = 'valor_total'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 208
    Top = 224
    object CdsPedidonumero_pedido: TIntegerField
      FieldName = 'numero_pedido'
    end
    object CdsPedidocliente: TIntegerField
      FieldName = 'cliente'
    end
    object CdsPedidovalor_total: TFloatField
      FieldName = 'valor_total'
    end
    object CdsPedidodata_emissao: TSQLTimeStampField
      FieldName = 'data_emissao'
    end
  end
  object DsPedido: TDataSource
    DataSet = CdsPedido
    Left = 288
    Top = 224
  end
  object CdsPedidoItem: TClientDataSet
    PersistDataPacket.Data = {
      7E0000009619E0BD0100000018000000050000000000030000007E000D6E756D
      65726F5F70656469646F04000100000000000770726F6475746F040001000000
      00000A7175616E74696461646504000100000000000E76616C6F725F756E6974
      6172696F08000400000000000B76616C6F725F746F74616C0800040000000000
      0000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'numero_pedido'
        DataType = ftInteger
      end
      item
        Name = 'produto'
        DataType = ftInteger
      end
      item
        Name = 'quantidade'
        DataType = ftInteger
      end
      item
        Name = 'valor_unitario'
        DataType = ftFloat
      end
      item
        Name = 'valor_total'
        DataType = ftFloat
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 136
    Top = 224
    object CdsPedidoItemnumero_pedido: TIntegerField
      FieldName = 'numero_pedido'
    end
    object CdsPedidoItemproduto: TIntegerField
      FieldName = 'produto'
    end
    object CdsPedidoItemquantidade: TIntegerField
      FieldName = 'quantidade'
    end
    object CdsPedidoItemvalor_unitario: TFloatField
      FieldName = 'valor_unitario'
    end
    object CdsPedidoItemvalor_total: TFloatField
      FieldName = 'valor_total'
    end
  end
end

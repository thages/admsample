unit WkVendas.Model.Conexao;


interface
uses
  System.Classes,FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, System.SysUtils,FireDAC.DApt,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Vcl.Forms,FireDAC.VCLUI.ConnEdit,
  System.StrUtils, FireDAC.Stan.Param, WkVendas.Controller.Observer.Interfaces,
  System.Variants, FireDAC.Comp.DataSet;

type
  iModelQuery = interface;

  iModelTransaction = interface;
  
  iModelConexao = interface
    function Connection : TObject;
    function Query : TObject;
    function Transaction: TObject;
    function MySQLDriver : TObject;
    procedure CreateTableEstados;
    procedure CreateTableCidades;
    procedure CreateTableClientes;
    procedure CreateTableProdutos;
    procedure CreateTablePedido;
    procedure CreateTablePedidoProdutos;
    function LibPath: String;
  end;

  iModelConexaoFactory = interface
    function Conexao : iModelConexao;
    function Transaction: iModelTransaction;
    function Query : iModelQuery;
  end;

  iModelQuery = interface
    function Query : TObject;
    function Open(ASQL : String; AParams: array of Variant) : iModelQuery;
    function ExecSQL(ASQL: String; AParams: array of Variant) : iModelQuery;
    function Append(ASQL: String; AValue : TDataSet) : iModelQuery;
  end;

  iModelTransaction = interface
    function Transaction: TObject;
    function Start : iModelTransaction;
    function Commit : iModelTransaction;
    function Rollback : iModelTransaction; 
  end;

  iModelEntity = interface
    function DataSet ( AValue : TDataSource ) : iModelEntity;
    procedure Open(ACod:integer);
    procedure Append(AValue : TDataSet);
  end;

  iModelPedido = interface
    function DataSet ( AValue : TDataSource ) : iModelPedido;
    procedure Open(ACod:integer);
    procedure Append(AValue : TDataSet);
    function NumeroPedido:  Integer;
  end;

  iModelEntityFactory = interface
    function Cliente: iModelEntity;
    function Produto: iModelEntity;
    function Pedido: iModelPedido;
    function PedidoProduto: iModelEntity;
  end;

Type
  TModelFiredacConexao = class(TInterfacedObject, iModelConexao)
    private
      FConexao : TFDConnection;
      FQuery : TFDQuery;
      FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
      FTransaction: TFDTransaction;
    public
      constructor Create; overload;
      destructor Destroy; override;
      class function New: iModelConexao; overload;
      function Connection : TObject;
      function Query : TObject;
      function Transaction : TObject;
      function MySQLDriver : TObject;
      procedure CreateTableEstados;
      procedure CreateTableCidades;
      procedure CreateTableClientes;
      procedure CreateTableProdutos;
      procedure CreateTablePedido;
      procedure CreateTablePedidoProdutos;
      function LibPath: String;
  end;

Type
  TModelFiredacQuery = class(TInterfacedObject, iModelQuery)
    private
      FQuery : TFDQuery;
      FConexao : iModelConexao;
    public
      constructor Create(AValue : iModelConexao);
      destructor Destroy; override;
      class function New(AValue : iModelConexao) : iModelQuery;
      function Query : TObject;
      function Open(ASQL: String; AParams: array of Variant) : iModelQuery;
      function ExecSQL(ASQL: String; AParams: array of Variant): iModelQuery;
      function Append(ASQL: String; AValue : TDataSet) : iModelQuery;
  end;

Type
  TModelFiredacTransaction = class(TInterfacedObject, iModelTransaction)
    private
      FTransaction: TFDTransaction;
      FConexao : iModelConexao;
    public
      constructor Create(AValue : iModelConexao);
      destructor Destroy; override;
      class function New(AValue : iModelConexao): iModelTransaction;
      function Transaction : TObject;
      function Start : iModelTransaction;
      function Commit : iModelTransaction;
      function Rollback : iModelTransaction;
  end;

Type
  TModelConexaoFactory = class(TInterfacedObject, iModelConexaoFactory)
    private
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelConexaoFactory;
      function Conexao : iModelConexao;
      function Query : iModelQuery;
      function Transaction : iModelTransaction;
  end;

type
  TModelEntityProduto = class(TInterfacedObject, iModelEntity)
    private
      FQuery : iModelQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEntity;
      function DataSet ( AValue : TDataSource ) : iModelEntity;
      procedure Open(ACod:integer);
      procedure Append( AValue : TDataSet );
  end;

type
  TModelEntityCliente = class(TInterfacedObject, iModelEntity)
    private
      FQuery : iModelQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEntity;
      function DataSet ( AValue : TDataSource ) : iModelEntity;
      procedure Open(ACod:integer);
      procedure Append( AValue : TDataSet );
  end;

type
  TModelEntityPedido = class(TInterfacedObject, iModelPedido)
    private
      FQuery : iModelQuery;
      FNumeroPedido : Integer;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelPedido;
      function DataSet( AValue : TDataSource ) : iModelPedido;
      procedure Open(ANum:integer);
      procedure Append( AValue : TDataSet );
      function NumeroPedido : Integer;
  end;

type
  TModelEntityPedidoProduto = class(TInterfacedObject, iModelEntity)
    private
      FQuery : iModelQuery;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEntity;
      function DataSet ( AValue : TDataSource ) : iModelEntity;
      procedure Open(ANum:integer);
      procedure Append( AValue : TDataSet );
  end;

type
    TModelEntitiesFactory = class(TInterfacedObject, iModelEntityFactory)
    private
      FProduto : iModelEntity;
      FCliente: iModelEntity;
      FPedido: iModelPedido;
      FPedidoProduto: iModelEntity;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelEntityFactory;
      function Cliente: iModelEntity;
      function Produto: iModelEntity;
      function Pedido: iModelPedido;
      function PedidoProduto: iModelEntity;
   end;

implementation


{ TModelFiredacConexao }

function TModelFiredacConexao.Connection: TObject;
begin
  Result := FConexao;
end;

constructor TModelFiredacConexao.Create;
begin
  try
  
    FDPhysMySQLDriverLink1 := TFDPhysMySQLDriverLink.Create(nil);
    FDPhysMySQLDriverLink1.VendorLib := libPath;

    FTransaction := TFDTransaction.Create(nil);
    FConexao := TFDConnection.Create(nil);
    FConexao.LoginPrompt := False;
    FConexao.Params.Values['DriverID'] := 'MySQL';
    FConexao.Params.Values['Server'] := 'localhost';
    FConexao.Params.Values['Database'] := 'wk_vendas';
    FConexao.Params.Values['User_Name'] := 'root';
    FConexao.Params.Values['Password']  := '123456';
    FConexao.Transaction := FTransaction;
    FConexao.Connected := true;
  
    FConexao.StartTransaction;

    CreateTableEstados;
    CreateTableCidades;
    CreateTableClientes;
    CreateTableProdutos;
    CreateTablePedido;
    CreateTablePedidoProdutos;
  
    FConexao.Commit;
    
  except on E: Exception do
    begin
      FConexao.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TModelFiredacConexao.CreateTableCidades;
begin
  try
    FQuery := TFDQuery.Create(nil);
    FQuery.Connection := FConexao;
    FQuery.ExecSQL(' CREATE TABLE IF NOT EXISTS cidades ( '
                  +' codigo INT(11) AUTO_INCREMENT, '
                  +' nome VARCHAR(120) NOT NULL,'
                  +' uf INT(2) NOT NULL, '
                  +' PRIMARY KEY (codigo), '
                  +' FOREIGN KEY (uf)  '
                  +'  REFERENCES estados(codigo)'
                  +' )ENGINE=InnoDB;'
                  );  
  except on E: Exception do
    raise;
  end;
end;

procedure TModelFiredacConexao.CreateTableClientes;
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  FQuery.ExecSQL(  ' CREATE TABLE IF NOT EXISTS clientes ( '
                  +' codigo INT AUTO_INCREMENT, '
                  +' nome VARCHAR(255) NOT NULL,'
                  +' cidade INT(11) NOT NULL, '
                  +' uf INT(2) NOT NULL, '
                  +' PRIMARY KEY (codigo), '
                  +' FOREIGN KEY (cidade)  '
                  +'  REFERENCES cidades(codigo),'
                  +' FOREIGN KEY (uf)  '
                  +'  REFERENCES estados(codigo)'
                  +' )ENGINE=InnoDB;'
                 );
end;

procedure TModelFiredacConexao.CreateTableEstados;
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  FQuery.ExecSQL(  ' CREATE TABLE IF NOT EXISTS estados ( '
                  +' codigo INT(2) NOT NULL, '
                  +' nome VARCHAR(75) NOT NULL,'
                  +' uf VARCHAR(2) DEFAULT NULL, '
                  +' PRIMARY KEY (codigo) '
                  +' )ENGINE=InnoDB;'
                 );


end;

procedure TModelFiredacConexao.CreateTablePedido;
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  FQuery.ExecSQL(  ' CREATE TABLE IF NOT EXISTS pedido ( '
                  +' numero_pedido INT AUTO_INCREMENT, '
                  +' data_emissao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,'
                  +' cliente INT NOT NULL, '
                  +' valor_total DOUBLE NOT NULL, '
                  +' PRIMARY KEY (numero_pedido), '
                  +' FOREIGN KEY (cliente)  '
                  +'  REFERENCES clientes(codigo)'
                  +' )ENGINE=InnoDB;'
                );
end;

procedure TModelFiredacConexao.CreateTablePedidoProdutos;
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  FQuery.ExecSQL(  ' CREATE TABLE IF NOT EXISTS pedido_produtos ( '
                  +' id INT AUTO_INCREMENT, '
                  +' numero_pedido INT NOT NULL, '
                  +' produto INT NOT NULL, '
                  +' quantidade INT NOT NULL, '
                  +' valor_unitario DOUBLE NOT NULL, '
                  +' valor_total DOUBLE NOT NULL, '
                  +' PRIMARY KEY (id), '
                  +' FOREIGN KEY (numero_pedido)  '
                  +'  REFERENCES pedido(numero_pedido)'
                  +' )ENGINE=InnoDB;'
                );
end;

procedure TModelFiredacConexao.CreateTableProdutos;
begin
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
  FQuery.ExecSQL(  ' CREATE TABLE IF NOT EXISTS produtos ( '
                  +' codigo INT NOT NULL, '
                  +' descricao VARCHAR(255) NOT NULL,'
                  +' preco_venda DOUBLE NOT NULL, '
                  +' PRIMARY KEY (codigo) '
                  +' )ENGINE=InnoDB;'
                 );
end;

destructor TModelFiredacConexao.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

function TModelFiredacConexao.LibPath: String;
begin
  {$IFDEF DEBUG}
    Result := StringReplace(ExtractFilePath(Application.ExeName),'\Win32\Debug\','',[])+'\libmysql.dll';
  {$ELSE}
    Result := ExtractFilePath(Application.ExeName)+'\libmysql.dll';
  {$ENDIF}

end;

function TModelFiredacConexao.MySQLDriver: TObject;
begin
  Result := FDPhysMySQLDriverLink1;
end;


class function TModelFiredacConexao.New: iModelConexao;
begin
  Result := Self.Create;
end;


function TModelFiredacConexao.Query: TObject;
begin
  Result := FQuery;
end;

function TModelFiredacConexao.Transaction: TObject;
begin
  Result := FTransaction;
end;

{ TModelFiredacQuery }

function TModelFiredacQuery.Append(ASQL: String; AValue: TDataSet): iModelQuery;
begin
  try
    Result := Self;
    FQuery.Open(ASQL);
    FQuery.Append;
    FQuery.CopyRecord(AValue);
    FQuery.Post;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

constructor TModelFiredacQuery.Create(AValue: iModelConexao);
begin
  FConexao := AValue;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(FConexao.Connection);
end;

destructor TModelFiredacQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function TModelFiredacQuery.ExecSQL(ASQL: String; AParams: Array of Variant): iModelQuery;
begin
  Result := Self;
  FQuery.ExecSQL(ASQL,AParams);
end;

class function TModelFiredacQuery.New(AValue: iModelConexao): iModelQuery;
begin
  Result := Self.Create(AValue);
end;

function TModelFiredacQuery.Open(ASQL: String; AParams: array of Variant): iModelQuery;
begin
  Result := Self;
  FQuery.Open(ASQL,AParams);
end;

function TModelFiredacQuery.Query: TObject;
begin
  Result := FQuery;
end;

{ TModelConexaoFactory }

function TModelConexaoFactory.Conexao: iModelConexao;
begin
  Result := TModelFiredacConexao.New;
end;

constructor TModelConexaoFactory.Create;
begin

end;

destructor TModelConexaoFactory.Destroy;
begin

  inherited;
end;

class function TModelConexaoFactory.New: iModelConexaoFactory;
begin
  Result := Self.Create;
end;

function TModelConexaoFactory.Query: iModelQuery;
begin
  Result := TModelFiredacQuery.New(Self.Conexao);
end;

function TModelConexaoFactory.Transaction: iModelTransaction;
begin
  Result := TModelFiredacTransaction.New(Self.Conexao);
end;

{ TModelEntidadeProduto }

procedure TModelEntityProduto.Append(AValue: TDataSet);
begin
  FQuery.Append('SELECT * FROM produto',AValue);
end;

constructor TModelEntityProduto.Create;
begin
  FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntityProduto.DataSet(AValue: TDataSource): iModelEntity;
begin
  Result := Self;
  AValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntityProduto.Destroy;
begin

  inherited;
end;


class function TModelEntityProduto.New: iModelEntity;
begin
  Result := Self.Create;
end;

procedure TModelEntityProduto.Open(ACod:integer);
begin
  FQuery.Open('SELECT * FROM produtos WHERE codigo = :Cod', [ACod]);
end;

{ TModelEntidadesFactory }

function TModelEntitiesFactory.Cliente: iModelEntity;
begin
  if not Assigned(FCliente) then
    FCliente := TModelEntityCliente.New;
  Result := FCliente;
end;

constructor TModelEntitiesFactory.Create;
begin

end;

destructor TModelEntitiesFactory.Destroy;
begin

  inherited;
end;

class function TModelEntitiesFactory.New: iModelEntityFactory;
begin
  Result := Self.Create;
end;

function TModelEntitiesFactory.Pedido: iModelPedido;
begin
  if not Assigned(FPedido) then
    FPedido := TModelEntityPedido.New;
  Result := FPedido;
end;

function TModelEntitiesFactory.PedidoProduto: iModelEntity;
begin
  if not Assigned(FPedidoProduto) then
    FPedidoProduto := TModelEntityPedidoProduto.New;
  Result := FPedidoProduto;
end;

function TModelEntitiesFactory.Produto: iModelEntity;
begin
  if not Assigned(FProduto) then
    FProduto := TModelEntityProduto.New;
  Result := FProduto;
end;

{ TModelEntityCliente }

procedure TModelEntityCliente.Append(AValue: TDataSet);
begin
   FQuery.Append('SELECT * FROM Cliente', AValue);
end;

constructor TModelEntityCliente.Create;
begin
  FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntityCliente.DataSet(AValue: TDataSource): iModelEntity;
begin
  Result := Self;
  AValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntityCliente.Destroy;
begin

  inherited;
end;


class function TModelEntityCliente.New: iModelEntity;
begin
  Result := Self.Create;
end;

procedure TModelEntityCliente.Open(ACod: integer);
begin
  FQuery.Open('SELECT * FROM clientes WHERE codigo = :Cod',[ACod]);
end;


{ TModelEntityPedido }

procedure TModelEntityPedido.Append(AValue: TDataSet);
begin
  try
    FQuery.Append('SELECT * FROM pedido ',AValue);
    FNumeroPedido := TFDQuery(FQuery.Query)
                      .FieldByName('numero_pedido')
                      .AsInteger;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

constructor TModelEntityPedido.Create;
begin
  FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntityPedido.DataSet(AValue: TDataSource): iModelPedido;
begin
  Result := Self;
  AValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntityPedido.Destroy;
begin

  inherited;
end;

class function TModelEntityPedido.New: iModelPedido;
begin
  Result := Self.Create;
end;

function TModelEntityPedido.NumeroPedido : Integer;
begin
  Result := FNumeroPedido;
end;

procedure TModelEntityPedido.Open(ANum:integer);
begin
  FQuery.Open('SELECT * FROM pedido WHERE numero_pedido = :Num',[ANum]);
end;

{ TModelEntityPedidoProduto }

procedure TModelEntityPedidoProduto.Append(AValue: TDataSet);
begin
  try
    FQuery.Append('SELECT * FROM pedido_produtos',AValue);  
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

constructor TModelEntityPedidoProduto.Create;
begin
  FQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntityPedidoProduto.DataSet(AValue: TDataSource): iModelEntity;
begin
  Result := Self;
  AValue.DataSet := TDataSet(FQuery.Query);
end;

destructor TModelEntityPedidoProduto.Destroy;
begin

  inherited;
end;


class function TModelEntityPedidoProduto.New: iModelEntity;
begin
  Result := Self.Create;
end;

procedure TModelEntityPedidoProduto.Open(ANum: integer);
begin
  FQuery.Open('SELECT * FROM pedido_produtos WHERE numero_pedido = :Num',[ANum]);
end;

{ TModelFiredacTransaction }

function TModelFiredacTransaction.Commit: iModelTransaction;
begin
  try
    Result := Self;
    FTransaction.Commit; 
  except on E: Exception do
    raise Exception.Create(E.Message);
  end; 
end;

constructor TModelFiredacTransaction.Create(AValue : iModelConexao);
begin
  try
    FConexao := AValue;
    FTransaction := TFDTransaction.Create(nil);
    FTransaction.Connection := TFDConnection(FConexao.Connection);
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

destructor TModelFiredacTransaction.Destroy;
begin
   FreeAndNil(FTransaction);
  inherited;
end;

class function TModelFiredacTransaction.New(AValue : iModelConexao): iModelTransaction;
begin
  Result := Self.Create(AValue);
end;

function TModelFiredacTransaction.Rollback: iModelTransaction;
begin
  try
    Result := Self;
    FTransaction.Rollback;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

function TModelFiredacTransaction.Start: iModelTransaction;
begin
  Result := Self;
  FTransaction.StartTransaction;
end;

function TModelFiredacTransaction.Transaction: TObject;
begin
  Result:=  FTransaction;
end;

end.

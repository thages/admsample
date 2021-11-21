unit WkVendas.Model.Pedido;

interface

uses
  WkVendas.Model.Interfaces, WkVendas.Controller.Conexao, Data.DB;

type
  TModelPedido = class(TInterfacedObject, iModelPedido)
    private
      [weak]
      FParent : iModelVenda;
      FCodigo : Integer;
      FCliente : Integer;
      FControllerConexao : iController;
    public
      constructor Create(Parent : iModelVenda);
      destructor Destroy; override;
      class function New(Parent : iModelVenda) : iModelPedido;
      function Codigo(Value : Integer) : iModelPedido;
      function Cliente(Value : Integer) : iModelPedido;
      function DadosGerais : iModelPedido;
  end;

implementation

uses
  WkVendas.Controller.Observer.Interfaces;

function TModelPedido.Codigo(Value: Integer): iModelPedido;
begin
  Result := Self;
  FCodigo := Value;
end;

constructor TModelPedido.Create(Parent : iModelVenda);
begin
  FParent := Parent;
  FControllerConexao := TController.New;
end;

destructor TModelPedido.Destroy;
begin

  inherited;
end;

class function TModelPedido.New (Parent : iModelVenda) : iModelPedido;
begin
  Result := Self.Create(Parent);
end;

function TModelPedido.Cliente(Value: Integer): iModelPedido;
begin
  Result := Self;
  FCliente := Value;
end;

function TModelPedido.DadosGerais: iModelPedido;
var
  RI : TRecordPedido;
  FDataSource:  TDataSource;
begin
  Result := Self;

  FDataSource := TDataSource.Create(nil);

  FControllerConexao
  .Entities
    .Cliente
      .DataSet(FDataSource)
    .Open(FCliente);

  RI.Cliente := FCliente;
  RI.ClienteNome := FDataSource
                    .DataSet
                      .FieldByName('nome')
                        .AsString;

  FParent.ObserverPedido.Display(RI);
end;
end.

unit WkVendas.Controller.Pedido;

interface

uses
  WkVendas.Controller.Interfaces;

type
  TControllerPedido = class(TInterfacedObject, iControllerPedido)
    private
      [weak]
      FParent : iControllerVenda;
      FCodigo : Integer;
      FCliente : Integer;
    public
      constructor Create(Parent : iControllerVenda);
      destructor Destroy; override;
      class function New(Parent : iControllerVenda) : iControllerPedido;
      function Codigo(Value : Integer) : iControllerPedido;
      function Cliente(Value : Integer) : iControllerPedido;
      function DadosGerais : iControllerPedido;
  end;

implementation

function TControllerPedido.Cliente(Value: Integer): iControllerPedido;
begin
  Result := Self;
  FCliente := Value;
end;

function TControllerPedido.Codigo(Value: Integer): iControllerPedido;
begin
  Result := Self;
  FCodigo := Value;
end;

constructor TControllerPedido.Create(Parent : iControllerVenda);
begin
  FParent := Parent;
end;

destructor TControllerPedido.Destroy;
begin

  inherited;
end;

class function TControllerPedido.New(Parent : iControllerVenda) : iControllerPedido;
begin
  Result := Self.Create(Parent);
end;

function TControllerPedido.DadosGerais: iControllerPedido;
begin
  Result := Self;
  FParent
    .Model
    .Pedido
      .Cliente(FCliente)
      .DadosGerais;
end;
end.

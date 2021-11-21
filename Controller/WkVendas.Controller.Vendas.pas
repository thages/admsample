unit WkVendas.Controller.Vendas;

interface

uses
  WkVendas.Controller.Interfaces, WkVendas.Model.Interfaces,
  WkVendas.Controller.Observer.Interfaces;

type
  TControllerVendas = class(TInterfacedObject, iControllerVenda)
    private
      FPedido : iControllerPedido;
      FItem : iControllerItens;
      FModel : iModelVenda;
      FObserverPedido : iSubjectPedido;
      FObserverItem : iSubjectItem;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iControllerVenda;
      function Pedido : iControllerPedido;
      function Item : iControllerItens;
      function Model : iModelVenda;
      function ObserverPedido : iSubjectPedido;
      function ObserverItem : iSubjectItem;
  end;

implementation

uses
  WkVendas.Controller.Item, WkVendas.Model.Venda,WkVendas.Controller.Pedido,
  WkVendas.Controller.Observer.Item,WkVendas.Controller.Observer.Pedido;

constructor TControllerVendas.Create;
begin
  FModel := TModelVenda.New;
  FObserverItem := TControllerObserverItem.New;
  FItem := TControllerItem.New(Self);
  FModel.ObserverItem(FObserverItem);
  FObserverPedido := TControllerObserverPedido.New;
  FPedido := TControllerPedido.New(Self);
  FModel.ObserverPedido(FObserverPedido);
end;

destructor TControllerVendas.Destroy;
begin

  inherited;
end;

function TControllerVendas.Item: iControllerItens;
begin
  Result := FItem;
end;

function TControllerVendas.Model: iModelVenda;
begin
  Result := FModel;
end;

class function TControllerVendas.New : iControllerVenda;
begin
  Result := Self.Create;
end;

function TControllerVendas.ObserverItem: iSubjectItem;
begin
  Result := FObserverItem;
end;

function TControllerVendas.ObserverPedido: iSubjectPedido;
begin
  Result := FObserverPedido;
end;

function TControllerVendas.Pedido: iControllerPedido;
begin
  Result := FPedido;
end;

end.

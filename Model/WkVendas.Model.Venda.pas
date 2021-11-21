unit WkVendas.Model.Venda;

interface

uses
  WkVendas.Model.Interfaces, WkVendas.Controller.Observer.Interfaces;

type
  TModelVenda = class(TInterfacedObject, iModelVenda)
    private
      FPedido : iModelPedido;
      FObserverPedido : iSubjectPedido;
      FItem : iModelItem;
      FObserverItem : iSubjectItem;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iModelVenda;
      function Pedido : iModelPedido;
      function ObserverPedido(Value : iSubjectPedido) : iModelVenda; overload;
      function ObserverPedido : iSubjectPedido; overload;
      function Item : iModelItem;
      function ObserverItem(Value : iSubjectItem) : iModelVenda; overload;
      function ObserverItem : iSubjectItem; overload;
  end;

implementation

uses
  WkVendas.Model.Item,WkVendas.Model.Pedido;

constructor TModelVenda.Create;
begin
  FItem := TModelItem.New(Self);
  FPedido := TModelPedido.New(Self);
end;

destructor TModelVenda.Destroy;
begin

  inherited;
end;

function TModelVenda.Item: iModelItem;
begin
  Result := FItem;
end;

class function TModelVenda.New : iModelVenda;
begin
  Result := Self.Create;
end;

function TModelVenda.ObserverItem: iSubjectItem;
begin
  Result := FObserverItem;
end;

function TModelVenda.ObserverPedido(Value: iSubjectPedido): iModelVenda;
begin
  Result := Self;
  FObserverPedido := Value;
end;

function TModelVenda.ObserverPedido: iSubjectPedido;
begin
  Result := FObserverPedido;
end;

function TModelVenda.Pedido: iModelPedido;
begin
  Result := FPedido;
end;

function TModelVenda.ObserverItem(Value: iSubjectItem): iModelVenda;
begin
  Result := Self;
  FObserverItem := Value;
end;

end.

unit WkVendas.Controller.Item;

interface

uses
  WkVendas.Controller.Interfaces;

type

  TControllerItem = class(TInterfacedObject, iControllerItens)
    private
      [weak]
      FParent : iControllerVenda;
      FCodigo : Integer;
      FQuantidade : Integer;
      FPrecoUnitario : Currency;
    public
      constructor Create(Parent : iControllerVenda);
      destructor Destroy; override;
      class function New(Parent : iControllerVenda) : iControllerItens;
      function Codigo(Value : Integer) : iControllerItens;
      function Quantidade(Value : Integer) : iControllerItens;
      function PrecoUnitario(Value : Currency) : iControllerItens;
      function IncluirItem : iControllerItens;
      function RemoverItem: iControllerItens;
      function &End : iControllerVenda;
  end;

implementation

function TControllerItem.Codigo(Value: Integer): iControllerItens;
begin
  Result := Self;
  FCodigo := Value;
end;

function TControllerItem.&End: iControllerVenda;
begin
  Result := FParent;
end;

constructor TControllerItem.Create(Parent : iControllerVenda);
begin
  FParent := Parent;
end;

destructor TControllerItem.Destroy;
begin

  inherited;
end;

class function TControllerItem.New (Parent : iControllerVenda) : iControllerItens;
begin
  Result := Self.Create(Parent);
end;

function TControllerItem.PrecoUnitario(Value: Currency): iControllerItens;
begin
  Result := Self;
  FPrecoUnitario := Value;
end;

function TControllerItem.Quantidade(Value: Integer): iControllerItens;
begin
  Result := Self;
  FQuantidade := Value;
end;

function TControllerItem.RemoverItem: iControllerItens;
begin
  Result := Self;
  FParent
    .Model
    .Item
      .RemoverItem;
end;

function TControllerItem.IncluirItem: iControllerItens;
begin
  Result := Self;
  FParent
    .Model
    .Item
      .Codigo(FCodigo)
      .Quantidade(FQuantidade)
      .PrecoUnitario(FPrecoUnitario)
      .IncluirItem;
end;
end.

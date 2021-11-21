unit WkVendas.Model.Item;

interface

uses
  WkVendas.Model.Interfaces, WkVendas.Controller.Conexao, Data.DB;

type
  TModelItem = class(TInterfacedObject, iModelItem)
    private
      [weak]
      FParent : iModelVenda;
      FCodigo : Integer;
      FQuantidade : Integer;
      FPrecoUnitario : Currency;
      FControllerConexao : iController;
    public
      constructor Create(Parent : iModelVenda);
      destructor Destroy; override;
      class function New(Parent : iModelVenda) : iModelItem;
      function Codigo(Value : Integer) : iModelItem;
      function Quantidade(Value : Integer) : iModelItem;
      function PrecoUnitario(Value : Currency) : iModelItem;
      function IncluirItem : iModelItem;
      function RemoverItem: iModelItem;
      function &End : iModelVenda;
  end;

implementation

uses
  WkVendas.Controller.Observer.Interfaces;

function TModelItem.Codigo(Value: Integer): iModelItem;
begin
  Result := Self;
  FCodigo := Value;
end;

function TModelItem.&End: iModelVenda;
begin
  Result := FParent;
end;

constructor TModelItem.Create(Parent : iModelVenda);
begin
  FParent := Parent;
  FControllerConexao := TController.New;
end;

destructor TModelItem.Destroy;
begin

  inherited;
end;

class function TModelItem.New (Parent : iModelVenda) : iModelItem;
begin
  Result := Self.Create(Parent);
end;

function TModelItem.PrecoUnitario(Value: Currency): iModelItem;
begin
  Result := Self;
  FPrecoUnitario := Value;
end;

function TModelItem.Quantidade(Value: Integer): iModelItem;
begin
  Result := Self;
  FQuantidade := Value;
end;

function TModelItem.RemoverItem: iModelItem;
begin
  Result := Self;
//  FParent.ObserverItem.Remover;
end;

function TModelItem.IncluirItem: iModelItem;
var
  RI : TRecordItem;
  FDataSource:  TDataSource;
begin
  Result := Self;

  FDataSource := TDataSource.Create(nil);

  FControllerConexao
  .Entities
    .Produto
      .DataSet(FDataSource)
    .Open(FCodigo);


  RI.Descricao := FDataSource
                    .DataSet
                      .FieldByName('descricao')
                        .AsString;

   RI.Codigo     := FCodigo;
   RI.Quantidade := FQuantidade;
   RI.Valor      := FPrecoUnitario;
   RI.TotalItem  := (FQuantidade * FPrecoUnitario);

   FParent.ObserverItem.Display(RI);
end;

end.

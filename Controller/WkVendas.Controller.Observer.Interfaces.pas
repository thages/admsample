unit WkVendas.Controller.Observer.Interfaces;

interface

Type
  TRecordPedido = record
    NumeroVenda: Integer;
    DataEmissao: TDateTime;
    Cliente: Integer;
    ClienteNome: String;
    ValorTotal: Currency;
  end;

type
  TRecordItem = record
    Codigo: Integer;
    NumeroPedido: Integer;
    Descricao: String;
    Quantidade: Integer;
    Valor: Currency;
    TotalItem: Currency;
  end;

  iObserverPedido = interface
    ['{585517E2-CD19-444B-A276-E5F476115172}']
    function UpdatePedido(Value : TRecordPedido) : iObserverPedido;
  end;

  iSubjectPedido = interface
    ['{35C5A228-7957-4319-82D8-B87642DEFF4D}']
    function Add(Value : iObserverPedido) : iSubjectPedido;
    function Display(Value : TRecordPedido) : iSubjectPedido;
  end;

  iObserverItem = interface
    ['{84216A54-4FDE-4105-BDAF-BB5B4CAA4C84}']
    function UpdateItem(Value : TRecordItem) : iObserverItem;
    function RemoveItem(Value : TRecordItem) :  iObserverItem;
  end;

  iSubjectItem = interface
    ['{ECBFF88C-AECD-494E-A14A-F568E099B7CB}']
    function Add(Value : iObserverItem) : iSubjectItem;
    function Remover(Value : iObserverItem) : iSubjectItem;
    function Display(Value : TRecordItem) : iSubjectItem;
  end;

implementation

end.

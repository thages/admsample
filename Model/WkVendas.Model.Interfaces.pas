unit WkVendas.Model.Interfaces;

interface

uses
  WkVendas.Controller.Observer.Interfaces;

type
  iModelPedido = interface;
  iModelItem = interface;

  iModelVenda = interface
    ['{21092875-FD83-4E65-AA53-6DED2447C4A6}']
    function Pedido: iModelPedido;
    function ObserverPedido(Value : iSubjectPedido) : iModelVenda; overload;
    function ObserverPedido: iSubjectPedido; overload;
    function Item : iModelItem;
    function ObserverItem(Value : iSubjectItem) : iModelVenda; overload;
    function ObserverItem : iSubjectItem; overload;
  end;

  iModelItem = interface
    ['{4680BA98-F591-4CD4-B57F-624B7C20C928}']
    function Codigo(Value : Integer) : iModelItem;
    function Quantidade(Value : Integer) : iModelItem;
    function PrecoUnitario(Value : Currency) : iModelItem;
    function IncluirItem : iModelItem;
    function RemoverItem : iModelItem;
    function &End : iModelVenda;
  end;

  iModelPedido = interface
    ['{5FCD7444-8C7E-42A4-9B71-27AC716D3A8A}']
    function Codigo(Value : Integer) : iModelPedido;
    function Cliente(Value : Integer) : iModelPedido;
    function DadosGerais : iModelPedido;
  end;


implementation

end.

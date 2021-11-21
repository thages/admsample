unit WkVendas.Controller.Interfaces;

interface

uses
  WkVendas.Model.Interfaces, WkVendas.Controller.Observer.Interfaces;

type
  iControllerPedido = interface;

  iControllerItens = interface;

  iControllerVenda = interface
    ['{EA58DF76-5413-4167-A838-D964FA5F9FDE}']
    function Pedido: iControllerPedido;
    function Item : iControllerItens;
    function Model : iModelVenda;
    function ObserverPedido: iSubjectPedido;
    function ObserverItem : iSubjectItem;
  end;

  iControllerItens = interface
    ['{FD304EB5-AD10-4EEE-A008-25E187D7D397}']
    function Codigo(Value : Integer) : iControllerItens;
    function Quantidade(Value : Integer) : iControllerItens;
    function PrecoUnitario(Value : Currency) : iControllerItens;
    function IncluirItem : iControllerItens;
    function RemoverItem : iControllerItens;
    function &End : iControllerVenda;
  end;

  iControllerPedido = interface
    ['{64EDD1B9-2FD3-449F-8AE5-4FED992E33FD}']
    function Codigo(Value : Integer) : iControllerPedido;
    function Cliente(Value : Integer) : iControllerPedido;
    function DadosGerais : iControllerPedido;
  end;

implementation


end.

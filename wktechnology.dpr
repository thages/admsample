program wktechnology;

uses
  Vcl.Forms,
  WkVendas.View in 'View\WkVendas.View.pas',
  WkVendas.Controller.Observer.Item in 'Controller\WkVendas.Controller.Observer.Item.pas',
  WkVendas.Controller.Observer.Pedido in 'Controller\WkVendas.Controller.Observer.Pedido.pas',
  WkVendas.Controller.Conexao in 'Controller\WkVendas.Controller.Conexao.pas',
  WkVendas.Controller.Vendas in 'Controller\WkVendas.Controller.Vendas.pas',
  WkVendas.Controller.Item in 'Controller\WkVendas.Controller.Item.pas',
  WkVendas.Controller.Pedido in 'Controller\WkVendas.Controller.Pedido.pas',
  WkVendas.Model.Conexao in 'Model\WkVendas.Model.Conexao.pas',
  WkVendas.Model.Interfaces in 'Model\WkVendas.Model.Interfaces.pas',
  WkVendas.Model.Item in 'Model\WkVendas.Model.Item.pas',
  WkVendas.Model.Venda in 'Model\WkVendas.Model.Venda.pas',
  WkVendas.Model.Pedido in 'Model\WkVendas.Model.Pedido.pas',
  WkVendas.Controller.Interfaces in 'Controller\WkVendas.Controller.Interfaces.pas',
  WkVendas.Controller.Observer.Interfaces in 'Controller\WkVendas.Controller.Observer.Interfaces.pas' {$R *.res};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

unit WkVendas.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.DBGrids, WkVendas.Controller.Conexao, Datasnap.DBClient,
  WkVendas.Controller.Interfaces,WkVendas.Controller.Observer.Interfaces, WkVendas.Controller.Vendas,
  Datasnap.Provider, Vcl.Mask, Vcl.DBCtrls;

type
  TForm1 = class(TForm, iObserverItem, iObserverPedido)
    Panel1: TPanel;
    Button1: TButton;
    DsItem: TDataSource;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    CdsItem: TClientDataSet;
    edtCodCliente: TEdit;
    edtClienteNome: TEdit;
    edtQtd: TEdit;
    edtCodProduto: TEdit;
    edtPrecoUn: TEdit;
    Button2: TButton;
    CdsPedido: TClientDataSet;
    DsPedido: TDataSource;
    CdsPedidonumero_pedido: TIntegerField;
    CdsPedidocliente: TIntegerField;
    CdsPedidoItem: TClientDataSet;
    DBEdit1: TDBEdit;
    CdsItemcodigo: TIntegerField;
    CdsItemdescricao: TStringField;
    CdsItemqtde: TIntegerField;
    CdsItemvalor: TFloatField;
    CdsItemvalortotal: TFloatField;
    CdsItemTotal: TFloatField;
    Label1: TLabel;
    CdsPedidovalor_total: TFloatField;
    CdsPedidodata_emissao: TSQLTimeStampField;
    CdsPedidoItemnumero_pedido: TIntegerField;
    CdsPedidoItemproduto: TIntegerField;
    CdsPedidoItemquantidade: TIntegerField;
    CdsPedidoItemvalor_unitario: TFloatField;
    CdsPedidoItemvalor_total: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FVenda : iControllerVenda;
    FConexao: iController;
    procedure AbrirPedido;
    procedure AddItem;
    procedure AddPedidoProdutos;
    procedure CarregarCliente;
    function UpdateItem(Value : TRecordItem) : iObserverItem;
    function RemoveItem(Value : TRecordItem) : iObserverItem;
    function UpdatePedido(Value : TRecordPedido) : iObserverPedido;
    procedure CleanFields;
    procedure UpdateTotalVenda(Value: Currency);
    procedure AtualizarItens(Value: Integer);
    procedure Flush;
    procedure SubtrairValor(Value: Currency);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    FConexao := TController.New;
    FConexao
      .Entities
      .Pedido
      .Append(CdsPedido);

    AtualizarItens(FConexao
                    .Entities
                    .Pedido
                    .NumeroPedido);

    Flush;

    ShowMessage('Cadastrado com sucesso.');
    edtCodCliente.SetFocus;

  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  AddItem;
end;

procedure TForm1.CarregarCliente;
begin
  FVenda
    .Pedido
      .Cliente(StrToInt(edtCodCliente.Text))
      .DadosGerais;
end;

procedure TForm1.CleanFields;
begin
  edtCodProduto.Text := '';
  edtQtd.Text := '';
  edtPrecoUn.Text := '';
  edtCodProduto.SetFocus;
end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_DELETE:
      begin
        if MessageDlg('Deseja deletar produto?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
        begin
          SubtrairValor(CdsItemvalortotal.AsCurrency);
          CdsItem.Delete;
        end;
      end;
    VK_RETURN:
      begin
        //
      end;
  end;
end;

procedure TForm1.edtCodClienteExit(Sender: TObject);
begin
  CarregarCliente;
end;

procedure TForm1.Flush;
begin
  edtCodProduto.Text := '';
  edtQtd.Text := '';
  edtPrecoUn.Text := '';
  edtCodCliente.Text := '';
  edtClienteNome.Text := '';

  CdsPedido.DisableControls;
  CdsPedido.EmptyDataSet;
  CdsPedido.EnableControls;

  CdsItem.DisableControls;
  CdsItem.EmptyDataSet;
  CdsItem.EnableControls;

  CdsPedidoItem.DisableControls;
  CdsPedidoItem.EmptyDataSet;
  CdsPedidoItem.EnableControls;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FVenda := TControllerVendas.New;
  FVenda.ObserverItem.Add(Self);
  FVenda.ObserverPedido.Add(Self);
  AbrirPedido;
end;

function TForm1.RemoveItem(Value: TRecordItem): iObserverItem;
begin
  Result := Self;

  CdsItem.Close;
  CdsItem.Open;
  CdsItem.Locate('codigo',Value.codigo,[]);
  CdsItem.Delete;
  CdsItem.Post;

end;

procedure TForm1.SubtrairValor(Value: Currency);
begin
  CdsPedido.Close;
  CdsPedido.Open;
  CdsPedido.Edit;

  CdsPedidovalor_total.AsCurrency := CdsPedidovalor_total.AsCurrency - Value;

  CdsPedido.Post;
end;

function TForm1.UpdateItem(Value: TRecordItem): iObserverItem;
begin
  Result := Self;

  CdsItem.Close;
  CdsItem.Open;
  CdsItem.Append;

  CdsItemcodigo.AsInteger   := Value.Codigo;
  CdsItemdescricao.AsString := Value.Descricao;
  CdsItemqtde.AsInteger     := Value.Quantidade;
  CdsItemvalor.AsFloat      := Value.Valor;
  CdsItemvalortotal.AsFloat := Value.TotalItem;

  CdsItem.Post;

  UpdateTotalVenda(Value.TotalItem);

end;

function TForm1.UpdatePedido(Value: TRecordPedido): iObserverPedido;
begin
  CdsPedido.Close;
  CdsPedido.Open;
  CdsPedido.Edit;
  CdsPedidocliente.AsInteger := Value.Cliente;
  CdsPedido.Post;

  edtClienteNome.Text := Value.ClienteNome;
end;

procedure TForm1.UpdateTotalVenda(Value: Currency);
begin
  CdsPedido.Close;
  CdsPedido.Open;
  CdsPedido.Edit;

  CdsPedidovalor_total.AsCurrency := CdsPedidovalor_total.AsCurrency + Value;

  CdsPedido.Post;
end;

procedure TForm1.AbrirPedido;
begin
  CdsPedido.Close;
  CdsPedido.Open;
  CdsPedido.Append;

  CdsPedidodata_emissao.AsDateTime := Now;
  CdsPedidovalor_total.AsCurrency := 0;
  CdsPedido.Post;
end;

procedure TForm1.AddItem;
begin
  FVenda
    .Item
      .Codigo(StrToInt(edtCodProduto.Text))
      .Quantidade(StrToInt(edtQtd.Text))
      .PrecoUnitario(StrToFloat(edtPrecoUn.Text))
        .IncluirItem;

  CleanFields;
end;

procedure TForm1.AddPedidoProdutos;
begin

  CdsPedidoItem.Close;
  CdsPedidoItem.Open;
  CdsPedidoItem.Append;

  CdsPedidoItemnumero_pedido.AsInteger  := CdsPedidonumero_pedido.AsInteger;
  CdsPedidoItemproduto.AsInteger        := CdsItemcodigo.AsInteger;
  CdsPedidoItemquantidade.AsInteger     := CdsItemqtde.AsInteger;
  CdsPedidoItemvalor_unitario.AsFloat   := CdsItemvalor.AsFloat;
  CdsPedidoItemvalor_total.AsFloat      := CdsItemvalortotal.AsFloat;

  CdsPedidoItem.Post;

end;

procedure TForm1.AtualizarItens(Value: Integer);
begin
  try
    CdsPedido.Close;
    CdsPedido.Open;
    CdsPedido.Edit;
    CdsPedidonumero_pedido.AsInteger := Value;
    CdsPedido.Post;

    CdsItem.Close;
    CdsItem.Open;
    CdsItem.First;

    while not CdsItem.eof do
    begin

      AddPedidoProdutos;

      FConexao.Entities.PedidoProduto.Append(CdsPedidoItem);
      CdsItem.next;
    end;

  except on E: Exception do
    raise Exception.Create('Erro ao inserir itens.'+sLineBreak+E.Message);
  end;

end;

end.

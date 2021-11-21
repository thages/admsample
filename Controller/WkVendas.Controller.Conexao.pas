unit WkVendas.Controller.Conexao;


interface

uses
  WkVendas.Model.Conexao;

type
  iController = interface
    ['{F8B4C5E0-E908-4376-B157-97C90E0C75F8}']
    function Entities : iModelEntityFactory;
    function Conexao : iModelConexaoFactory;
  end;

Type
  TController = class(TInterfacedObject, iController)
    private
      FModelEntities : iModelEntityFactory;
      FModelConexao : iModelConexaoFactory;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iController;
      function Entities : iModelEntityFactory;
      function Conexao :  iModelConexaoFactory;
  end;

implementation

{ TController }

function TController.Conexao: iModelConexaoFactory;
begin
  Result := FModelConexao;
end;

constructor TController.Create;
begin
  FModelEntities := TModelEntitiesFactory.New;
  FModelConexao := TModelConexaoFactory.New;
end;

destructor TController.Destroy;
begin

  inherited;
end;

function TController.Entities: iModelEntityFactory;
begin
  Result := FModelEntities;
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

end.

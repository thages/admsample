unit WkVendas.Controller.Observer.Pedido;

interface

uses
  WkVendas.Controller.Observer.Interfaces, System.Generics.Collections;

type
  TControllerObserverPedido = class(TInterfacedObject, iSubjectPedido)
    private
      FList : TList<iObserverPedido>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iSubjectPedido;
      function Add(Value : iObserverPedido) : iSubjectPedido;
      function Display(Value : TRecordPedido) : iSubjectPedido;
  end;

implementation

uses
  System.SysUtils;

function TControllerObserverPedido.Add(Value: iObserverPedido): iSubjectPedido;
begin
  Result := Self;
  FList.Add(Value);
end;

constructor TControllerObserverPedido.Create;
begin
   FList := TList<iObserverPedido>.Create;
end;

destructor TControllerObserverPedido.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TControllerObserverPedido.Display(
  Value: TRecordPedido): iSubjectPedido;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Pred(FList.Count) do
    FList[I].UpdatePedido(Value);
end;

class function TControllerObserverPedido.New : iSubjectPedido;
begin
  Result := Self.Create;
end;

end.

unit WkVendas.Controller.Observer.Item;

interface

uses
  WkVendas.Controller.Observer.Interfaces, System.Generics.Collections;

type
  TControllerObserverItem = class(TInterfacedObject, iSubjectItem)
    private
      FList : TList<iObserverItem>;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iSubjectItem;
      function Add(Value : iObserverItem) : iSubjectItem;
      function Remover(Value : iObserverItem) :  iSubjectItem;
      function Display(Value : TRecordItem) : iSubjectItem;
  end;

implementation

uses
  System.SysUtils;

function TControllerObserverItem.Add(Value: iObserverItem): iSubjectItem;
begin
  Result := Self;
  FList.Add(Value);
end;

constructor TControllerObserverItem.Create;
begin
  FList := TList<iObserverItem>.Create;
end;

destructor TControllerObserverItem.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TControllerObserverItem.New : iSubjectItem;
begin
  Result := Self.Create;
end;

function TControllerObserverItem.Remover(Value: iObserverItem): iSubjectItem;
begin
  Result := Self;
  FList.Remove(Value);
end;

function TControllerObserverItem.Display(Value: TRecordItem): iSubjectItem;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Pred(FList.Count) do
    FList[I].UpdateItem(Value);
end;


end.

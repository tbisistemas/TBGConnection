unit TBGDBExpressDriver.Model.Conexao;

interface

uses
  TBGConnection.Model.Interfaces, System.Classes,
  Data.SqlExpr, Data.DB, Data.DBXCommon,
  TBGConnection.Model.DataSet.Interfaces;

Type
  TDBExpressDriverModelConexao = class(TInterfacedObject, iConexao)
  private
    FConnection : TSQLConnection;
    FTrans: TDBXTransaction;
  public
    constructor Create(Connection : TSQLConnection; LimitCacheRegister : Integer);
    destructor Destroy; override;
    class function New(Connection : TSQLConnection; LimitCacheRegister : Integer) : iConexao;
    function ThisAs: TObject;
    //iConexao
    function Conectar : iConexao;
    function &End: TComponent;
    function Connection : TComponent;
    function StartTransaction : iConexao;
    function RollbackTransaction : iConexao;
    function Commit : iConexao;
  end;

implementation

uses
  System.SysUtils, TBGConnection.Model.DataSet.Proxy;

{ TDBExpressDriverModelConexao }

function TDBExpressDriverModelConexao.Commit: iConexao;
begin
  Result := Self;
  FConnection.CommitFreeAndNil(FTrans);
end;

function TDBExpressDriverModelConexao.Conectar: iConexao;
begin
  Result := Self;
  FConnection.Connected := true;
end;

function TDBExpressDriverModelConexao.&End: TComponent;
begin
  Result := FConnection;
end;

function TDBExpressDriverModelConexao.Connection: TComponent;
begin
  Result := FConnection;
end;

constructor TDBExpressDriverModelConexao.Create(Connection : TSQLConnection; LimitCacheRegister : Integer);
begin
  FConnection := Connection;
end;

destructor TDBExpressDriverModelConexao.Destroy;
begin

  inherited;
end;

class function TDBExpressDriverModelConexao.New(Connection : TSQLConnection; LimitCacheRegister : Integer) : iConexao;
begin
  Result := Self.Create(Connection, LimitCacheRegister);
end;

function TDBExpressDriverModelConexao.RollbackTransaction: iConexao;
begin
  Result := Self;
  FConnection.RollbackFreeAndNil(FTrans);
end;

function TDBExpressDriverModelConexao.StartTransaction: iConexao;
begin
  Result := Self;
  FTrans := FConnection.BeginTransaction;
end;

function TDBExpressDriverModelConexao.ThisAs: TObject;
begin
  Result := Self;
end;

end.

unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, uniGUIBaseClasses, uniGUIClasses, uniPanel,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Phys.FB, FireDAC.Phys.FBDef, Vcl.Mask,
  Vcl.ComCtrls, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd, ppClass, ppReport,
  Vcl.Menus, ppCtrls, ppPrnabl, ppBands, ppCache, ppDesignLayer, ppParameter;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    TB_EMPRESA_CIDADE: TFDQuery;
    CONNECTION: TFDConnection;
    DS: TDataSource;
    TB_EMPRESA_CIDADEID: TIntegerField;
    TB_EMPRESA_CIDADECIDADE: TStringField;
    TB_EMPRESA_CIDADEESTADO: TStringField;
    TB_EMPRESA_CIDADECONTATO: TStringField;
    TB_EMPRESA_CIDADESTATUS: TStringField;
    TB_EMPRESA_CIDADENOME_EMPRESA: TStringField;
    TB_EMPRESA_CIDADEESTADO_ATUAL: TStringField;
    TB_EMPRESA_CIDADEDATA: TDateField;
    TB_EMPRESA_CIDADECONTATADO: TStringField;
    UniContainerPanel1: TUniContainerPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    TB_SELECT: TFDQuery;
    Report: TppReport;
    DBPipeline: TppDBPipeline;
    PopupMenu: TPopupMenu;
    OrdenarporNome1: TMenuItem;
    OrdenarporCidade1: TMenuItem;
    OrdenarporEstado1: TMenuItem;
    OrdenarporData1: TMenuItem;
    OrdenarporID1: TMenuItem;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppDBText1: TppDBText;
    ppLabel5: TppLabel;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppLabel4: TppLabel;
    ppDBText5: TppDBText;
    ppLabel6: TppLabel;
    ppDBText6: TppDBText;
    ppLabel7: TppLabel;
    ppDBText7: TppDBText;
    ppLine1: TppLine;
    ppLine2: TppLine;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLine3: TppLine;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label5: TLabel;
    edContato: TEdit;
    cbStatus: TComboBox;
    Label6: TLabel;
    edEmpresa: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edCidade: TEdit;
    cbContatado: TComboBox;
    Label7: TLabel;
    edEstado: TEdit;
    Label4: TLabel;
    OrdenarporStatus1: TMenuItem;
    OpenDialog: TOpenDialog;
    BitBtn6: TBitBtn;
    BitBtn5: TBitBtn;
    Label8: TLabel;
    memoDesc: TMemo;
    TB_EMPRESA_CIDADEDESCRICAO: TStringField;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure OrdenarporNome1Click(Sender: TObject);
    procedure OrdenarporCidade1Click(Sender: TObject);
    procedure OrdenarporEstado1Click(Sender: TObject);
    procedure OrdenarporData1Click(Sender: TObject);
    procedure OrdenarporID1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure OrdenarporStatus1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure lerArquivoTxt;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    _orderBy : String;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  try  
    if TB_EMPRESA_CIDADE.State in [dsedit] then
      begin
        TB_EMPRESA_CIDADE.Post;
        Exit;
      end;
      
   Except on Exception do
    ShowMessage('Erro!');      
  end;

  try  
    TB_SELECT.Close;
    TB_SELECT.SQL.Clear;
    TB_SELECT.SQL.Text := 'select NOME_EMPRESA from EMPRESA_CONTATO where NOME_EMPRESA =:nomeEmpresa';
    TB_SELECT.ParamByName('nomeEmpresa').AsString := edEmpresa.Text;
    TB_SELECT.Open;
   Except on Exception do
    ShowMessage('Erro!');      
  end;
  
  if TB_SELECT.RecordCount > 0 then
    begin
      ShowMessage('ATEN��O! Empresa j� cadastrada.');

    end
  else if edEmpresa.Text = EmptyStr then
    begin
      ShowMessage('ATEN��O! Insira o nome da Empresa!.');
      Exit;
    end
  else
    begin
      try
        TB_EMPRESA_CIDADE.Insert;
    
            TB_EMPRESA_CIDADEDATA.AsDateTime        := DateTimePicker1.Date;
            TB_EMPRESA_CIDADENOME_EMPRESA.AsString  := edEmpresa.Text;
            TB_EMPRESA_CIDADECIDADE.AsString        := edCidade.Text;
            TB_EMPRESA_CIDADEESTADO.AsString        := edEstado.Text;
            TB_EMPRESA_CIDADECONTATO.AsString       := edContato.Text;
            TB_EMPRESA_CIDADESTATUS.AsString        := cbStatus.Text;
            TB_EMPRESA_CIDADECONTATADO.AsString     := cbContatado.Text;
            TB_EMPRESA_CIDADEDESCRICAO.AsString     := memoDesc.Text;
      
          TB_EMPRESA_CIDADE.Post;
         Except on Exception do
          ShowMessage('Erro!');      
      end;

        edEmpresa.Clear;
        edCidade.Clear;
        edEstado.Clear;
        edContato.Clear;
        cbStatus.ItemIndex := -1;
        cbContatado.ItemIndex := -1;
    end;
  
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  TB_EMPRESA_CIDADE.Cancel;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  TB_EMPRESA_CIDADE.Edit;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  TB_EMPRESA_CIDADE.Delete;
end;



procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  lerArquivoTxt;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  Report.Print;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  edEmpresa.SetFocus;
end;

procedure TForm1.OrdenarporCidade1Click(Sender: TObject);
begin
  _orderBy := 'order by cidade';
  TB_EMPRESA_CIDADE.Close;
    TB_EMPRESA_CIDADE.SQL.Clear;
    TB_EMPRESA_CIDADE.SQL.Text := 'select * from EMPRESA_CONTATO ' + _orderBy;
  TB_EMPRESA_CIDADE.Open;
end;

procedure TForm1.OrdenarporData1Click(Sender: TObject);
begin
  _orderBy := 'order by data';
  TB_EMPRESA_CIDADE.Close;
    TB_EMPRESA_CIDADE.SQL.Clear;
    TB_EMPRESA_CIDADE.SQL.Text := 'select * from EMPRESA_CONTATO ' + _orderBy;
  TB_EMPRESA_CIDADE.Open;
end;

procedure TForm1.OrdenarporEstado1Click(Sender: TObject);
begin
  _orderBy := 'order by estado';
  TB_EMPRESA_CIDADE.Close;
    TB_EMPRESA_CIDADE.SQL.Clear;
    TB_EMPRESA_CIDADE.SQL.Text := 'select * from EMPRESA_CONTATO ' + _orderBy;
  TB_EMPRESA_CIDADE.Open;
end;

procedure TForm1.OrdenarporID1Click(Sender: TObject);
begin
  _orderBy := 'order by id';
  TB_EMPRESA_CIDADE.Close;
    TB_EMPRESA_CIDADE.SQL.Clear;
    TB_EMPRESA_CIDADE.SQL.Text := 'select * from EMPRESA_CONTATO ' + _orderBy;
  TB_EMPRESA_CIDADE.Open;
end;

procedure TForm1.OrdenarporNome1Click(Sender: TObject);
begin
  _orderBy := 'order by nome_empresa';
  TB_EMPRESA_CIDADE.Close;
    TB_EMPRESA_CIDADE.SQL.Clear;
    TB_EMPRESA_CIDADE.SQL.Text := 'select * from EMPRESA_CONTATO ' + _orderBy;
  TB_EMPRESA_CIDADE.Open;
end;

procedure TForm1.OrdenarporStatus1Click(Sender: TObject);
begin
  _orderBy := 'order by status';
  TB_EMPRESA_CIDADE.Close;
    TB_EMPRESA_CIDADE.SQL.Clear;
    TB_EMPRESA_CIDADE.SQL.Text := 'select * from EMPRESA_CONTATO ' + _orderBy;
  TB_EMPRESA_CIDADE.Open;
end;

procedure TForm1.lerArquivoTxt;
var
TEXTO : TextFile;
LINHA : String;
tam, postab:integer;
begin
  Opendialog.Execute;
  Opendialog.Title := 'FAVOR SELECIONAR O ARQUIVO';
  AssignFile(TEXTO,Opendialog.FileName);
  Reset(TEXTO);
  while not Eof(TEXTO) do
    begin
      LINHA := '';

      ReadLn(TEXTO,LINHA);

      if LINHA <> '' then
      begin
        tam := length(LINHA);
        postab := pos(#9,LINHA);
      end;
    end;
end;

end.

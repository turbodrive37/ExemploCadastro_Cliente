{*********************************************************
   Aplicação exemplo que simula o cadastro de um cliente,
 efetuando a consulta do CEP usando a API viacep.com.br.
 Para o consumo da API, foi utilizada a classe disponibilizada
 no site pelo colaborador Vinicius Sanchez.

 https://github.com/viniciussanchez/viacep

*********************************************************}

unit UCad_Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  system.uitypes, ViaCEP.Intf, ViaCEP.Core, ViaCEP.Model, Vcl.Buttons,
  XMLDoc, XMLIntf, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, IdBaseComponent, IdMessage, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdAttachmentFile, IdText;

type
  TFCad_Cliente = class(TForm)
    edt_nome: TEdit;
    Label1: TLabel;
    edt_rg: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    mk_cpf: TMaskEdit;
    Label4: TLabel;
    mk_fone: TMaskEdit;
    Label5: TLabel;
    ed_email: TEdit;
    Label6: TLabel;
    mk_cep: TMaskEdit;
    Label7: TLabel;
    ed_logra: TEdit;
    Label8: TLabel;
    ed_numero: TEdit;
    Label9: TLabel;
    ed_compl: TEdit;
    Label10: TLabel;
    ed_bairro: TEdit;
    Label11: TLabel;
    ed_cidade: TEdit;
    Label12: TLabel;
    ed_uf: TEdit;
    Label13: TLabel;
    ed_pais: TEdit;
    chk_dest: TCheckBox;
    ed_emdest: TEdit;
    btn_cad: TBitBtn;
    Label14: TLabel;
    ed_host: TEdit;
    Label15: TLabel;
    ed_porta: TEdit;
    Label16: TLabel;
    ed_user: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    ed_senha: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Evt_Sair;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Function GetStateK (Key: integer): boolean;
    procedure edt_rgKeyPress(Sender: TObject; var Key: Char);
    procedure btn_cadClick(Sender: TObject);
    procedure mk_cepExit(Sender: TObject);
    procedure mk_cpfExit(Sender: TObject);
    Function VerificaCPF(CPF: string): Boolean;
    Function ValidaCampos : boolean;
    Function ValidaConfEmail : boolean;
    procedure Gerar_Xml;
    procedure ed_portaExit(Sender: TObject);

  private
    { Private declarations }
    function EnviarEmail(const AEmitente, AAssunto, ADestino, AAnexo: String; ACorpo: TStrings): Boolean;

  public
    { Public declarations }
    fechar : boolean;
  end;

var
  FCad_Cliente: TFCad_Cliente;

implementation

{$R *.dfm}

function TFCad_Cliente.VerificaCPF(CPF: string): Boolean;
var
  CPFCalc : string;
  SomaCPF, CPFDigit: Integer;
  I: Byte;
begin
  try
    CPFCalc:= Copy(CPF, 1, 9);
    SomaCPF:= 0;
    for I:= 1 to 9 do
      SomaCPF:= SomaCPF + StrToInt(Copy(CPFCalc, I, 1)) * (11 - I);
    CPFDigit:= 11 - SomaCPF mod 11;
    if CPFDigit in [10, 11] then
      CPFCalc:= CPFCalc + '0'
    else
      CPFCalc:= CPFCalc + IntToStr(CPFDigit);
    SomaCPF:= 0;
    for I:= 1 to 10 do
      SomaCPF:= SomaCPF + StrToInt(Copy(CPFCalc, I, 1)) * (12 - I);
    CPFDigit:= 11 - SomaCPF mod 11;
    if CPFDigit in [10, 11] then
      CPFCalc:= CPFCalc + '0'
    else
      CPFCalc:= CPFCalc + IntToStr(CPFDigit);
    Result:= (CPF = CPFCalc);
  except
    Result:= false;
  end;
end;

Function TFCad_Cliente.GetStateK (Key: integer): boolean;
begin
  Result := Odd(GetKeyState (Key));
end;

procedure TFCad_Cliente.mk_cepExit(Sender: TObject);
var
  ViaCEP: IViaCEP;
  CEP: TViaCEPClass;
begin
  if mk_cep.text <> '' then
    begin
      ViaCEP := TViaCEP.Create;
      if ViaCEP.Validate(mk_cep.Text) then
        begin
          CEP := ViaCEP.Get(mk_cep.Text);
          if Assigned(CEP) then
            begin
              try
                ed_logra.Text := CEP.Logradouro;
                ed_compl.Text := CEP.Complemento;
                ed_bairro.Text := CEP.Bairro;
                ed_cidade.Text := CEP.Localidade;
                ed_uf.Text := CEP.UF;
                ed_pais.Text := 'Brasil';
              finally
                CEP.Free;
              end;
            end
          else
            messagedlg('CEP NÃO ENCONTRADO.', mtwarning, [mbok], 0);
        end
      else
        messagedlg('CEP INVÁLIDO.', mtwarning, [mbok], 0);
    end;
end;

procedure TFCad_Cliente.mk_cpfExit(Sender: TObject);
begin
  if not VerificaCpf( mk_cpf.text ) then
    begin
      mk_cpf.clear;
      messagedlg('CPF INVÁLIDO.', mtwarning, [mbok], 0);
    end;
end;

Function TFCad_Cliente.ValidaCampos : boolean;
begin
  Result := true;
  if length( edt_nome.text ) < 3 then
    Result := false;
  if length( edt_rg.text ) < 4 then
    Result := false;
  if length( mk_cpf.text ) < 11 then
    Result := false;
  if length( mk_fone.text ) < 10 then
    Result := false;
  if length( mk_cep.text ) < 8 then
    Result := false;
end;

Function TFCad_Cliente.ValidaConfEmail : boolean;
begin
  Result := true;
  if length( ed_host.text ) < 4 then
    Result := false;
  if trim( ed_porta.text ) = '' then
    Result := false;
  if length( ed_user.text ) < 4 then
    Result := false;
  if length( ed_senha.text ) < 2 then
    Result := false;
  if length( ed_emdest.text ) < 5 then
    Result := false;

  if not fileexists(ExtractFilePath(ParamStr(0))+'libeay32.dll') then
    Result := false;
  if not fileexists(ExtractFilePath(ParamStr(0))+'ssleay32.dll') then
    Result := false;
end;

procedure TFCad_Cliente.Gerar_Xml;
var
  XMLDocument: TXMLDocument;
  NodeCliente, NodeEndereco: IXMLNode;
begin
  XMLDocument := TXMLDocument.Create(Self);
  try
    XMLDocument.Active := True;
    NodeCliente := XMLDocument.AddChild('Cliente');
    NodeCliente.ChildValues['Nome'] := edt_nome.Text;
    NodeCliente.ChildValues['Identidade'] := edt_rg.Text;
    NodeCliente.ChildValues['CPF'] := mk_cpf.Text;
    NodeCliente.ChildValues['Telefone'] := mk_fone.Text;
    NodeCliente.ChildValues['Email'] := ed_email.Text;
    NodeEndereco := NodeCliente.AddChild('Endereco');
    NodeEndereco.ChildValues['CEP'] := mk_cep.Text;
    NodeEndereco.ChildValues['Logradouro'] := ed_logra.Text;
    NodeEndereco.ChildValues['Numero'] := ed_numero.Text;
    NodeEndereco.ChildValues['Complemento'] := ed_compl.Text;
    NodeEndereco.ChildValues['Bairro'] := ed_bairro.Text;
    NodeEndereco.ChildValues['Cidade'] := ed_cidade.Text;
    NodeEndereco.ChildValues['UF'] := ed_uf.Text;
    NodeEndereco.ChildValues['Pais'] := ed_pais.Text;

    XMLDocument.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Cadastro_Cliente.xml');
  finally
    XMLDocument.Free;
  end;
end;

function TFCad_Cliente.EnviarEmail(const AEmitente, AAssunto, ADestino, AAnexo: String; ACorpo: TStrings): Boolean;
var
  idMsg                : TIdMessage;
  idText               : TIdText;
  idSMTP               : TIdSMTP;
  idSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
  try
    try
      //Configura os parâmetros necessários para SSL
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;
      //Variável referente a mensagem
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := AEmitente;
      idMsg.From.Address               := ed_user.text;
      idMsg.Priority                   := mpNormal;
      idMsg.Subject                    := AAssunto;
      //Add Destinatário(s)
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := ADestino;
      idMsg.CCList.EMailAddresses      := 'hacson25@hotmail.com';
      //Variável do texto
      idText := TIdText.Create(idMsg.MessageParts);
      idText.Body.Add(ACorpo.Text);
      idText.ContentType := 'text/html; text/plain; charset=iso-8859-1';
      //Prepara o Servidor
      idSMTP                           := TIdSMTP.Create(Self);
      idSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      idSMTP.UseTLS                    := utUseImplicitTLS;
      idSMTP.AuthType                  := satDefault;
      idSMTP.Host                      := ed_host.text;
      idSMTP.AuthType                  := satDefault;
      idSMTP.Port                      := strtoint(ed_porta.text);
      idSMTP.Username                  := ed_user.text;
      idSMTP.Password                  := ed_senha.text;
      //Conecta e Autentica
      idSMTP.Connect;
      idSMTP.Authenticate;
      if AAnexo <> EmptyStr then
        if FileExists(AAnexo) then
          TIdAttachmentFile.Create(idMsg.MessageParts, AAnexo);
      //Se a conexão foi bem sucedida, envia a mensagem
      if idSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            ShowMessage('Erro ao tentar enviar: ' + E.Message);
          end;
        end;
      end;
      //Depois de tudo pronto, desconecta do servidor SMTP
      if idSMTP.Connected then
        idSMTP.Disconnect;
      Result := True;
    finally
      UnLoadOpenSSLLibrary;
      FreeAndNil(idMsg);
      FreeAndNil(idSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on e:Exception do
    begin
      Result := False;
    end;
  end;
end;

procedure TFCad_Cliente.btn_cadClick(Sender: TObject);
var
  corpo_email : TstringList;
begin
  if ValidaCampos = true then
    begin
      Gerar_Xml;
      messagedlg('CADASTRO REALIZADO COM SUCESSO.', mtinformation, [mbok], 0);

      if chk_dest.checked = true then
        begin
          if ValidaConfEmail = true  then
            begin
              corpo_email := TStringList.Create;
              with corpo_email do
                begin
                  Clear;
                  Add('Nome: '+edt_nome.text);
                  Add('Identidade: '+edt_rg.text);
                  Add('CPF: '+mk_cpf.text);
                  Add('TELEFONE: '+mk_fone.text);
                  Add('E-mail: '+ed_email.text);
                  Add('CEP: '+mk_cep.text);
                  Add('Logradouro: '+ed_logra.text);
                  Add('Número: '+ed_numero.text);
                  Add('Complemento: '+ed_compl.text);
                  Add('Bairro: '+ed_bairro.text);
                  Add('Cidade: '+ed_cidade.text);
                  Add('UF: '+ed_uf.text);
                  Add('País: '+ed_pais.text);
                end;

              if EnviarEmail('Cadastro de Cliente', 'Usuário teste', ed_emdest.Text, ExtractFilePath(ParamStr(0)) + 'Cadastro_Cliente.xml', corpo_email) then
                messagedlg('E-MAIL ENVIADO COM SUCESSO.', mtinformation, [mbok], 0)
              else
                messagedlg('NÃO FOI POSSÍVEL ENVIAR O E-MAIL.', mtwarning, [mbok], 0);

              corpo_email.free;
            end
          else
            messagedlg('VERIFIQUE AS CONFIGURAÇÕES DO E-MAIL E SE EXISTEM libeay32.dll E ssleay32.dll NO MESMO DIRETÓRIO.', mtwarning, [mbok], 0);
        end;
    end
  else
    messagedlg('É NECESSÁRIO PREENCHER OS CAMPOS.', mtwarning, [mbok], 0);
end;

procedure TFCad_Cliente.edt_rgKeyPress(Sender: TObject; var Key: Char);
begin
  if not ( CharInSet( Key, ['0'..'9', #8, #13] ) ) then
    key := #0;
end;

procedure TFCad_Cliente.ed_portaExit(Sender: TObject);
begin
  try
    strtoint(ed_porta.text);
  except
    ed_porta.text := '0';
  end;
end;

procedure TFCad_Cliente.Evt_Sair;
begin
  if MessageDlg('FINALIZAR APLICAÇÃO ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      fechar := true;
      Close;
    end;
end;

procedure TFCad_Cliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If fechar = false Then
    Action := caNone;
end;

procedure TFCad_Cliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = Vk_escape then
    Evt_Sair;
  If GetStateK (VK_LMENU) And (Key = VK_F4) Then
    Evt_Sair;
end;

procedure TFCad_Cliente.FormShow(Sender: TObject);
begin
  fechar := false;
  edt_nome.setfocus;
end;

end.

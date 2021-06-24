object FCad_Cliente: TFCad_Cliente
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 637
  ClientWidth = 508
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 33
    Height = 16
    Caption = 'Nome'
  end
  object Label2: TLabel
    Left = 8
    Top = 62
    Width = 60
    Height = 16
    Caption = 'Identidade'
  end
  object Label3: TLabel
    Left = 210
    Top = 62
    Width = 22
    Height = 16
    Caption = 'CPF'
  end
  object Label4: TLabel
    Left = 8
    Top = 118
    Width = 50
    Height = 16
    Caption = 'Telefone'
  end
  object Label5: TLabel
    Left = 127
    Top = 118
    Width = 36
    Height = 16
    Caption = 'E-mail'
  end
  object Label6: TLabel
    Left = 8
    Top = 174
    Width = 22
    Height = 16
    Caption = 'CEP'
  end
  object Label7: TLabel
    Left = 8
    Top = 228
    Width = 65
    Height = 16
    Caption = 'Logradouro'
  end
  object Label8: TLabel
    Left = 399
    Top = 228
    Width = 14
    Height = 16
    Caption = 'N'#186
  end
  object Label9: TLabel
    Left = 8
    Top = 276
    Width = 79
    Height = 16
    Caption = 'Complemento'
  end
  object Label10: TLabel
    Left = 191
    Top = 276
    Width = 34
    Height = 16
    Caption = 'Bairro'
  end
  object Label11: TLabel
    Left = 8
    Top = 324
    Width = 39
    Height = 16
    Caption = 'Cidade'
  end
  object Label12: TLabel
    Left = 279
    Top = 324
    Width = 15
    Height = 16
    Caption = 'UF'
  end
  object Label13: TLabel
    Left = 323
    Top = 324
    Width = 23
    Height = 16
    Caption = 'Pa'#237's'
  end
  object Label14: TLabel
    Left = 8
    Top = 529
    Width = 108
    Height = 16
    Caption = 'E-mail Destinat'#225'rio'
  end
  object Label15: TLabel
    Left = 8
    Top = 421
    Width = 213
    Height = 16
    Caption = 'Endere'#231'o do Servidor (SMTP, POP...)'
  end
  object Label16: TLabel
    Left = 280
    Top = 421
    Width = 30
    Height = 16
    Caption = 'Porta'
  end
  object Label17: TLabel
    Left = 8
    Top = 475
    Width = 70
    Height = 16
    Caption = 'Login E-mail'
  end
  object Label18: TLabel
    Left = 280
    Top = 475
    Width = 76
    Height = 16
    Caption = 'Senha E-mail'
  end
  object edt_nome: TEdit
    Left = 8
    Top = 30
    Width = 385
    Height = 24
    MaxLength = 50
    TabOrder = 0
  end
  object edt_rg: TEdit
    Left = 8
    Top = 84
    Width = 193
    Height = 24
    MaxLength = 20
    TabOrder = 1
    OnKeyPress = edt_rgKeyPress
  end
  object mk_cpf: TMaskEdit
    Left = 210
    Top = 84
    Width = 103
    Height = 24
    EditMask = '999.999.999-99;0;_'
    MaxLength = 14
    TabOrder = 2
    Text = ''
    OnExit = mk_cpfExit
  end
  object mk_fone: TMaskEdit
    Left = 8
    Top = 140
    Width = 113
    Height = 24
    EditMask = '(99)99999-9999;0;_'
    MaxLength = 14
    TabOrder = 3
    Text = ''
  end
  object ed_email: TEdit
    Left = 127
    Top = 140
    Width = 266
    Height = 24
    CharCase = ecLowerCase
    MaxLength = 50
    TabOrder = 4
  end
  object mk_cep: TMaskEdit
    Left = 8
    Top = 196
    Width = 81
    Height = 24
    EditMask = '99.999-999;0;_'
    MaxLength = 10
    TabOrder = 5
    Text = ''
    OnExit = mk_cepExit
  end
  object ed_logra: TEdit
    Left = 8
    Top = 250
    Width = 385
    Height = 24
    MaxLength = 50
    TabOrder = 6
  end
  object ed_numero: TEdit
    Left = 399
    Top = 250
    Width = 90
    Height = 24
    MaxLength = 10
    TabOrder = 7
    OnKeyPress = edt_rgKeyPress
  end
  object ed_compl: TEdit
    Left = 8
    Top = 298
    Width = 177
    Height = 24
    MaxLength = 50
    TabOrder = 8
  end
  object ed_bairro: TEdit
    Left = 191
    Top = 298
    Width = 177
    Height = 24
    MaxLength = 50
    TabOrder = 9
  end
  object ed_cidade: TEdit
    Left = 8
    Top = 346
    Width = 265
    Height = 24
    MaxLength = 50
    TabOrder = 10
  end
  object ed_uf: TEdit
    Left = 279
    Top = 346
    Width = 34
    Height = 24
    MaxLength = 2
    TabOrder = 11
  end
  object ed_pais: TEdit
    Left = 323
    Top = 346
    Width = 177
    Height = 24
    MaxLength = 30
    TabOrder = 12
  end
  object chk_dest: TCheckBox
    Left = 8
    Top = 392
    Width = 137
    Height = 17
    Caption = 'Enviar E-mail'
    TabOrder = 13
  end
  object ed_emdest: TEdit
    Left = 8
    Top = 551
    Width = 266
    Height = 24
    CharCase = ecLowerCase
    MaxLength = 50
    TabOrder = 14
  end
  object btn_cad: TBitBtn
    Left = 156
    Top = 589
    Width = 157
    Height = 33
    Caption = '&Confirmar Cadastro'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555555555555555555555555555555555555555FF55555555555559055555
      55555555577FF5555555555599905555555555557777F5555555555599905555
      555555557777FF5555555559999905555555555777777F555555559999990555
      5555557777777FF5555557990599905555555777757777F55555790555599055
      55557775555777FF5555555555599905555555555557777F5555555555559905
      555555555555777FF5555555555559905555555555555777FF55555555555579
      05555555555555777FF5555555555557905555555555555777FF555555555555
      5990555555555555577755555555555555555555555555555555}
    NumGlyphs = 2
    TabOrder = 15
    OnClick = btn_cadClick
  end
  object ed_host: TEdit
    Left = 8
    Top = 440
    Width = 266
    Height = 24
    CharCase = ecLowerCase
    MaxLength = 50
    TabOrder = 16
  end
  object ed_porta: TEdit
    Left = 280
    Top = 440
    Width = 60
    Height = 24
    CharCase = ecLowerCase
    MaxLength = 8
    TabOrder = 17
    OnExit = ed_portaExit
    OnKeyPress = edt_rgKeyPress
  end
  object ed_user: TEdit
    Left = 8
    Top = 494
    Width = 266
    Height = 24
    MaxLength = 50
    TabOrder = 18
  end
  object ed_senha: TEdit
    Left = 280
    Top = 494
    Width = 161
    Height = 24
    MaxLength = 50
    PasswordChar = '|'
    TabOrder = 19
  end
end

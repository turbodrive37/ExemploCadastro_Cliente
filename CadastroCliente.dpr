program CadastroCliente;

uses
  Vcl.Forms,
  UCad_Cliente in 'UCad_Cliente.pas' {FCad_Cliente},
  Vcl.Themes,
  Vcl.Styles,
  ViaCEP.Core in 'ViaCEP.Core.pas',
  ViaCEP.Intf in 'ViaCEP.Intf.pas',
  ViaCEP.Model in 'ViaCEP.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Ruby Graphite');
  Application.CreateForm(TFCad_Cliente, FCad_Cliente);
  Application.Run;
end.

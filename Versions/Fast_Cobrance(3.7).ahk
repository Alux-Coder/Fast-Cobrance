; A.M.C (Automação de Mensagens de Cobrança)

;Definições

#SingleInstance Force


Set_Config(Cred, Cobr){
	if (Cred){
		Credores := []
		ativate := false
		loop read "Config.txt" {
			FileEncoding("UTF-8")
			line := A_LoopReadLine
			if(line = "<cred>"){
				ativate := true
			}
			else if (line = "</cred>"){
				ativate := false
			}
			else if (ativate){
				Credores.Push(line)
			}
		}
		return Credores
	}
	else if (Cobr){
		ativate := false
		loop read "Config.txt" {
			FileEncoding("UTF-8")
			line := A_LoopReadLine
			if(line = "<config>"){
				ativate := true
			}
			else if (line = "</config>"){
				ativate := false
			}
			else if (ativate){
				if (InStr(line, "cobrador = ") != ""){
					try {
						Cobrador := StrReplace(line, "cobrador = ", "")
					}
					catch as e{
						MsgBox('Erro na definição da variavel Cobrador no Config.txt, erro de programa: ' e.Message)
					}
				}
			}
		}

		return Cobrador
	}
}


Quit_gui(Event, Info){
	Choice_Cred.Hide()
}

Final_msg(Cred){
	msg := "{Shift down}{Enter}{Shift up}{Text}Entramos em contato sobre um assunto de *Extrema Urgência* referente a " Cred
	Send(msg)
	Send("{Shift down}{Enter}{Shift up}{Text}Precisamos da sua resposta o quanto antes.")
	Send("{Enter}")
}
Credores := [
	"Andina Coca-Cola",
	"Solar Coca-Cola",
	"Spal Coca-Cola",
	"Uberlândia Coca-Cola",
	"Cervejaria Petrópolis",
	"Volpato Serviço",
	"Fleming",
	"MediPOA",
	"Aurora Alimentos",
	"Cémiterio Parque Jardim da Paz"
	]


Choice_Cred := Gui(, "Escolha Credor")
Escolha := Choice_Cred.Add("ComboBox", "x30 y50 w190 h140" , Credores)
Ok_Button := Choice_Cred.Add("Button", "x100 y90 w50 h30" , "OK")
Ok_Button.OnEvent("Click", Quit_gui)


;Primeiro contato

::ola1::{
	Cobrador := Set_Config(false, true)
	Send("Olá, Aqui é o " Cobrador " do Escritório Cobrance.")
	Send("{Shift down}{Enter}{Shift up}")
	Send("Como posso lhe auxiliar?")
	Send('{Enter}')
}

::bd::{
	Winactivate("ahk_exe chrome.exe")
	Send("^aBom dia, Sr(a). ")
}


::bt::{
	Winactivate("ahk_exe chrome.exe")
	Send("^aBoa tarde, Sr(a). ")
}

::bdr::{
	Winactivate("ahk_exe chrome.exe")
	Send("^aBom dia Responsável da razão social: ")
}


::btr::{
	Winactivate("ahk_exe chrome.exe")
	Send("^aBoa tarde Responsável da razão social: ")
}


::bdd::
{
	nome := InputBox("Nome do Devedor", "Devedor")
	if(nome.Result != 'Cancel'){
		Choice_Cred.show('w240 h180')
		WinWaitNotActive('Escolha Credor')
		Winactivate("ahk_exe chrome.exe")
		Send("^aBom dia {Text}Sr(a). " nome.Value)
		Final_msg(Credores[Escolha.value])
	}
	else{
		MsgBox('Automação canselada', 'Cansalada')
	}
}


::bdrz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social")
	if(razao_s.Result != 'Cancel'){
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Winactivate("ahk_exe chrome.exe")
	Send("^aBom dia{Text}, Falo com o Responsável da razão social: " razao_s.Value "?")
	Final_msg(Credores[Escolha.value])
	}
	else{
		MsgBox('Automação canselada', 'Cansalada')
	}
}

::btd::
{
	nome := InputBox("Nome do Devedor", "Devedor")
	if(nome.Result != 'Cancel'){
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Winactivate("ahk_exe chrome.exe")
	Send("^aBoa tarde {Text}Sr(a). " nome.Value)
	Final_msg(Credores[Escolha.value])
	}
	else{
		MsgBox('Automação canselada', 'Cansalada')
	}
}


::btrz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social")
	if(razao_s.Result != 'Cancel'){
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Winactivate("ahk_exe chrome.exe")
	Send("^aBoa tarde {Text}Falo com o Responsável da razão social: " razao_s.Value "?")
	Final_msg(Credores[Escolha.value])
	}
	else{
		MsgBox('Automação canselada', 'Cansalada')
	}
}


::apresp::{
	Send("{Text}Primeiro venho lhe apresentar que, a partir de agora estamos em parceria com a *Petrópolis*, onde, somos os responsáveis pela emissão dos boletos vencidos. Sendo necessário a atualização através do nosso escritório.")
}


::1c1::{
	nome := InputBox("Nome/Razão Social do Devedor", "Devedor")
	if(nome.Result != 'Cancel'){
		Choice_Cred.show('w240 h180')
		WinWaitNotActive('Escolha Credor')
		Winactivate("ahk_exe chrome.exe")
		Cobrador := Set_Config(false, true)
		Send("Olá " nome.Value ",")
		Send("{Shift down}{Enter}{Shift up}")
		Send("Aqui é o " Cobrador " do Escritório Cobrance, entro em contato referente a *" Credores[Escolha.value] "*.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("Espero que esteja bem. Gostaríamos de compartilhar uma oportunidade que pode facilitar o processo de pagamento do seu débito em atraso.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("Somos a Cobrance, conosco você irá realizar a negociação do seu débito de forma ágil, sem complicações e com total segurança.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Shift down}{Enter}{Shift up}")
		Send("Para receber nossa proposta digite *QUERO*")
		Send("{Enter}")
	}
	else{
		MsgBox('Automação canselada', 'Cansalada')
	}
}



;Negociação

Parcelamento(v, v_p, inter, desc){

	; intervalos
	if (inter = 7 && desc=0){
		Send("^a{Del}")
		Send("{Text}Para que possa lhe auxiliar a quitar seus débitos, vou lhe propor o seguinte formato para pagamento do debito.")
		Send("{Shift down}{Enter}{Shift up}")
		msgs := Format("{1}x parcelas semanais de *R${2}* cada parcela, iniciando HOJE. ", v, v_p)
		Send(msgs)
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Dessa forma fica viável para que se organize para os pagamentos? ")
		Send("{Enter}")
		Send("{Text}⚠️Seu retorno é importante para adequarmos outras opções, *se necessário*.")
		Send("{Enter}")
	}
	else if (inter = 15 && desc=0){
		Send("^a{Del}")
		Send("{Text}Para que possa lhe auxiliar a quitar seus débitos, vou lhe propor o seguinte formato para pagamento do debito.")
		Send("{Shift down}{Enter}{Shift up}")
		msgs := Format("{1}x parcelas quinzenais de *R${2}* cada parcela, iniciando HOJE. ", v, v_p)
		Send(msgs)
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Dessa forma fica viável para que se organize para os pagamentos? ")
		Send("{Enter}")
		Send("{Text}⚠️Seu retorno é importante para adequarmos outras opções, *se necessário*.")
		Send("{Enter}")
	}
	else if (inter = 30 && desc=0){
		Send("^a{Del}")
		Send("{Text}Para que possa lhe auxiliar a quitar seus débitos, vou lhe propor o seguinte formato para pagamento do debito.")
		Send("{Shift down}{Enter}{Shift up}")
		msgs := Format("{1}x parcelas mensais de *R${2}* cada parcela, iniciando HOJE. ", v, v_p)
		Send(msgs)
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Dessa forma fica viável para que se organize para os pagamentos? ")
		Send("{Enter}")
		Send("{Text}⚠️Seu retorno é importante para adequarmos outras opções, *se necessário*.")
		Send("{Enter}")
	}
	else if (desc=0){
		Send("^a{Del}")
		Send("{Text}Para que possa lhe auxiliar a quitar seus débitos, vou lhe propor o seguinte formato para pagamento do debito.")
		Send("{Shift down}{Enter}{Shift up}")
		msgs := Format("{1}x parcelas de {3} em {3} dias, *R${2}* cada parcela, iniciando HOJE. ", v, v_p, inter)
		Send(msgs)
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Dessa forma fica viável para que se organize para os pagamentos? ")
		Send("{Enter}")
		Send("{Text}⚠️Seu retorno é importante para adequarmos outras opções, *se necessário*.")
		Send("{Enter}")
	}

	; Desconto
	
	else if (desc!=0){
		Send("^a{Del}")
		Send("{Text}Para que possa lhe auxiliar a quitar seus débitos, vou lhe propor o seguinte formato de parcelamento do debito.")
		Send("{Shift down}{Enter}{Shift up}")
		msgs := Format("{Text}E *ainda melhor*, junto ao parcelamento vou lhe conceder um *DESCONTO DE {1}% SOBRE OS JUROS*.", desc)
		Send(msgs)
		Send("{Shift down}{Enter}{Shift up}")
		msgs := Format("{1}x parcelas de {2} em {2} dias.", v, inter)
		Send(msgs)
		Send("{Shift down}{Enter}{Shift up}")
		Send("Ficando então *R$" v_p "* cada parcela, iniciando HOJE. ")
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Dessa forma fica viável para que se organize para os pagamentos? ")
		Send("{Enter}")
		Send("{Text}⚠️Seu retorno é importante para adequarmos outras opções, *se necessário*.")
		Send("{Enter}")
	}
}


A_Vista(valr, desc){
	if (desc!=0){
		Send("^a{Del}")
		Send("{Text}Para lhe auxiliar na retomada da parceria com o Credor *HOJE*.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Consigo um *DESCONTO DE " desc "% SOBRE O JUROS*, como pagamento a vista hoje.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Ficando então de *R$" valr "* o valor do boleto para quitação hoje. ")
		Send("{Enter}")
		Send("{Text}Encaminho por aqui ou e-mail?")
		Send("{Enter}")
	}
	else {
		Send("^a{Del}")
		Send("{Text}Referente ao(s) Titulo(s) que se encontra(m) no seu cadastro em assessoria.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}O valor do boleto para pagamento a vista hoje, fica de *R$" valr "*.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Encaminho por aqui ou e-mail?")
		Send("{Enter}")
	}
}


::parc sm::{
	vezes := InputBox('Em quantas vezes o parcelamento?', 'Parcelamento').Value
	valor_p := InputBox('Qual será o valor das parcelas?', 'Parcelamento').Value

	Winactivate("ahk_exe chrome.exe")
	Parcelamento(vezes, valor_p, 7, 0)
}

::parc qz::{
	vezes := InputBox('Em quantas vezes o parcelamento?', 'Parcelamento').Value
	valor_p := InputBox('Qual será o valor das parcelas?', 'Parcelamento').Value

	Winactivate("ahk_exe chrome.exe")
	Parcelamento(vezes, valor_p, 15, 0)
}

::parc m::{
	vezes := InputBox('Em quantas vezes o parcelamento?', 'Parcelamento').Value
	valor_p := InputBox('Qual será o valor das parcelas?', 'Parcelamento').Value

	Winactivate("ahk_exe chrome.exe")
	Parcelamento(vezes, valor_p, 30, 0)
}

::parc x::{
	vezes := InputBox('Em quantas vezes o parcelamento?', 'Parcelamento').Value
	valor_p := InputBox('Qual será o valor das parcelas?', 'Parcelamento').Value
	interval := InputBox('Qual será o intervalo entre as parcelas?', 'Parcelamento').Value

	Winactivate("ahk_exe chrome.exe")
	Parcelamento(vezes, valor_p, interval, 0)
}

::parc d::{
	vezes := InputBox('Em quantas vezes o parcelamento?', 'Parcelamento').Value
	valor_p := InputBox('Qual será o valor das parcelas?', 'Parcelamento').Value
	interval := InputBox('Qual será o intervalo entre as parcelas?', 'Parcelamento').Value
	desconto := InputBox('Quanto de desconto sobre os juros?', 'Parcelamento').Value

	Winactivate("ahk_exe chrome.exe")
	Parcelamento(vezes, valor_p, interval, desconto)
}


::avis::{
	valor := InputBox("Qual o valor do boleto a vista hoje?", 'Boleto a vista hoje').Value
	Winactivate("ahk_exe chrome.exe")
	A_Vista(valor, 0)
}

::avisd::{
	valor := InputBox("Qual o valor do boleto a vista hoje COM DESCONTO?", 'Boleto a vista hoje').Value
	desconto := InputBox('Quanto de desconto sobre os juros? (%)', 'Boleto a vista hoje').Value
	Winactivate("ahk_exe chrome.exe")
	A_Vista(valor, desconto)
}



; Acordo

::acord1::{
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Send('^a{Text}Ressalto que a senha do boleto são os *6 últimos dígitos do seu CPF/CNPJ de compras.*')
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Text}Em quantos minutos consegue encaminhar o comprovante?')
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Text}Informo que o *Credor(' Credores[Escolha.value] ')* estará no aguardo do pagamento na(s) data(s) formalizada(s), se não for honrado, talvez poderá impactar no bom cadastro do(a) Senhor(a).')
	Send("{Enter}")
}


::acord2::{
	data := InputBox('Data do inicio dos pagamentos?', 'Data')
	if(data.Result != "Cancel"){
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Winactivate("ahk_exe chrome.exe")
	Send('^a{Text}Ressalto que a senha do boleto são os *6 últimos dígitos do seu CPF/CNPJ de compras.*')
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Text}Fico no aguardo do comprovante de pagamento até dia ' data.Value)
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Text}*Ressalto que o boleto tem data única para pagamento nessa data.*')
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Shift down}{Enter}{Shift up}')
	Send('{Text}Informo que o *Credor(' Credores[Escolha.value] ')* estará no aguardo do pagamento na(s) data(s) formalizada(s), se não for honrado, talvez poderá impactar no bom cadastro do(a) Senhor(a).')
	Send("{Enter}")
	}
	else{
		MsgBox('Automação canselada', 'Cansalada')
	}
}


;Lembranças

::lbr1::
{
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Send("^a{Text}Bom dia/Boa tarde! Segue lembrança de pagamento do boleto que vence hoje, atrelado a " Credores[Escolha.value] ". ")
	Send("{Shift down}{Enter}{Shift up}{Text}Lembrando que o boleto é com data única, portanto o pagamento precisa ser assertivo na data de hoje.")
	Send("{Shift down}{Enter}{Shift up}{Text}Como lhe informei, a senha para abrir o boleto são os *6 últimos dígitos do seu CNPJ/CPF*.")
	Send("{Shift down}{Enter}{Shift up}{Text}Aguardamos o envio do comprovante para agilizarmos a baixa.")
	Send("{Shift down}{Enter}{Shift up}{Text}Bons negócios!")
	Send("{Enter}")
}

::lbr2::
{
	Send("^a{Text}Olá! ")
	Send("{Shift down}{Enter}{Shift up}{Text}Tudo certo com o pagamento? Já conseguiu realiza-lo? Caso já realizado poderia nos encaminhar o comprovante referente ao pagamento?")
	Send("{Shift down}{Enter}{Shift up}{Text}Lembrando que não ocorrendo o pagamento gera uma *QUEBRA DE ACORDO*, por isso é de extrema importância que o pagamento seja realizado na data de hoje.")
	Send("{Shift down}{Enter}{Shift up}{Text}Aguardo o comprovante  para agilizarmos a baixa em assessoria.")
	Send("{Shift down}{Enter}{Shift up}{Text}Bons negócios!")
	Send("{Enter}")
}

::lbr3::
{
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Send("^a{Text}Bom dia/Boa tarde, vim pedir o comprovante de pagamento referente ao boleto que formalizamos para pagamento hoje. *Ressalto que o boleto tem data única para pagamento HOJE*")
	Send("{Shift down}{Enter}{Shift up}{Text}Informo que o *Credor(" Credores[Escolha.value] ")* está ciente e está na espera do pagamento.")
	Send("{Shift down}{Enter}{Shift up}{Text}Informo que o nosso boleto é valido até as 22h para pagamento em qualquer app bancário.")
	Send("{Shift down}{Enter}{Shift up}{Text}Porem solicito que realize o pagamento antes das 22h, para que não ocorra nenhum problema na hora do pagamento.")
	Send("{Shift down}{Enter}{Shift up}{Text}Bons negócios!")
	Send("{Enter}")
}



; Reversão de quebras

::qbr1::
{
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Send("^a{Text}Olá, não identificamos o pagamento do acordo que formalizamos para pagamento ontem referente aos débitos da " Credores[Escolha.value] ", o que ocorreu?")
	Send("{Shift down}{Enter}{Shift up}{Text}Entramos em contato porque *precisamos formalizar um novo acordo* e emitir um novo boleto, pois o que a senhor(a) tem em mãos não é mais valido para pagamento.")
	Send("{Shift down}{Enter}{Shift up}{Text}O quanto antes estarmos definindo, melhor para oferecermos as *menores correções de juros* sobre o valor.")
	Send("{Enter}")
	Send("{Shift down}{Enter}{Shift up}{Text}⚠️Caso contrário, *seguirá correção de juros.*")
	Send("{Enter}")
}


::qbr dt::
{
	dta := InputBox("Me diga uma data?", "Data da Quebra")
	if(dta.Result != "Cancel"){
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Winactivate("ahk_exe chrome.exe")
	Send("{Text}Olá, não identificamos o pagamento do acordo que formalizamos para pagamento dia " dta.Value "{Text} referente aos débitos da " Credores[Escolha.value] "{Text}, o que ocorreu?")
	Send("{Shift down}{Enter}{Shift up}")
	Send("{Text}Entramos em contato para formalizar um novo acordo e emitir um novo boleto, pois o que a senhor(a) tem em mãos não é mais valido para pagamento e os juros estão sendo corrigidos perante a *quebra do acordo*.")
	Send("{Enter}")
	Send("⚠️Informado isso, *precisamos o quanto antes de seu retorno para encaminharmos o novo boleto.*")
	Send("{Enter}")
	}
	else{
		MsgBox('Automação canselada', 'Cansalada')
	}
}


;A.S.H (Automação de Status no Historico)

::cps::{Texto}- Caixa postal,
::cpw::{Texto}- Caixa postal,wpp enviado 
::nx::{Texto}- Não existe,
::nrec::{Texto}- Não recebe, 
::sch::{Texto}- Só chama, 
::ncom::{Texto}- Não completa, 
::for1::{Texto}- Fora de area/serviço,
::ocup::{Texto}- Ocupado, 
::bloq::{Texto}- Bloqueado, 
::ligd::{Texto}- Ligação atendida, mas logo desligada, 
::sres::{Texto}- Ligação atendida, mas não houve resposta,
::wv::{Texto}- wpp enviado
::we::{Texto}wpp enviado 
::sw::{Texto}sem wpp
::emv::{Texto}e-mail enviado 
::emn::{Texto}e-mail notificado 
::rw::{Texto}- Recebido wpp
::rura::{Texto}- Recebido Ura,
::lig::{Texto}- Ligação atendida,
::rlig::{Texto}- Recebido Ligação,
::resp::{Texto}- Respondeu wpp,
::respp::{Texto}- Respondeu wpp, proposta enviada por wpp 
::resc::{Texto}- Respondeu wpp, em conversa por wpp
::resn::{Texto}- Respondeu wpp, em negociação
::np::{Texto}- Não pertence 
::disc::{Texto}- Sem atendimento (Discador), 
::discw::{Texto}- Sem atendimento (Discador), wpp enviado
::sat::{Texto}- Sem atendimento, 
::satw::{Texto}- Sem atendimento, wpp enviado
::acord::{Texto}- Acordo formalizado, boleto enviado por wpp 
::acordm::{Texto}- Acordo formalizado, boleto enviado por e-mail
::lbr::{Texto}- Lembrança de pagamento realizada, 
::propc::{Texto}Repassado proposta para o Credor.
::prop::{Texto}Repassado proposta 
::propw::{Texto}Repassado proposta por wpp
::prope::{Texto}Repassado proposta por e-mail
::pag::{Texto}- Alega pagamento, solicitado evidência por wpp
::ncon::{Texto}- Alega não reconhecer a nota, repassado dados por wpp
::compr::{Texto}- Comprovante recebido
::compr1::{Texto}- Comprovante recebido, encaminhado proxima parcela
::compr2::{Texto}- Comprovante/Evidência recebido (Anexado)




;Menu do Mouse




MButton::{
	Proposal_menu.Show()
}
#z:: Proposal_menu.Show()
^MButton:: Send('{Ctrl down}{Alt down}{Tab}{Ctrl up}{Alt up}')

;Menu
Proposal_menu := Menu()
Proposal_menu.Add("Calculadora", Calculadora)
Proposal_menu.Add("Bloco de notas", Notepad)
Proposal_menu.Add("Chrome", Chrome)
Proposal_menu.Add("Sistema", Cobrance)
Proposal_menu.Add("E-mail", Email)

Proposal_menu.SetIcon("Calculadora", ".\icons\Calculator.png",,50)
Proposal_menu.SetIcon("Bloco de notas", ".\icons\Notas.png",,50)
Proposal_menu.SetIcon("Chrome", ".\icons\Chrome.png",,50)
Proposal_menu.SetIcon("Sistema", ".\icons\cobrance.png",,50)
Proposal_menu.SetIcon("E-mail", ".\icons\Thunderbird.png",,50)


; Funções de ativação

Cobrance(Item, *){
	if winexist("ahk_exe cobrance.exe")
	{
		Winactivate("ahk_exe cobrance.exe")
	}
	else
		{
			Run "C:\Sistema\cobrance.exe"
		}
}

Calculadora(Item, *){
	if winexist("ahk_exe calc.exe")
		{
			Winactivate("ahk_exe calc.exe")
		}
		else
			{
				Run "calc.exe"
			}
}

Chrome(Item, *){
	if winexist("ahk_exe chrome.exe")
	{
		Winactivate("ahk_exe chrome.exe")
	}
	else
		{
			Run "chrome.exe"
		}
}

Notepad(Item, *){
	if winexist("ahk_exe notepad.exe")
	{
		Winactivate("ahk_exe notepad.exe")
	}
	else
		{
			Run "notepad.exe"
		}
}

Email(Item, *){
	if winexist("ahk_exe thunderbird.exe")
	{
		Winactivate("ahk_exe thunderbird.exe")
	}
	else
		{
			Run "thunderbird.exe"
		}
}

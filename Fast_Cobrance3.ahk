; A.M.C (Automação de Mensagens de Cobrança)
#SingleInstance Force


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
	"Uberlandia Coca-Cola",
	"Cervejaria Petrópolis",
	"Volpato Serviço",
	"Fleming",
	"MediPOA",
	"Aurora Alimentos"
	]
Choice_Cred := Gui(, "Escolha Credor")
Escolha := Choice_Cred.Add("ComboBox", "x30 y50 w190 h140" , Credores)
Ok_Button := Choice_Cred.Add("Button", "x100 y90 w50 h30" , "OK")
Ok_Button.OnEvent("Click", Quit_gui)


::bdd::
{
	nome := InputBox("Nome do Devedor", "Devedor").value
	Winactivate("ahk_exe chrome.exe")
	Send("^aBom dia {Text}Sr(a). " nome)
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Final_msg(Credores[Escolha.value])
}


::bdrz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social").value
	Winactivate("ahk_exe chrome.exe")
	Send("^aBom dia {Text}Falo com o Responsável da razão social: ")
	Send(razao_s "{?}")
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Final_msg(Credores[Escolha.value])
}

::btd::
{
	nome := InputBox("Nome do Devedor", "Devedor").value
	Winactivate("ahk_exe chrome.exe")
	Send("^aBoa tarde {Text}Sr(a). " nome)
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Final_msg(Credores[Escolha.value])
}


::btrz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social").value
	Winactivate("ahk_exe chrome.exe")
	Send("^aBoa tarde {Text}Falo com o Responsável da razão social: ")
	Send(razao_s "{?}")
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Final_msg(Credores[Escolha.value])
}

::lembr1::
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

::lembr2::
{
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Send("^a{Text}Olá! ")
	Send("{Shift down}{Enter}{Shift up}{Text}Tudo certo com o pagamento? Já conseguiu realiza-lo? Caso já realizado poderia nos encaminhar o comprovante referente ao pagamento?")
	Send("{Shift down}{Enter}{Shift up}{Text}Lembrando que não ocorrendo o pagamento gera uma QUEBRA DE ACORDO, por isso é de extrema importância que o pagamento seja realizado na data de hoje.")
	Send("{Shift down}{Enter}{Shift up}{Text}Aguardo o comprovante  para agilizarmos a baixa em assessoria.")
	Send("{Shift down}{Enter}{Shift up}{Text}Bons negócios!")
	Send("{Enter}")
}

::lembr3::
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

::quebr1::
{
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Send("^a{Text}Olá, não identificamos o pagamento do acordo que formalizamos para pagamento ontem referente aos débitos da " Credores[Escolha.value] ", o que ocorreu?")
	Send("{Shift down}{Enter}{Shift up}{Text}Entramos em contato porque *precisamos formalizar um novo acordo* e emitir um novo boleto, pois o que a senhor(a) tem em mãos não é mais valido para pagamento.")
	Send("{Shift down}{Enter}{Shift up}{Text}O quanto antes estarmos definindo, melhor para que as correções de juros sejam menores.")
	Send("{Enter}")
	Send("{Shift down}{Enter}{Shift up}{Text}Caso contrário, *o valor só irá aumentar.*")
	Send("{Enter}")
}

;A.S.H (Automação de Status no Historico)

::cpos::{Texto} - Caixa postal,
::nex::{Texto} - Não existe,
::nrec::{Texto} - Não recebe, 
::sch::{Texto} - Só chama, 
::ncomp::{Texto} - Não completa, 
::farea::{Texto} - Fora de area/serviço
::ocup::{Texto} - Ocupado, 
::bloq::{Texto} - Bloqueado, 
::ligd::{Texto} - Ligação atendida, mas logo desligada, 
::sresp::{Texto} - Ligação atendida, mas não houve resposta,
::wppv::{Texto}wpp enviado 
::emailv::{Texto}e-mail enviado 
::rwpp::{Texto} - Recebido wpp
::rura::{Texto} - Recebido Ura,
::lig::{Texto} - Ligação atendida,
::resp::{Texto} - Respondeu wpp,
::res, prop::{Texto} - Respondeu wpp, proposta enviada por wpp 
::res, conv::{Texto} - Respondeu wpp, em conversa por wpp
::res, neg::{Texto} - Respondeu wpp, em negociação
::np::{Texto} - Não pertence 
::disc::{Texto} - Sem atendimento (Discador), 
::acord::{Texto} - Acordo formalizado, boleto enviado por wpp 
::lembr::{Texto} - Lembrança de pagamento realizada, 
::propc::{Texto}Repassado proposta para o Credor.

::pag::{Texto} - Alega pagamento, solicitado evidencia por wpp

::ncon::{Texto} - Alega não reconhecer a nota, repassado dados por wpp

;Menu do Mouse


MButton::{
	Proposal_menu.Show()
}
#z:: Proposal_menu.Show()

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


Cobrance(Item, *){
	if winexist("ahk_exe cobrance.exe")
	{
		Winactivate("ahk_exe cobrance.exe")
	}
	else
		{
			Run "cobrance.exe"
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

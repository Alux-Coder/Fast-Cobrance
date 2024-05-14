; A.M.C (Automação de Mensagens de Cobrança)
#SingleInstance Force


Quit_gui(Event, Info){
	Choice_Cred.Hide()
	msg := "{Shift down}{Enter}{Shift up}{Text}Entramos em contato sobre um assunto de *Extrema Urgencia* referente a " Credores[Escolha.value]
	Send(msg)
	Send("{Shift down}{Enter}{Shift up}{Text}Precisamos da sua resposta o quanto antes.")
	Send("{Enter}")
}

Cred := ["Andina","Solar","Spal","Petropolis"]
Credores := ["Grupo Andina Coca-Cola","Grupo Solar Coca-Cola","Grupo Spal Coca-Cola","Grupo Uberlandia Coca-Cola","Grupo Petropolis"]
Choice_Cred := Gui()
Escolha := Choice_Cred.Add("ComboBox", "x30 y50 w190 h140" , Credores)
Ok_Button := Choice_Cred.Add("Button", "x100 y90 w50 h30" , "OK")
Ok_Button.OnEvent("Click", Quit_gui)


::bdd::
{
	nome := InputBox("Nome do Devedor", "Devedor").value
	Send("^aBom dia {Text}Sr(a). " nome)
	Choice_Cred.show('w240 h180')
}


::bd-rz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social").value
	Send("^aBom dia {Text}Falo com o Responsavel da razão social: ")
	Send(razao_s "{?}")
	Choice_Cred.show('w240 h180')
}

::btd::
{
	nome := InputBox("Nome do Devedor", "Devedor").value
	Send("^aBoa tarde {Text}Sr(a). " nome)
	Choice_Cred.show('w240 h180')
}


::bt-rz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social").value
	Send("^aBoa tarde {Text}Falo com o Responsavel da razão social: ")
	Send(razao_s "{?}")
	Choice_Cred.show('w240 h180')
}

::lembr1::
{
	Send("^a{Text}Boa tarde! Segue lembrança de pagamento do boleto que vence hoje, atrelado a CERVEJARIA PETROPOLIS. ")
	Send("{Shift down}{Enter}{Shift up}{Text}Lembrando que o boleto é com data única, portanto o pagamento precisa ser assertivo na data de hoje.")
	Send("{Shift down}{Enter}{Shift up}{Text}Como lhe informei, a senha para abrir o boleto são os *5 últimos dígitos do seu CNPJ/CPF*.")
	Send("{Shift down}{Enter}{Shift up}{Text}Aguardamos o envio do comprovante para agilizarmos a baixa.")
	Send("{Shift down}{Enter}{Shift up}{Text}Bons negócios!")
	Send("{Enter}")
}

::lembr2::
{
	Send("^a{Text}Olá! ")
	Send("{Shift down}{Enter}{Shift up}{Text}Tudo certo com o pagamento? Já conseguiu realiza-lo? Caso já realizado poderia nos encaminhar o comprovante referente ao pagamento?")
	Send("{Shift down}{Enter}{Shift up}{Text}Lembrando que não ocorrendo o pagamento gera uma QUEBRA DE ACORDO, por isso é de extrema importância que o pagamento seja realizado na data de hoje.")
	Send("{Shift down}{Enter}{Shift up}{Text}Aguardo o comprovante  para agilizarmos a baixa em assessoria.")
	Send("{Shift down}{Enter}{Shift up}{Text}Bons negócios!")
	Send("{Enter}")
}

::lembr3::
{
	Send("^a{Text}Boa tarde, vim pedir o comprovante de pagamento referente ao boleto que formalizamos para pagamento hoje. *Ressalto que o boleto tem data única para pagamento HOJE*")

	Send("{Shift down}{Enter}{Shift up}{Text}Informo que o *Credor(Cervejaria Petrópolis)* está ciente e está na espera do pagamento.")
	Send("{Shift down}{Enter}{Shift up}{Text}Informo que o nosso boleto é valido até as 22h para pagamento em qualquer app bancário.")
	Send("{Shift down}{Enter}{Shift up}{Text}Porem solicito que realize o pagamento antes das 22h, para que não ocorra nenhum problema na hora do pagamento.")
}

::quebr1::
{
	Send("^a{Text}Olá, não identificamos o pagamento do acordo que formalizamos para pagamento ontem referente aos débitos da Cervejaria Petrópolis, o que ocorreu?")
	Send("{Shift down}{Enter}{Shift up}{Text}Entramos em contato porque *precisamos formalizar um novo acordo* e emitir um novo boleto, pois o que a senhor(a) tem em mãos não é mais valido para pagamento.")
	Send("{Shift down}{Enter}{Shift up}{Text}O quanto antes estarmos definindo, melhor para que as correções de juros sejam menores.")
	Send("{Shift down}{Enter}{Shift up}{Text}Caso sontario, o valor só irá aumentar.")
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
::ura::{Texto} - Recebido Ura,
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

;Menu do Mouse


MButton::Proposal_menu.Show()
#z:: Proposal_menu.Show()

;Menu
Proposal_menu := Menu()
Proposal_menu.Add("Calculadora", Calculadora)
Proposal_menu.Add("Bloco de notas", Bloco_de_notas)
Proposal_menu.Add("Telas", Menu_Telas)


Calculadora(Item, *){
	run("win32calc.exe")
}

Bloco_de_notas(Item, *){
	run("notepad.exe")
}

Menu_Telas(Item, *){
	Telas := Menu()
	Telas.add("Chrome", Tela_Chrome)
	Telas.add("Bloco de Notas", Tela_Notepad)
	Telas.show()
}

Tela_Chrome(Item, *){
	Winactivate("ahk_exe chrome.exe")
}

Tela_Notepad(Item, *){
	Winactivate("ahk_exe notepad.exe")
}

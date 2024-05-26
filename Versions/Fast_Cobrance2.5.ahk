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
::parcel1::
{
	Prop_Gen2.show("w450 h80")
}


;Menu
Proposal_menu := Menu()
Proposal_menu.Add("Proposta 1", Proposal_Generator)
Proposal_menu.Add("Parcelamento", Proposal_Generator2)
Proposal_menu.Add("Calculadora", Calculadora)
Proposal_menu.Add("Bloco de notas", Bloco_de_notas)
Proposal_menu.Add("Telas", Menu_Telas)


Proposal_Generator(Item, *) {
    Prop_Gen1.show("w499 h387")
}

Proposal_Generator2(Item, *) {
    Prop_Gen2.show("w450 h80")
}

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

;Proposal_Generator1
Prop_Gen1 := Gui()
Prop_Gen1.Add("Edit", "x12 y29 w110 h30" , "Number")
Prop_Gen1.Add("Edit", "x12 y79 w340 h290" , "Proposta")
Prop_Gen1.Add("Slider", "x132 y29 w100 h30" , 20 )
Prop_Gen1.Add("Slider", "x242 y29 w100 h30" , 5 )
Prop_Gen1.Add("Text", "x362 y79 w110 h30" , "Valor Oring: ")
Prop_Gen1.Add("ComboBox", "x362 y29 w110 h70" , Cred )
Prop_Gen1.Add("Text", "x362 y119 w110 h30" , "Adicionais: ")
Prop_Gen1.Add("Text", "x362 y169 w110 h30" , "Total: ")
Genarete1 := Prop_Gen1.Add("Button", "x362 y329 w110 h40" , "Gerar")



;Proposal_Generator2
Prop_Gen2 := Gui()
Parcel := Prop_Gen2.Add("Edit", "x15 y19 w67 h30" , "Parcelas" )
Interval := Prop_Gen2.Add("Edit", "x82 y19 w60 h30" , "Dias" )
HO := Prop_Gen2.Add("Edit", "x162 y19 w60 h30" , "HO" )
Fees := Prop_Gen2.Add("Edit", "x222 y19 w60 h30" , "Juros" )
Valor := Prop_Gen2.Add("Edit", "x282 y19 w60 h30", "Valor" )
Genarete2 := Prop_Gen2.Add("Button", "x342 y19 w100 h30" , "Gerar")
Genarete2.OnEvent("Click", Gen_Prop1)


Gen_Prop1(Event, Info){

	ParcelNum := Number(Parcel.value)
	IntervalNum := Number(Interval.value)
	HONum := Number(HO.value)
	FeesNum := Number(Fees.value)
	ValorNum := Number(Valor.value)

	FesPerDay := (FeesNum/100) / 30

	Duration := ParcelNum * IntervalNum

	HOTotal := ((ValorNum + ((ValorNum * FesPerDay) * Duration)) * (HONum / 100))

	ValueFinal := ValorNum + ((ValorNum * FesPerDay) * Duration) + HOTotal

	ParcelValue := ValueFinal / ParcelNum

	AtualDate := FormatTime(A_Now, "LongDate")

	LastDate := FormatTime( DateAdd(A_Now, Duration, "days"), "LongDate")

	Prop_Gen2.Hide()

	Proposta := "Para lhe auxiliar na quitação dos debito pendentes, conseguimos aprovar o seguinte modelo de parcelamento. {Shift down}{Enter}{Shift up}Plano: " ParcelNum " parcelas de R$ " Format("{1:.2f}", ParcelValue) " de " IntervalNum " em " IntervalNum " dias. {Shift down}{Enter}{Shift up}Primeiro pagamento deve occorer hoje, " AtualDate " e ultimo pagamento " LastDate ".{Shift down}{Enter}{Shift up}Precisamos prosseguir com o envio da primeira parcela, encaminho por aqui{?}. {Enter}"

	ControlSend Proposta,, "ahk_exe chrome.exe"

}



; A.M.C (Automação de Mensagens de Cobrança)
#SingleInstance Force


::bd-spal::{Text}Bom dia! Entro em contato referente a sobre a *Spal refrigerantes Coca-Cola*, Tudo bom?


::bd-solar::{Text}Bom dia! Entro em contato referente a sobre a *Solar refrigerantes Coca-Cola*, Tudo bom?


::bd-andina::{Text}Bom dia! Entro em contato referente a sobre a *Andina refrigerantes Coca-Cola*, Tudo bom?


::bdd::
{
	nome := InputBox("Nome do Devedor", "Devedor").value
	Send("^aBom dia {Text} Sr(a). " nome)
	Send("{Shift down}{Enter}{Shift up}{Text}Precisamos falar de um assunto *Urgente*")
	Send("{Enter}")
}


::bd-rz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social").value
	Send("^aBom dia {Text} Falo com o Responsavel da razão social:")
	Send(razao_s "{?}")
	Send("{Shift down}{Enter}{Shift up}{Text}Referente a um assunto de *Extrema Urgencia*")
	Send("{Enter}")
}

::lembr1::
{
	Send("^aBom dia Presado Cliente, {Shift down}{Enter}{Shift up}{Text}Venho lhe relembrar a quitação do acordo que formalizamos para pagamento hoje.")
	Send("{Shift down}{Enter}{Shift up}{Text}Solicito que após a realização do pagamento nos envie o comprovante de pagamento para estarmos indenticando o pagamento e notificando o Credor para realizar a baixa")
	Send("{Shift down}{Enter}{Shift up}{Text}Só para estarmos preparados e no aguardo para quando encaminhar o comprovante, em quantos minutos consegue nos encaminhar o comprovante?")
	Send("{Enter}")
}

::quebr1::
{
	Send("^aBom dia Presado Cliente, {Text}Não indentificamos o pagamento que formalizamos para ontem, que ocorreu?")
	Send("{Shift down}{Enter}{Shift up}{Text}Gostariamos de saber o como poderiamos auxiliar caso o Senhor(a) tenha tido algum problema ou dificuldade na realização do pagamento.")
	Send("{Shift down}{Enter}{Shift up}{Text}Porque precisamos estar emitindo um novo boleto, pois o que tem em mãos não é mais valido para pagamento")
	Send("{Enter}")
}

;A.S.H (Automação de Status no Historico)

::cpos::{Texto} - Caixa postal,


::ncomp::{Texto} - Não completa,


::nexis::{Texto} - Não existe,


::fserv::{Texto} - Fora da area/serviço,


::cwpp::{Texto} wpp enviado


::swpp::{Texto} sem wpp


::cemail::{Texto} enviado email


;UI de Proposta


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

Proposal_Generator(Item, *) {
    Prop_Gen1.show("w499 h387")
}

Proposal_Generator2(Item, *) {
    Prop_Gen2.show("w450 h80")
}

Cred := ["Andina","Solar","Spal","Preventivo"]

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

	Proposta := "Pra lhe auxiliar na quitação dos debito pendentes, conseguimos aprovar o seguinte modelo de parcelamento. {Shift down}{Enter}{Shift up}Plano: " ParcelNum "x de R$ " Format("{1:.2f}", ParcelValue) " de " IntervalNum " em " IntervalNum " dias. Primeiro pagamento deve occorer hoje, " AtualDate " e ultimo pagamento " LastDate "{Shift down}{Enter}{Shift up}Precisamos prosseguir com o envio da primeira parcela. {Enter}"

	ControlSend Proposta,, "ahk_exe chrome.exe"

}



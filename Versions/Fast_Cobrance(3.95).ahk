;Definições

#SingleInstance Force

;Funções

Set_Config(Cred, Cobr, Scrip){
	if (Cred){
		Credores := []
		ativate := false
		Configs := FileRead('Config.txt', 'UTF-8')
		Configs :=  StrSplit(Configs, "`n")
		loop Configs.Length {
			line := Configs[A_Index]
			if(InStr(line, "<cred>") != 0){
				ativate := true
			}
			else if (InStr(line, "</cred>") != 0){
				ativate := false
			}
			else if (ativate){
				Credores.Push(line)
			}
		}
		;MsgBox(Credores)
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
				if (InStr(line, "cobrador = ") != 0){
					try {
						Cobrador := StrReplace(line, "cobrador = ", "")
					}
					catch as e{
						MsgBox('Erro na definição da variavel Cobrador no Config.txt, erro de programa: ' e.Message)
					}
				}
			}
		}
		;MsgBox(Cobrador)
		return Cobrador
	}
	else if (Scrip){
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
				if (InStr(line, "scripts_dir = ") != 0){
					try {
						Scripts_Dir := StrReplace(line, "scripts_dir = ", "")
					}
					catch as e{
						MsgBox('Erro na definição da variavel scripts_dir no Config.txt, erro de programa: ' e.Message)
					}
				}
			}
		}
		;MsgBox(Scripts_Dir)
		return Scripts_Dir
	}
}



Actvate_Scripts(){
	Dir := Set_Config(false, false, true)
	Script_Name := []
	Script_Value := []
	loop files A_ScriptDir "\" Dir "\*.txt", "F" {
		Script_Name.Push(A_LoopFileName)
		Script_Value.Push(FileRead(A_LoopFileFullPath, "UTF-8"))
	}
	loop Script_Name.Length {
		Comand := StrReplace( Script_Name[A_Index], ".txt", '')
		Creat_Hotstring(Comand, Script_Value[A_Index], false)
	}
}

Creat_Hotstring(HS, Text, Debug){
		; Debug: Mostrar a hotstring e o script concatenado
		if (Debug){
			MsgBox("Hotstring: " HS "`nScript: " Text, "Debug",)
		}
		
		Hotstring '::' HS , Text, 1
}

;Importando os Scripts Configuraveis
Actvate_Scripts()



Final_msg(Cred, Var, Urgence){
	if (Var = 0){
	msg := "{Shift down}{Enter}{Shift up}{Text}Entramos em contato sobre um assunto de *Extrema Urgência* referente a " Cred
	Send(msg)
	Send("{Shift down}{Enter}{Shift up}{Text}Precisamos da sua resposta o quanto antes.")
	Send("{Enter}")
	}
	else if (Var = 1){
		Send("{Shift down}{Enter}{Shift up}")
		Send("Temos um assunto urgente referente a " Cred ".{Shift down}{Enter}{Shift up}O senhor(a) prefere que conversemos por aqui?")
		Send("{Enter}")
	}
	else if (Var = 2){
		Send("{Shift down}{Enter}{Shift up}")
		Send("É necessario conversarmos sobre uma questão *urgente* referente à " Cred ". Podemos conversar por aqui?")
		Send("{Enter}")
	}
	else if (Var = 3){
		Send("{Shift down}{Enter}{Shift up}")
		Send("*A " Cred "* está no aguardo do seu posicionamento. {Shift down}{Enter}{Shift up}Por isso *precisamos da sua resposta o quanto antes*. ")
		Send("{Enter}")
	}
	else if (Var = 4){
		nome := InputBox("Nome do Devedor", "Devedor")
		if(nome.Result != 'Cancel'){
			Cobrador := Set_Config(false, true, false)
			Winactivate("ahk_exe chrome.exe")
			Send("^a{Del}")
			Send("*⚠️Urgente⚠️*")
			Send("{Shift down}{Enter}{Shift up}")
			Send("Bom dia/Boa tarde " nome.Value)
			Send("{Shift down}{Enter}{Shift up}")
			Send("Aqui é o " Cobrador " do Escritório Cobrance. Entro em contato referente a(o) " Cred)
			Send("{Shift down}{Enter}{Shift up}")
			Send("Conseguimos uma condição diferente do seu cadastro, *precisamos do seu retorno para ativar*.")
			Send("{Enter}")
		}
		else{
			MsgBox('Automação cancelada', 'Cancelada')
		}
	}
	else if (Var = 5){
		nome := InputBox("Nome do Devedor", "Devedor")
		if(nome.Result != 'Cancel'){
			Cobrador := Set_Config(false, true, false)
			Winactivate("ahk_exe chrome.exe")
			Send("^a{Del}")
			Send("*⚠️Urgente⚠️*")
			Send("{Shift down}{Enter}{Shift up}")
			Send("Bom dia/Boa tarde " nome.Value)
			Send("{Shift down}{Enter}{Shift up}")
			Send('Pelo que demonstra dos nossos últimos contatos com o(a) senhor(a), *não tem mais interesse no retorno da parceria com o ' Cred ' ?*. {Shift down}{Enter}{Shift up}Se sim, Gostaríamos de saber o que lhe causa esse desinteresse?')
			Send("{Enter}")
		}
		else{
			MsgBox('Automação cancelada', 'Cancelada')
		}
	}
	else {
		MsgBox('Não existe opção: ' Var 'Tente novamente.', "Erro da Variação")
	}
}


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


A_Entrada(p1, p_r, vezes){
	if (vezes = 1){
		data := InputBox('Data a partir da 2ª parcela?', 'Data').Value
		Winactivate("ahk_exe chrome.exe")
		Send("^a{Del}")
		Send("Meu sistema permite lhe auxiliar com um prazo adicional, assim pode se organizar para a quitação de seu(s) debito(s) até o dia " data ".")
		Send("{Shift down}{Enter}{Shift up}")
		Send("Mas somente mediante uma entrada hoje para abatimento de uma parte da divida e como desmonstração de interesse no retorno da parceria. ")
		Send("{Shift down}{Enter}{Shift up}")
		Send("Fica da seguinte forma:")
		Send("{Shift down}{Enter}{Shift up}")
		Send("Uma entrada de *R$" p1 "* e o restante de R$" p_r " para pagamento até dia " data)
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Encaminho o boleto da entrada por aqui ou e-mail?")
		Send("{Enter}")
	}
	else{
		data := InputBox('Me diga o intervalo entre as parcelas?', 'Data').Value
		Winactivate("ahk_exe chrome.exe")
		Send("^a{Del}")
		Send("{Text}Para lhe auxiliar a quitar seu(s) débito(s), está liberado com uma *entrada reduzida*, sendo uma *condição especial por parte da gestão*, o seguinte formato de parcelamento do debito.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("Uma entrada de *R$" p1 "* e outras " vezes " parcelas de R$" p_r " para pagamento a cada " data " dias.")
		Send("{Shift down}{Enter}{Shift up}")
		Send("{Text}Encaminho o boleto da entrada por aqui ou e-mail?")
		Send("{Enter}")
		
	}
}


;##Ui Basicas



Add_Comand_Gui(HotSK, New_btv)
{	
	myGui := Gui()
	ListaHotK := myGui.Add("ListView", "x32 y24 w207 h428 +LV0x4000", ["HotStrings/HotKeys", "Value"])
	Edit1 := myGui.Add("Edit", "x256 y24 w346 h178")
	Edit1.Value := "Valor"
	ButtonAddComand := myGui.Add("Button", "x256 y256 w162 h21", "&Add Comando")
	ComboBox1 := myGui.Add("ComboBox", "x256 y216 w161", ["HotString"])
	ComboBox1.Value := 1
	Name_Comand := myGui.Add("Edit", "x427 y216 w161 h20")
	Name_Comand.Value := 'Comando'
	ListaHotK.OnEvent("DoubleClick", LV_DoubleClick)
	ButtonAddComand.OnEvent("Click", Save_ScriptKeys)
	myGui.OnEvent('Close', (*) => myGui.Destroy)
	myGui.Title := "Adicionar Novo Comando"
	
	LV_DoubleClick(LV, RowNum)
	{
		if not RowNum
			return

		Dir := Set_Config(false, false, true)
		Valor := FileRead(A_ScriptDir '\' Dir '\' LV.GetText(RowNum) '.txt', "UTF-8")
		Edit1.Value := Valor
		Name_Comand.Value := StrReplace(LV.GetText(RowNum), ".txt", '')

	}
	
	Save_ScriptKeys(*)
	{
		Dir := Set_Config(false, false, true)
		Path_Defalt := A_ScriptDir '\' Dir '\' Name_Comand.Value '.txt'
		MsgBox(Path_Defalt)
		FileAppend(Edit1.Value, Path_Defalt, 'UTF-8')
		myGui.Destroy
		Atual := Add_Comand_Gui(true, true)
		Atual.Show('w614 h480')
	}

	Read_Scripts(){
		Dir := Set_Config(false, false, true)
		Script_Name := []
		Script_Value := []
		loop files A_ScriptDir "\" Dir "\*.txt", "F" {
			Script_Name.Push(A_LoopFileName)
			Script_Value.Push(FileRead(A_LoopFileFullPath, "UTF-8"))
		}
		loop Script_Name.Length {
			Comand := StrReplace( Script_Name[A_Index], ".txt", '')
			Value := StrReplace( Script_Value[A_Index], '`n', '{Shift down}{Enter}{Shift up}')
			ListaHotK.Add(, Comand, Value)
			Creat_Hotstring(Comand, Value, false)
		}
	}

	Read_Scripts()
	
	return myGui
}

^#h::{
	Gui := Add_Comand_Gui(true, true)
	Gui.Show('w614 h480')
}


Multi_Prop_Gui()
{	
	myGui := Gui()
	myGui.SetFont("Norm")
	myGui.Add("Text", "x16 y16 w201 h23 +0x200", "Geração de Multi-Ofertas")
	LV_ := myGui.Add("ListView", "x16 y48 w200 h150 +LV0x4000", ["Opt", "Valor(R$)", "Parcelas", "Interval", "Entrad", "Desc", "Modelo"])
	myGui.Add("Text", "x224 y48 w120 h24 +0x200", "OPT:")
	Avis_Parc := myGui.Add("CheckBox", "x224 y72 w96 h21", "A Vista")
	EditValor := myGui.Add("Edit", "x224 y120 w120 h21", "0")
	EditParcels := myGui.Add("Edit", "x224 y168 w120 h21", "0")
	EditParcels.Visible := 0
	RadioSEMANAL := myGui.Add("Radio", "x360 y72 w105 h19", "SEMANAL")
	RadioQUINZENAL := myGui.Add("Radio", "x360 y96 w120 h23", "QUINZENAL")
	RadioMENSAL := myGui.Add("Radio", "x360 y120 w120 h25", "MENSAL")
	myGui.Add("Text", "x224 y96 w120 h23 +0x200", "Valor")
	TextoParcels := myGui.Add("Text", "x224 y144 w120 h23 +0x200", "X Parcelas")
	TextoParcels.Visible := 0
	ButtonADDOPO := myGui.Add("Button", "x360 y168 w80 h23", "&ADD OPÇÃO")
	CheckBoxEntrada := myGui.Add("CheckBox", "x336 y48 w61 h23", "Entrada")
	CheckBoxDesconto := myGui.Add("CheckBox", "x400 y48 w120 h23", "Desconto")
	ButtonEncaminharPropostas := myGui.Add("Button", "x16 y208 w127 h27", "&Encaminhar Propostas")
	EditEntrada := myGui.Add("Edit", "x144 y208 w80 h21", "0")
	TextoEtrad := myGui.Add("Text", "x235 y208 w120 h23 +0x200", "Entrada")
	EditEntrada.Visible := 0
	TextoEtrad.Visible := 0
	EditDesc := myGui.Add("Edit", "x280 y208 w110 h21", "0")
	TextoDesc := myGui.Add("Text", "x400 y208 w120 h23 +0x200", "Desconto")
	EditDesc.Visible := 0
	TextoDesc.Visible := 0
	LV_.OnEvent("DoubleClick", LV_DoubleClick)
	Avis_Parc.OnEvent("Click", Tranforme_A2P)
	ButtonADDOPO.OnEvent("Click", Add_Prop_List)
	CheckBoxEntrada.OnEvent("Click", Activate_Entrad)
	CheckBoxDesconto.OnEvent("Click", Activate_Descont)
	ButtonEncaminharPropostas.OnEvent("Click", Send_Props)
	myGui.OnEvent('Close', (*) => myGui.Destroy)
	myGui.Title := "Multi Propostas"

	CheckBoxEntrada.Enabled := 0
	RadioMENSAL.Enabled := 0
	RadioQUINZENAL.Enabled := 0
	RadioSEMANAL.Enabled := 0

	OPTs := 0
	List_Prop := []
	
	Tranforme_A2P(*){
		if (Avis_Parc.Value = 1){
			Avis_Parc.Text := "Parcelamento"
			EditParcels.Visible := 1
			TextoParcels.Visible := 1
			CheckBoxEntrada.Enabled := 1
			RadioMENSAL.Enabled := 1
			RadioQUINZENAL.Enabled := 1
			RadioSEMANAL.Enabled := 1
		}
		else {
			Avis_Parc.Text := "A vista"
			EditParcels.Visible := 0
			TextoParcels.Visible := 0
			CheckBoxEntrada.Enabled := 0
			RadioMENSAL.Enabled := 0
			RadioQUINZENAL.Enabled := 0
			RadioSEMANAL.Enabled := 0
		}
	}

	Activate_Entrad(*){
		if (CheckBoxEntrada.Value = 1){
			EditEntrada.Visible := 1
			TextoEtrad.Visible := 1
		}
		else{
			EditEntrada.Visible := 0
			TextoEtrad.Visible := 0
		}
	}

	Activate_Descont(*){
		if (CheckBoxDesconto.Value = 1){
			EditDesc.Visible := 1
			TextoDesc.Visible := 1
		}
		else{
			EditDesc.Visible := 0
			TextoDesc.Visible := 0
		}
	}

	
	LV_DoubleClick(LV, RowNum)
	{
		if not RowNum
			return
		ToolTip(LV.GetText(RowNum), 77, 277)
		SetTimer () => ToolTip(), -3000
	}

	Add_Prop_List(*){
		OPTs += 1
		if (Avis_Parc.Value != 0){
			if (RadioSEMANAL.Value = 1) {
				if (CheckBoxDesconto.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 7, 0, EditDesc.Value, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 7, 0, EditDesc.Value, Avis_Parc.Value)
					return
				}
				else if (CheckBoxEntrada.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 7, EditEntrada.Value, 0, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 7, EditEntrada.Value, 0, Avis_Parc.Value)
					return
				}
				else if (CheckBoxEntrada.Value != 0 and CheckBoxDesconto.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 7, EditEntrada.Value, EditDesc.Value, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 7, EditEntrada.Value, EditDesc.Value, Avis_Parc.Value)
					return
				}
				LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 7, 0, 0, Avis_Parc.Value)
				Add_Props( OPTs, EditValor.Value, EditParcels.Value, 7, 0, 0, Avis_Parc.Value)
				return
			}
			else if (RadioQUINZENAL.Value = 1) {
				if (CheckBoxDesconto.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 15, 0, EditDesc.Value, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 15, 0, EditDesc.Value, Avis_Parc.Value)
					return
				}
				else if (CheckBoxEntrada.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 15, EditEntrada.Value, 0, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 15, EditEntrada.Value, 0, Avis_Parc.Value)
					return
				}
				else if (CheckBoxEntrada.Value != 0 and CheckBoxDesconto.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 15, EditEntrada.Value, EditDesc.Value, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 15, EditEntrada.Value, EditDesc.Value, Avis_Parc.Value)
					return
				}
				LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 15, 0, 0, Avis_Parc.Value)
				Add_Props( OPTs, EditValor.Value, EditParcels.Value, 15, 0, 0, Avis_Parc.Value)
				return
			}
			else if (RadioMENSAL.Value = 1) {
				if (CheckBoxDesconto.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 30, 0, EditDesc.Value, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 30, 0, EditDesc.Value, Avis_Parc.Value)
					return
				}
				else if (CheckBoxEntrada.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 30, EditEntrada.Value, 0, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 30, EditEntrada.Value, 0, Avis_Parc.Value)
					return
				}
				else if (CheckBoxEntrada.Value != 0 and CheckBoxDesconto.Value != 0){
					LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 30, EditEntrada.Value, EditDesc.Value, Avis_Parc.Value)
					Add_Props( OPTs, EditValor.Value, EditParcels.Value, 30, EditEntrada.Value, EditDesc.Value, Avis_Parc.Value)
					return
				}
				LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 30, 0, 0, Avis_Parc.Value)
				Add_Props(OPTs, EditValor.Value, EditParcels.Value, 30, 0, 0, Avis_Parc.Value)
				return
			}
		}
		else{
			if (CheckBoxDesconto.Value != 0){
				LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 0, 0, EditDesc.Value, Avis_Parc.Value)
				Add_Props(OPTs, EditValor.Value, EditParcels.Value, 0, 0, EditDesc.Value, Avis_Parc.Value)
			}
			else {
				LV_.Add(, OPTs, EditValor.Value, EditParcels.Value, 0, 0, 0, Avis_Parc.Value)
				Add_Props(OPTs, EditValor.Value, EditParcels.Value, 0, 0, 0, Avis_Parc.Value)
			}
		}
		
	}

	Add_Props(Opt, Valor, Parcelas, Interval, Entrad, Desc, Modelo){
		Prop := [Opt, Valor, Parcelas, Interval, Entrad, Desc, Modelo]
		List_Prop.Push(Prop)
		return
	}

	Send_Props(*){
		myGui.Hide()
		Winactivate("ahk_exe chrome.exe")
		Send('{Shift down}{Home}{Shift up}Para lhe auxiliar na quitação do debito lhe ofereço as seguintes opções para iniciarmos a negociação:')
		Send('{Shift down}{Enter}{Shift up}')
		Send('{Shift down}{Enter}{Shift up}')
		loop List_Prop.Length {
			Opt := List_Prop[A_Index][1]
			Valor := List_Prop[A_Index][2]
			Parcelas := List_Prop[A_Index][3]
			Interval := List_Prop[A_Index][4]
			Entrad := List_Prop[A_Index][5]
			Desc := List_Prop[A_Index][6]
			Modelo := List_Prop[A_Index][7]
			Send(A_Index ") Proposta: " )
			if (Modelo != 0){
				if (Interval = 7) {
					if (Desc != 0){
						if (Entrad != 0){
							Send('Parcelamento SEMANAL com *desconto de ' Desc '% sobre os juros*, de ' Parcelas 'x e com a *1ª parcela de R$ ' Entrad '* e as restantes de R$ ' Valor)
						}
						else {
							Send('Parcelamento SEMANAL com *desconto de ' Desc '% sobre os juros*, sendo em ' Parcelas 'x de R$ ' Valor ' cada parcela.')
						}
					}
					else {
						if (Entrad != 0){
							Send('Parcelamento SEMANAL de ' Parcelas 'x e com a *1ª parcela de R$ ' Entrad '* e as restantes de R$ ' Valor)
						}
						else {
							Send('Parcelamento SEMANAL de ' Parcelas 'x, sendo R$ ' Valor ' cada parcela.')
						}
					}
				}
				else if (Interval = 15) {
					if (Desc != 0){
						if (Entrad != 0){
							Send('Parcelamento QUINZENAL com *desconto de ' Desc '% sobre os juros*, de ' Parcelas 'x e com a *1ª parcela de R$ ' Entrad '* e as restantes de R$ ' Valor)
						}
						else {
							Send('Parcelamento QUINZENAL com *desconto de ' Desc '% sobre os juros*, sendo em ' Parcelas 'x de R$ ' Valor ' cada parcela.')
						}
					}
					else {
						if (Entrad != 0){
							Send('Parcelamento QUINZENAL de ' Parcelas 'x e com a *1ª parcela de R$ ' Entrad '* e as restantes de R$ ' Valor)
						}
						else {
							Send('Parcelamento QUINZENAL de ' Parcelas 'x, sendo R$ ' Valor ' cada parcela.')
						}
					}
				}
				else if (Interval = 30) {
					if (Desc != 0){
						if (Entrad != 0){
							Send('Parcelamento MENSAL com *desconto de ' Desc '% sobre os juros*, de ' Parcelas 'x e com a *1ª parcela de R$ ' Entrad '* e as restantes de R$ ' Valor)
						}
						else {
							Send('Parcelamento MENSAL com *desconto de ' Desc '% sobre os juros*, sendo em ' Parcelas 'x de R$ ' Valor ' cada parcela.')
						}
					}
					else {
						if (Entrad != 0){
							Send('Parcelamento MENSAL de ' Parcelas 'x e com a *1ª parcela de R$ ' Entrad '* e as restantes de R$ ' Valor)
						}
						else {
							Send('Parcelamento MENSAL de ' Parcelas 'x, sendo R$ ' Valor ' cada parcela.')
						}
					}
				}
			}
			else {
				if (Desc != 0){
					Send("Pagamento á vista hoje *com desconto de " Desc "% sobre os juros*, o valor fica de R$ " Valor)
				}
				else {
					Send("Pagamento á vista hoje, o valor fica de R$ " Valor)
				}

			}
			Send('{Shift down}{Enter}{Shift up}')
		}
		Send('{Enter}')
		Send('⚠️Qual das opções escolherá para fecharmos o acordo? {Enter}')
		myGui.Destroy()
	}
	
	return myGui
}


Quit_gui(Event, Info){
	Choice_Cred.Hide()
}

Credores := Set_Config(true, false, false)
Choice_Cred := Gui(, "Escolha Credor")
Escolha := Choice_Cred.Add("ComboBox", "x30 y50 w190 h140" , Credores)
Ok_Button := Choice_Cred.Add("Button", "x100 y90 w50 h30" , "OK")
Ok_Button.OnEvent("Click", Quit_gui)
Choice_Cred.OnEvent('Close', (*) => Choice_Cred.Hide)

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





;## A.M.C (Automação de Mensagens de Cobrança)

;Primeiro contato

::ola1::{
	Cobrador := Set_Config(false, true, false)
	Send("^aOlá, Aqui é o " Cobrador " do Escritório Cobrance.")
	Send("{Shift down}{Enter}{Shift up}")
	Send("Como posso lhe auxiliar?")
	Send('{Enter}')
}

::ola2::{
	Send("Pode me informar seu CPF/CNPJ?")
	Send('{Enter}')
}

::#idc::{
	Cobrador := Set_Config(false, true, false)
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Send("{Shift down}{Home}{Shift up}Aqui é o " Cobrador " do Escritório Cobrance. Entro em contato referente a(o) " Credores[Escolha.value])
}

::#id::{
	Cobrador := Set_Config(false, true, false)
	Send("{Shift down}{Home}{Shift up}Aqui é o " Cobrador " do Escritório Cobrance.")
}

::bd::{
	Winactivate("ahk_exe chrome.exe")
	Send("{Shift down}{Home}{Shift up}Bom dia, Sr(a). ")
}


::bt::{
	Winactivate("ahk_exe chrome.exe")
	Send("{Shift down}{Home}{Shift up}Boa tarde, Sr(a). ")
}

::bdr::{
	Winactivate("ahk_exe chrome.exe")
	Send("{Shift down}{Home}{Shift up}Bom dia, Responsável da razão social: ")
}


::btr::{
	Winactivate("ahk_exe chrome.exe")
	Send("{Shift down}{Home}{Shift up}Boa tarde, Responsável da razão social: ")
}

::bdqr::{
	Winactivate("ahk_exe chrome.exe")
	Send("{Shift down}{Home}{Shift up}*⚠️Bom dia, não tem mais interesse na quitação do debito e retorno com a parceria?⚠️*")
}


::btqr::{
	Winactivate("ahk_exe chrome.exe")
	Send("{Shift down}{Home}{Shift up}*⚠️Boa tarde, não tem mais interesse na quitação do debito e retorno com a parceria?⚠️*")
}

::bdd::
{
	nome := InputBox("Nome do Devedor", "Devedor")
	if(nome.Result != 'Cancel'){
		Choice_Cred.show('w240 h180')
		WinWaitNotActive('Escolha Credor')
		Winactivate("ahk_exe chrome.exe")
		Send("^aBom dia, {Text}Sr(a). " nome.Value)
		Final_msg(Credores[Escolha.value], 0, false)
	}
	else{
		MsgBox('Automação cancelada', 'Cancelada')
	}
}


::bdrz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social")
	if(razao_s.Result != 'Cancel'){
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Winactivate("ahk_exe chrome.exe")
	Send("^aBom dia,{Text}, Falo com o Responsável da razão social: " razao_s.Value "?")
	Final_msg(Credores[Escolha.value], 0, false)
	}
	else{
		MsgBox('Automação cancelada', 'Cancelada')
	}
}

::btd::
{
	nome := InputBox("Nome do Devedor", "Devedor")
	if(nome.Result != 'Cancel'){
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Winactivate("ahk_exe chrome.exe")
	Send("^aBoa tarde, {Text}Sr(a). " nome.Value)
	Final_msg(Credores[Escolha.value], 0, false)
	}
	else{
		MsgBox('Automação cancelada', 'Cancelada')
	}
}


::btrz::
{
	razao_s := InputBox("Me diga a Razão social", "Razao Social")
	if(razao_s.Result != 'Cancel'){
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Winactivate("ahk_exe chrome.exe")
	Send("^aBoa tarde, {Text}Falo com o Responsável da razão social: " razao_s.Value "?")
	Final_msg(Credores[Escolha.value], 0, false)
	}
	else{
		MsgBox('Automação cancelada', 'Cancelada')
	}
}


::btv::{
	variação := InputBox('Informe a opção de 1ª contato a ser encaminhado: De 1 a 3', 'Variação')
	nome := InputBox("Nome/Razão social do Devedor:", "Devedor")
	if(variação.Result != 'Cancel' && nome.Result != 'Cancel'){
		Choice_Cred.show('w240 h180')
		WinWaitNotActive('Escolha Credor')
		Winactivate("ahk_exe chrome.exe")
		Send("^aBoa tarde, " nome.Value "?")
		Final_msg(Credores[Escolha.value], variação.Value, false)
	}
	else{
		MsgBox('Automação cancelada', 'Cancelada')
	}
}

::bdv::{
	variação := InputBox('Informe a opção de 1ª contato a ser encaminhado: De 1 a 3', 'Variação')
	nome := InputBox("Nome/Razão social do Devedor:", "Devedor")
	if(variação.Result != 'Cancel' && nome.Result != 'Cancel'){
		Choice_Cred.show('w240 h180')
		WinWaitNotActive('Escolha Credor')
		Winactivate("ahk_exe chrome.exe")
		Send("^aBom dia, " nome.Value "?")
		Final_msg(Credores[Escolha.value], variação.Value, false)
	}
	else{
		MsgBox('Automação cancelada', 'Cancelada')
	}
}


::urg1::{
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Final_msg(Credores[Escolha.value], 4, true)
}

::urg2::{
	Choice_Cred.show('w240 h180')
	WinWaitNotActive('Escolha Credor')
	Final_msg(Credores[Escolha.value], 5, true)
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
		Cobrador := Set_Config(false, true, false)
		Send("^aOlá " nome.Value ",")
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
		MsgBox('Automação cancelada', 'Cancelada')
	}
}



;Negociação

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


::avs::{
	valor := InputBox("Qual o valor do boleto a vista hoje?", 'Boleto a vista hoje').Value
	Winactivate("ahk_exe chrome.exe")
	A_Vista(valor, 0)
}

::avd::{
	valor := InputBox("Qual o valor do boleto a vista hoje COM DESCONTO?", 'Boleto a vista hoje').Value
	desconto := InputBox('Quanto de desconto sobre os juros? (%)', 'Boleto a vista hoje').Value
	Winactivate("ahk_exe chrome.exe")
	A_Vista(valor, desconto)
}


::etr::{
	entrada := InputBox('Valor da entrada?', "Entrada")
	parcel := InputBox('Nº de parcelas? (Excluindo a entrada)', "Entrada")
	v_parcel := InputBox('Valor da(s) parcela(s)?', "Entrada")
	if(entrada.Result != 'Cancel' && parcel.Result != 'Cancel' && v_parcel.Result != 'Cancel'){
		A_Entrada(entrada.Value, v_parcel.Value, parcel.Value)
	}
}

::opt1::{
	gui := Multi_Prop_Gui()
	gui.Show('w500 h280')
}



; Acordo

::acrd1::{
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


::acrd2::{
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
		MsgBox('Automação cancelada', 'Cancelada')
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


::qbrd::
{
	nome := InputBox("Nome do Devedor", "Devedor")
	if(nome.Result != 'Cancel'){
		Choice_Cred.show('w240 h180')
		WinWaitNotActive('Escolha Credor')
		Send("^a{Text}Olá Sr(a). " nome ", não identificamos o pagamento do acordo que formalizamos para pagamento ontem referente aos débitos da " Credores[Escolha.value] ", o que ocorreu?")
		Send("{Enter}")
	}
	else {
		MsgBox('Automação cancelada', 'Cancelada')
	}
}


::qbrz::
{
	nome := InputBox("Nome da Razão social:", "Devedor")
	if(nome.Result != 'Cancel'){
		Choice_Cred.show('w240 h180')
		WinWaitNotActive('Escolha Credor')
		Send("^a{Text}Olá Responsável da razão social: " nome ", não identificamos o pagamento do acordo que formalizamos para pagamento ontem referente aos débitos da " Credores[Escolha.value] ", o que ocorreu?")
		Send("{Enter}")
	}
	else {
		MsgBox('Automação cancelada', 'Cancelada')
	}
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
		MsgBox('Automação cancelada', 'Cancelada')
	}
}


::agrd::Agradeço o envio do comprovante de pagamento, Bons negócios.
::agrdt::Agradeço o envio do comprovante de pagamento, tenha uma boa tarde e Bons negócios.
::agrdd::Agradeço o envio do comprovante de pagamento, tenha um bom dia e Bons negócios.
::agrdsm::Agradeço o envio do comprovante de pagamento, tenha uma ótima semana e Bons negócios.
::agrdf::Agradeço o envio do comprovante de pagamento, tenha um ótimo final de semana e Bons negócios.


::pbt::{Shift down}{Home}{Shift up}{Text}Segue o próximo(a) boleto/parcela abaixo.



;## A.S.H (Automação de Status no Historico)

::cps::{arquiv}- Caixa postal,
::nx::{arquiv}- Não existe,
::nrec::{arquiv}- Não recebe, 
::sch::{arquiv}- Só chama, 
::ncm::{arquiv}- Não completa, 
::for1::{arquiv}- Fora de area/serviço,
::ocup::{arquiv}- Ocupado, 
::bloq::{arquiv}- Bloqueado, 
::ligd::{arquiv}- Ligação atendida, mas logo desligada, 
::sres::{arquiv}- Ligação atendida, mas não houve resposta,

::rt::{arquiv}Retorno deu 
::rtc::{arquiv}Retorno deu caixa postal
::rto::{arquiv}Retorno deu ocupado

::wv::{arquiv}- wpp enviado
::we::{arquiv}wpp enviado 
::sw::{arquiv}sem wpp
::emv::{arquiv}e-mail enviado 
::emn::{arquiv}e-mail notificado 
::rw::{arquiv}- Recebido wpp
::rura::{arquiv}- Recebido Ura,
::lig::{arquiv}- Ligação atendida,
::rlig::{arquiv}- Recebido Ligação,
::resp::{arquiv}- Respondeu wpp,
::respp::{arquiv}- Respondeu wpp, proposta enviada por wpp 
::resc::{arquiv}- Respondeu wpp, em conversa por wpp
::resn::{arquiv}- Respondeu wpp, em negociação
::np::{arquiv}- Não pertence 
::disc::{arquiv}- Sem atendimento (Discador), 
::discw::{arquiv}- Sem atendimento (Discador), wpp enviado
::sat::{arquiv}- Sem atendimento, 
::satw::{arquiv}- Sem atendimento, wpp enviado
::afw::{arquiv}- Acordo formalizado, boleto enviado por wpp 
::afe::{arquiv}- Acordo formalizado, boleto enviado por e-mail
::lbr::{arquiv}- Lembrança de pagamento realizada, 
::prpc::{arquiv}Repassado proposta para o Credor.
::prp::{arquiv}Repassado proposta 
::prpp::{arquiv}Repassado proposta de parcelamento
::prpd::{arquiv}Repassado proposta de desconto á vista
::prpw::{arquiv}- Repassado proposta por wpp
::prpe::{arquiv}Repassado proposta por e-mail
::prpet::{arquiv}Repassado proposta por entrada hoje
::pagw::{arquiv}- Alega pagamento, solicitado evidência por wpp
::pag::{arquiv}- Alega pagamento.
::nrc::{arquiv}- Alega não reconhecer a nota, repassado dados por wpp
::compr::{arquiv}- Comprovante recebido
::compr1::{arquiv}- Comprovante recebido, encaminhado proxima parcela
::compr2::{arquiv}- Comprovante/Evidência recebido (Anexado)

; Status de Pesquisa

::CR::Credilink
::NV::Nova Vida
::RF::Receita federal
::RSC::Rede social
::GM::Google Maps

::nloc::Não localizada a fachada no Google Maps.
::nlocr::Não localizada rede social
::locn::Localizado número, final
::locf::Localizado fachada do comercio.
::eloc::Localizado e-mail, 
::locv::Localizado vizinho, 

::inst::Instagram
::fcb::Facebook
::lnk::Linkedin

::locinst::Localizado Instagram
::locfcb::Localizado Facebook
::loclnk::Localizado Linkedin
::locst::Localizado Site: 

::ninst::Notificado Instagram
::nfcb::Notificado Facebook
::nlnk::Notificado Linkedin

::cw::com wpp


; Combos

::cpw::{arquiv}- Caixa postal, wpp enviado
::nxw::{arquiv}- Não existe,  wpp enviado
::nrecw::{arquiv}- Não recebe, wpp enviado
::schw::{arquiv}- Só chama, wpp enviado
::ncmw::{arquiv}- Não completa, wpp enviado
::for2::{arquiv}- Fora de area/serviço, wpp enviado
::ocupw::{arquiv}- Ocupado, wpp enviado
::bloqw::{arquiv}- Bloqueado, wpp enviado
::ligdw::{arquiv}- Ligação atendida, mas logo desligada, wpp enviado
::sresw::{arquiv}- Ligação atendida, mas não houve resposta, wpp enviado

::cpss::{arquiv}- Caixa postal, sem wpp
::nxs::{arquiv}- Não existe,  sem wpp
::nrecs::{arquiv}- Não recebe, sem wpp
::schs::{arquiv}- Só chama, sem wpp
::ncms::{arquiv}- Não completa, sem wpp
::for3::{arquiv}- Fora de area/serviço, sem wpp
::ocups::{arquiv}- Ocupado, sem wpp
::bloqs::{arquiv}- Bloqueado, sem wpp
::ligds::{arquiv}- Ligação atendida, mas logo desligada, sem wpp
::sress::{arquiv}- Ligação atendida, mas não houve resposta, sem wpp

;## Automação de Pesquisa (BETA)

^!p::{
	id := InputBox('Insira o CPF/CNPJ para pesquisa: ', "Pesquisa")
	if(id.Result != "Cancel"){
		if (InStr(id.Value, "0001") != 0){
			Run "chrome.exe https://solucoes.receita.fazenda.gov.br/Servicos/cnpjreva/Cnpjreva_Solicitacao.asp?cnpj=" id.Value
		}
		else {
			MsgBox('Ainda não temos atuação para CPF')
		}
	}
	else{
		MsgBox('Automação cancelada', 'Cancelada')
	}
}

+^!p::{
	Run "chrome.exe https://congonhas.novavidati.com.br/"
}



; Automação de e-mail

::mdlpetra::Motivo: `n`nValor Capital: R$ x. `n`nVencimentos títulos: x `n`nPlano: x parcelas semanais de R$ x. `n`nPrimeiro pagamento em x de fevereiro e último vencimento em x de setembro. `n`nValor final acordo: R$ x. `n`nAtraso: x dias `n`nJuros: 1%/R$ x. `n`nMulta: 2 %/R$ x.

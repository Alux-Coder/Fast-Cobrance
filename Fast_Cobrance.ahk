; A.M.C
#SingleInstance Force
FileEncoding UTF-8


::bd-spal::{Text}Bom dia! Entro em contato referente a sobre a *Spal refrigerantes Coca-Cola*, Tudo bom?


::bd-solar::{Text}Bom dia! Entro em contato referente a sobre a *Solar refrigerantes Coca-Cola*, Tudo bom?


::bd-andina::{Text}Bom dia! Entro em contato referente a sobre a *Andina refrigerantes Coca-Cola*, Tudo bom?

::bdd::
{
	InputBox, nome, Devedor, Me fala o nome dele:
	Send, ^aBom dia Sr{(}a{)}{.}%nome% {Text}Precisamos falar de um assunto *Urgente*
	Send, {Enter}
	return
}


::bd-Rz::
{
	InputBox, nome, Devedor, Me fala o nome dele:
	Send, ^aBom dia {Text} Falo com o Responsavel da razão social:
	Send,  %nome% {?}
	Send, {Enter}
	return
}


;UI de Proposta




open util/ordering[Time] as to

module Construtora

sig Time {}

--------------------------------------------------------------------------------------
--   ASSINATURAS      (Definindo as Assinaturas do Modelo)          (12)                  --                                                      
--------------------------------------------------------------------------------------
one abstract sig Cidade{
	construtora: one Construtora

}

sig CampinaGrande extends Cidade{
}

one sig Construtora{
	contratos: set Contrato,
	equipesPedreiros: EquipePedreiros set -> Time,
	equipeEngenheiro: one EquipeEngenheiros,
	equipePintores: one EquipePintores
}

sig Contrato{
	construcao: Construcao one -> Time
}

abstract sig Construcao{
	equipePedreiros:  EquipePedreiros one -> Time,
	equipeEngenheiros: EquipeEngenheiros lone -> Time,
	equipePintores: EquipePintores lone -> Time
}

sig Predio, CondominioPopular, EstadioFutebol extends Construcao{}

sig EquipePedreiros{}

one sig EquipePintores{
}

one sig EquipeEngenheiros{
	engenheiros: some Engenheiro
}

abstract sig Engenheiro{}

sig EngenheiroEletricista extends Engenheiro{}

sig EngenheiroCivil extends Engenheiro{}


--------------------------------------------------------------------------------------
--   PREDICADOS      (Definindo os predicados do Modelo)          (17)                  --                                                      
--------------------------------------------------------------------------------------
pred construtoraTemTresContratos[]{
	all c:Construtora | #c.contratos = 3
}

pred todaEquipeDePredeirosEstaNaConstrutora[t: Time]{
	all c: Construtora, ep: EquipePedreiros | 
	(ep in c.equipesPedreiros.t)
}

pred todaEquipeDePedreiroEstaEmUmaUnicaConstrucao[t: Time]{
	all c: Construcao, e: EquipePedreiros | 
	(e in c.equipePedreiros.t => (all co: Construcao - c | e !in co.equipePedreiros.t))
}

pred todaEquipePedreirosDevePassarEmTodasConstrucoes[]{
	all c: Construcao, e: EquipePedreiros | some t: Time | e in c.equipePedreiros.t
}

pred todaConstrucaoTemUmContrato[t: Time]{
	all c: Contrato, e: Construcao | 
	(e in c.construcao.t => (all co: Contrato - c | e !in co.construcao.t))
}

pred todaEquipeDeEngenheirosTem2Engenheiros[]{
	all e: EquipeEngenheiros | #e.engenheiros = 2
}

pred umaEquipeEngenheirosTrabalhaEmUmaContrucaoPorVez[t: Time]{
	all c1, c2: Construcao | 
	(c1 != c2 and  #c1.equipeEngenheiros.t = 1) => (#c2.equipeEngenheiros.t = 0)
}

pred equipeEngenheirosPassamEmTodasConstrucoes{
	 all c: Construcao, e: EquipeEngenheiros | some t: Time | e in c.equipeEngenheiros.t
}

pred umaEquipePintoresTrabalhaEmUmaContrucaoPorVez[t: Time]{
	all c1, c2: Construcao | 
	(c1 != c2 and  #c1.equipePintores.t = 1) => (#c2.equipePintores.t = 0)
}

pred equipePintoresPassamEmTodasConstrucoes{
	 all c: Construcao, e: EquipePintores | some t: Time | e in c.equipePintores.t
}

pred aEquipePintoresNaoTrabalhaNaMesmaConstrucaoDaEquipeEngenheiros[t: Time] {
	all c: Construcao | (#c.equipeEngenheiros.t = 1) => (#c.equipePintores.t = 0)
}

pred equipeEngenheirosSempreTrabalha[t: Time]{
	 some c: Construcao | 	#c.equipeEngenheiros.t = 1
}

pred equipePintoresSempreTrabalha[t: Time]{
	 some c: Construcao | 	#c.equipePintores.t = 1
}

pred cadaContratoTemApenasUmaConstrucao[]{
		all t1,t2: Time | all cont: Contrato | cont.construcao.t1 = cont.construcao.t2
}

pred init[t: Time]{
}


--------------------------------------------------------------------------------------
--   FUNCOES      (Definindo as funcoes do Modelo)          (9)                  --                                                      
--------------------------------------------------------------------------------------
fun contratosDaConstrutora[c: Construtora]: set Contrato {
	c.contratos
}

fun equipeDePedreirosDaConstrutora[c: Construtora, t: Time]: set EquipePedreiros {
	c.equipesPedreiros.t
}

fun equipeEngenheirosDaConstrutora[c: Construtora]: one EquipeEngenheiros {
	c.equipeEngenheiro
}

fun equipePintoresDaConstrutora[c: Construtora]: one EquipePintores {
	c.equipePintores
}

fun construcaoDoContrato[c: Contrato, t: Time]: one Construcao {
	c.construcao.t
}

fun equipeDePedreirosDaConstrucao[c: Construcao, t: Time]: one EquipePedreiros {
	c.equipePedreiros.t
}

fun equipeEngenheirosDaConstrucao[c: Construcao, t: Time]: lone EquipeEngenheiros {
	c.equipeEngenheiros.t
}

fun equipePintoresDaConstrucao[c: Construcao, t: Time]: lone EquipePintores {
	c.equipePintores.t
}

fun engenheirosDaEquipe[e: EquipeEngenheiros]: some Engenheiro {
	e.engenheiros
}

--------------------------------------------------------------------------------------
--   FATOS      (Definindo os fatos do Modelo)          (2)                  --                                                      
--------------------------------------------------------------------------------------

fact Funcoes{
	all c: Construtora | 
		#contratosDaConstrutora[c] = 3
	all c: Construtora | all t: Time | 
		#equipeDePedreirosDaConstrutora[c, t] = 4
	all c: Construtora | 
		#equipeEngenheirosDaConstrutora[c] = 1
	all c: Construtora | 
		#equipePintoresDaConstrutora[c] = 1
	all c: Contrato | all t: Time | 
		#construcaoDoContrato[c, t] = 1
	all c: Construcao | all t: Time | 
		#equipeDePedreirosDaConstrucao[c, t] = 1
	all c: Construcao | all t: Time | 
		#equipeEngenheirosDaConstrucao[c, t] = 1 or 
		#equipeEngenheirosDaConstrucao[c, t] = 0
	all c: Construcao  | all t: Time | 
		#equipePintoresDaConstrucao[c, t] = 1 or 
		#equipePintoresDaConstrucao[c, t] = 0
	all e: EquipeEngenheiros | 
		#engenheirosDaEquipe[e] > 1
}

fact especificacoes{
	#Predio = 1
	#CondominioPopular = 1
	#EstadioFutebol = 1
	#EngenheiroEletricista = 1
	#EngenheiroCivil = 1
	
	construtoraTemTresContratos
	todaEquipePedreirosDevePassarEmTodasConstrucoes
	todaEquipeDeEngenheirosTem2Engenheiros
	equipeEngenheirosPassamEmTodasConstrucoes
	equipePintoresPassamEmTodasConstrucoes
	cadaContratoTemApenasUmaConstrucao
	all t:Time | aEquipePintoresNaoTrabalhaNaMesmaConstrucaoDaEquipeEngenheiros[t]
	all t: Time | umaEquipeEngenheirosTrabalhaEmUmaContrucaoPorVez[t]
	all t: Time | umaEquipePintoresTrabalhaEmUmaContrucaoPorVez[t]
	all t: Time | todaEquipeDePredeirosEstaNaConstrutora[t]
	all t: Time | todaEquipeDePedreiroEstaEmUmaUnicaConstrucao[t]
	all t: Time | todaConstrucaoTemUmContrato[t]
	all t: Time | equipeEngenheirosSempreTrabalha[t]
	all t: Time | equipePintoresSempreTrabalha[t]
	init[Time]
}


--------------------------------------------------------------------------------------
--   ASSERTS      (Definindo os asserts do Modelo)          (9)                  --                                                      
--------------------------------------------------------------------------------------

assert construtoraTemQuatroEquipePedreiros {
	all c: Construtora | all t: Time | #c.equipesPedreiros.t = 4
}

--check construtoraTemQuatroEquipePedreiros for 4

assert construtoraTemUmaEquipeEngenheiro {
	all c: Construtora | one c.equipeEngenheiro
}

--check construtoraTemUmaEquipeEngenheiro for 4

assert construtoraTemUmaEquipePintores {
	all c: Construtora | one c.equipePintores
}

--check construtoraTemUmaEquipePintores for 4

assert construcaoTemSomenteUmaEquipePedreiros {
	all c: Construcao, t: Time | one c.equipePedreiros.t
}

--check construcaoTemSomenteUmaEquipePedreiros for 4


assert construcaoTemUmaOuNenhumaEquipeDeEngenheiros{
	all t:Time, c: Construcao | #c.equipeEngenheiros.t = 1 or #c.equipeEngenheiros.t = 0
}

--check construcaoTemUmaOuNenhumaEquipeDeEngenheiros for 4

assert construcaoTemUmaOuNenhumaEquipeDePintores{
	all t:Time, c: Construcao | #c.equipePintores.t = 1 or #c.equipePintores.t = 0
}

--check construcaoTemUmaOuNenhumaEquipeDePintores for 4

assert equipePintoresNaoTrabalhaComEquipeEngenheiros{
	all t: Time, c: Construcao | (#c.equipePintores.t = 1) => (#c.equipeEngenheiros.t = 0)
}

--check equipePintoresNaoTrabalhaComEquipeEngenheiros for 4

assert existePredioCondominioPopularEstadioFutebol {
	all t: Time, cont: Contrato | some cons: Construcao | 
	cons in cont.construcao.t and
	(cons = Predio or cons = CondominioPopular or cons = EstadioFutebol)
}

--check existePredioCondominioPopularEstadioFutebol for 4

assert todosEngenheirosTrabalhamJuntos{
	all eq: EquipeEngenheiros, en: Engenheiro | en in eq.engenheiros
}

--check todosEngenheirosTrabalhamJuntos for 4

pred show[]{}

run show for 6

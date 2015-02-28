open util/ordering[Time] as to

module Construtora

sig Time {}

--------------------------------------------------------------------------------------
--   ASSINATURAS      (Definindo as Assinaturas do Modelo)          (11)                  --                                                      
--------------------------------------------------------------------------------------
one abstract sig Cidade{
	construtora: one Construtora

}

sig CampinaGrande extends Cidade{
}

one sig Construtora{
	contratos: set Contrato,
	equipesPedreiros: EquipePedreiros set -> Time,
	equipeEngenheiro: one EquipeEngenheiros
}

sig Contrato{
	construcao: Construcao one -> Time
}

abstract sig Construcao{
	equipePedreiros:  EquipePedreiros one -> Time,
	equipeEngenheiros: EquipeEngenheiros lone -> Time
}

sig Predio, CondominioPopular, EstadioFutebol extends Construcao{}

sig EquipePedreiros{
}

one sig EquipeEngenheiros{
	engenheiros: some Engenheiro
}

abstract sig Engenheiro{}

sig EngenheiroEletricista extends Engenheiro{}

sig EngenheiroCivil extends Engenheiro{}

--PREDICADOS
pred todoContratoTemUmaConstrutora[]{
	all c:Construtora | #c.contratos = 3
}

pred todoConstrucaoSoTemUmaEquipeDePedreirosUnica []{
	all c1, c2: Construcao |( c1 != c2) => (c1.equipePedreiros != c2.equipePedreiros)
}

pred todaEquipeDePedreirosDaConstrucaoEstaNaConstrutora[]{
	all c: Construtora, cons: Construcao | 
	(cons.equipePedreiros in c.equipesPedreiros)
}

pred todaEquipeDePredeirosEstaNaConstrutora[t: Time]{
	all c: Construtora, ep: EquipePedreiros | 
	(ep in c.equipesPedreiros.t)
}

pred todaEquipeDePedreiroEstaEmUmaUnicaConstrucao[t: Time]{
	all c: Construcao, e: EquipePedreiros | 
	(e in c.equipePedreiros.t => (all co: Construcao - c | e !in co.equipePedreiros.t))
}

pred todaConstrucaoTemUmContrato[t: Time]{
	all c: Contrato, e: Construcao | 
	(e in c.construcao.t => (all co: Contrato - c | e !in co.construcao.t))
}

pred todaEquipeDeEngenheirosTem2Engenheiros[]{
	all e: EquipeEngenheiros | #e.engenheiros = 2
}

pred todaEquipeDeEngenheirosTemUmEletricista[]{
	all e1: EquipeEngenheiros, e2: EngenheiroEletricista | e2 in e1.engenheiros
}

pred todaEquipeDeEngenheirosTemUmCivil[]{
	all e1: EquipeEngenheiros, e2: EngenheiroCivil | e2 in e1.engenheiros
}

pred umaEquipeEngenheirosTrabalhaEmUmaContrucaoPorVez[t: Time]{
	all c1, c2: Construcao | 
	(c1 != c2 and  #c1.equipeEngenheiros.t = 1) => (#c2.equipeEngenheiros.t = 0)
}

pred init[t: Time]{
}

--FATOS
fact especificacoes{
	#Contrato = 3
	#Predio = 1
	#CondominioPopular = 1
	#EstadioFutebol = 1
	#EquipePedreiros = 4
	#Engenheiro = 2
	todoContratoTemUmaConstrutora
	todoConstrucaoSoTemUmaEquipeDePedreirosUnica
	todaEquipeDePedreirosDaConstrucaoEstaNaConstrutora
	todaEquipeDeEngenheirosTem2Engenheiros
	todaEquipeDeEngenheirosTemUmEletricista
	todaEquipeDeEngenheirosTemUmCivil
	all t: Time | umaEquipeEngenheirosTrabalhaEmUmaContrucaoPorVez[t]
	all t: Time | todaEquipeDePredeirosEstaNaConstrutora[t]
	all t: Time | todaEquipeDePedreiroEstaEmUmaUnicaConstrucao[t]
	all t: Time | todaConstrucaoTemUmContrato[t]
	init[Time]
}

pred show[]{}
run show for 10

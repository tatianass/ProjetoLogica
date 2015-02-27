open util/ordering[Time] as to

module Construtora

sig Time {}

--------------------------------------------------------------------------------------
--   ASSINATURAS      (Definindo as Assinaturas do Modelo)          (11)                  --                                                      
--------------------------------------------------------------------------------------
abstract sig Cidade{
	construtora: one Construtora

}

sig CampinaGrande extends Cidade{
}

sig Construtora{
	contratos: set Contrato,
	equipesPedreiros: EquipePedreiros set -> Time
}

sig Contrato{
	construcao: Construcao one -> Time
}

abstract sig Construcao{
	equipePedreiros:  EquipePedreiros one -> Time
}

sig Predio, CondominioPopular, EstadioFutebol extends Construcao{}

sig EquipePedreiros{
}

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

pred init[t: Time]{
}

--FATOS
fact especificacoes{
	#Cidade = 1
	#Construtora = 1
	#Contrato = 3
	#Predio = 1
	#CondominioPopular = 1
	#EstadioFutebol = 1
	#EquipePedreiros = 4
	todoContratoTemUmaConstrutora
	todoConstrucaoSoTemUmaEquipeDePedreirosUnica
	todaEquipeDePedreirosDaConstrucaoEstaNaConstrutora
	all t: Time | todaEquipeDePredeirosEstaNaConstrutora[t]
	all t: Time | todaEquipeDePedreiroEstaEmUmaUnicaConstrucao[t]
	all t: Time | todaConstrucaoTemUmContrato[t]
	init[Time]
}

pred show[]{}
run show for 10

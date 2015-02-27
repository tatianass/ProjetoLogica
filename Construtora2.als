
module Construtora

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
	equipesPedreiros: set EquipePedreiros
}

sig Contrato{
	construcao: one Construcao
}

abstract sig Construcao{
	equipePedreiros: one EquipePedreiros
}

sig Predio, CondominioPopular, EstadioFutebol extends Construcao{}

sig EquipePedreiros{}

--PREDICADOS
pred todoContratoTemUmaConstrutora[]{
	all c:Construtora | #c.contratos = 3
}

pred todoContratoSoTemUmaConstrucaoUnica []{
	all c1, c2: Contrato |( c1 != c2) => (c1.construcao != c2.construcao)
}

pred todoConstrucaoSoTemUmaEquipeDePedreirosUnica []{
	all c1, c2: Construcao |( c1 != c2) => (c1.equipePedreiros != c2.equipePedreiros)
}

pred todaEquipeDePedreirosDaConstrucaoEstaNaConstrutora[]{
	all c: Construtora, cons: Construcao | 
	(cons.equipePedreiros in c.equipesPedreiros)
}

pred todaEquipeDePredeirosEstaNaConstrutora[]{
	all c: Construtora, ep: EquipePedreiros | 
	(ep in c.equipesPedreiros)
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
	todoContratoSoTemUmaConstrucaoUnica
	todoConstrucaoSoTemUmaEquipeDePedreirosUnica
	todaEquipeDePedreirosDaConstrucaoEstaNaConstrutora
	todaEquipeDePredeirosEstaNaConstrutora
}

pred show[]{}
run show for 20

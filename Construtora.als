open util/ordering[Time] as to

module Construtora

sig Time {}

--------------------------------------------------------------------------------------
--   ASSINATURAS      (Definindo as Assinaturas do Modelo)          (11)                  --                                                      
--------------------------------------------------------------------------------------
one sig Construtora{
	cidade: one Cidade,
	contratos: set Contrato,
	equipePedreiros: set EquipePredeiros,
	engenheiros: set Engenheiros,
	equipePintores: one EquipePintores
}

sig Cidade{
	nome: one Nome,
	estado: one Estado
}

sig Contrato{
	equipePedreirosContrato: set EquipePredeiros,
	engenheirosContrato: set Engenheiros,
	equipePintoresContrato: one EquipePintores
}

sig Predio, CondominioPopular, EstadioFutebol extends Contrato{}

sig EquipePredeiros{}

abstract sig Engenheiros{}
sig EngenheiroCivil, EngenheiroEletrico extends Engenheiros{}
sig EquipePintores{}

--------------------------------------------------------------------------------------
--   ATRIBUTOS DAS ASSINATURAS        (2)                  --                                                      
--------------------------------------------------------------------------------------
sig Nome{}
sig Estado{}

--------------------------------------------------------------------------------------
--   PREDICADOS        (4)                  --                                                      
--------------------------------------------------------------------------------------
-- QUATIDADES
pred construtoraTem3Contratos[]{
	all c:Construtora | #c.contratos = 3
}

pred construtoraTem4EquipesDePedreiros[]{
	all c:Construtora | #c.equipePedreiros = 4
}

pred construtoraTem2Engenheiros[]{
	all c:Construtora | #c.engenheiros = 2
}

pred construtoraTem1EquipeDePintores[]{
	all c:Construtora | #c.equipePintores = 1
}

--TEMPO
pred init[t: Time]{
}

--------------------------------------------------------------------------------------
--   FATOS        (4)                  --                                                      
--------------------------------------------------------------------------------------
fact EspecificacaoDaConstrutora{
	construtoraTem3Contratos
	construtoraTem4EquipesDePedreiros
	construtoraTem2Engenheiros
	construtoraTem1EquipeDePintores
}

fact engenheirosTrabalhamJuntos{
	all e:Engenheiros, p: Predio, c: CondominioPopular, ef: EstadioFutebol |
	((e in p.engenheirosContrato) and !(e in c.engenheirosContrato) and !(e in ef.engenheirosContrato)) or
	(!(e in p.engenheirosContrato) and (e in c.engenheirosContrato) and !(e in ef.engenheirosContrato)) or
	(!(e in p.engenheirosContrato) and !(e in c.engenheirosContrato) and (e in ef.engenheirosContrato))
}

fact equipePintoresNaoTrabalhaComEngenheiros{
	all ep:EquipePintores, e: EquipePredeiros, p: Predio, c: CondominioPopular, ef: EstadioFutebol |
	((ep in p.equipePintoresContrato) and !(e in p.equipePedreirosContrato)) or
	((ep in c.equipePintoresContrato) and !(e in c.equipePedreirosContrato)) or
	((ep in ef.equipePintoresContrato) and !(e in ef.equipePedreirosContrato))
}

pred show[]{}
run show for 10

open util/ordering[Time] as to

module Construtora

sig Time {}

--------------------------------------------------------------------------------------
--   ASSINATURAS      (Definindo as Assinaturas do Modelo)          (11)                  --                                                      
--------------------------------------------------------------------------------------
one sig Construtora{
	contratos: set Contrato,
	equipePedreiros: set EquipePredeiros,
	engenheiros: set Engenheiros,
	equipePintores: one EquipePintores
}

one sig Cidade{
	nome: one Nome,
	estado: one Estado,
	construtora: set Construtora
}

sig Contrato{
	construcao: one Construcao
}

abstract sig Construcao{
	equipePedreirosContrato: one EquipePredeiros,
	engenheirosContrato: set Engenheiros,
	equipePintoresContrato: lone EquipePintores
}

one sig Predio, CondominioPopular, EstadioFutebol extends Construcao{}

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
-- QUATIDADES ATRIBUTOS CONSTRUTORA
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

-- QUATIDADES ATRIBUTOS CONTRATO
pred construtoraContratoTem4EquipesDePedreiros[]{
	all c:Construcao | #c.equipePedreirosContrato = 4
}

pred construtoraContratoTem2Engenheiros[]{
	all c:Construcao | #c.engenheirosContrato = 2
}

pred construtoraContratoTem1EquipeDePintores[]{
	all c:Construcao | #c.equipePintoresContrato = 1
}

--OBRA
pred predioTemPeloMenos1EquipeDePredeiros[]{
	all p:Predio | #p.equipePedreirosContrato > 0
}

pred condominioPopularTemPeloMenos1EquipeDePredeiros[]{
	all c:CondominioPopular | #c.equipePedreirosContrato > 0
}

pred estadioFutebolTemPeloMenos1EquipeDePredeiros[]{
	all e:EstadioFutebol | #e.equipePedreirosContrato > 0
}

--TEMPO
pred init[t: Time]{
}

--RUN
pred show[]{}

--------------------------------------------------------------------------------------
--   FATOS        (4)                  --                                                      
--------------------------------------------------------------------------------------

fact EspecificacaoDaConstrutora{
	construtoraTem3Contratos
	construtoraTem4EquipesDePedreiros
	construtoraTem2Engenheiros
	construtoraTem1EquipeDePintores
}

fact EspecificacaoDaContrato{
	construtoraContratoTem4EquipesDePedreiros
	construtoraContratoTem2Engenheiros
	construtoraContratoTem1EquipeDePintores
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

fact obrasComPeloMenosUmaEquipePredeiros{
	predioTemPeloMenos1EquipeDePredeiros
	condominioPopularTemPeloMenos1EquipeDePredeiros
	estadioFutebolTemPeloMenos1EquipeDePredeiros
}

run show for 10

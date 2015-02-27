module Construtora

--------------------------------------------------------------------------------------
--   ASSINATURAS      (Definindo as Assinaturas do Modelo)          (11)                  --                                                      
--------------------------------------------------------------------------------------
sig Construtora{
	cidade: one Cidade
	contratos: set Contrato
	equipePedreiros: set EquipePredeiros
	engenheiros: set Engenheiros
	equipePintores: one EquipePintores
}

sig Cidade{
	nome: one Nome
	estado: one Estado
}

abstract sig Contrato{}
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
pred construtoraTem3Contratos[]{
	all c:Construtora | #co.contratos = 3
}

pred construtoraTem4EquipesDePedreiros[]{
	all c:Construtora | #ep.equipePedreiros = 4
}

pred construtoraTem2Engenheiros[]{
	all c:Construtora | #e.engenheiros = 2
}

pred construtoraTem1EquipeDePintores[]{
	all c:Construtora | #epi.equipePintores = 1
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

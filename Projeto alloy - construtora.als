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
--   Atributos das assinaturas        (2)                  --                                                      
--------------------------------------------------------------------------------------
sig Nome{}
sig Estado{}

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
sig Cidade{}
sig Contrato{}
sig Predio extends Contrato{}
sig CondominioPopular extends Contrato{}
sig EstadioFutebol extends Contrato{}
sig EquipePredeiros{}
sig Engenheiros{}
sig EngenheiroCivil extends Engenheiros{}
sig EngenheiroEletrico extends Engenheiros{}
sig EquipePintores{}

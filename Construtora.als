module Construtora

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

--------------------------------------------------------------------------------------
--   FATOS        (4)                  --                                                      
--------------------------------------------------------------------------------------


pred show[]{}
run show for 2

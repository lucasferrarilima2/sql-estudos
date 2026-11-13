DROP TABLE IF EXISTS pagamentos, matriculas, planos, alunos;

CREATE TABLE alunos (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	data_nascimento DATE NOT NULL,
	cidade VARCHAR(100) NOT NULL,
	cep VARCHAR(8) NOT NULL,
	data_cadastro DATE DEFAULT CURRENT_DATE
);


CREATE TABLE planos (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nome VARCHAR(30) UNIQUE NOT NULL,
	valor_mensal NUMERIC(10,2) NOT NULL CHECK (valor_mensal > 0),
	duracao_meses INTEGER NOT NULL CHECK (duracao_meses > 0)
);

CREATE TABLE matriculas (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	aluno_id INTEGER NOT NULL REFERENCES alunos(id),
	plano_id INTEGER NOT NULL REFERENCES planos(id),
	data_inicio DATE NOT NULL DEFAULT CURRENT_DATE,
	data_fim DATE NOT NULL,
	status VARCHAR(20) NOT NULL DEFAULT 'ativa' CHECK (status IN ('ativa', 'cancelada', 'vencida')),
	CHECK (data_fim>data_inicio)
);


CREATE TABLE pagamentos (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	matricula_id INTEGER NOT NULL REFERENCES matriculas(id),
	valor NUMERIC(10,2) NOT NULL CHECK (valor > 0),
	data_vencimento DATE NOT NULL,
	data_pagamento DATE
);
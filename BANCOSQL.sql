CREATE TABLE cliente(
	id_cliente SERIAL PRIMARY KEY NOT NULL,
	nome_cliente VARCHAR(100) NOT NULL,
	nascimento_cliente DATE NOT NULL,
	cpf_cliente VARCHAR(14) UNIQUE,
	foto_cliente BYTEA,
	cliente_ativo BOOLEAN DEFAULT true,
	desativado_em TIMESTAMP,
	genero VARCHAR(15) NOT NULL
);

CREATE TABLE contato(
	id_contato SERIAL NOT NULL PRIMARY KEY,
	contato VARCHAR(50) NOT NULL,
	tipo_contato VARCHAR(20) NOT NULL
);

CREATE TABLE cliente_contato(
	id_cliente INT NOT NULL,
	id_contato INT NOT NULL,
	PRIMARY KEY (id_cliente, id_contato),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	FOREIGN KEY (id_contato) REFERENCES contato (id_contato)
);

CREATE TABLE area_atuacao(
	id_area_atuacao SERIAL NOT NULL PRIMARY KEY,
	area_atuacao VARCHAR(50) NOT NULL,
	foto_area_atuacao BYTEA
);

CREATE TABLE endereco(
	id_endereco SERIAL NOT NULL PRIMARY KEY,
	cep VARCHAR(8) NOT NULL,
	logradouro VARCHAR(50) NOT NULL,
	complemento VARCHAR(50),
	numero VARCHAR(10) NOT NULL,
	bairro VARCHAR(30) NOT NULL,
	cidade VARCHAR(30) NOT NULL,
	estado VARCHAR(2) NOT NULL,
	latitude FLOAT NOT NULL,
	longitude FLOAT NOT NULL
);

CREATE TABLE empresa(
	id_empresa SERIAL NOT NULL PRIMARY KEY,
	nome_fantasia VARCHAR(50) NOT NULL,
	cpf_empresa VARCHAR(14) UNIQUE,
	cnpj_empresa VARCHAR(18) UNIQUE,
	descricao_empresa VARCHAR(400),
	logo_empresa BYTEA,
	empresa_ativada BOOLEAN DEFAULT true,
	desativada_em TIMESTAMP,
	genero VARCHAR(15) NOT NULL,
	id_area_atuacao INT NOT NULL,
	id_endereco INT NOT NULL,
	FOREIGN KEY (id_area_atuacao) REFERENCES area_atuacao(id_area_atuacao),
	FOREIGN KEY (id_endereco) REFERENCES endereco(id_endereco)
);

CREATE TABLE login(
	id_login SERIAL PRIMARY KEY NOT NULL,
	usuario VARCHAR(50) UNIQUE NOT NULL,
	senha VARCHAR(64) NOT NULL,
	login_google VARCHAR(100),
	id_cliente INT,
	id_empresa INT,
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa)
);

CREATE TABLE empresa_contato(
	id_empresa INT NOT NULL,
	id_contato INT NOT NULL,
	PRIMARY KEY(id_empresa, id_contato),
	FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa),
	FOREIGN KEY (id_contato) REFERENCES contato (id_contato)
);

CREATE TABLE cliente_empresa(
	id_cliente INT NOT NULL,
	id_empresa INT NOT NULL,
	PRIMARY KEY(id_cliente, id_empresa),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa)
);

CREATE TABLE comentario(
	id_comentario SERIAL NOT NULL PRIMARY KEY,
	data_comentario TIMESTAMP DEFAULT now(),
	comentario VARCHAR(140) NOT NULL,
	comentario_ativado BOOLEAN DEFAULT true,
	id_cliente INT NOT NULL,
	id_empresa INT NOT NULL,
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE funcionario(
	id_funcionario SERIAL NOT NULL PRIMARY KEY,
	nome_funcionario VARCHAR(50) NOT NULL,
	foto_funcionario BYTEA,
	funcionario_ativo BOOLEAN DEFAULT true,
	desativado_em TIMESTAMP,
	id_empresa INT NOT NULL,
	FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE dia_semana(
	id_dia_semana SERIAL NOT NULL PRIMARY KEY,
	dia_semana VARCHAR(20) NOT NULL
);

CREATE TABLE horario_empresa(
	id_horario_empresa SERIAL NOT NULL PRIMARY KEY,
	inicio_expediente TIME WITHOUT TIME ZONE NOT NULL,
	inicio_intervalo TIME WITHOUT TIME ZONE,
	fim_intervalo TIME WITHOUT TIME ZONE,
	fim_expediente TIME WITHOUT TIME ZONE NOT NULL,
	id_dia_semana INT NOT NULL,
	id_empresa INT NOT NULL,
	UNIQUE (id_dia_semana, id_empresa),
	FOREIGN KEY (id_dia_semana) REFERENCES dia_semana(id_dia_semana),
	FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE grupo_servico(
	id_grupo_servico SERIAL NOT NULL PRIMARY KEY,
	grupo_servico VARCHAR(50) NOT NULL,
	foto_grupo_servico BYTEA NOT NULL,
	id_area_atuacao INT NOT NULL,
	FOREIGN KEY (id_area_atuacao) REFERENCES area_atuacao(id_area_atuacao)

);

CREATE TABLE servico(
	id_servico SERIAL NOT NULL PRIMARY KEY,
	servico VARCHAR(50) NOT NULL,
	id_grupo_servico INT NOT NULL,
	FOREIGN KEY (id_grupo_servico) REFERENCES grupo_servico(id_grupo_servico)
);

CREATE TABLE servico_prestado(
	id_servico_prestado SERIAL NOT NULL PRIMARY KEY,
	valor_servico REAL NOT NULL,
	tempo_aproximado_servico INT NOT NULL,
	informacoes_servico VARCHAR(400),
	id_servico INT NOT NULL,
	id_empresa INT NOT NULL,
	FOREIGN KEY (id_servico) REFERENCES servico (id_servico),
	FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa)
);

CREATE TABLE horario_marcado(
	id_horario_marcado SERIAL NOT NULL PRIMARY KEY,
	horario_inicio TIME WITHOUT TIME ZONE NOT NULL,
	horario_fim TIME WITHOUT TIME ZONE NOT NULL,
	data_marcada DATE NOT NULL,
	status VARCHAR(1) DEFAULT 'A',
	desativado BOOLEAN DEFAULT false,
	id_cliente INT NOT NULL,
	id_empresa INT NOT NULL,
	id_funcionario INT,
	id_servico_prestado INT NOT NULL,
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa),
	FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario),
	FOREIGN KEY (id_servico_prestado) REFERENCES servico_prestado(id_servico_prestado)
);

CREATE TABLE servico_prestado_funcionario(
	id_servico_prestado INT NOT NULL,
	id_funcionario INT NOT NULL,
	PRIMARY KEY(id_servico_prestado, id_funcionario),
	FOREIGN KEY (id_servico_prestado) REFERENCES servico_prestado (id_servico_prestado),
	FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario)
);

CREATE TABLE galeria (
	id_galeria SERIAL NOT NULL PRIMARY KEY,
	id_empresa INT NOT NULL,
	id_grupo_servico INT NOT NULL,
	UNIQUE (id_empresa, id_grupo_servico),
	FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa),
	FOREIGN KEY (id_grupo_servico) REFERENCES grupo_servico (id_grupo_servico)
);

CREATE TABLE foto_galeria (
	id_foto_galeria SERIAL NOT NULL PRIMARY KEY,
	foto_antes_galeria BYTEA NOT NULL,
	foto_depois_galeria BYTEA NOT NULL,
	id_galeria INT NOT NULL,
	FOREIGN KEY (id_galeria) REFERENCES galeria(id_galeria)
);


CREATE SEQUENCE mensagem_erro_id_mensagem_erro_seq RESTART WITH 1001;
	
CREATE TABLE mensagem_erro(
	id_erro INTEGER DEFAULT NEXTVAL('mensagem_erro_id_mensagem_erro_seq'),
	codigo_erro INT NOT NULL,
	mensagem_erro VARCHAR(200) NOT NULL,
	pertence_a VARCHAR(100) NOT NULL,
	quem_dispara VARCHAR(100) NOT NULL

);

CREATE SEQUENCE mensagem_sucesso_id_mensagem_sucesso_seq RESTART WITH 3001;

CREATE TABLE mensagem_sucesso(
	id_sucesso INTEGER DEFAULT NEXTVAL('mensagem_sucesso_id_mensagem_sucesso_seq'),
	codigo_sucesso INT NOT NULL,
	mensagem_sucesso VARCHAR(200) NOT NULL,
	pertence_a VARCHAR(100) NOT NULL,
	quem_dispara VARCHAR(100) NOT NULL
);
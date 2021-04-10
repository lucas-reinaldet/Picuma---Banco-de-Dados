	
INSERT INTO mensagem_erro(codigo_erro, mensagem_erro, pertence_a, quem_dispara) 
	VALUES(1001, 'Parametro nome do cliente está vazio ou invalido', 'Função insert_cliente', 'Cadastro de cliente'),
		(1002, 'Parametro data de nascimento está vazio', 'Função insert_cliente', 'Cadastro de cliente'),
		(1003, 'Parametro de usuario do login está vazio ou invalido', 'Função insert_login', 'Cadastro de login'),
		(1004, 'Parametro de senha do login está vazio ou invalido', 'Função insert_login', 'Cadastro de login'),
		(1005, 'Parametro de genero de cliente invalido', 'Função insert_cliente', 'Cadastro de cliente'),
		(1006, 'Parametro de contato está vazio ou invalido', 'Função insert_contato', 'Cadastro de contato'),
		(1007, 'Parametro de id do tipo contato invalido', 'Função insert_contato', 'Cadastro de contato'),
		(1008, 'Falha ao obter o id do cliente', 'Função cadastrado_dados_cliente', 'Cadastro de cliente'),
		(1009, 'Quantidade de informações referentes a contato invalido', 'Função cadastrado_dados_cliente', 'Cadastro de cliente'),
		(1010, 'Retorno do id de contato invalido', 'Função cadastrado_dados_cliente', 'Cadastro de cliente'),
		(1011, 'Parametro de nome fantasia da empresa está vazio ou invalido', 'Função insert_empresa', 'Cadastro de empresa'),
		(1012, 'Falha ao cadastrar dados de cliente', 'Função cadastro_dados_cliente', 'Cadastro de cliente'),
		(1013, 'Parametro de login da empresa está vazio ou invalido', 'Função insert_empresa', 'Cadastro de empresa'),
		(1014, 'Parametro de senha da empresa está vazio ou invalido', 'Função insert_empresa', 'Cadastro de empresa'),
		(1015, 'Parametro de id da area de atuação da empresa invalido', 'Função insert_empresa', 'Cadastro de empresa'),
		(1016, 'Parametro de cep da empresa está vazio ou invalido', 'Função insert_endereco', 'Cadastro de empresa'),
		(1017, 'Parametro de logradouro da empresa está vazio', 'Função insert_endereco', 'Cadastro de empresa'),
		(1018, 'Parametro de numero do endereco da empresa está vazio', 'Função insert_endereco', 'Cadastro de empresa'),
		(1019, 'Parametro do bairro da empresa está vazio', 'Função insert_endereco', 'Cadastro de empresa'),
		(1020, 'Parametro de cidade da empresa está vazio', 'Função insert_endereco', 'Cadastro de empresa'),
		(1021, 'Parametro do estado onde a empresa se localiza está vazio ou invalido', 'função insert_endereco', 'Cadastro de empresa'),
		(1022, 'Parametro do id da empresa invalido', 'Função insert_endereco', 'Cadastro de empresa'),
		(1023, 'Retorno de id da empresa está vazio', 'Função cadastro_dados_empresa', 'Cadastro de empresa'),
		(1024, 'Quantidade de informações referentes a contato invalido', 'Função cadastrado_dados_empresa', 'Cadastro de empresa'),
		(1025, 'Retorno do id de contato invalido', 'Função cadastrado_dados_empresa', 'Cadastro de empresa'),
		(1026, 'Falha ao cadastrar dados de empresa', 'Função cadastro_dados_empresa', 'Cadastro de empresa'),
		(1027, 'Falha ao associar empresa ao genero de atendimento', 'Função cadastro_dados_empresa', 'Cadastro de empresa'),
		(1028, 'Parametro do inicio do expediente invalido', 'Função insert_horario_empresa', 'Cadastro de empresa'),
		(1029, 'Parametro do fim do expediente invalido', 'Função insert_horario_empresa', 'Cadastro de empresa'),
		(1030, 'Parametro de id do dia da semana invalido', 'Função insert_horario_empresa', 'Cadastro de empresa'),
		(1031, 'Parametro de id da empresa invalido', 'Função insert_horario_empresa', 'Cadastro de empresa'),
		(1032, 'Falha ao cadastrar horario da empresa', 'Função insert_horario_empresa', 'Cadastro de empresa'),
		(1033, 'Paramentro referente a genero invalido ou vazio', 'Função cadastrado_dados_empresa', 'Cadastro de empresa'),
		(1034, 'Quantidade de informações referentes a horario da empresa invalido', 'Função cadastrado_dados_empresa', 'Cadastro de empresa'),
		(1035, 'Falha ao cadastrar horario de funcionamento da empresa', 'Função cadastrado_dados_empresa', 'Cadastro de empresa'),
		(1036, 'Parametros de id_cliente e id_empresa estao vazio ou invalidos', 'Funcao insert_login', 'cadastro de dados de cliente'),
		(1037, 'Login do cliente nao foi cadastrado com sucesso', 'Funcao insert_login', 'Cadastro de dados de cliente'),
		(1038, 'Login da empresa nao foi cadastrado com sucesso', 'Funcao insert_login', 'Cadastro de dados de empresa'),
		(1039, 'Cadastro de login retornou nulo', 'funcao insert login', 'funcao inter login'),
		(1040, 'Paramentros v_id_cliente e v_id_empresa estao nulos', 'Funcao realizar_login', 'RealizarLogin no WebService'),
		(1041, 'Parametro de genero de empresa invalido', 'Função insert_empresa', 'Cadastro de empresa'),
		(1041, 'Parametro de id endereco invalido', 'Função insert_empresa', 'Cadastro de empresa'),
		(1042, 'Parametro de latitude de endereço vazio', 'Função insert_endereco', 'Cadastro empresa'),
		(1043, 'Parametro de longitute de endereço vazio', 'Função insert_endereco', 'Cadastro empresa'),
		(1044, 'Parametro de cpf ou cnpj de empresa vazios', 'Função insert_empresa', 'Cadastro empresa'),
		(1045, 'Parametro de contato vazio ou invalido', 'Função cadastro_contato_empresa', 'Cadastro de contato'),
		(1046, 'Parametro de tipo contato vazio ou invalido', 'Função cadastro_contato_empresa', 'Cadastro de contato'),
		(1047, 'Parametro de id de empresa vazio ou invalido', 'Função cadastro_contato_empresa', 'Cadastro de contato'),
		(1048, 'retorno de id de contato vazio', 'Função cadastro_contato_empresa', 'Cadastro de contato');
		(1049, 'Parametro de cadastro de horario empresa invalido', 'Função cadastro horario empresa', 'Cadastro de horario');
		(1050, 'Parametro de id emrpesa vazio ou invalido', 'Função cadastro horario empresa', 'Cadastro de horario');
		(1051, 'Parametro de grupo servico está vazio', 'Função cadastro foto galeria', 'Cadastro de foto'),
		(1052, 'Parametro de id de grupo servico invalido', 'Função cadastro foto galeria', 'Cadastro de foto'),
		(1053, 'Parametro do id empresa invalido', 'Função cadastro foto empresa', 'Cadastro de foto'),
		(1054, 'Falha ao cadastrar galeria', 'Função cadastro foto empresa', 'Cadastro de foto'),
		(1055, 'Parametro de fotos antes e depois vazios', 'Função cadastro foto empresa', 'Cadastro de foto'),
		(1056, 'Falha ao cadastrar fotos da galeria', 'Função cadastro foto empresa', 'Cadastro de foto'),
		(1057, 'Parametro de id foto vazio', 'Função delete foto galeria empresa', 'Deletar foto de galeria'),
		(1058, 'Retorno de id galeria vazio', 'Função delete foto galeria empresa', 'Deletar foto de galeria'),
		(1059, 'Parametro de id empresa está vazio', 'Função desativar funcionario empresa', 'Desativar Funcionario'),


INSERT INTO mensagem_sucesso VALUE(codigo_sucesso, mensagem_sucesso, pertence_a, quem_dispara) 
	VALUES(3001, 'Cliente cadastrado com sucesso', 'Função cadastro_dados_cliente', 'Cadastro de cliente'),
		(3002, 'Endereço da empresa cadastrado com sucesso', 'Função insert_endereco', 'Cadastro de endereço'),
		(3003, 'Dados da empresa cadastrado com sucesso', 'Função cadastro_dados_empresa', 'Cadastro de empresa'),
		(3004, 'Cadastro de horario de funcionamento da empresa cadastrado com sucesso', 'Função cadastro_horario_empresa', 'Cadastro de empresa'),
		(3005, 'Cadastro de login efetuado com sucesso', 'funcao insert_login', 'Cadastro de Cliente ou Empresa'),
		(3006, 'Cadastro de contato da empresa efetuado com sucesso', 'Função cadastro de contato empresa', 'Cadastro de contato'),
		(3007, 'Cadastro de horario da empresa efetuado com sucesso', 'Função cadastro de horario empresa', 'Cadastro de horario'),
		(3008, 'Cadastro de fotos de empresa efetuado com sucesso', 'Função cadastro foto empresa', 'Cadastro de foto'),
		(3009, 'Foto da galeria excluida com sucesso', 'Função delete foto galeria', 'Deletar foto de galeria'),
		(1010, 'Funcionario desativado com sucesso', 'Função desativar funcionario empresa', 'Desativar funcionario'),
);
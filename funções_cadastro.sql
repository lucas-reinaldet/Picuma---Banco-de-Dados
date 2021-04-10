testes

select * from cadastro_dados_cliente('Lucas Medeiros', '30/01/1994', null, 'llucasm312', 'senhaaa1', null, null, 1, array['444444','1','qqqqqqqq','2','hhhhhh', '3']);
select * from cadastro_dados_empresa('ughuygbuhu', null, null, null, 'p_logi2262n VARCHAR', 'p_senha VARCHAR',null, null, 1, array['444444','1','qqqqqqqq','2','hhhhhh', '3'], '85859318', 'p_logradouro VARCHAR', null, '1232', 'p_bairro VARCHAR',  'p_cidade VARCHAR', 'SP', array[1,2])
select * from cadastro_dados_empresa('ughuygbuhu', null, null, null, 'p_logsid2262n VARCHAR', 
                                     'p_senha VARCHAR',null, null, 1, array['444444','1','qqqqqqqq','2','hhhhhh', '3'], 
                                     '85859318', 'p_logradouro VARCHAR', null, '1232', 'p_bairro VARCHAR',  'p_cidade VARCHAR', 'SP', array[1,2],
                                     array['12:00:00','12:00:00','12:00:00','12:00:00', '1', '12:00:00','12:00:00','12:00:00','12:00:00', '2'])



funções


CREATE OR REPLACE FUNCTION cadastro_dados_cliente(p_nome VARCHAR, p_nascimento DATE, p_cpf_cliente VARCHAR,
												 p_foto BYTEA, p_genero VARCHAR,  p_dados_contato VARCHAR[], p_usuario VARCHAR,
												 p_senha VARCHAR, p_login_google VARCHAR) RETURNS INT AS $$
                    
DECLARE v_id_cliente INT;
		v_id_contato INT;
        v_controle_contato INT;
        v_contato VARCHAR[2];
        v_loop INT;
        v_resultado BOOLEAN;
        v_resultado_login INT;
BEGIN

	v_resultado = false;

	v_id_cliente = (SELECT * FROM insert_cliente(p_nome, p_nascimento, p_cpf_cliente, p_foto, p_genero));

	IF (v_id_cliente IS NOT NULL) THEN    
    	IF (array_length(p_dados_contato, 1) % 2 = 0) THEN
	    	v_resultado_login = (SELECT * FROM insert_login(p_usuario, p_senha, p_login_google, v_id_cliente, NULL));
	        	
	        IF (v_resultado_login > 0) THEN

		        v_controle_contato = 1;            
		            
		        WHILE (v_controle_contato < array_length(p_dados_contato, 1)) LOOP
		            	
		                v_loop = 1;
		            	FOR v_loop IN v_loop..2 LOOP
		                
		                	v_contato[v_loop] = p_dados_contato[v_controle_contato];
		                    
		                    v_controle_contato = v_controle_contato + 1;
		                
		                END LOOP;
		                
		                v_id_contato = (SELECT * FROM insert_contato(v_contato[1], v_contato[2]));
		                
		                IF (v_id_contato IS NOT NULL) THEN
		                
		                	INSERT INTO cliente_contato(id_cliente, id_contato) VALUES (v_id_cliente, v_id_contato);

		                	v_resultado = true;
		                
		                ELSE
		                	RAISE EXCEPTION '1010';
		                END IF;           
		        END LOOP;	        

	            IF (v_resultado) THEN
	            
	           		RETURN v_id_cliente;

	           	ELSE
            		RAISE EXCEPTION '1037';
           		END IF; 

            ELSE
            	RAISE EXCEPTION '1012';
           	END IF;            
        ELSE
        	RAISE EXCEPTION '1009';
        END IF;
    ELSE
    	RAISE EXCEPTION '1008';
    END IF;
END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cadastro_dados_empresa(p_nome VARCHAR, p_cnpj VARCHAR, p_cpf VARCHAR, p_descricao VARCHAR, p_logo BYTEA, p_id_area_atuacao INT, p_dados_contato VARCHAR[],
                                          p_cep VARCHAR, p_logradouro VARCHAR, p_complemento VARCHAR, p_numero VARCHAR, p_bairro VARCHAR,
                                          p_cidade VARCHAR, p_estado VARCHAR, p_latitude FLOAT, p_longitude FLOAT,
                                          p_genero VARCHAR, p_dados_horario VARCHAR[],
                                          p_usuario VARCHAR, p_senha VARCHAR, p_login_google VARCHAR) RETURNS INT AS $$

DECLARE v_id_empresa INT;
		v_id_contato INT;
        v_retorno_endereco INT;
        v_controle_contato INT;
        v_contato VARCHAR[2];
        v_loop INT;
        v_controle_horario INT;
        v_horario VARCHAR[5];
        v_resultado_horario INT;
        v_verificacao_horario BOOLEAN;
        v_resultado_login INT;
BEGIN

	v_retorno_endereco = (SELECT * FROM insert_endereco(p_cep, p_logradouro, p_complemento, p_numero, p_bairro, p_cidade, p_estado, p_latitude, p_longitude));

	IF (v_retorno_endereco > 0) THEN

		v_id_empresa = (SELECT * FROM insert_empresa(p_nome, p_cnpj, p_cpf, p_descricao, p_logo, p_genero, p_id_area_atuacao, v_retorno_endereco));

		IF (v_id_empresa IS NOT NULL) THEN

			v_resultado_login = (SELECT * FROM insert_login(p_usuario, p_senha, p_login_google, NULL, v_id_empresa));

		    IF (v_resultado_login > 0) THEN	
		    	
		    	IF (array_length(p_dados_contato, 1) % 2 = 0) THEN
	    			IF (array_length(p_dados_horario, 1) % 5 = 0) THEN

			        	v_controle_contato = 1;            
			            
			            WHILE (v_controle_contato < array_length(p_dados_contato, 1)) LOOP
			            	
			                v_loop = 1;
			            	FOR v_loop IN v_loop..2 LOOP
			                
			                	v_contato[v_loop] = p_dados_contato[v_controle_contato];
			                    
			                    v_controle_contato = v_controle_contato + 1;
			                
			                END LOOP;
			                
			                v_id_contato = (SELECT * FROM insert_contato(v_contato[1], v_contato[2]));
			                
			                IF (v_id_contato IS NOT NULL) THEN
			                
			                	INSERT INTO empresa_contato(id_empresa, id_contato) VALUES (v_id_empresa, v_id_contato);
			                END IF;         
			            END LOOP;

		                	v_controle_horario = 1;

		                	WHILE (v_controle_horario < array_length(p_dados_horario, 1)) LOOP

		                		v_verificacao_horario = false;
		            	
				                v_loop = 1;
				            	FOR v_loop IN v_loop..5 LOOP
				                
				                	v_horario[v_loop] = p_dados_horario[v_controle_horario];
				                    
				                    v_controle_horario = v_controle_horario + 1;
				                
				                END LOOP;
				                
				                v_resultado_horario = (SELECT * FROM insert_horario_empresa(v_horario[1],v_horario[2],v_horario[3],v_horario[4], v_horario[5]::INTEGER, v_id_empresa));

					                IF (v_resultado_horario = 3004) THEN
	                                
					                	v_verificacao_horario = true;

					                ELSE
					                	RAISE EXCEPTION '1035';
					                END IF;
				            END LOOP;

				            IF (v_verificacao_horario) THEN
		   
		                		RETURN v_id_empresa;

		                	END IF; 
			        ELSE
			        	RAISE EXCEPTION '1034';
			       	END IF;
		        ELSE
		        	RAISE EXCEPTION '1024';
		    	END IF; 
			ELSE
	    		RAISE EXCEPTION '1038';
	   		END IF;           
	    ELSE
	    	RAISE EXCEPTION '1023';
	    END IF;
    ELSE
    	RAISE EXCEPTION '1022';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION cadastro_contato_empresa(p_contato VARCHAR, p_tipo VARCHAR, p_id_empresa INT) RETURNS INT AS $$

DECLARE v_id_contato INT;

BEGIN
	IF (p_contato IS NOT NULL) THEN
		IF (p_tipo IS NOT NULL) THEN
			IF (p_id_empresa > 0) THEN

				INSERT INTO contato (contato, tipo_contato) VALUES (p_contato, p_tipo) RETURNING id_contato INTO v_id_contato;

				if (v_id_contato > 0) THEN
					INSERT INTO empresa_contato (id_empresa, id_contato) VALUES (p_id_empresa, v_id_contato);

					RETURN 3006;
				ELSE
					RAISE EXCEPTION '1048';
				END IF;
			ELSE
				RAISE EXCEPTION '1047';
			END IF;
		ELSE
			RAISE EXCEPTION '1046';
		END IF;
	ELSE
		RAISE EXCEPTION '1045';
	END IF;
END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cadastro_horario_empresa(p_horarios VARCHAR[], p_id_empresa INT) RETURNS INT AS $$

DECLARE v_verificacao INT;
BEGIN
	IF (array_length(p_horarios, 1) % 5 = 0) THEN
		IF (p_id_empresa > 0) THEN
            v_verificacao = (SELECT * FROM insert_horario_empresa(p_horarios[1],p_horarios[2],p_horarios[3],p_horarios[4], p_horarios[5]::INTEGER, p_id_empresa));
            
            IF (v_verificacao = 3004) THEN
            RETURN 3007;
            ELSE 
            	RAISE EXCEPTION '1051';
            END IF;
        ELSE 
 			RAISE EXCEPTION '1050';
 		END IF;
 	ELSE
 		RAISE EXCEPTION '1049';
 	END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION cadastro_foto_galeria(p_id_empresa INT, p_id_grupo_servico INT, p_foto_antes BYTEA, p_foto_depois BYTEA) RETURNS INT AS $$

DECLARE v_id_galeria INT;
		v_id_foto_galeria INT;
BEGIN
	IF (p_foto_antes IS NOT NULL AND p_foto_depois IS NOT NULL) THEN
			IF (p_id_grupo_servico > 0) THEN

				IF (p_id_empresa > 0) THEN

					v_id_galeria = (SELECT id_galeria FROM galeria WHERE id_grupo_servico = p_id_grupo_servico AND id_empresa = p_id_empresa);

					IF (v_id_galeria IS NULL OR v_id_galeria = 0) THEN
						INSERT INTO galeria (id_empresa, id_grupo_servico) VALUES (p_id_empresa, p_id_grupo_servico) RETURNING id_galeria INTO v_id_galeria;
					END IF;

					INSERT INTO foto_galeria (foto_antes_galeria, foto_depois_galeria, id_galeria) VALUES (p_foto_antes, p_foto_depois, v_id_galeria) RETURNING id_foto_galeria INTO v_id_foto_galeria;

					IF (v_id_foto_galeria > 0) THEN
						RETURN v_id_foto_galeria;
					ELSE
						RAISE EXCEPTION '1056';
					END IF;
				ELSE
					RAISE EXCEPTION '1053';
				END IF;
			ELSE
				RAISE EXCEPTION '1052';
			END IF;
	ELSE
		RAISE EXCEPTION '1055';
	END IF;
END;
$$ LANGUAGE plpgsql;
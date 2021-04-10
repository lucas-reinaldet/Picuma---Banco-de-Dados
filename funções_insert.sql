Testes

SELECT * FROM insert_cliente('Lucas Medeiros', '30/08/1994', null, null, '123456789', '123456789',null, null, 1, null);
SELECT * from insert_contato('Lucass', 1);
SELECT * FROM insert_empresa('hauhauahuah', 'uhahauha2u1h121', null, null,'loginnn122ns', 'senhaaa', 'null', null, 1)
select * from insert_endereco('12345678', 'rua x', null, 'p_numero', 'p_bairro', 'p_cidade', 'SP', 1);
select * from insert_horario_empresa('12:00:0000','12:00:0000','12:00:0000','12:00:0000', 1, 1);



Funções

CREATE OR REPLACE FUNCTION insert_login(p_usuario VARCHAR, p_senha VARCHAR, p_login_google VARCHAR, p_id_cliente INT, p_id_empresa INT)
 RETURNS INTEGER AS $$

DECLARE v_id_login INT;
BEGIN

    IF (p_id_cliente IS NOT NULL OR p_id_empresa IS NOT NULL) THEN
        IF (p_usuario IS NOT NULL) THEN
            IF (p_senha IS NOT NULL) THEN

                        INSERT INTO login(usuario, senha, login_google, id_cliente, id_empresa)
                        VALUES (p_usuario, p_senha, p_login_google, p_id_cliente, p_id_empresa) RETURNING id_login INTO v_id_login;

                        IF (v_id_login > 0) THEN
                            RETURN v_id_login;
                        ELSE
                            RAISE EXCEPTION '1039';
                        END IF;

            ELSE
                RAISE EXCEPTION '1004';
            END IF;
        ELSE
            RAISE EXCEPTION '1003';
        END IF;
    ELSE
        RAISE EXCEPTION '1036';
    END IF;    
END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_cliente(p_nome VARCHAR, p_nascimento DATE, p_cpf_cliente VARCHAR,
                    p_foto BYTEA, p_genero VARCHAR) RETURNS INTEGER AS $$

DECLARE v_id_cliente INT;
BEGIN

    IF (p_nome IS NOT NULL AND char_length(p_nome) > 5) THEN
        IF (p_nascimento IS NOT NULL) THEN
            IF (p_genero IS NOT NULL) THEN

                INSERT INTO cliente(nome_cliente, nascimento_cliente, cpf_cliente, foto_cliente, genero) 
                VALUES (p_nome, p_nascimento, p_cpf_cliente, p_foto, p_genero) RETURNING id_cliente INTO v_id_cliente;

                RETURN v_id_cliente;

            ELSE
                RAISE EXCEPTION '1005';
            END IF;
        ELSE
            RAISE EXCEPTION '1002';
        END IF;
    ELSE
        RAISE EXCEPTION '1001';
    END IF;
END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_contato(p_contato VARCHAR, p_tipo_contato VARCHAR) RETURNS INTEGER AS $$

DECLARE v_id_contato INT;
BEGIN
    IF (p_contato IS NOT NULL AND char_length(p_contato) > 5) THEN
        IF (p_tipo_contato IS NOT NULL AND char_length(p_tipo_contato) < 21) THEN
            
           INSERT INTO contato(contato, tipo_contato) VALUES (p_contato, p_tipo_contato) RETURNING id_contato INTO  v_id_contato;
            
            RETURN v_id_contato;
        ELSE
            RAISE EXCEPTION '1007';
        END IF;
    ELSE
        RAISE EXCEPTION '1006';
    END IF;
END;

$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION insert_empresa(p_nome VARCHAR, p_cnpj VARCHAR, p_cpf VARCHAR, p_descricao VARCHAR, p_logo BYTEA , 
    p_genero VARCHAR, p_id_area_atuacao INT, p_id_endereco INT) RETURNS INT AS $$

DECLARE v_id_empresa INT;
BEGIN
    
    IF (p_nome IS NOT NULL AND char_length(p_nome) > 5) THEN       
        IF (p_genero IS NOT NULL) THEN 
            IF (p_id_endereco > 0) THEN
                IF (p_id_area_atuacao > 0) THEN
                    IF (p_cnpj IS NOT NULL OR p_cpf IS NOT NULL) THEN
                    
                    INSERT INTO empresa(nome_fantasia, cnpj_empresa, cpf_empresa, descricao_empresa, logo_empresa, genero, id_area_atuacao, id_endereco)
                     VALUES (p_nome, p_cnpj, p_cpf, p_descricao, p_logo, p_genero, p_id_area_atuacao, p_id_endereco) RETURNING id_empresa INTO v_id_empresa;

                    RETURN v_id_empresa;

                    ELSE
                        RAISE EXCEPTION '1044';
                    END IF;
                ELSE
                    RAISE EXCEPTION '1015';
                END IF;
            ELSE
                RAISE EXCEPTION '1042';
            END IF;
        ELSE
            RAISE EXCEPTION '1041';
        END IF;             
    ELSE
        RAISE EXCEPTION '1011';
    END IF;
END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_endereco(p_cep VARCHAR, p_logradouro VARCHAR, p_complemento VARCHAR, p_numero VARCHAR, p_bairro VARCHAR,
                                          p_cidade VARCHAR, p_estado VARCHAR, p_latitude FLOAT, p_longitude FLOAT) RETURNS INT AS $$
DECLARE v_id_endereco INT; 

BEGIN
    IF(p_cep IS NOT NULL AND char_length(p_cep) = 8) THEN
        IF (p_logradouro IS NOT NULL) THEN
            IF (p_numero IS NOT NULL) THEN
                IF (p_bairro IS NOT NULL) THEN
                    IF (p_cidade IS NOT NULL) THEN
                        IF (p_estado IS NOT NULL AND char_length(p_estado) = 2) THEN
                            IF (p_latitude IS NOT NULL) THEN
                                IF (p_longitude IS NOT NULL) THEN
                                    INSERT INTO endereco(cep, logradouro, complemento, numero, bairro, cidade, estado, latitude, longitude)
                                     VALUES(p_cep,p_logradouro, p_complemento, p_numero, p_bairro, p_cidade, p_estado, p_latitude, p_longitude)
                                     RETURNING id_endereco INTO v_id_endereco;

                                    RETURN v_id_endereco; 
                                ELSE 
                                    RAISE EXCEPTION '1043';
                                END IF;
                            ELSE
                                RAISE EXCEPTION '1042';
                            END IF;
                        ELSE
                            RAISE EXCEPTION '1021';
                        END IF;
                    ELSE
                        RAISE EXCEPTION '1020';
                    END IF;
                ELSE
                    RAISE EXCEPTION '1019';
                END IF;
            ELSE
                RAISE EXCEPTION '1018';
            END IF;
        ELSE
            RAISE EXCEPTION '1017';
        END IF;
    ELSE
        RAISE EXCEPTION '1016';
    END IF;   
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION insert_horario_empresa(p_inicio_exp VARCHAR, p_inicio_inter VARCHAR, p_fim_inter VARCHAR, 
                                                  p_fim_exp VARCHAR, p_id_dia_semana INT, p_id_empresa INT) RETURNS INT AS $$

DECLARE v_id_horario_empresa INT;
BEGIN
    IF (p_inicio_exp IS NOT NULL) THEN
        IF (p_fim_exp IS NOT NULL) THEN
            IF (p_id_dia_semana IS NOT NULL) THEN
                IF (p_id_empresa > 0) THEN
                    
                    INSERT INTO horario_empresa(inicio_expediente, inicio_intervalo, fim_intervalo, fim_expediente, id_dia_semana, id_empresa)
                     VALUES (p_inicio_exp::TIMESTAMP, p_inicio_inter::TIMESTAMP, p_fim_inter::TIMESTAMP, p_fim_exp::TIMESTAMP, p_id_dia_semana, p_id_empresa) 
                     RETURNING id_horario_empresa INTO v_id_horario_empresa;
                    
                    IF (v_id_horario_empresa IS NOT NULL) THEN
                    
                        RETURN 3004;
                    ELSE
                        RAISE EXCEPTION '1032';
                    END IF;               
                ELSE
                    RAISE EXCEPTION '1031';
                END IF;
            ELSE
                RAISE EXCEPTION '1030';
            END IF;
        ELSE
            RAISE EXCEPTION '1029';
        END IF;
    ELSE
        RAISE EXCEPTION '1028';
    END IF;
END;

$$ LANGUAGE plpgsql;
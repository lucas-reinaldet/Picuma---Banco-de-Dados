
CREATE OR REPLACE FUNCTION delete_foto_galeria_empresa(p_id_foto INT) RETURNS INT AS $$

DECLARE v_verificacao INT;
		v_id_galeria INT;
BEGIN
	
	IF (p_id_foto IS NOT NULL) THEN

		v_id_galeria = (SELECT id_galeria FROM foto_galeria WHERE id_foto_galeria = p_id_foto);
		IF (v_id_galeria IS NOT NULL) THEN

			DELETE FROM foto_galeria WHERE id_foto_galeria = p_id_foto;

			v_verificacao = (SELECT id_foto_galeria FROM foto_galeria WHERE id_galeria = v_id_galeria LIMIT 1);

			IF (v_verificacao IS NULL) THEN
				DELETE FROM galeria WHERE id_galeria = v_id_galeria;
			END IF;

			RETURN 3009;
		ELSE
			RAISE EXCEPTION '1058';
		END IF;
	ELSE
		RAISE EXCEPTION '1057';
	END IF;
END;

$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION desativar_funcionario_empresa(p_id_funcionario INT) RETURNS INT AS $$

BEGIN
	IF (p_id_funcionario IS NOT NULL) THEN
    
    	UPDATE funcionario SET funcionario_ativo = false, desativado_em = now() WHERE id_funcionario = p_id_funcionario;
        DELETE FROM servico_prestado_funcionario WHERE id_funcionario = p_id_funcionario;
        
        RETURN 3010;
    ELSE
    	RAISE EXCEPTION '1059';
    END IF;
END;

$$ LANGUAGE plpgsql;
/*
PACKAGE
*/

CREATE OR REPLACE PACKAGE  PKG_TABELA AS

FUNCTION fn_pontuacao_equipe ( p_cod_equipe NUMBER, 
                              p_data_atual  DATE) 
  RETURN NUMBER ; 


FUNCTION fn_qtd_jogos_equipe ( p_cod_equipe NUMBER, 
                              p_data_atual  DATE) 
  RETURN NUMBER ; 


FUNCTION fn_vitoria_equipe ( p_cod_equipe NUMBER, 
                            p_data_atual  DATE) 
  RETURN NUMBER ; 


FUNCTION fn_empate_equipe ( p_cod_equipe NUMBER, 
                           p_data_atual  DATE) 
  RETURN NUMBER ; 


FUNCTION fn_derrota_equipe ( p_cod_equipe NUMBER, 
                            p_data_atual  DATE) 
  RETURN NUMBER ; 


FUNCTION fn_gol_pro_equipe ( p_cod_equipe NUMBER, 
                            p_data_atual  DATE) 
  RETURN NUMBER ; 


FUNCTION fn_gol_contra_equipe ( p_cod_equipe NUMBER, 
                               p_data_atual  DATE) 
  RETURN NUMBER ; 


FUNCTION fn_saldo_gol_equipe ( p_cod_equipe NUMBER, 
                              p_data_atual  DATE) 
  RETURN NUMBER ; 


FUNCTION fn_aproveitamento_equipe ( p_cod_equipe NUMBER, 
                                   p_data_atual  DATE) 
  RETURN NUMBER ;

end PKG_TABELA;
/


CREATE OR REPLACE PACKAGE BODY PKG_TABELA AS
  
/* 
Pontuação 
*/ 
 FUNCTION Fn_pontuacao_equipe ( p_cod_equipe NUMBER, 
                                                p_data_atual  DATE) 
  RETURN       NUMBER AS v_pontuacao NUMBER; 
  saldo_gols   NUMBER; 
  j_cod_equipe NUMBER; 
  BEGIN 
    v_pontuacao :=0; 
    FOR c_jogos IN 
    ( 
           SELECT * 
           FROM   jogo 
           WHERE  ( 
                         cod_equipe_mandante = p_cod_equipe 
                  OR     cod_equipe_visitante = p_cod_equipe) 
           AND    data <= p_data_atual ) 
    LOOP 
      saldo_gols := 0; 
      FOR c_gols IN 
      ( 
             SELECT * 
             FROM   gol 
             WHERE  cod_jogo = c_jogos.cod_jogo ) 
      LOOP 
        SELECT cod_equipe 
        INTO   j_cod_equipe 
        FROM   jogador 
        WHERE  c_gols.cod_jogador = cod_jogador; 
         
        IF j_cod_equipe = p_cod_equipe 
          AND 
          ( 
            c_gols.se_gol_contra = 'n' 
            OR 
            c_gols.se_gol_contra IS NULL 
          ) 
          THEN 
          saldo_gols := saldo_gols + 1; 
        ELSE 
          saldo_gols := saldo_gols - 1; 
        END IF; 
      END LOOP; 
      IF saldo_gols > 0 THEN 
        v_pontuacao := v_pontuacao + 3; 
      ELSE 
        IF saldo_gols = 0 THEN 
          v_pontuacao := v_pontuacao + 1; 
        END IF; 
      END IF; 
    END LOOP; 
    RETURN v_pontuacao; 
  END fn_pontuacao_equipe; 
  /* 
Jogos 
*/ 
  FUNCTION Fn_qtd_jogos_equipe ( p_cod_equipe NUMBER, 
                                                  p_data_atual  DATE) 
    RETURN NUMBER AS qtd_jogos NUMBER; 
    BEGIN 
      SELECT count (*) 
      INTO   qtd_jogos 
      FROM   jogo 
      WHERE  ( 
                    cod_equipe_mandante = p_cod_equipe 
             OR     cod_equipe_visitante = p_cod_equipe) 
      AND    data <= p_data_atual; 
       
      RETURN qtd_jogos; 
    END fn_qtd_jogos_equipe; 
    /* 
Vitórias 
*/ 
    FUNCTION Fn_vitoria_equipe ( p_cod_equipe NUMBER, 
                                                  p_data_atual  DATE) 
      RETURN       NUMBER AS v_vitorias NUMBER; 
      saldo_gols   NUMBER; 
      j_cod_equipe NUMBER; 
      BEGIN 
        v_vitorias :=0; 
        FOR c_jogos IN 
        ( 
               SELECT * 
               FROM   jogo 
               WHERE  ( 
                             cod_equipe_mandante = p_cod_equipe 
                      OR     cod_equipe_visitante = p_cod_equipe) 
               AND    data <= p_data_atual ) 
        LOOP 
          saldo_gols := 0; 
          FOR c_gols IN 
          ( 
                 SELECT * 
                 FROM   gol 
                 WHERE  cod_jogo = c_jogos.cod_jogo ) 
          LOOP 
            SELECT cod_equipe 
            INTO   j_cod_equipe 
            FROM   jogador 
            WHERE  c_gols.cod_jogador = cod_jogador; 
             
            IF j_cod_equipe = p_cod_equipe 
              AND 
              ( 
                c_gols.se_gol_contra = 'n' 
                OR 
                c_gols.se_gol_contra IS NULL 
              ) 
              THEN 
              saldo_gols := saldo_gols + 1; 
            ELSE 
              saldo_gols := saldo_gols - 1; 
            END IF; 
          END LOOP; 
          IF saldo_gols > 0 THEN 
            v_vitorias := v_vitorias + 1; 
          END IF; 
        END LOOP; 
        RETURN v_vitorias; 
      END fn_vitoria_equipe; 
      /* 
Empates 
*/ 
      FUNCTION Fn_empate_equipe ( p_cod_equipe NUMBER, 
                                                   p_data_atual  DATE) 
        RETURN       NUMBER AS v_empates NUMBER; 
        saldo_gols   NUMBER; 
        j_cod_equipe NUMBER; 
        BEGIN 
          v_empates :=0; 
          FOR c_jogos IN 
          ( 
                 SELECT * 
                 FROM   jogo 
                 WHERE  ( 
                               cod_equipe_mandante = p_cod_equipe 
                        OR     cod_equipe_visitante = p_cod_equipe) 
                 AND    data <= p_data_atual ) 
          LOOP 
            saldo_gols := 0; 
            FOR c_gols IN 
            ( 
                   SELECT * 
                   FROM   gol 
                   WHERE  cod_jogo = c_jogos.cod_jogo ) 
            LOOP 
              SELECT cod_equipe 
              INTO   j_cod_equipe 
              FROM   jogador 
              WHERE  c_gols.cod_jogador = cod_jogador; 
               
              IF j_cod_equipe = p_cod_equipe 
                AND 
                ( 
                  c_gols.se_gol_contra = 'n' 
                  OR 
                  c_gols.se_gol_contra IS NULL 
                ) 
                THEN 
                saldo_gols := saldo_gols + 1; 
              ELSE 
                saldo_gols := saldo_gols - 1; 
              END IF; 
            END LOOP; 
            IF saldo_gols = 0 THEN 
              v_empates := v_empates + 1; 
            END IF; 
          END LOOP; 
          RETURN v_empates; 
        END fn_empate_equipe; 
        /* 
Derrotas 
*/ 
        FUNCTION Fn_derrota_equipe ( p_cod_equipe NUMBER, 
                                                      p_data_atual  DATE) 
          RETURN       NUMBER AS v_derrotas NUMBER; 
          saldo_gols   NUMBER; 
          j_cod_equipe NUMBER; 
          BEGIN 
            v_derrotas :=0; 
            FOR c_jogos IN 
            ( 
                   SELECT * 
                   FROM   jogo 
                   WHERE  ( 
                                 cod_equipe_mandante = p_cod_equipe 
                          OR     cod_equipe_visitante = p_cod_equipe) 
                   AND    data <= p_data_atual ) 
            LOOP 
              saldo_gols := 0; 
              FOR c_gols IN 
              ( 
                     SELECT * 
                     FROM   gol 
                     WHERE  cod_jogo = c_jogos.cod_jogo ) 
              LOOP 
                SELECT cod_equipe 
                INTO   j_cod_equipe 
                FROM   jogador 
                WHERE  c_gols.cod_jogador = cod_jogador; 
                 
                IF j_cod_equipe = p_cod_equipe 
                  AND 
                  ( 
                    c_gols.se_gol_contra = 'n' 
                    OR 
                    c_gols.se_gol_contra IS NULL 
                  ) 
                  THEN 
                  saldo_gols := saldo_gols + 1; 
                ELSE 
                  saldo_gols := saldo_gols - 1; 
                END IF; 
              END LOOP; 
              IF saldo_gols < 0 THEN 
                v_derrotas := v_derrotas + 1; 
              END IF; 
            END LOOP; 
            RETURN v_derrotas; 
          END fn_derrota_equipe; 
          /* 
Gols Pró 
*/ 
          FUNCTION Fn_gol_pro_equipe ( p_cod_equipe NUMBER, 
                                                        p_data_atual  DATE) 
            RETURN                NUMBER AS gol_pro_total NUMBER; 
            gol_pro_total_parcial NUMBER; 
            j_cod_equipe          NUMBER; 
            BEGIN 
              gol_pro_total :=0; 
              FOR c_jogos IN 
              ( 
                     SELECT * 
                     FROM   jogo 
                     WHERE  ( 
                                   cod_equipe_mandante = p_cod_equipe 
                            OR     cod_equipe_visitante = p_cod_equipe) 
                     AND    data <= p_data_atual ) 
              LOOP 
                gol_pro_total_parcial := 0; 
                FOR c_gols IN 
                ( 
                       SELECT * 
                       FROM   gol 
                       WHERE  cod_jogo = c_jogos.cod_jogo ) 
                LOOP 
                  SELECT cod_equipe 
                  INTO   j_cod_equipe 
                  FROM   jogador 
                  WHERE  c_gols.cod_jogador = cod_jogador; 
                   
                  IF j_cod_equipe = p_cod_equipe 
                    AND 
                    ( 
                      c_gols.se_gol_contra = 'n' 
                      OR 
                      c_gols.se_gol_contra IS NULL 
                    ) 
                    THEN 
                    gol_pro_total_parcial := gol_pro_total_parcial + 1; 
                  END IF; 
                END LOOP; 
                gol_pro_total := gol_pro_total + gol_pro_total_parcial; 
              END LOOP; 
              RETURN gol_pro_total; 
            END fn_gol_pro_equipe; 
            /* 
Gols Contra 
*/ 
            FUNCTION Fn_gol_contra_equipe ( p_cod_equipe NUMBER, 
                                                             p_data_atual  DATE) 
              RETURN             NUMBER AS gol_contra_total NUMBER; 
              gol_contra_parcial NUMBER; 
              j_cod_equipe       NUMBER; 
              BEGIN 
                gol_contra_total :=0; 
                FOR c_jogos IN 
                ( 
                       SELECT * 
                       FROM   jogo 
                       WHERE  ( 
                                     cod_equipe_mandante = p_cod_equipe 
                              OR     cod_equipe_visitante = p_cod_equipe) 
                       AND    data <= p_data_atual ) 
                LOOP 
                  gol_contra_parcial := 0; 
                  FOR c_gols IN 
                  ( 
                         SELECT * 
                         FROM   gol 
                         WHERE  cod_jogo = c_jogos.cod_jogo ) 
                  LOOP 
                    SELECT cod_equipe 
                    INTO   j_cod_equipe 
                    FROM   jogador 
                    WHERE  c_gols.cod_jogador = cod_jogador; 
                     
                    IF (j_cod_equipe <> p_cod_equipe 
                      AND 
                      ( 
                        c_gols.se_gol_contra = 'n' 
                        OR 
                        c_gols.se_gol_contra IS NULL 
                      ) 
                      ) 
                      OR 
                      ( 
                        j_cod_equipe = p_cod_equipe 
                        AND 
                        c_gols.se_gol_contra = 's' 
                      ) 
                      THEN 
                      gol_contra_parcial := gol_contra_parcial + 1; 
                    END IF; 
                  END LOOP; 
                  gol_contra_total := gol_contra_total + gol_contra_parcial; 
                END LOOP; 
                RETURN gol_contra_total; 
              END fn_gol_contra_equipe; 
              /* 
Saldo de gols 
*/ 
              FUNCTION Fn_saldo_gol_equipe ( p_cod_equipe NUMBER, 
                                                              p_data_atual  DATE) 
                RETURN       NUMBER AS saldo_gols_total NUMBER; 
                saldo_gols   NUMBER; 
                j_cod_equipe NUMBER; 
                BEGIN 
                  saldo_gols_total :=0; 
                  FOR c_jogos IN 
                  ( 
                         SELECT * 
                         FROM   jogo 
                         WHERE  ( 
                                       cod_equipe_mandante = p_cod_equipe 
                                OR     cod_equipe_visitante = p_cod_equipe) 
                         AND    data <= p_data_atual ) 
                  LOOP 
                    saldo_gols := 0; 
                    FOR c_gols IN 
                    ( 
                           SELECT * 
                           FROM   gol 
                           WHERE  cod_jogo = c_jogos.cod_jogo ) 
                    LOOP 
                      SELECT cod_equipe 
                      INTO   j_cod_equipe 
                      FROM   jogador 
                      WHERE  c_gols.cod_jogador = cod_jogador; 
                       
                      IF j_cod_equipe = p_cod_equipe 
                        AND 
                        ( 
                          c_gols.se_gol_contra = 'n' 
                          OR 
                          c_gols.se_gol_contra IS NULL 
                        ) 
                        THEN 
                        saldo_gols := saldo_gols + 1; 
                      ELSE 
                        saldo_gols := saldo_gols - 1; 
                      END IF; 
                    END LOOP; 
                    saldo_gols_total := saldo_gols_total + saldo_gols; 
                  END LOOP; 
                  RETURN saldo_gols_total; 
                END fn_saldo_gol_equipe; 
                /* 
Aproveitamento 
*/ 
                FUNCTION Fn_aproveitamento_equipe ( p_cod_equipe NUMBER, 
                                                                     p_data_atual  DATE) 
                  RETURN           NUMBER AS v_pontuacao_equipe NUMBER; 
                  v_jogos_equipe   NUMBER; 
                  v_aproveitamento NUMBER; 
                  BEGIN 
                    SELECT Fn_pontuacao_equipe (p_cod_equipe, p_data_atual) 
                    INTO   v_pontuacao_equipe 
                    FROM   dual; 
                     
                    SELECT Fn_qtd_jogos_equipe (p_cod_equipe, p_data_atual) 
                    INTO   v_jogos_equipe 
                    FROM   dual; 
                     
                    v_aproveitamento := (v_pontuacao_equipe / (v_jogos_equipe* 3))* 100; 
                    SELECT Round (v_aproveitamento, 1) 
                    INTO   v_aproveitamento 
                    FROM   dual; 
                     
                    RETURN v_aproveitamento; 
                  END fn_aproveitamento_equipe;

END PKG_TABELA;
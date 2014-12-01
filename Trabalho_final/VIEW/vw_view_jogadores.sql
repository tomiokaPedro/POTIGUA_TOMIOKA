CREATE OR REPLACE VIEW VW_ANALISE_JOGADORES (Nome_jogador, gols, Nome_equipe, cartoes_amarelo, cartoes_vermelho) AS
SELECT
  J.NOME_JOGADOR,
  COUNT(cod_gol),
  E.nome_equipe,
  fn_cartoes_amarelo (j.cod_jogador),
  fn_cartoes_vermelho (j.cod_jogador)
FROM JOGADOR J
INNER JOIN EQUIPE E
  ON J.COD_EQUIPE = E.COD_EQUIPE
LEFT JOIN GOL G
  ON G.COD_JOGADOR = J.COD_JOGADOR
GROUP BY J.NOME_JOGADOR,
         Nome_equipe, fn_cartoes_amarelo (j.cod_jogador),
  fn_cartoes_vermelho (j.cod_jogador);
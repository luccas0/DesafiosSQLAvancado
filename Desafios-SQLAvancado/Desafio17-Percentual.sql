SELECT
VS.TAMANHO, VS.ANO, VS.VENDA_ANO,
ROUND((CONVERT( FLOAT, VS.VENDA_ANO) / CONVERT( FLOAT, VA.VENDA_TOTAL_ANO)) * 100, 2) AS PERCENTUAL
FROM 
(
SELECT
P.TAMANHO
,YEAR(N.DATA_VENDA) AS ANO
,SUM(I.QUANTIDADE) AS VENDA_ANO
FROM TABELA_DE_PRODUTOS P
INNER JOIN ITENS_NOTAS_FISCAIS I
ON P.CODIGO_DO_PRODUTO = I.CODIGO_DO_PRODUTO
INNER JOIN NOTAS_FISCAIS N
ON I.NUMERO = N.NUMERO
WHERE YEAR(N.DATA_VENDA) = 2016
GROUP BY P.TAMANHO, YEAR(N.DATA_VENDA)
) VS
INNER JOIN
(
SELECT 
YEAR(N.DATA_VENDA) AS ANO
, SUM(I.QUANTIDADE) AS VENDA_TOTAL_ANO
FROM NOTAS_FISCAIS N
INNER JOIN ITENS_NOTAS_FISCAIS I
ON N.NUMERO = I.NUMERO
WHERE YEAR(N.DATA_VENDA) = 2016
GROUP BY YEAR(N.DATA_VENDA)
) VA
ON VS.ANO = VA.ANO
ORDER BY VS.VENDA_ANO DESC;
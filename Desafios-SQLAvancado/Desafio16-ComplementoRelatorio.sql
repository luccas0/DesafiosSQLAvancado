SELECT 
C.CPF, C.NOME, C.VOLUME_DE_COMPRA, TV.MES_ANO, TV.QUANTIDADE_TOTAL, 
(CASE WHEN C.VOLUME_DE_COMPRA >= TV.QUANTIDADE_TOTAL THEN 'VENDAS V�LIDAS' 
ELSE 'VENDAS INV�LIDAS' END) AS RESULTADO, 
ROUND((1-(C.VOLUME_DE_COMPRA/TV.QUANTIDADE_TOTAL)) * 100, 2) AS PERCENTUAL
FROM TABELA_DE_CLIENTES C 
INNER JOIN (
    SELECT N.CPF, 
    CONVERT(VARCHAR(7), N.DATA_VENDA, 120) AS MES_ANO, 
    SUM(I.QUANTIDADE) AS QUANTIDADE_TOTAL 
    FROM NOTAS_FISCAIS N 
    INNER JOIN ITENS_NOTAS_FISCAIS I 
    ON N.NUMERO = I.NUMERO 
    GROUP BY N.CPF, CONVERT(VARCHAR(7), N.DATA_VENDA, 120)
) TV
ON TV.CPF = C.CPF 
WHERE TV.MES_ANO = '2015-01'
AND
(C.VOLUME_DE_COMPRA - TV.QUANTIDADE_TOTAL) < 0;
SELECT NOME, LIMITE_DE_CREDITO, (CASE WHEN LIMITE_DE_CREDITO >= 150000 THEN 'Clientes Grandes' 
WHEN LIMITE_DE_CREDITO < 150000 AND LIMITE_DE_CREDITO >=  110000 THEN 'Clientes m�dios'
ELSE 'Clientes pequenos' END) AS CLASSIFICACAO FROM TABELA_DE_CLIENTES;
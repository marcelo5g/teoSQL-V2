# SQL - TeoMeWhy
[TeoMeWhy](https://www.twitch.tv/teomewhy).	

SQL - Structured Query Language

Linguagem de consulta de dados

## Banco de dados

RDBMS - Relational Data Base Manegement System		
SGBDR - Sistema de Gerenciamento de Banco de Dados Relacional

Tabela - Organização em Linhas e Colunas		
Row - Entidade	 
Column - Campos / Características	
Obs: Primeira linha é o nome do campo, não conta como linha

### Join
- Juntar Tabelas (Similar a relacionar abas de uma planilha Excel com o PROCV) usando algum campo (em comum entre as diferentes tabelas) como **`chave`** (Normalmente o ID)


### Exemplos de Query:
Buscar categoria `bebes` OU `perfumaria` 	
Ambas acima de 1 foto	

```SQL
SELECT product_id,
      product_category_name,
      product_photos_qty

from tb_products

WHERE ( product_category_name = 'bebes'
    or product_category_name = 'perfumaria')
AND product_photos_qty > 1


```

Query Combinada:	
bebes acima de 1 foto	
OU	
perfumaria acima de 5 fotos


```SQL
SELECT t1.product_id,
      t1.product_category_name,
      t1.product_photos_qty

from tb_products as t1

WHERE ( t1.product_category_name = 'bebes'
       and t1.product_photos_qty > 1 )
or  ( t1.product_category_name = 'perfumaria'
    AND product_photos_qty > 5 )

```



### Dicas:

- Última linha da query, posso limitar a quantidade de resultados quando a tabela for muito grande com o comando:	
`limit 10`

 - Contar quantas linhas foram retornadas dando o "apelido" `qtde_itens`:
```
SELECT count(*) as qtde_itens
```


 - Dada a possibilidade de repetição de ID's, posso pedir somente os dados únicos com o DISTINCT
```
SELECT count(DISTINCT product_id)
```

 - Exemplo de Análise Exploratória 
```SQL
SELECT 
    count(*) as qtde_linhas,
    count(product_id) as qtde_produtos,
    count(DISTINCT product_id) as qtde_produtos_distintos,
    count(DISTINCT product_category_name) as qtde_categorias
    
FROM tb_products
```

 - Fazer o cálculo de Volume e jogar resultado numa nova coluna

```SQL
SELECT *,
    product_length_cm *	product_height_cm *	product_width_cm / 1000 as product_volume
    
FROM tb_products
```


 - Criar a Nova Coluna na 2º posição e não na última:

```SQL
SELECT 

product_id,
product_length_cm *product_height_cm * product_width_cm / 1000000 as product_volume_m3,
product_category_name,
product_name_lenght,
product_description_lenght,
product_photos_qty,
product_weight_g,
product_length_cm,
product_height_cm,
product_width_cm
    
FROM tb_products
```


## GROUP BY

- Agrupar (Agregação) por categoria, calculando mín, max e média e ainda contar quantas ocorrências de cada categoria

**PRIMEIRO FILTRA DEPOIS AGRUPA** - `GROUP BY` sempre vem por último

```SQL
SELECT
        product_category_name,
        count (*) as qtde_produtos,
        max(product_weight_g) as maior_peso,
        min(product_weight_g) as menor_peso,
        avg(product_weight_g) as avg_peso

from tb_products

-- retira valores nulos, DEVE vir antes do GROUP BY
WHERE product_category_name is not NULL

GROUP BY product_category_name
```


- Quantos vendedores tem em cada Estado?

```SQL
SELECT 
    seller_state,
    count(*) as qtde_vendedores

from tb_sellers

GROUP BY seller_state
```

 - Para selecionar somente alguns poderia ser também:
```
where sellers_state IN ('SP', 'RJ', 'PR')
```


 - Sub-query (Fazer uma query em cima de uma outra query). 	
**Deve ser evitado fazer isso dessa forma**
```SQL
SELECT *

FROM (
    SELECT 
        seller_state,
        count(*) as qtde_vendedores

    from tb_sellers

    GROUP BY seller_state
)

WHERE qtde_vendedores > 10
```

- Para não usar Sub-query, a melhor opção é usar o HAVING

```SQL
SELECT 
    seller_state,
    count(*) as qtde_vendedores

from tb_sellers

GROUP BY seller_state

HAVING count(*) > 10
```

 - GROUP BY pode ser acompanhado do HAVING (Novo filtro em cima da query agrupada) e do ORDER BY (Ordenar valores por alguma coluna)

```SQL
SELECT
        product_category_name,        
        max(product_name_lenght) as maior_nome,
        min(product_name_lenght) as menor_nome,
        avg(product_name_lenght) as avg_nome

from tb_products

WHERE product_description_lenght > 100

GROUP BY product_category_name

HAVING avg(product_description_lenght) > 500

ORDER BY avg(product_name_lenght) desc 
	
```

 - Posso colocar `desc` depois da coluna do ORDER BY para ordenar de forma DESCRESCENTE 		

 - Posso colocar 2 instruções de ordenação: Ordena pela primeira, e se der empate, ordena os empatados pela segunda:

```
ORDER BY min(product_name_lenght) desc,
		 max(product_name_lenght) asc	
```



## CASE WHEN, COALESCE, LIKE, IN

### Discussão Baixo-Nível: 
> Diferente de Linguagens de Programação convencionais, que vão executando linha por linha, o SQL executa tudo de uma vez por meio no PLANO DA EXECUÇÃO		

> Quando faço uma cláusula SQL com alguma instrução, o Banco de Dados gera um PLANO DA EXECUÇÃO DO SQL para atender a Query (Consulta) da melhor forma possível



 - WHEN WHEN

 - Lembrando que o CASE WHEN gera **APENAS UMA VARIÁVEL / COLUNA** ao final da Query
```SQL

SELECT 
        DISTINCT CASE WHEN product_category_name IS NULL THEN  'outros'
        
                      WHEN product_category_name = 'alimentos' 
                           OR product_category_name = 'alimentos_bebidas' THEN 'alimentos'

                      WHEN product_category_name IN ('artes', 'artes_e_artesanato') THEN 'artes'

                      WHEN product_category_name LIKE '%artigos%' THEN 'artigos'

                      ELSE product_category_name 
                 END AS categoria_fillna

FROM tb_products
	
```

  - Like %artigos% significa "CONTÉM" a palavra artigos dentro da string


### COALESCE - Verdadeiro Poder

- Permite pesquisar na lista de telefones e selecionar o primeiro não nulo (o mais provável) e colocar na variável melhor_tel. Caso todos estejam nulos, substituir por Zero 

```SQL
SELECT 
	tel1,
	tel2,
	cel1,
	cel2,
	COALESCE (cel1, cel2, tel1, tel2, 0) as melhor_tel

FROM contatos	
```




## JOIN

 - Selecionar tudo da t1 e somente uma coluna (category) da coluna t2


```SQL
	 SELECT t1.*,
        t2.product_category_name

 FROM tb_order_items as t1

 LEFT JOIN tb_products as t2
 on t1.product_id = t2.product_id

```


```
	
```

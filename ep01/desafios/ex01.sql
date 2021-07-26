-- Ex1:  Quantos produtos temos da categoria 'artes'?

-- conta quantas linhas foram retornadas
SELECT 
    count(*) as qtde_linhas,
    count(product_id) as qtde_produtos,
    count(DISTINCT product_id) as qtde_produtos_distintos,
    count(DISTINCT product_category_name) as qtde_categorias
    
FROM tb_products

WHERE product_category_name = 'artes' 
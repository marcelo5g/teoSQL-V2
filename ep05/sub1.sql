-- Achar a receita por estado do seller, por produto da categoria mais vendida



-- Exemplo de resolução SEM Subquery (tenho que alterar manualmente)
-- Essa forma é mais rápida porém manual
SELECT
        t2.seller_state,
        t1.product_id,
        sum(t1.price) as receita_total

FROM tb_order_items as t1

LEFT JOIN tb_sellers as t2
on t1.seller_id = t2.seller_id

LEFT JOIN tb_products as t3
on t1.product_id = t3.product_id


-- Para saber qual categoria precisei fazer a Nova Query e jogar a categoria aqui
WHERE product_category_name = 'cama_mesa_banho'

GROUP BY t2.seller_state,
        t1.product_id


/*  Nova Query para saber a categoria mais vendida */ 
SELECT t2.product_category_name,
        count(*)

FROM tb_order_items as t1

LEFT JOIN tb_products as t2
ON t1.product_id = t2.product_id

GROUP BY t2.product_category_name
ORDER BY count(*) desc 

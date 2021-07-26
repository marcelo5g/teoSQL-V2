-- Achar a receita por estado do seller, por produto da categoria mais vendida

-- Versão 3 - left join

-- Exemplo de resolução COM Subquery 

SELECT
        t2.seller_state,
        t1.product_id,
        t3.product_category_name,
        sum(t1.price) as receita_total

FROM tb_order_items as t1

LEFT JOIN tb_sellers as t2
on t1.seller_id = t2.seller_id

LEFT JOIN tb_products as t3
on t1.product_id = t3.product_id


LEFT JOIN (
        
        SELECT t2.product_category_name,
                1 as flag_categoria
        FROM tb_order_items as t1
        LEFT JOIN tb_products as t2
        ON t1.product_id = t2.product_id
        GROUP BY t2.product_category_name
        ORDER BY count(*) desc 
        -- Devo colocar Limit 1 pois só quero a mais vendida
        LIMIT 3
) as t4
on t3.product_category_name = t4.product_category_name


WHERE t4.flag_categoria = 1

GROUP BY t2.seller_state,
         t1.product_id,
         t3.product_category_name




-- Achar a receita por estado do seller, por produto da categoria mais vendida
-- WITH - Algo como atribuir a uma variável (tabela virtual) o resultado de uma query (É bem mais eficiente para o Plano de Execução do Banco de Dados)
-- Usando o WITH, começa dando um nome para uma nova tabela, separa por vírgula e vai fatiando as queries
WITH tb_best_categoria AS (
       
        SELECT t2.product_category_name                
        FROM tb_order_items as t1
        LEFT JOIN tb_products as t2
        ON t1.product_id = t2.product_id
        GROUP BY t2.product_category_name
        ORDER BY count(*) desc         
        LIMIT 3
),

tb_receita_estado_produto as (

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

        GROUP BY t2.seller_state,
                t1.product_id,
                t3.product_category_name

)


SELECT *
FROM tb_receita_estado_produto as t1

INNER JOIN tb_best_categoria as t2
on t1.product_category_name = t2.product_category_name


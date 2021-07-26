-- Ex3. Faça uma query que apresente o tamanho médio, máximo e mínimo do nome do objeto por categoria. Considere apenas os objetos que tenham a descrição maior que 100.

SELECT
        product_category_name,        
        max(product_name_lenght) as maior_nome,
        min(product_name_lenght) as menor_nome,
        avg(product_name_lenght) as avg_nome

from tb_products

WHERE product_description_lenght > 100

GROUP BY product_category_name


-- Ex2. Faça uma query que apresente o tamanho médio, máximo e mínimo do nome do objeto por categoria

SELECT
        product_category_name,        
        max(product_name_lenght) as maior_nome,
        min(product_name_lenght) as menor_nome,
        avg(product_name_lenght) as avg_nome

from tb_products

GROUP BY product_category_name
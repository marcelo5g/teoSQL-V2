-- Ex1. Faça uma query que apresente o tamanho médio, máximo e mínimo da descrição do objeto por categoria

SELECT
        product_category_name,        
        max(product_description_lenght) as maior_description,
        min(product_description_lenght) as menor_description,
        avg(product_description_lenght) as avg_description

from tb_products

GROUP BY product_category_name

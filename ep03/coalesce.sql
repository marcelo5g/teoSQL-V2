-- coalesce é uma forma de substituir os nulos por 'outros'

SELECT DISTINCT coalesce(product_category_name, 'outros') as categoria_fillma

FROM tb_products

order by product_category_name 
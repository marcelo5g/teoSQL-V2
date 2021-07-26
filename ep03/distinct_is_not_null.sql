-- lista das categorias por ordem alfabética

SELECT DISTINCT product_category_name

FROM tb_products

WHERE product_category_name IS NOT NULL

order by product_category_name 
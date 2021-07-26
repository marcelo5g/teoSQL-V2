-- qual a receita de cada categoria de produto?
-- qual o total de vendas?
-- qual o total em unidades e em pedidos?



-- Selecione Tudo(*) da tabela tb_order_items, cruzando com a tb_products
-- usando product_id como chave primária (pk)
 SELECT t1.order_id,
        t1.order_item_id,
        t1.product_id,
        t2.product_category_name,
        t1.price

 FROM tb_order_items as t1

 LEFT JOIN tb_products as t2
 on t1.product_id = t2.product_id
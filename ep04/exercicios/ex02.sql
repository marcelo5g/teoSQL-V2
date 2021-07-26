-- Qual o valor total de receita gerada por sellers de cada estado?
-- Considere a base completa, com apenas pedidos entregues


SELECT t3.seller_state,
       sum(t2.price) as receita_total,
       sum(t2.price) / count(DISTINCT t2.seller_id) as avg_receita_seller,
       count(DISTINCT t2.seller_id) as qtde_sellers

FROM tb_orders as t1


-- Todos itens da tabela de venda e cruza com item pedido
LEFT JOIN tb_order_items as t2
on t1.order_id = t2.order_id

LEFT JOIN tb_sellers as t3
on t2.seller_id = t3.seller_id

WHERE t1.order_status = 'delivered'

GROUP BY t3.seller_state

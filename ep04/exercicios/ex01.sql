-- Qual o valor total de receita gerada por clientes de cada estado? (receita media por estado)
-- Considere a base completa, com apenas pedidos entregues


SELECT t2.customer_state,
       sum(t3.price) / count(DISTINCT t1.customer_id) AS avg_receita_cliente
       
       

from tb_orders as t1

LEFT JOIN tb_customers as t2
on t1.customer_id = t2.customer_id

LEFT JOIN tb_order_items as t3
ON t1.order_id = t3.order_id

WHERE t1.order_status = 'delivered'

GROUP BY t2.customer_state

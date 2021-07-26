-- Quantos vendedores tem em cada Estado?
SELECT 
    seller_state,
    count(*) as qtde_vendedores

from tb_sellers

-- filtro pré agg (agregação)
WHERE seller_state in ('SP', 'RJ', 'PR', 'AC')

GROUP BY seller_state


-- HAVING deve vir DEPOIS do GROUP BY
-- filtro pós agg (agregação)
HAVING count(*) > 10


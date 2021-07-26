-- Quantos vendedores tem em cada Estado?

SELECT *

FROM (

    SELECT 
        seller_state,
        count(*) as qtde_vendedores

    from tb_sellers

    GROUP BY seller_state

)

WHERE qtde_vendedores > 10
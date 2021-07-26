SELECT t1.product_id,
      t1.product_category_name,
      t1.product_photos_qty

from tb_products as t1

WHERE ( t1.product_category_name = 'bebes'
       and t1.product_photos_qty > 1 )
or  ( t1.product_category_name = 'perfumaria'
    AND product_photos_qty > 5 )



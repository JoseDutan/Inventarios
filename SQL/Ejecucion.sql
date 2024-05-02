select prov.identificador, prov.tipo_de_documento, td.descripcion, prov.nombre, prov.telefono, prov.correo, prov.direccion 
from proveedores prov, tipo_de_documentos td
where prov.tipo_de_documento = td.codigo
and upper(nombre) like'%S%'

select codigo, descripcion from tipo_de_documentos

select prod.codigo_pro, prod.nombre as nombre_producto, 
udm.codigo_udm, udm.descripcion as descripcion_udm, 
cast(prod.precio_de_venta as decimal(9,2)), prod.tiene_iva, 
cast(prod.coste as decimal(9,2)), prod.categoria_cat, 
cat.nombre as nombre_categoria, prod.stock
from productos prod, unidades_medida udm, categorias cat
where prod.udm = udm.codigo_udm
and prod.categoria_cat = cat.codigo_cat
and upper(prod.nombre) like '%M%'

update productos set nombre = ?, udm = ?, precio_de_venta = ?, tiene_iva = ?, coste ?, categoria_cat = ?, stock = ? where codigo_pro =?

update cabecera_pedido set estado where numero=6
update detalle_pedido set cantidad_recibida = 0, subtotal= 0 where codigo=4

select cp.proveedor, dp.cabecera_pedido, dp.producto, dp.cantidad_solicitada, dp.subtotal, dp.cantidad_recibida 
from cabecera_pedido cp, detalle_pedido dp
where  cp.proveedor = dp.cabecera_pedido

select pro.identificador, pro.nombre, pro.telefono, pro.correo, pro.direccion, td.codigo, td.descripcion AS descipcion_doc, cp.numero, cp.fecha, cp.estado, ep.descripcion AS descripcion_estado 
from proveedores pro, cabecera_pedido cp, estados_pedido ep, tipo_de_documentos td 
Where cp.proveedor = pro.identificador 
AND ep.codigo = cp.estado 
AND td.codigo = pro.tipo_de_documento 
AND cp.proveedor = '1792285747001'

select dt.codigo AS codigo_detalle , dt.cabecera_pedido, pro.codigo_pro, pro.nombre, 
udm.codigo_udm, udm.descripcion AS descripcion_udm, udm.categoria_udm, cast(pro.precio_de_venta as decimal(6,2)), 
pro.tiene_iva, cast(pro.coste as decimal(5,4)), pro.categoria_cat, c.nombre As nombre_categoria, pro.stock, 
dt.cantidad_solicitada, cast(dt.subtotal as decimal(10,4)), dt.cantidad_recibida 
from detalle_pedido dt, productos pro, categorias c, unidades_medida udm 
Where dt.producto = pro.codigo_pro 
AND pro.categoria_cat = c.codigo_cat 
AND pro.udm = udm.codigo_udm 
AND dt.cabecera_pedido= '6'

select pro.identificador, pro.tipo_de_documento, td.descripcion, pro.nombre, pro.telefono, pro.correo, pro.direccion from proveedores pro, tipo_de_documentos td
Where pro.tipo_de_documento = td.codigo
AND identificador = '0302578166'


select pro.codigo_pro, pro.nombre, udm.codigo_udm, udm.descripcion AS descripcion_udm, udm.categoria_udm, cast(pro.precio_de_venta as decimal(6,2)), 
pro.tiene_iva, cast(pro.coste as decimal(5,4)), pro.categoria_cat, c.nombre As nombre_categoria, pro.stock 
from productos pro, categorias c, unidades_medida udm 
Where pro.categoria_cat = c.codigo_cat 
AND pro.udm = udm.codigo_udm 
AND pro.codigo_pro='2'

Update productos set nombre = ('PASTA de tomate'), udm = ('lb'), precio_de_venta = ('0.96'::numeric), tiene_iva = ('FALSE'::boolean), coste ('0.8800'::numeric), categoria_cat = ('1'::int4), stock = ('40'::int4) where codigo_pro = ('1'::int4)
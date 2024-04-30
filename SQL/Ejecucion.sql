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

select * from productos prod, unidades_medida udm, categorias cat
where prod.udm = udm.codigo_udm
and prod.categoria_cat = cat.codigo_cat

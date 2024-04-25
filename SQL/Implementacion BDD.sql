drop table if exists categorias;
create table categorias(
	codigo_cat serial not null,
	nombre varchar(100) not null,
	categoria_padre int,
	constraint categorias_pk primary key(codigo_cat),
	constraint categorias_fk foreign key(categoria_padre) references categorias(codigo_cat)
);
 insert into categorias(nombre, categoria_padre)
 values('Materia Prima', null);
 insert into categorias(nombre, categoria_padre)
 values('Proteina', 1);
 insert into categorias(nombre, categoria_padre)
 values('Salsas', 1);
 insert into categorias(nombre, categoria_padre)
 values('Punto de Venta', null);
 insert into categorias(nombre, categoria_padre)
 values('Bedidas', 4);
 insert into categorias(nombre, categoria_padre)
 values('Con Alcohol', 5);
 insert into categorias(nombre, categoria_padre)
 values('Sin Alcohol', 5);
 select * from categorias

drop table if exists categoria_unidad_medida;
create table categoria_unidad_medida(
	codigo_udm char(1) not null,
	nombre varchar(100) not null,
	constraint categoria_unidad_medida_pk primary key(codigo_udm)
);
insert into categoria_unidad_medida(codigo_udm, nombre)
values('U', 'Unidades');
insert into categoria_unidad_medida(codigo_udm, nombre)
values('V', 'Volumen');
insert into categoria_unidad_medida(codigo_udm, nombre)
values('P', 'Peso');
select * from categoria_unidad_medida

drop table if exists unidades_medida;
create table unidades_medida(
	codigo_udm char(2) not null,
	descripcion varchar(100) not null,
	categoria_udm char(1) not null,
	constraint unidades_medida_pk primary key(codigo_udm),
	constraint cum_um_fk foreign key(categoria_udm) references categoria_unidad_medida(codigo_udm)
);
insert into unidades_medida(codigo_udm, descripcion, categoria_udm)
values('ml', 'mililitros', 'V');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm)
values('l', 'litros', 'V');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm)
values('u', 'unidad', 'U');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm)
values('d', 'docena', 'U');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm)
values('g', 'gramos', 'P');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm)
values('kg', 'kilogramos', 'P');
insert into unidades_medida(codigo_udm, descripcion, categoria_udm)
values('lb', 'libras', 'P');
select * from unidades_medida

drop table if exists productos;
create table productos(
	codigo_pro serial not null,
	nombre varchar(30) not null,
	udm char(2) not null,
	precio_de_venta money not null,
	tiene_iva boolean not null,
	coste money not null,
	categoria_cat int not null,
	stock int not null,
	constraint productos_pk primary key(codigo_pro),
	constraint productos_unidades_medida_fk foreign key(udm) references unidades_medida(codigo_udm),
	constraint producto_categorias_fk foreign key(categoria_cat) references categorias(codigo_cat)
);
insert into productos(nombre, udm, precio_de_venta, tiene_iva, coste, categoria_cat, stock)
values('Coca Cola Pequeña', 'u', 0.5804, true, 0.3729, 7, 100);
insert into productos(nombre, udm, precio_de_venta, tiene_iva, coste, categoria_cat, stock)
values('Salsa de Tomate', 'kg', 0.95, true, 0.8736, 3, 0);
insert into productos(nombre, udm, precio_de_venta, tiene_iva, coste, categoria_cat, stock)
values('Moztasa', 'kg', 0.95, true, 0.8736, 3, 0);
insert into productos(nombre, udm, precio_de_venta, tiene_iva, coste, categoria_cat, stock)
values('Fuze Te', 'u', 0.80, true, 0.370, 7, 50);
select * from productos

drop table if exists tipo_de_documentos;
create table tipo_de_documentos(
	codigo char(1) not null,
	descripcion varchar(20) not null,
	constraint tipo_de_documentos_ok primary key(codigo)
);
insert into tipo_de_documentos(codigo, descripcion)
values('C', 'CEDULA');
insert into tipo_de_documentos(codigo, descripcion)
values('R', 'RUC');
select * from tipo_de_documentos

drop table if exists proveedores;
create table proveedores(
	identificador varchar(13) not null,
	tipo_de_documento char(1) not null,
	nombre varchar(20) not null,
	telefono varchar(10),
	correo varchar(20),
	direccion varchar (20),
	constraint proveedores_pk primary key(identificador),
	constraint proveedores_tipo_de_documentos_fk foreign key(tipo_de_documento) references tipo_de_documentos(codigo)
);
insert into proveedores(identificador, tipo_de_documento, nombre, telefono, correo, direccion)
values('1792285747', 'C', 'SANTIAGO MOSQUERA', '099292030', 'zantycb89@gmail.com', 'Cumbayork');
insert into proveedores(identificador, tipo_de_documento, nombre, telefono, correo, direccion)
values('1792285747001', 'R', 'SNACKS SA', '099292007', 'snacks@gmail.com', 'La Tola');
select * from proveedores

drop table if exists estados_pedido;
create table estados_pedido(
	codigo char(1) not null,
	descripcion varchar(20) not null,
	constraint estados_pedido_pk primary key(codigo)
);
insert into estados_pedido(codigo, descripcion)
values('S', 'Solitario');
insert into estados_pedido(codigo, descripcion)
values('R', 'Recibir');
select * from estados_pedido

drop table if exists cabecera_pedido;
create table cabecera_pedido(
	numero serial not null,
	proveedor varchar(13) not null,
	fecha date not null,
	estado char(1) not null,
	constraint cabecera_pedido_pk primary key(numero),
	constraint cabecera_pedido__fk foreign key(proveedor) references proveedores(identificador),
	constraint cabecera_pedido_estados_pedido_fk foreign key( estado) references estados_pedido(codigo)
);
insert into cabecera_pedido( proveedor, fecha, estado)
values('1792285747', '11/20/23', 'R');
insert into cabecera_pedido( proveedor, fecha, estado)
values('1792285747', '11/20/23', 'R');
select * from cabecera_pedido

drop table if exists detalle_pedido;
create table detalle_pedido(
	codigo serial not null,
	cabecera_pedido int not null,
	producto int not null,
	cantidad_solicitada int not null,
	subtotal decimal not null,
	cantidad_recibida int not null,
	constraint detalle_pedido_pk primary key(codigo),
	constraint detalle_pedido_cabecera_pedido_fk foreign key(cabecera_pedido) references cabecera_pedido(numero),
	constraint detalle_pedido_productos_fk foreign key(producto) references productos(codigo_pro)
);
insert into detalle_pedido(cabecera_pedido, producto, cantidad_solicitada, subtotal, cantidad_recibida)
values(1, 1, 100, 37.29, 100);
insert into detalle_pedido(cabecera_pedido, producto, cantidad_solicitada, subtotal, cantidad_recibida)
values(1, 4, 50, 11.8, 50);
insert into detalle_pedido(cabecera_pedido, producto, cantidad_solicitada, subtotal, cantidad_recibida)
values(2, 1, 10, 3.73, 10);
select * from detalle_pedido

drop table if exists historial_stock;
create table historial_stock(
	codigo serial not null,
	fecha Timestamp not null,
	referencia varchar(10),
	producto int not null,
	cantidad int not null,
	constraint historial_stock_pk primary key (codigo),
	constraint historial_stock_producto_fk foreign key(producto) references productos(codigo_pro)
);
insert into historial_stock(fecha, referencia, producto, cantidad)
values('11/20/2023 19:59:08', 'PEDIDO 1', 1, 100);
insert into historial_stock(fecha, referencia, producto, cantidad)
values('11/20/2023 19:59:08', 'PEDIDO 1', 4, 50);
insert into historial_stock(fecha, referencia, producto, cantidad)
values('11/20/2023 20:00:08', 'PEDIDO 2', 1, 10);
insert into historial_stock(fecha, referencia, producto, cantidad)
values('11/20/2023 20:00:08', 'VENTA 1', 1, -5);
insert into historial_stock(fecha, referencia, producto, cantidad)
values('11/20/2023 20:00:08', 'VENTA 1', 4, -1);
select * from historial_stock

drop table if exists cabecera_ventas;
create table cabecera_ventas(
	codigo serial not null,
	fecha Timestamp not null,
	total_sin_iva decimal not null,
	iva decimal not null,
	total decimal not null,
	constraint cabecera_ventas_pk primary key(codigo)
);
insert into cabecera_ventas(fecha, total_sin_iva, iva, total)
values('11/20/2023/ 20:00:08', 3.26, 0.39, 3.65);
select * from cabecera_ventas

drop table if exists detalle_de_ventas;
create table detalle_de_ventas(
	codigo serial not null,
	cabecera_ventas int not null,
	producto int not null,
	cantidad int not null,
	precio_venta decimal not null,
	subtotal decimal not null,
	subtatal_con_iva decimal not null,
	constraint detalle_de_ventas_pk primary key(codigo),
	constraint detalle_de_ventas_cabecera_ventas_fk foreign key(cabecera_ventas) references cabecera_ventas(codigo),
	constraint detalle_de_ventas_productos_fk foreign key(producto) references productos(codigo_pro)
);
insert into detalle_de_ventas(cabecera_ventas, producto, cantidad, precio_venta, subtotal, subtatal_con_iva)
values(1, 1, 5,	0.58, 2.9, 3.25);
insert into detalle_de_ventas(cabecera_ventas, producto, cantidad, precio_venta, subtotal, subtatal_con_iva)
values(1, 4, 1, 0.36, 0.36, 0.4);
select * from detalle_de_ventas

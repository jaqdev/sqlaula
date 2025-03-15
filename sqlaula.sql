create database loja;

drop database loja;

use loja;

create table clientes(
 cod_cliente int primary key not null, 
 nome varchar (100) not null, 
 endereco  varchar (90) not null,
 cidade  varchar (100) not null,
 cep varchar (90) not null
);

create table pedidos(
num_pedido int (100) not null,
data_pedido varchar (100) not null,
item  varchar (600) not null,
valor varchar (30),
cod_cliente int,
foreign key (cod_cliente) references clientes(cod_cliente)
);

insert into clientes(cod_cliente, nome, endereco, cidade, cep) values 

(1, "Jaqueline", "Rua joazinho beira mar", "Paula da Cruz", "05200-346"), 
(2, "Luana do grau", "Jaque do italo da cruz", "jujuba", "07900-456"),
(3, "Italo pjl", "Luana Lula", "aoba coisa boa", "09800-765");

insert into pedidos(num_pedido, data_pedido, item, valor, cod_cliente) values 
(56, "24/03/2025", "bola de cristal", "R&100,00", 1);

select *from  pedidos

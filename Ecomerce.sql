create dataBase Ecomerce;

use Ecomerce

/*---------------------*-------------------------*----------------*----------------------------*--------------------------*----------------------*/

create table Produtos (
	Codigo int,
	Nome varchar(100),
	Descricao varchar(200),
	Preco float
);

create table Clientes (
	Codigo int not null,
	Nome varchar(200) not null,
	TipoPessoa char(1) not null
);

create table Pedido (
	Codigo int not null,
	DataSolcitacao dateTime not null,
	FlagPago bit not null,
	TotalPedido float not null,
	CodigoCliente int
);

create table PedidoItem (
	CodigoPedido int not null,
	CodigoProduto int not null,
	Preco float not null,
	Quantidade int not null
);

/*---------------------*-------------------------*----------------*----------------------------*--------------------------*----------------------*/

select * from clientes;

insert into clientes (Codigo, Nome, TipoPessoa) values (1, 'Douglas', 'F');
insert into clientes (Codigo, Nome, TipoPessoa) values (2, 'Douglas', 'F');
insert into clientes (Codigo, Nome, TipoPessoa) values (3, 'Douglas', 'F');
insert into clientes (Codigo, Nome, TipoPessoa) values (4, 'Douglas', 'F');
insert into clientes (Codigo, Nome, TipoPessoa) values (5, 'Douglas', 'J');
insert into clientes (Codigo, Nome, TipoPessoa) values (6, 'Douglas', 'J');

select * from clientes
where TipoPessoa = 'J';

update clientes 
set Nome = 'Thiago'
where Codigo = 5;

delete from clientes
where Codigo in(4,5,6);

/*---------------------*-------------------------*----------------*----------------------------*--------------------------*----------------------*/

select * from Produtos;

insert Produtos (Codigo, Nome, Descricao, Preco) values (1, 'Caneta', 'caneta azul', 1.5), (2, 'Caderno', 'Carderno 10 matérias', 20.99);

/*---------------------*-------------------------*----------------*----------------------------*--------------------------*----------------------*/

select * from Pedido;

insert Pedido (Codigo, DataSolcitacao, FlagPago, TotalPedido, CodigoCliente) values (1, getDate(), 0, 3, 2);
insert Pedido (Codigo, DataSolcitacao, FlagPago, TotalPedido, CodigoCliente) values (2, getDate(), 0, 22.49, 1);

/*---------------------*-------------------------*----------------*----------------------------*--------------------------*----------------------*/

select * from PedidoItem;

insert PedidoItem (CodigoPedido, CodigoProduto, Preco, Quantidade) values (1, 1, 1.5, 3);
insert PedidoItem (CodigoPedido, CodigoProduto, Preco, Quantidade) values (2, 2, 22.49, 1);

select * from Pedido;
select * from PedidoItem;

/*---------------------*-------------------------*----------------*----------------------------*--------------------------*----------------------*/

/*      Consultas     */

select * from clientes
where Codigo = 1 
AND TipoPessoa = 'F';

select * from clientes
where Codigo = 1 
OR TipoPessoa = 'F';

select *, convert(varchar, DataSolicitacao, 103)
from Pedido

select *, 
	case
		when TipoPessoa = 'J' then 'Jurídica'		
		when TipoPessoa = 'F' then 'Física'
		else 'Pessoa Indefinida'
	end
from Clientes

select *, 
	case
		when TipoPessoa = 'J' then 'Jurídica'		
		when TipoPessoa = 'F' then 'Física'
		else 'Pessoa Indefinida'
	end + convert(varchar, GETDATE(), 103)
from Clientes

select * from Clientes cli
inner	join Pedido ped
on		cli.Codigo = ped.CodigoCliente

select * from Clientes cli
left	join Pedido ped
on		cli.Codigo = ped.CodigoCliente

select * from Pedido ped
right	join Clientes cli
on		cli.Codigo = ped.CodigoCliente

select * from Clientes cli
left	join Pedido ped
on		cli.Codigo = ped.CodigoCliente
where	ped.TotalPedido > 10

select	cli.Nome,
		ped.TotalPedido,
		case
			when cli.TipoPessoa = 'F' then 'Física'
			else 'Jurídica'
		end TipoPessoa
from	Clientes cli
left	join Pedido ped
on		cli.Codigo = ped.CodigoCliente

select	* 
from	PedidoItem t1
inner	join PedidoItemLog t2
on		t1.CodigoPedido = t2.CodigoPedido
and		t1.CodigoProduto = t2.CodigoProduto

select	t4.Codigo,
			t4.Descricao,
			sum(t1.Preco * t1.Quantidade)
from	PedidoItem t1
inner	join PedidoItemLog t2
on		t1.CodigoPedido = t2.CodigoPedido
and		t1.CodigoProduto = t2.CodigoProduto
inner	join StatusPedidoItem t3
on		t3.Codigo = t2.CodigoStatusPedidoItem
inner	join Produtos t4
on		t4.Codigo = t2.CodigoProduto
group	by t4.Codigo,
			t4.Descricao
order	by t4.Codigo desc

/*---------------------*-------------------------*----------------*----------------------------*--------------------------*----------------------*/

/* Adicionando Primary Key e Foreign Key nas tabelas */

alter table Clientes add constraint pk_cliente primary key (Codigo);

alter table PedidoItem add constraint pk_cliente foreign key (CodigoPedido) references Pedido (Codigo);
alter table PedidoItem add constraint pk_cliente foreign key (CodigoProduto) references Produtos (Codigo);
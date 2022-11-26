create database bd_Oficina;
use bd_Oficina;

create table pessoa(
	idPessoa int auto_increment primary key,
    nome varchar(45) not null,
    endereco char(255) not null,
    identificacao varchar(20) not null
);

insert into pessoa (nome, endereco, identificacao)
            values ('Carlos', 'ceu azul', '111111111'),
insert into pessoa (nome, endereco, identificacao)
            values ('hiann', 'castelo', '111111112'),
insert into pessoa (nome, endereco, identificacao)
            values ('matheus', 'ceu azul', '111111113'),
insert into pessoa (nome, endereco, identificacao)
            values ('brenda', 'caicara', '111111114');

create table mecanico(
	idMecanico int auto_increment primary key,
    idPessoa int,
    codigo varchar(45) not null,
    especialidade varchar(20) not null,
    constraint fk_pessoa_mecanico foreign key (idPessoa) references pessoa(idPessoa)
);

insert into pessoa (codigo, especialidade)
            values ('1', 'suspenção'),
insert into pessoa (codigo, especialidade)
            values ('2', 'escapamento',);


create table cliente(
	idCliente int auto_increment primary key,
    idPessoa int,
    constraint fk_pessoa_cliente foreign key (idPessoa) references pessoa(idPessoa)
);

create table equipe(
	idEquipe int auto_increment primary key,
    nome varchar(20) not null
);

insert into pessoa (nome)
            values ('Power Ranger');

create table veiculo(
	idVeiculo int auto_increment primary key,
    placa varchar(8) not null,
    modelo varchar(20) not null,
    ano char(5) not null,
    idEquipe int,
    idCliente int,
    constraint fk_veiculo_equipe foreign key (idEquipe) references equipe(idEquipe),
    constraint fk_veiculo_cliente foreign key (idCliente) references cliente(idCliente)
);

insert into veiculo (placa, modelo, ano)
            values ('grw-4325', 'fiat palio', '2008');

create table mecanico_equipe(
	idEquipe int,
    idMecanico int,
    constraint fk_mecanico_equipe_equipe foreign key (idEquipe) references equipe(idEquipe),
    constraint fk_mecanico_equipe_mecanico foreign key (idMecanico) references mecanico(idMecanico)
);

create table ordem_servico(
	idOrdemServico int auto_increment primary key,
    valorTotal double not null,
    dataEmissao DATE,
    dataEntrega DATE,
    idEquipe int,
    constraint fk_ordem_servico_equipe foreign key (idEquipe) references equipe(idEquipe)
);

insert into ordem_servico (valorTotal, dataEmissao, dataEntrega)
            values ('650.00', '20/11/2022', '26/11/2022');

create table peca(
	idPeca int auto_increment primary key,
    nomePeca varchar(45),
    preco double,
    tipo varchar(45),
    idOrdemServico int,
    constraint fk_ordem_servico_peca foreign key (idOrdemServico) references ordem_servico(idOrdemServico)
);

insert into peca (nomePeca, preco, tipo)
            values ('mola da suspenção', '300.00', 'suspenção');

create table refer_mao_obra(
	idRefMaoObra int auto_increment primary key,
    tipo varchar(45),
    valor double
);

insert into refer_mao_obra (tipo, valor)
            values ('troca', '350.00');

create table servico(
	idServico int auto_increment primary key,
    statusServico varchar(45),
    valorServico varchar(45),
    idCliente int,
    idRefMaoObra int,
    idOrdemServico int,
    constraint fk_servico_cliente foreign key (idCliente) references cliente(idCliente),
    constraint fk_servico_refer_mao_obra foreign key (idRefMaoObra) references refer_mao_obra(idRefMaoObra),
    constraint fk_servico_ordem_servico foreign key (idOrdemServico) references ordem_servico(idOrdemServico)
);

insert into servico (statusServico, valorServico)
            values ('pronto', '650.34');


SELECT COUNT(idServico), servico
FROM bd_Oficina
GROUP BY statusServico
HAVING COUNT(idCliente) > 0;
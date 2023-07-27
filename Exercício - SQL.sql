create database viagens;
use viagens;

create table Marca(
			marca varchar(50) primary key);

create table ModeloMarca(
			modelo varchar(50),
            marca varchar(50),
            foreign key(marca) references Marca(marca),
            primary key(modelo,marca));
            
create table Aviao(
			id int auto_increment primary key,
            matricula varchar(50),
            modelo varchar(50),
            foreign key(modelo) references ModeloMarca(modelo),
            nr_pessoas int,
            autonomia decimal(10,2));
            
create table AeroPorto(
			id int auto_increment primary key,
            nome varchar(50),
            localidade varchar(50));
            
create table Piloto(
			id int auto_increment primary key,
            nome varchar(50),
            telefone int,
            email varchar(50),
            escalao int);
            
create table Voo(
			id int auto_increment primary key,
            aviao int,
            foreign key(aviao) references Aviao(id),
            piloto int,
            foreign key(piloto) references Piloto(id),
            origem int,
            foreign key(origem) references AeroPorto(id),
            destino int,
            foreign key(destino) references AeroPorto(id),
            duracao int);
            
insert into Marca(marca) values 
			('easyJet'),
            ('TAP'),
            ('Ryanair'),
            ('Emirates Airlines'),
            ('AirFrance');
select * from Marca;

insert into AeroPorto(nome, localidade) values
			('Aeroporto Francisco Sá Carneiro','Portugal'),
            ('Aeroporto Humberto Delgado','Portugal'),
            ('Aeroporto Adolfo Suárez-Barajas','Espanha'),
            ('Aeroporto Palma de Maiorca-Son Sant Joan','Espanha'),
            ('Aeroporto de Orly','França'),
            ('Aeroporto de Lyon','França'),
            ('Aeroporto de Bruxelas','Bélgica');
select * from AeroPorto;

insert into ModeloMarca(modelo,marca) values
			('Comercial','easyJet'),
            ('Passageiros','easyJet'),
            ('Comercial','TAP'),
            ('Passageiros','TAP'),
            ('Comercial','Ryanair'),
            ('Passageiros','Ryanair'),
            ('Comercial','Emirates Airlines'),
            ('Passageiros','Emirates Airlines'),
            ('Comercial','AirFrance'),
            ('Passageiros','AirFrance');
select * from ModeloMarca;

insert into Piloto(nome,telefone,email,escalao) values	
			('Manuel Faria','912345678','mfaria@gmail.com','3'),
            ('José António','918765432','zetono@outlook.com','1'),
            ('Maurício Albuquerque','931245678','albuquerque1983@hotmail.com','2'),
            ('Tiago Alves','938765421','alvestiago@gmail.com','1');
select * from Piloto;

insert into Aviao(matricula,modelo,nr_pessoas,autonomia) values 
			('22-VD-85','Passageiros','150','100.2'),
            ('12-02-JO','Comercial','50','100.2'),
            ('243-68-PML','Comercial','37','100.2'),
            ('LMP-86-342','Passageiros','200','100.2'),
            ('MLP-423-96','Passageiros','192','100.2');
select * from Aviao;

insert into Voo(aviao,piloto,origem,destino,duracao) values 
			('4','2','1','6','120'),
            ('1','4','2','3','30'),
            ('2','1','5','1','120'),
            ('4','2','7','2','150'),
            ('3','2','1','5','125');
select * from Voo;

#a) Quais os voos que partem do Porto?
select * from Voo where origem = 1;

#b) Quantos aeroportos há em França?
select * from Aeroporto where localidade = 'França';

#c) Qual o modelo do avião com mais voos?
select count(v.id), a.modelo from Voo v, Aviao a where
				a.id = v.aviao
                group by a.modelo order by count(v.id) desc
                limit 1;

#d) Quais os voos que nunca voaram? E quais os pilotos?
select id from Aviao where
				id NOT IN (select aviao from Voo);
                
select id from Piloto where
				id NOT IN (select piloto from Voo);

#e) Qual o aeroporto c/ mais voos?
select count(v.id), a.nome from Voo v, AeroPorto a where
				a.id = v.aviao
                group by a.nome;

#f) Quantos voos fez cada avião? E cada piloto?
select count(v.id), a.id from Voo v, Aviao a where
				v.aviao = a.id
                group by a.id;
                
select coutn(v.id), p.id from Voo v, Piloto p where
				v.piloto = piloto.id
                group by p.id;


#g) Quais as marcas de avião pilotados pelo piloto Manuel Faria?        
select m.marca from Marca m, ModeloMarca mm, Aviao a, Voo v, Piloto p where
				m.marca = mm.marca and
                mm.modelo = a.modelo and
                a.id = v.aviao and 
                v.piloto = p.id and
                p.nome = 'Manuel Faria'; 
            
            

            
            

            

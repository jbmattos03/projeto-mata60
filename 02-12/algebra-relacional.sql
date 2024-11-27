create database projeto_bd;
use projeto_bd;

###
# criando tabelas
###
create table Administrator ( # Admin é palavra reservada
	id int auto_increment primary key,
    name_admin varchar(255), # name aparentemente é palavra reservada do mysql
    phone_number varchar(13),
    email varchar(255),
    password_admin varchar(20), # palavra reservada
    created_at datetime,
    updated_at datetime
);

create table Form (
	id int auto_increment primary key,
    title varchar(255),
    description_form varchar(255), # palavra reservada
    status_form smallint,
    creator_id int,
    created_at datetime,
    updated_at datetime,
    
    foreign key (creator_id) references Administrator (id)
);

create table `User` ( # User é palavra reservada, mas não pensei em nada para substituir
	id int auto_increment primary key,
    name_user varchar(255),
    phone_number varchar(13),
    email varchar(255),
    password_user varchar(20),
    created_at datetime,
    updated_at datetime
    
);

create table Submission (
	id int auto_increment primary key,
    form_id int,
    user_id int,
    created_at datetime,
    updated_at datetime,
    
    foreign key (form_id) references Form (id),
    foreign key (user_id) references `User` (id)
);

create table `Component` ( # Component é palavra reservada
	id int auto_increment primary key,
    default_regex varchar(255),
    default_label varchar(255),
    created_at datetime,
    updated_at datetime
);

create table Form_To_Component (
	form_id int,
    component_id int,
    regex varchar(255),
    label varchar(255),
    
    primary key (form_id, component_id),
    foreign key (form_id) references Form (id),
    foreign key(component_id) references `Component` (id)
);

create table Submission_Values (
	component_id int,
    submission_id int,
    submission_value text,
    
    primary key (component_id, submission_id),
    foreign key (component_id) references `Component` (id),
    foreign key (submission_id) references Submission (id)
);

###
# criando valores
###
# Admin
insert into Administrator (name_admin, phone_number, email, password_admin, created_at)
	values ("Maria da Silva", "7155555555", "ms@email.example", "senha123", now()),
		   ("Joana Pereira", "71111111111", "jp@email.example", "senha246", now());

# Form
insert into Form (title, description_form, status_form, creator_id, created_at)
	values ("Pessoas que usam este sistema", 
			"Calcular a quantidade de pessoas que usam esse sistema",
            1,
            1,
            now()
		   );

# User
insert into `User` (name_user, phone_number, email, password_user, created_at)
	values ("André de Jesus", "71666666666", "aj@email.example", "senha123", now()),
		   ("Fernanda Oliveira", "71777777777", "fo@email.example", "senha123", now()),
           ("Gabriela Gomes", "71888888888", "gg@email.example", "senha123", now()),
           ("Artur Costa", "71999999999", "ac@email.example", "senha123", now()),
           ("Breno Marques", "71222222222", "bm@email.example", "senha123", now());
           
# Submission
insert into Submission (form_id, user_id, created_at)
	values (1, 4, now()),
		   (1, 2, now());

# Component
insert into `Component` (default_regex, default_label, created_at)
	values ("/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/",
            "E-mail",
			now()
           );

# Form to Component 
insert into Form_To_Component (form_id, component_id, regex, label)
	values(1,
		   1,
           (select default_regex from `Component` where id = 1),
           (select default_label from `Component` where id = 1)
		  );

# Submission Values
insert into Submission_Values (component_id, submission_id, submission_value)
	values (1, 1, "ac2@email.example"),
           (1, 2, "fs@email.example");
    
###
# queries
###
# 1. buscar um formulário por id, e fazer um join com todas as sumissões junto
select * 
	from Submission S join Form F on S.form_id = F.id
	where F.id = 1;

# 2. buscar submissões de um usuário com base num nome
select *
	from Submission
    where user_id = (select id from User where name_user = "Artur Costa");

# 3. buscar uma submissão por id e trazer todos os valores e componentes da submissão

# 4. buscar todos os forms pertencentes a um admin
select * from Form
	where creator_id = 1;

# 5. buscar um form e seus componentes por id


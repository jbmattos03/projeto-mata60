create database projeto_bd;
use projeto_bd;

###
# criando tabelas - DDL
###
create table Administrator ( 
	id int auto_increment primary key,
    name_admin varchar(255) not null, 
    phone_number varchar(13) not null,
    email varchar(255) not null,
    password_admin varchar(20) not null, 
    created_at datetime,
    updated_at datetime
);

create table Form (
	id int auto_increment primary key,
    title varchar(255) not null,
    description_form varchar(255), 
    status_form smallint not null,
    creator_id int not null,
    created_at datetime,
    updated_at datetime,
    
    foreign key (creator_id) references Administrator (id)
);

create table `User` ( 
	id int auto_increment primary key,
    name_user varchar(255) not null,
    phone_number varchar(13) not null,
    email varchar(255) not null,
    password_user varchar(20) not null,
    created_at datetime,
    updated_at datetime
    
);

create table Submission (
	id int auto_increment primary key,
    form_id int not null,
    user_id int not null,
    created_at datetime,
    updated_at datetime,
    
    foreign key (form_id) references Form (id),
    foreign key (user_id) references `User` (id)
);

create table `Component` ( 
	id int auto_increment primary key,
    default_regex varchar(255) not null,
    default_label varchar(255) not null,
    created_at datetime,
    updated_at datetime
);

create table Form_To_Component (
	form_id int,
    component_id int,
    regex varchar(255) not null,
    label varchar(255) not null,
    
    primary key (form_id, component_id),
    foreign key (form_id) references Form (id),
    foreign key(component_id) references `Component` (id)
);

create table Submission_Values (
	component_id int,
    submission_id int,
    submission_value text not null,
    
    primary key (component_id, submission_id),
    foreign key (component_id) references `Component` (id),
    foreign key (submission_id) references Submission (id)
);

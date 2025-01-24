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

CREATE UNIQUE INDEX admin_id ON Administrator(id) USING BTREE;
CREATE INDEX name_admin ON Administrator(name_admin) USING HASH;
CREATE UNIQUE INDEX user_id ON User(id) USING BTREE;
CREATE INDEX name_user ON User(name_user) USING HASH;
CREATE UNIQUE INDEX component_id ON Component(id) USING BTREE;
CREATE INDEX form_admin_id ON Form(creator_id) USING BTREE;
CREATE INDEX form_status ON Form(status_form) USING HASH;
CREATE INDEX form_submission ON Submission(form_id) USING BTREE;
CREATE INDEX user_submission ON Submission(user_id) USING BTREE;
CREATE INDEX form_to_component ON Form_To_Component(form_id, component_id) USING
BTREE;
CREATE INDEX submission_values ON Submission_Values(component_id, submission_id)
USING BTREE;
CREATE INDEX created_at_admin ON Administrator(created_at) USING BTREE;
CREATE INDEX created_at_user ON User(created_at) USING BTREE;
CREATE INDEX created_at_form ON Form(created_at) USING BTREE;
CREATE INDEX created_at_submission ON Submission(created_at) USING BTREE;
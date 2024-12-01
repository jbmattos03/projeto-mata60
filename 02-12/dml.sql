use projeto_bd;

###
# criando valores - DML
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
-- use projeto_bd;


-- criando valores - DML

INSERT INTO `administrators` (`name`, `phone_number`, `email`, `password`)
	VALUES ("Maria da Silva", "7155555555", "ms@email.example", "senha123"),
		   ("Joana Pereira", "71111111111", "jp@email.example", "senha246");

INSERT INTO `components` (`default_regex`, `default_label`)
	VALUES ("^[^\s@]+@[^\s@]+\.[^\s@]+$",
            "E-mail"
           );

INSERT INTO `components` (`default_regex`, `default_label`)
    VALUES ("^(sim|não)$",
            "Sim ou Não"
           );

INSERT INTO `forms` (`title`, `description`, `status`, `creator_id`)
	VALUES ("Pessoas que usam este sistema", 
			"Calcular a quantidade de pessoas que usam esse sistema",
            1,
            1
		   );

INSERT INTO `forms_to_components` (`form_id`, `component_id`, `regex`, `label`)
	VALUES (1,
		    1,
            (SELECT `default_regex` FROM `components` WHERE `id` = 1),
            (SELECT `default_label` FROM `components` WHERE `id` = 1)
		   );

INSERT INTO `forms_to_components` (`form_id`, `component_id`, `regex`, `label`)
    VALUES (1,
            2,
            (SELECT `default_regex` FROM `components` WHERE `id` = 2),
            "Está satisfeito com o sistema?"
           );


INSERT INTO `users` (`name`, `phone_number`, `email`, `password`)
	VALUES ("André de Jesus", "71666666666", "aj@email.example", "senha123"),
		   ("Fernanda Oliveira", "71777777777", "fo@email.example", "senha123"),
           ("Gabriela Gomes", "71888888888", "gg@email.example", "senha123"),
           ("Artur Costa", "71999999999", "ac@email.example", "senha123"),
           ("Breno Marques", "71222222222", "bm@email.example", "senha123");
           

INSERT INTO `submissions` (`form_id`, `user_id`)
	VALUES (1, 4),
		   (1, 2);


INSERT INTO `submission_values` (`component_id`, `submission_id`, `submission_value`)
	VALUES (1, 1, "ac@email.example"),
           (1, 2, "fo@email.example"),
           (2, 1, "sim"),
           (2, 2, "não");
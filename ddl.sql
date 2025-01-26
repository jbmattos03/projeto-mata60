-- Banco de dados MySQL

-- Descomentar linhas abaixo caso necessário
-- CREATE DATABASE IF NOT EXISTS projeto_bd;
-- USE projeto_bd;

--
-- criando tabelas - DDL
--

CREATE TABLE `administrators` ( 
	`id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL, 
    `phone_number` VARCHAR(13) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(20) NOT NULL, 
    `created_at` TIMESTAMP NOT NULL DEFAULT now(),
    `updated_at` TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE `forms` (
	`id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `description` VARCHAR(255), 
    `status` SMALLINT NOT NULL,
    `creator_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT now(),
    `updated_at` TIMESTAMP NOT NULL DEFAULT now(),
    
    FOREIGN KEY (`creator_id`) REFERENCES `administrators` (`id`)
);

CREATE TABLE `users` ( 
	`id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `phone_number` VARCHAR(13) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `password` VARCHAR(20) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT now(),
    `updated_at` TIMESTAMP NOT NULL DEFAULT now()
    
);

CREATE TABLE `submissions` (
	`id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `form_id` INTEGER NOT NULL,
    `user_id` INTEGER NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT now(),
    `updated_at` TIMESTAMP NOT NULL DEFAULT now(),
    
    FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `components` ( 
	`id` INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `default_regex` VARCHAR(255) NOT NULL,
    `default_label` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT now(),
    `updated_at` TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE `forms_to_components` (
	`form_id` INTEGER,
    `component_id` INTEGER,
    `regex` VARCHAR(255) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    
    PRIMARY KEY (`form_id`, `component_id`),
    FOREIGN KEY (`form_id`) REFERENCES `forms` (`id`),
    FOREIGN KEY (`component_id`) REFERENCES `components` (`id`)
);

CREATE TABLE `submission_values` (
	`component_id` INTEGER,
    `submission_id` INTEGER,
    `submission_value` text NOT NULL,
    
    PRIMARY KEY (`component_id`, `submission_id`),
    FOREIGN KEY (`component_id`) REFERENCES `components` (`id`),
    FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`id`)
);

CREATE INDEX `admin_name_idx` ON `administrators`(`name`) USING BTREE;

CREATE INDEX `user_name_idx` ON `users`(`name`) USING BTREE;

CREATE INDEX `form_creator_id_idx` ON `forms`(`creator_id`) USING BTREE;
CREATE INDEX `form_status_idx` ON `forms`(`status`) USING BTREE;

CREATE INDEX `submission_form_id_idx` ON `submissions`(`form_id`) USING BTREE;
CREATE INDEX `submission_user_id_idx` ON `submissions`(`user_id`) USING BTREE;
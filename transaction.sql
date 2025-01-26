-- Create a Form and a Compoenent and relate it
START TRANSACTION;
    -- Create a Form
    INSERT INTO `forms` (`title`, `description`, `status`, `creator_id`)
        VALUES ("Pessoas que usam este sistema (transaction)", 
                "Form para coletar informações sobre os usuários do sistema",
                1,
                1
               );
    -- Get the form_id
    SET @form_id = LAST_INSERT_ID();
    -- Create a Component
    INSERT INTO `components` (`default_regex`, `default_label`)
        VALUES ("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                "E-mail (transaction)"
               );
    -- Get the component_id
    SET @component_id = LAST_INSERT_ID();
    -- Relate the Form to the Component
    INSERT INTO `forms_to_components` (`form_id`, `component_id`, `regex`, `label`)
        VALUES(@form_id,
               @component_id,
               (SELECT default_regex FROM `components` WHERE id = component_id),
               (SELECT default_label FROM `components` WHERE id = component_id)
              );
COMMIT;

-- Create a Submission and its Submission_Values
START TRANSACTION;
    -- Create a Submission
    INSERT INTO `submissions` (`form_id`, `user_id`)
        VALUES (1, 1);
    -- Get the submission_id
    SET @submission_id = LAST_INSERT_ID();
    -- Create values for each component
    INSERT INTO `submission_values` (`submission_id`, `component_id`, `submission_value`)
        VALUES (@submission_id,
                1,
                "aj@email.example"
                );
    INSERT INTO `submission_values` (`submission_id`, `component_id`, `submission_value`)
        VALUES (@submission_id,
                2,
                "sim"
                );
COMMIT;
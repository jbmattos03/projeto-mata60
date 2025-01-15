-- Create a Form and a Compoenent and relate it
START TRANSACTION
    -- Create a Form
    INSERT INTO Form (title, description_form, status_form, creator_id, created_at)
        VALUES ("Pessoas que usam este sistema", 
                "Form para coletar informações sobre os usuários do sistema",
                1,
                1,
                NOW()
               )
        RETURNING id INTO form_id;
    -- Create a Component
    INSERT INTO `Component` (default_regex, default_label, created_at)
        VALUES ("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                "E-mail",
                NOW()
               )
        RETURNING id INTO component_id;
    -- Relate the Form to the Component
    INSERT INTO Form_To_Component (form_id, component_id, regex, label)
        VALUES(form_id,
               component_id,
               (SELECT default_regex FROM `Component` WHERE id = component_id),
               (SELECT default_label FROM `Component` WHERE id = component_id)
              );
COMMIT;

-- Create a Submission and its Submission_Values
START TRANSACTION
    -- Create a Submission
    INSERT INTO Submission (form_id, user_id, created_at)
        VALUES (1,
                1,
                NOW()
               )
        RETURNING id INTO submission_id;
    -- Create a Submission_Values
    INSERT INTO Submission_Values (submission_id, component_id, submission_value)
        VALUES (submission_id,
                1,
                "user@example.com"
                );
COMMIT;
-- use projeto_bd;

-- buscar um formulário por id, e fazer um join com todas as sumissões e valores junto, ordenando por data de submissão
SELECT f.title as "form_name", u.name as "user_name", ftc.label as "field", sv.submission_value as "value"
    FROM `forms` f
    JOIN `submissions` s ON f.id = s.form_id
    JOIN `users` u ON u.id = s.user_id
    JOIN `forms_to_components` ftc ON ftc.form_id = f.id
    JOIN `submission_values` sv ON (sv.submission_id = s.id AND sv.component_id = ftc.component_id)
    WHERE f.id = 1
    ORDER BY s.created_at;

-- buscar quais usuários responderam um formulário, e a quantidade de vezes que responderam
SELECT u.name as "user_name", COUNT(s.user_id) as "count"
    FROM `submissions` s
    JOIN `users` u ON u.id = s.user_id
    WHERE s.form_id = 1
    GROUP BY s.user_id
    ORDER BY u.name ASC;

-- buscar quantidades de "sim" e "não" no formulário
SELECT sv.submission_value as "value", COUNT(sv.submission_value) as "count"
    FROM `forms` f
    JOIN `submissions` s ON f.id = s.form_id
    JOIN `forms_to_components` ftc ON ftc.form_id = f.id
    JOIN `submission_values` sv ON (sv.submission_id = s.id AND sv.component_id = ftc.component_id)
    WHERE (f.id = 1 AND sv.component_id = 2)
    GROUP BY sv.submission_value;

-- buscar um formulário por id, e fazer um join com todas as sumissões junto
SELECT * FROM `forms` f JOIN `submissions` s on f.id = s.form_id WHERE f.id = 1;

-- buscar submissões de um usuário com base num nome
SELECT * FROM `submissions` s WHERE s.user_id = (SELECT id FROM `users` u WHERE u.name = "Artur Costa");

-- buscar uma submissão por id e trazer todos os valores e componentes da submissão
SELECT * FROM `submissions` s JOIN `submission_values` sv on s.id = sv.submission_id WHERE s.id = 1;

-- buscar todos os forms pertencentes a um admin
SELECT * FROM `forms` f WHERE f.creator_id = 1;

-- buscar um form e seus componentes por id
SELECT * FROM `forms` f JOIN `forms_to_components` fc on f.id = fc.form_id WHERE f.id = 1;

-- INSERT через команды, так что весь материал к пункту находится в 4-full-model

-- читаем базу
SELECT *
FROM client;


-- можно удалить, что требуется
DELETE *
FROM client
WHERE adress == 'Америка';


-- латинский алфавит
UPDATE client 
SET adress =
    CASE 
        WHEN adress = 'Москва' THEN 'Moscow'
        WHEN adress = 'Санкт-Петербург' THEN 'Saint Petersburg'
        WHEN adress = 'Новосибирск' THEN 'Novosibirsk'
        WHEN adress = 'Екатеринбург' THEN 'Yekaterinburg'
        WHEN adress = 'Казань' THEN 'Kazan'
        WHEN adress = 'Ростов-на-Дону' THEN 'Rostov-on-Don'
        WHEN adress = 'Волгоград' THEN 'Volgograd'
        WHEN adress = 'Нижний Новгород' THEN 'Nizhny Novgorod'
        WHEN adress = 'Челябинск' THEN 'Chelyabinsk'
        WHEN adress = 'Уфа' THEN 'Ufa'
        ELSE adress
    END;


-- INSERT запросы по большей части в 4-full-model

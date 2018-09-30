INSERT INTO categories (name) VALUES
    ('Доски и лыжи'),
    ('Крепления'),
    ('Ботинки'),
    ('Одежда'),
    ('Инструменты'),
    ('Разное');

INSERT INTO users (reg_date, email, name, password, avatar_url, contacts) VALUES
    (NOW(), 'test1@gmail.com', 'Test 1', 'pwd1', 'img/avatar.jpg', ''),
    (NOW(), 'test2@gmail.com', 'Test 2', 'pwd2', 'img/avatar.jpg', '');

INSERT INTO lots (created_at, name, description, image, start_price, finish_date, bet_step, user_id, category_id) VALUES
	(NOW(), '2014 Rossignol District Snowboard', 'Описание', 'img/lot-1.jpg', 10999, '2018-10-15 00:00:00', 100, 1, 1),
	(NOW(), 'DC Ply Mens 2016/2017 Snowboard', 'Описание', 'img/lot-2.jpg', 159999, '2018-10-17 00:00:00', 300, 2, 1),
	(NOW(), 'Крепления Union Contact Pro 2015 года размер L/XL', 'Описание', 'img/lot-3.jpg', 8000, '2018-10-13 00:00:00', 100, 1, 2),
	(NOW(), 'Ботинки для сноуборда DC Mutiny Charocal', 'Описание', 'img/lot-4.jpg', 10999, '2018-10-14 00:00:00', 200, 2, 3),
	(NOW(), 'Куртка для сноуборда DC Mutiny Charocal', 'Описание', 'img/lot-5.jpg', 7500, '2018-10-15 00:00:00', 100, 2, 4),
	(NOW(), 'Маска Oakley Canopy', 'Описание', 'img/lot-6.jpg', 5400, '2018-10-17 00:00:00', 50, 1, 6);

INSERT INTO bets (created_at, bet_amount, user_id, lot_id) VALUES
	('2018-09-25 12:15:00', 8100, 1, 3),
	('2018-09-25 12:51:30', 8500, 2, 3);

--Получить все категории
SELECT * FROM categories;

-- Получить самые новые, открытые лоты. Каждый лот должен включать название, стартовую цену, ссылку на изображение, цену, количество ставок, название категории;
SELECT
    l.name, -- имя лота
    l.start_price,  -- начальная цена лота
    l.image, -- изображение лота
    c.name AS category_name, -- название категории
    (SELECT MAX(b.bet_amount) FROM bets AS b WHERE l.id = b.lot_id) AS max_price, -- максимальная цена за лот
    (SELECT COUNT(1) FROM bets AS b WHERE l.id = b.lot_id GROUP BY b.lot_id) AS bets_count -- количество ставок
FROM
    lots AS l -- выбираем из таблицы lots (псевдоним: l)
LEFT JOIN
    categories AS c 
    ON c.id = l.category_id -- присоединяем к таблице lots таблицу categories, чтобы достать название категории по ее ID
LEFT JOIN
    bets AS b
    ON b.lot_id = l.id -- присоединяем к таблице lots таблицу bets
WHERE
    l.finish_date > NOW() -- выбираем только открытые лоты
GROUP BY
    l.id -- группируем весь результат по ID лота (из-за join'ов и внутренних запросов имеем несколько одинаковых записей, поэтому и группируем их в одну запись)
ORDER BY
    l.created_at DESC; -- сортируем от новых до старых

 -- Показать лот по его ID. Получите также название категории, к которой принадлежит лот.
SELECT
    l.id,
    l.name,
    c.name AS category_name
FROM
    lots AS l
JOIN
    categories AS c
    ON l.category_id = c.id -- присоединяем таблицу категорий, чтобы достать название категории по ее ID
WHERE
    l.id = 1;
    
 -- Обновить название лота по его идентификатору.
UPDATE lots SET name = '2014 Rossignol District Snowboard NEW' WHERE id = 1;

 -- Получить список самых свежих ставок для лота по его идентификатору.
SELECT * FROM bets WHERE lot_id = 1 ORDER BY created_at DESC;
-- больше двух адресов в профиле
SELECT count(adress) AS num_of_adresses
FROM client
GROUP BY _id
HAVING count(adress) >= 3;


-- больше двух отзывов
SELECT *
FROM feedback
WHERE author_id IN
(SELECT author_id
  FROM (SELECT author_id, count(book_id) AS book_count
         FROM feedback
         GROUP BY author_id) AS htable
  WHERE htable.book_count > 1)
ORDER BY author_id;


-- средний год книги (партируя по цене)
SELECT title,
	avg(year_of_publishing) OVER (PARTITION BY price) AS avg_date_from_price
FROM book;


-- средний год возрастания (ранжирование по цене)
SELECT title,
	avg(year_of_publishing) OVER (ORDER BY price) AS avg_date_from_price
FROM book
ORDER BY price;


-- средние отзывы over time
SELECT author_id,
	avg(score) OVER (PARTITION BY author_id ORDER BY _date) AS avg_score_from_time
FROM feedback
ORDER BY author_id;


-- положение оценки автора по отношению к другим авторам
SELECT *,
	DENSE_RANK() OVER (ORDER BY avg_score) AS position_of_avg
FROM (SELECT min(author_id) OVER (PARTITION BY author_id) AS author_id,
	  avg(score) OVER (PARTITION BY author_id) AS avg_score,
	  FIRST_VALUE(score) OVER (PARTITION BY author_id) AS min_of_score
	  FROM feedback
	  ORDER BY min_of_score) AS fo;

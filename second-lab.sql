SELECT * 
FROM Product;

-- 1. БД «Комп. фірма». Вивести моделі ПК із кількістю RAM більшою
-- за 64 Мб. Вивести: model, ram, price. Вихідні дані впорядкувати за
-- зростанням за стовпцем hd.

SELECT model, ram, price 
FROM PC
WHERE ram >= 64;

-- 2. БД «Фірма прий. вторсировини». З таблиці Outcome вивести всю
-- інформацію за березень місяць.

SELECT * 
FROM Outcome
WHERE date LIKE '%-03-%';

-- 3. БД «Комп. фірма». Виведіть усі можливі моделі ПК, їх виробників
-- та ціну (якщо вона вказана). Вивести: maker, model, price.

SELECT maker, Product.model, price 
FROM Product 
JOIN PC ON Product.model = PC.model;

-- 4. БД «Комп. фірма». Знайти тих виробників ПК, усі моделі ПК яких є
-- в наявності в таблиці PC (використовувати вкладені підзапити та
-- оператори IN, ALL, ANY). Вивести maker.

SELECT maker FROM product 
WHERE model IN (SELECT model FROM pc) 
GROUP BY maker;

-- 5. БД «Комп. фірма». Виведіть тих виробників ноутбуків, які також
-- випускають і принтери. Вивести maker.

SELECT DISTINCT maker
FROM product
WHERE type = 'Laptop' and maker in (SELECT maker from product WHERE type = 'Printer');

-- 6. БД «Аеропорт». Вивести дані для таблиці Trip з об’єднаними зна-
-- ченнями двох стовпців: town_from та town_to, з додатковими комента-
-- рями типу: 'from Rostov to Paris'.

SELECT CONCAT('from ', town_from, ' to ', town_to)
FROM Trip;

-- 7. БД «Комп. фірма». Знайдіть ноутбуки, швидкість яких є меншою за
-- швидкість будь-якого з ПК. Вивести: type, model, speed.

SELECT type, laptop.model, laptop.speed FROM product
JOIN laptop
ON product.model = laptop.model
WHERE speed < ANY(SELECT min(speed) from pc);

-- 8. БД «Кораблі». Вкажіть назву та країну кораблів, що були потоплені
-- в битвах, але лише для тих кораблів, для яких ця інформація є відо-
-- мою. Вивести: ship, country. (Підказка: використовувати підзапити в
-- якості обчислювальних стовпців та перевірку на NULL)

SELECT ship, country
FROM classes 
JOIN (SELECT * FROM outcomes JOIN ships ON outcomes.ship = ships.name
WHERE result = 'sunk') as subquery ON classes.class =subquery.class;

-- 9. БД «Комп. фірма». Для таблиці Product отримати підсумковий набір
-- у вигляді таблиці зі стовпцями maker, laptop, у якій для кожного ви-
-- робника необхідно вказати, чи виробляє він ('yes'), чи ні ('no')
-- відповідний тип продукції. У першому випадку ('yes') додатково
-- вказати поруч у круглих дужках загальну кількість наявної (тобто, що
-- знаходиться в таблиці Laptop) продукції, наприклад, 'yes(2)'. (Підказка:
-- використовувати підзапити в якості обчислювальних стовпців та
-- оператор CASE)

SELECT DISTINCT Product.maker,
CASE
WHEN form.count IS NOT NULL THEN CONCAT('yes(', form.count, ')')
ELSE 'no' END AS Laptop FROM Product
LEFT JOIN (SELECT maker, COUNT(*) AS COUNT FROM Laptop
JOIN Product ON Laptop.model = Product.model GROUP BY maker) AS form ON Product.maker = form.maker
ORDER BY maker ASC;

-- 10. БД «Кораблі». Перерахуйте назви головних кораблів, що є наявни-
-- ми в БД (врахувати також і кораблі з таблиці Outcomes). Вивести:
-- назва корабля, class. (Підказка: використовувати оператор UNION та
-- операцію EXISTS)

SELECT CASE WHEN COUNT(DISTINCT Classes.class) = COUNT(Classes.class) 
THEN Classes.class END AS unique_ship FROM Classes
UNION
SELECT CASE WHEN COUNT(DISTINCT Ships.class) = COUNT(Ships.class)
THEN Ships.class END FROM Ships;
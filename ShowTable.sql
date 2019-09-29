USE tempdb;
GO
DECLARE @udate smalldatetime = '21.03.2007';								-- Дата задается через интерфейс и передается в скрипт в виде переменной, для примера установлена дата 22.03.2007
DECLARE @countrow smallint;													-- Для количества параметров
SELECT @countrow = COUNT(*) FROM params;									-- Определение количества параметров
DECLARE @query varchar(max);												-- Переменная для запроса
SET @query = 'SELECT id_object,';											-- Добавление начала запроса, вывод id_object как левая колонка
DECLARE @i smallint = 1														-- Переменная для цикла

WHILE @i <= @countrow 														
	BEGIN
		DECLARE @name varchar(50)											-- Создание временной переменной name для хранения названий параметров
		SELECT @name = [name] FROM params WHERE id_param = @i				-- Определение названия параметра в данной точке цикла
		SET @query = @query + 'SUM(CASE WHEN id_param = ' + CAST(@i			-- Создание запроса, выборка по id_param `p.s. sum для унификации параметра в select
		AS varchar(10)) + ' THEN [value] END) AS [' + @name + '],';			-- Установка имени параметра как alias
		SET @i = @i + 1														-- Инкремент
	END;
SET @query = REVERSE(STUFF(REVERSE(@query),1,1,' '));						-- Удаление лишней запятой, образовавшейся в результате цикла

SET @query = @query +'FROM objects_params WHERE (cdate = (SELECT max(cdate) 
FROM objects_params WHERE cdate <= ' + QUOTENAME(@udate, '''') + 
')) GROUP BY id_object ORDER BY id_object ASC;'								-- Добавление информации о используемой таблице, определении актуальной даты и группировка по id_object и сортировка по возрастанию
EXECUTE ( @query );															-- Выполение задуманного запроса
GO

USE tempdb;
GO
CREATE TABLE params
( id_param    smallint PRIMARY KEY NOT NULL	-- идентификатор параметра
, [name]      varchar(50)					-- название параметра 
);
GO
CREATE TABLE objects_params
( id_object   int NOT NULL					-- идентификатор объекта
, id_param    smallint NOT NULL				-- идентификатор параметра
, cdate       smalldatetime					-- дата начала действия значения параметра
, [value]     int							-- значение
, FOREIGN KEY (id_param) REFERENCES params (id_param) ON DELETE CASCADE
);
GO
PRINT 'Tables created!';
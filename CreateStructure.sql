USE tempdb;
GO
CREATE TABLE params
( id_param    smallint PRIMARY KEY NOT NULL	-- ������������� ���������
, [name]      varchar(50)					-- �������� ��������� 
);
GO
CREATE TABLE objects_params
( id_object   int NOT NULL					-- ������������� �������
, id_param    smallint NOT NULL				-- ������������� ���������
, cdate       smalldatetime					-- ���� ������ �������� �������� ���������
, [value]     int							-- ��������
, FOREIGN KEY (id_param) REFERENCES params (id_param) ON DELETE CASCADE
);
GO
PRINT 'Tables created!';
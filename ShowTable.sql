USE tempdb;
GO
DECLARE @udate smalldatetime = '21.03.2007';								-- ���� �������� ����� ��������� � ���������� � ������ � ���� ����������, ��� ������� ����������� ���� 22.03.2007
DECLARE @countrow smallint;													-- ��� ���������� ����������
SELECT @countrow = COUNT(*) FROM params;									-- ����������� ���������� ����������
DECLARE @query varchar(max);												-- ���������� ��� �������
SET @query = 'SELECT id_object,';											-- ���������� ������ �������, ����� id_object ��� ����� �������
DECLARE @i smallint = 1														-- ���������� ��� �����

WHILE @i <= @countrow 														
	BEGIN
		DECLARE @name varchar(50)											-- �������� ��������� ���������� name ��� �������� �������� ����������
		SELECT @name = [name] FROM params WHERE id_param = @i				-- ����������� �������� ��������� � ������ ����� �����
		SET @query = @query + 'SUM(CASE WHEN id_param = ' + CAST(@i			-- �������� �������, ������� �� id_param `p.s. sum ��� ���������� ��������� � select
		AS varchar(10)) + ' THEN [value] END) AS [' + @name + '],';			-- ��������� ����� ��������� ��� alias
		SET @i = @i + 1														-- ���������
	END;
SET @query = REVERSE(STUFF(REVERSE(@query),1,1,' '));						-- �������� ������ �������, �������������� � ���������� �����

SET @query = @query +'FROM objects_params WHERE (cdate = (SELECT max(cdate) 
FROM objects_params WHERE cdate <= ' + QUOTENAME(@udate, '''') + 
')) GROUP BY id_object ORDER BY id_object ASC;'								-- ���������� ���������� � ������������ �������, ����������� ���������� ���� � ����������� �� id_object � ���������� �� �����������
EXECUTE ( @query );															-- ��������� ����������� �������
GO

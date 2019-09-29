USE tempdb;
GO
DELETE FROM objects_params;
DELETE FROM params;
DROP TABLE objects_params;
DROP TABLE params;
PRINT 'Tables cleaned and deleted!';
GO
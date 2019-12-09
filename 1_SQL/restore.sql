-- use master;
-- go

-- RESTORE filelistonly
-- FROM disk = 'AdventureWorks2017.bak';

-- restore database AdventureWorks2019
-- from disk = 'AdventureWorks2017.bak'
-- with
-- -- restore filelistonly,
-- move 'AdventureWorks2017' to '/var/opt/mssql/data/aw2017.mdf',
-- move 'AdventureWorks2017_log' to '/var/opt/mssql/data/aw2017_log.ldf'
-- -- move 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQL2017RTM\MSSQL\DATA\AdventureWorks2017.mdf' to 'AdventureWorks2017.mdf',
-- -- move 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQL2017RTM\MSSQL\DATA\AdventureWorks2017_log.ldf' to 'AdventureWorks2017_log.ldf'

use master;
go

RESTORE FILELISTONLY
FROM disk = 'AdventureWorks2017.bak';

restore database AdventureWorks2017
from disk = 'AdventureWorks2017.bak'
with
move 'AdventureWorks2017' to '/var/opt/mssql/data/aw2017.mdf'
,move 'AdventureWorks2017_log' to '/var/opt/mssql/data/aw2017_log.ldf';
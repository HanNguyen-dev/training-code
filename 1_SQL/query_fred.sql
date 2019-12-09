use AdventureWorks2017;
go

-- view
create view vw_Person
as
select firstname, lastname
from Person.Person;
go

alter view vw_Person with schemabinding
as
select firstname, lastname
from Person.Person;
go

select * from vw_Person;
go

-- function
create function fn_Person(@first nvarchar(50))
returns table
as
return
select firstname, lastname
from Person.Person
where FirstName = @first;
go

create function fn_FullName(@first nvarchar(50), @middle nvarchar(50), @last nvarchar(50))
returns nvarchar(200)
as
begin
    --return @first + ' ' + @middle + ' ' + @last
    return @first + coalesce(' ' + @middle, '', null, null) + ' ' + @last
    --return @first + isnull(isnull(isnull(' ' + @middle, ''), null), null) + ' ' + @last
end;
go

select dbo.fn_FullName(firstname, null, lastname) as full_name from fn_Person('joshua');
go

-- stored procedure
create procedure sp_InsertName(@first nvarchar(50), @middle nvarchar(50), @last nvarchar(50))
as
begin
    begin transaction
        begin try
            declare @mname nvarchar(50) = @middle

            if(@mname is null)
            begin
                set @mname = ''
            end

            checkpoint --savepoint

            insert into Person.Person(FirstName, LastName, MiddleName)
            values (@first, @last, @mname)
            
            commit transaction
        end try

        begin catch
            print error_message()
            print error_line()
            print error_severity()
            print error_state()
            print error_number()
            rollback transaction
        end catch
end;

execute sp_InsertName 'fred', null, 'belotte';
go

-- trigger
create trigger tr_InsertName 
on Person.Person
instead of insert
as
update pp
set firstname = inserted.firstname
from Person.Person as pp
where pp.BusinessEntityID = inserted.BusinessEntityID;

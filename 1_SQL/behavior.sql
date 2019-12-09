USE AdventureWorks2017;
GO

CREATE VIEW vw_Person WITH SCHEMABINDING
AS
SELECT firstname, lastname
FROM Person.Person;
GO
-- this is unsafe, if firstname, lastname changes column - this will fail.
-- ?? cannot be orphan
-- The person table change its firstname, lastname unless the VIEW allow it.  Can't drop the person table.  Datatype can change, but the name of the column cannot change.

ALTER VIEW vw_Person WITH SCHEMABINDING
AS
SELECT firstname, lastname
FROM Person.Person;
GO

SELECT * FROM vw_Person;
GO -- go gives its own container


-- text data type,  -- text (same as nvarchar)
                    -- ntext
                    -- char - text with the exact number of characters, it will be padded or truncated if it is not the exact same length. ascii
                    -- varchar - up to the upper limit no matter the number of characters. ascii
                    -- nchar
                    -- nvarchar - n mean unicode of type UTF-8
                    -- nvarchar(max) - the maximum size of a file on that specific filesystem
                    --

-- function
-- reverse of C#
CREATE FUNCTION fn_Person(@first nvarchar(50))
RETURNS TABLE -- this a tabular function
AS
RETURN
SELECT firstname, lastname
FROM Person.Person
WHERE FirstName = @first;
GO

-- SELECT * FROM fn_Person('joshua');

CREATE FUNCTION fn_FullName(@first NVARCHAR(50), @middle NVARCHAR(50), @last NVARCHAR(50))
RETURNS NVARCHAR(200)
AS
BEGIN   -- there is query, so begin and end is required.
    -- RETURN @first + ' ' + @middle + ' ' + @last
    -- coalesce if the first parameter isn't null, it will be return, if not the second parameter will be return.  If all terms are null, then it will return null.
    -- RETURN @first + coalesce(' ' + @middle, '', null, null) + ' ' + @last
    RETURN @first + isnull(' ' + @middle, '') + ' ' + @last -- isnull is a T-SQL thing
    RETURN @first + ISNULL(ISNULL(ISNULL(' ' + @middle, ''), null), null);
END;
GO

select dbo.fn_FullName(FirstName, null, lastname) as fullname FROM fn_person('joshua');

SELECT * FROM fn_Person('joshua');
GO

-- stored procedure aka proc, procedures are cached thus it is called stored.  Have logical statement
-- @ - within the scope that was created in.
-- @@ - globally available in the session.

CREATE PROCEDURE sp_InsertName(@first nvarchar(50), @middle nvarchar(50), @last nvarchar(50))
AS
BEGIN
    BEGIN TRANSACTION
        BEGIN TRY
        DECLARE @mname NVARCHAR(50) = @middle;

        IF (@middle is NULL)
        BEGIN
            set @mname = ''
        END

        CHECKPOINT

        INSERT INTO Person.Person(FirstName, LastName, MiddleName)
        values(@first, @last, @mname)
        COMMIT TRANSACTION
        END TRY

        BEGIN CATCH
            print error_message()  -- what the error is
            print error_severity() -- 5 levels of severity, level 1 - db and hardware error, level 2 - permission,level 3 - issues with the data, level 4 - , level 5 is a warning "should be doing it"
            print error_state()    -- internal error vs an external error
            print error_number()   -- under 10,000 by SQL, above 10,000 is generated by the user or dba
            ROLLBACK TRANSACTION
        END CATCH
END;
GO
-- transactions have savepoints or checkpoints
-- In T-SQL rollback the whole things instead of to the savepoint (would not atomic)

EXECUTE sp_InsertName 'fred', NULL, 'belotte';
GO
-- TRIGGER are sql event attached to SQL dml statement.
    -- BEFORE will run its query before the dml statement that raise the event
    -- FOR will run in parallel to the dml statement
    -- INSTEADOF will run instead of the dml statement

CREATE TRIGGER tr_InsertName
ON Person.Person
INSTEAD OF INSERT
AS
UPDATE PP --Person.Person
SET firstname = inserted.firstname
-- SELECT i.FirstName
-- FROM inserted AS i
FROM Person.Person as pp
WHERE pp.BusinessEntityID = inserted.BusinessEntityID;

-- inserted create a temporary table then inserted into that temporary table.
-- Insert table, delete table, update uses both

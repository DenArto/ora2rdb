insert into companies (lob_column)
select TO_LOB(long_column) from suppliers;
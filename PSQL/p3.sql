DROP FUNCTION func3(cust_account TEXT,cust_name TEXT, cust_province TEXT, cust_crlimit INTEGER);

CREATE OR REPLACE FUNCTION func3(cust_account TEXT,cust_name TEXT, cust_province TEXT, cust_crlimit INTEGER) 
RETURNS TABLE(cust_account2 TEXT,cust_name2 TEXT, cust_province2 TEXT, cust_balance DECIMAL(10,2), cust_crlimit2 INTEGER) as $$
  DECLARE
    
  BEGIN
    INSERT INTO Customer (Account,Cname, Province, CBalance, Crlimit)
    VALUES (cust_account, cust_name, cust_province , 0, cust_crlimit);
    return query
    SELECT * FROM Customer;

  END;
$$ LANGUAGE PLPGSQL;
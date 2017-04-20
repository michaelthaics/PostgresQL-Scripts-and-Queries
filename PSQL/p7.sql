DROP FUNCTION func7();

CREATE OR REPLACE FUNCTION func7() returns void AS $$

  DECLARE

    cust_names TEXT;
    cust_balance DECIMAL(10,2);
    cust_limit INTEGER;

    c1 CURSOR FOR SELECT Cname, Cbalance, Crlimit  FROM Customer;

  BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO cust_names, cust_balance, cust_limit;
      EXIT WHEN NOT FOUND;
      
      IF ( cust_balance > cust_limit)THEN
	RAISE NOTICE 'Customers over credit limit';
	UPDATE customer SET Cbalance = Cbalance + (Cbalance * 0.1) WHERE Cname = cust_names;
	RAISE NOTICE 'Customer Name: %', cust_names;
	RAISE NOTICE 'New Balance: %', cust_balance + (cust_balance * 0.1);
	RAISE NOTICE '';
      END IF;
    END LOOP;
    CLOSE c1;

  END;
$$ LANGUAGE PLPGSQL;
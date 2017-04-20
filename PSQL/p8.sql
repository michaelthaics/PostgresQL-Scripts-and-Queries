DROP FUNCTION func8(transaction_number TEXT,vendor_number TEXT,cust_account TEXT,transaction_amount DECIMAL(10,2));

CREATE OR REPLACE FUNCTION func8(transaction_number TEXT,vendor_number TEXT,cust_account TEXT,transaction_amount DECIMAL(10,2))
RETURNS VOID AS $$
  DECLARE
    transaction_date Date = CURRENT_DATE;
    v_num TEXT;
    v_name TEXT;
    v_city TEXT;
    v_balance DECIMAL(10,2);
    c_num TEXT;
    c_name TEXT;
    c_province TEXT;
    c_balance DECIMAL(10,2);
    c_crlimit INTEGER;

    c1 CURSOR FOR SELECT Vno, Vname, City, Vbalance FROM Vendor ORDER BY Vno;
    c2 CURSOR FOR SELECT Account, Cname, Province, Cbalance, Crlimit FROM Customer ORDER BY Account;
  BEGIN
    RAISE NOTICE 'New Transaction Information:  Tno: %   Vno: %   Acct No.: %   Date: %    Amount: $%', transaction_number, vendor_number, cust_account, transaction_date, transaction_amount;
    INSERT INTO Transaction (Tno, Vno, Account, T_Date, Amount)
    VALUES (transaction_number, vendor_number, cust_account, transaction_date, transaction_amount);

    UPDATE Vendor SET Vbalance = Vbalance + transaction_amount WHERE vendor_number = Vendor.Vno;
    UPDATE Customer SET Cbalance = Cbalance + transaction_amount WHERE cust_account = Customer.Account;

    OPEN c1;
    LOOP 
      FETCH c1 INTO v_num, v_name, v_city, v_balance;
      EXIT WHEN NOT FOUND;
      RAISE NOTICE 'Vendor No: %   Vendor Name: %   City: %   Balance: %', v_num, v_name, v_city, v_balance;
    END LOOP;
    CLOSE c1;

    OPEN c2;
    LOOP 
      FETCH c2 INTO c_num, c_name, c_province, c_balance, c_crlimit;
      EXIT WHEN NOT FOUND;
      RAISE NOTICE 'Account No.: %   Name: %   Province: %   Balance: %   Credit Limit: %', c_num, c_name, c_province, c_balance, c_crlimit;
    END LOOP;
    CLOSE c2;

  END;
$$ LANGUAGE PLPGSQL;
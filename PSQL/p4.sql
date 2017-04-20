DROP FUNCTION func4();

CREATE OR REPLACE FUNCTION func4() returns void AS $$

  DECLARE
    account_number TEXT;
    cust_name TEXT;
    trans_amount DECIMAL(10,2);
    vendor_name TEXT;
    c1 CURSOR FOR SELECT Customer.Account, Cname, Amount, Vname FROM Transaction, Customer, Vendor 
    WHERE Customer.Account = Transaction.Account AND Transaction.Vno = Vendor.Vno AND 
    T_Date = (SELECT MAX(T_Date) FROM Transaction WHERE Customer.Account = Transaction.Account);
  BEGIN
    open c1;
    LOOP
      FETCH c1 INTO account_number, cust_name, trans_amount, vendor_name;
      EXIT WHEN NOT FOUND;
      RAISE NOTICE 'Account Number: %', account_number;
      RAISE NOTICE 'Customer Name: %', cust_name;
      RAISE NOTICE 'Transaction Amount: %', trans_amount;
      RAISE NOTICE 'Vendor Name: %', vendor_name;
  
    END LOOP;
     close c1;
  END;
$$ LANGUAGE PLPGSQL;



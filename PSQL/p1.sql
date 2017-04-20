DROP FUNCTION func1 (name TEXT);

CREATE OR REPLACE FUNCTION func1(name TEXT) returns void as $$
  DECLARE
    vendorName TEXT;
    transDate Date;
    trans_Amount DECIMAL(10,2);
    c1 CURSOR FOR SELECT Vname, T_Date, Amount FROM Vendor, Customer, Transaction
    WHERE Customer.Account = Transaction.Account AND Transaction.Vno = Vendor.Vno AND Customer.Cname = name;
  BEGIN
    OPEN c1;
    
    LOOP
      FETCH c1 INTO vendorName, transDate, trans_Amount;
      EXIT WHEN NOT FOUND;
      RAISE NOTICE 'Vendor Name: %', vendorName;
      RAISE NOTICE 'Transaction Date %', transDate;
      RAISE NOTICE 'Amount %', trans_Amount;
      RAISE NOTICE '';
    END LOOP;
    CLOSE c1;
  END;
$$ LANGUAGE PLPGSQL;


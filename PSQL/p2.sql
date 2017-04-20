DROP FUNCTION func2(vendorName TEXT);

CREATE OR REPLACE FUNCTION func2(vendorName TEXT) returns void as $$
  DECLARE

    cust_account TEXT;
    cust_name TEXT;
    cust_province TEXT;
    c1 CURSOR FOR SELECT Customer.Account, Cname, Province FROM Vendor, Customer, Transaction
    WHERE Customer.Account = Transaction.Account AND Transaction.Vno = Vendor.Vno AND Vendor.Vname = vendorName;
  BEGIN
    OPEN c1;

    LOOP
      FETCH c1 INTO cust_account, cust_name, cust_province;
      EXIT WHEN NOT FOUND;
      RAISE NOTICE 'Customer Account: %', cust_account;
      RAISE NOTICE 'Customer Name: %', cust_name;
      RAISE NOTICE 'Province: %', cust_province;
      RAISE NOTICE '';
    END LOOP;
    CLOSE c1;
  END;
$$ LANGUAGE PLPGSQL;
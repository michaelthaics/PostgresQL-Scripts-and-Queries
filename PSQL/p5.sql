DROP FUNCTION func5();

CREATE OR REPLACE FUNCTION func5() returns void AS $$

  DECLARE
    vendor_numbers TEXT;
    vendor_names TEXT;
    current_balance DECIMAL(10,2);
    trans_amount DECIMAL(10,2);

    c1 CURSOR FOR SELECT Transaction.Vno,SUM(Amount) FROM Transaction, Vendor
    WHERE Transaction.Vno = Vendor.Vno GROUP BY Transaction.Vno;
    
    c2 CURSOR FOR SELECT DISTINCT Transaction.Vno, Vname, Vbalance FROM Vendor,Transaction WHERE Vendor.Vno = Transaction.Vno;

  BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO vendor_numbers, trans_amount;
      EXIT WHEN NOT FOUND;
      UPDATE Vendor SET Vbalance = Vbalance + trans_amount WHERE vendor_numbers = Vendor.Vno;
    END LOOP;
    CLOSE c1;

    OPEN c2;
    LOOP
      FETCH c2 INTO vendor_numbers, vendor_names, current_balance;
      EXIT WHEN NOT FOUND;
      RAISE NOTICE 'Vendor No.: %', vendor_numbers;
      RAISE NOTICE 'Vname: %', vendor_names;
      RAISE NOTICE 'Balance: %', current_balance;
    END LOOP;
    CLOSE c2;
    

  END;
$$ LANGUAGE PLPGSQL;
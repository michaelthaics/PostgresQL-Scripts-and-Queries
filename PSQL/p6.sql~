DROP FUNCTION func6();

CREATE OR REPLACE FUNCTION func6() returns void AS $$

  DECLARE

    vendor_names TEXT;
    current_balance DECIMAL(10,2);
    deductibles DECIMAL(10,2);

    c1 CURSOR FOR SELECT Vname, Vbalance FROM Vendor;

  BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO vendor_names, deductibles;
      EXIT WHEN NOT FOUND;
	UPDATE Vendor SET Vbalance = Vbalance - (Vbalance * 0.04) WHERE Vname = vendor_names;
	RAISE NOTICE 'Vendor Name: %', vendor_names;
	RAISE NOTICE 'Amount Deducted: %', (deductibles*0.04);
	RAISE NOTICE 'New Balance: %', (deductibles - deductibles*0.04);
	RAISE NOTICE '';
    END LOOP;
    CLOSE c1;

  END;
$$ LANGUAGE PLPGSQL;
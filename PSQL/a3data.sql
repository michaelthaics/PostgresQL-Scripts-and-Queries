DROP TABLE Transaction;
DROP TABLE Vendor;
DROP TABLE Customer;

CREATE TABLE Vendor 
(
Vno TEXT PRIMARY KEY,
Vname TEXT NOT NULL,
City TEXT NOT NULL,
VBalance DECIMAL(10,2) NOT NULL
);

INSERT INTO Vendor (Vno, Vname, City, VBalance)
VALUES ('V1', 'Sears' , 'Toronto', 200.00);

INSERT INTO Vendor (Vno, Vname, City, VBalance)
VALUES ('V2', 'WalMart', 'Waterloo', 671.05);

INSERT INTO Vendor (Vno, Vname, City, VBalance)
VALUES ('V3', 'ESSO', 'Windsor', 0.00);

INSERT INTO Vendor (Vno, Vname, City, VBalance)
VALUES ('V4', 'ESSO', 'Waterloo', 225.00);

CREATE TABLE Customer
(
Account TEXT PRIMARY KEY, 
Cname TEXT NOT NULL, 
Province TEXT NOT NULL, 
CBalance DECIMAL(10,2) NOT NULL, 
Crlimit INTEGER NOT NULL
);

INSERT INTO Customer (Account,Cname, Province, CBalance, Crlimit)
VALUES ('A1', 'Smith', 'ONT' , 2515.00, 2000);

INSERT INTO Customer (Account,Cname, Province, CBalance, Crlimit)
VALUES ('A2', 'Jones', 'BC', 2014.00, 2500);

INSERT INTO Customer (Account,Cname, Province, CBalance, Crlimit)
VALUES ('A3', 'Doc', 'ONT', 150.00, 1000);

CREATE TABLE Transaction
(
Tno TEXT PRIMARY KEY, 
Vno TEXT REFERENCES Vendor(Vno),
Account TEXT REFERENCES Customer(Account), 
T_Date Date NOT NULL,
Amount DECIMAL(10,2) NOT NULL
);

INSERT INTO Transaction (Tno, Vno, Account, T_Date, Amount)
VALUES ('T1', 'V2', 'A1', '2015-07-15', 1325.00);

INSERT INTO Transaction (Tno, Vno, Account, T_Date, Amount)
VALUES ('T2', 'V2', 'A3', '2014-12-16', 1900.00);

INSERT INTO Transaction (Tno, Vno, Account, T_Date, Amount)
VALUES ('T3', 'V3', 'A1', '2015-09-01', 2500.00);

INSERT INTO Transaction (Tno, Vno, Account, T_Date, Amount)
VALUES('T4', 'V4', 'A2', '2015-03-20', 1613.00);

INSERT INTO Transaction (Tno, Vno, Account, T_Date, Amount)
VALUES('T5', 'V4', 'A3', '2015-07-31', 3312.00);
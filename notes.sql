INSERT INTO CUSTOMER
(Custno, Custfirstname, Custlastname, Custstreet, CustCity, custState, Custzip, custbal)
VALUES
('C9999999', 'Jake', 'Ildefonso', 'StreetAddressHere', 'Kaysville', 'UT', '84037', 0.0)
SAVEPOINT Step1; --points for rollback
UPDATE CUSTOMER
SET custzip = '84041-1111' --updated value
WHERE custNo = 'C9999999';
SAVEPOINT Step2;
DELETE FROM customer
WHERE custno = 'C9999999'
SAVEPOINT step3;

ROLLBACK; --back to beginning
ROLLBACK TO step1; --undoes everything to a given savepoint

--All things are stored in memory and are temporary until committed

SELECT * ordline FROM ordline
INSERT INTO Ordline --subquery for inserting MULTIPLE lines
(Ordno, Prodno, qty)
(SELECT 'O1116324', Prodno, 5 --lines to be inserted
FROM product
WHERE ProdMFG = 'Connex');

SELECT * FROM Ordline WHERE Ordno = 'O1116324';
--Integrity Constrains

--IC1
CREATE OR REPLACE FUNCTION tg_insert_reservation_proc()
RETURNS TRIGGER AS
$$
DECLARE cursor_reservation CURSOR FOR
    SELECT * FROM reservation;
declare reserva reservation%ROWTYPE;
BEGIN
    OPEN cursor_reservation;
    LOOP
        FETCH cursor_reservation INTO reserva;
        IF reserva IS NULL THEN
            EXIT;
        ELSIF (new.start_date <= reserva.end_date) AND (new.end_date >= reserva.start_date) THEN
            RAISE EXCEPTION 'Reservation_Overlap' USING HINT ='The reservation overlaps with another on the data base';
        END IF;
    END LOOP;
    CLOSE cursor_reservation;
    RETURN new;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER tg_insert_reservation ON reservation;
CREATE TRIGGER tg_insert_reservation
BEFORE INSERT OR UPDATE ON reservation
FOR EACH ROW EXECUTE PROCEDURE tg_insert_reservation_proc();

--IC2
--pescadinha de rabo na boca
-- código do prof
DROP TRIGGER IF EXISTS tg_verify_account ON borrower;

CREATE CONSTRAINT TRIGGER tg_verify_account
AFTER INSERT ON borrower DEFERRABLE
FOR EACH ROW EXECUTE PROCEDURE verify_account();

START TRANSACTION;
SET CONSTRAINTS ALL DEFERRED;
INSERT INTO customer VALUES('Alberto','Rua 1','Lisboa');
INSERT INTO loan VALUES('1111', 'Central', 100);
-- begin (inserting in borrower before depositor would not be possible without deferring)
INSERT INTO borrower VALUES('Alberto', '1111');
INSERT INTO depositor VALUES('Alberto', 'A-101');
-- end (inserting in borrower before depositor would not be possible without deferring)
COMMIT; -- trigger will be fired here
-- fim do codigo do prof

--IC3
CREATE OR REPLACE FUNCTION tg_check_country_proc()
RETURNS TRIGGER AS
$$
BEGIN
    IF (SELECT count(DISTINCT (latitude,longitude)) -- distinct is implicit since lat,long are PK --count(*)
        FROM location
        WHERE iso_code=new.iso_code)<1
    THEN
    RAISE EXCEPTION 'Country does not have at least one location';
    END IF;
RETURN new;
END ;
$$ LANGUAGE plpgsql;

DROP TRIGGER tg_check_country ON boat;
CREATE TRIGGER tg_check_country
BEFORE INSERT OR UPDATE ON boat
FOR EACH ROW EXECUTE PROCEDURE tg_check_country_proc();




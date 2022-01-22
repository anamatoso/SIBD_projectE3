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
        if reserva is null then
            exit;
        elsif (new.start_date <= reserva.end_date) and (new.end_date >= reserva.start_date) then
            raise exception 'Reservation_Overlap' using hint ='The reservation overlaps with another on the data base';
        end if;
    end loop;
    close cursor_reservation;
    return new;
END;
$$ LANGUAGE plpgsql;

drop trigger tg_insert_reservation on reservation;
create trigger tg_insert_reservation
before insert or update ON reservation
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
begin
    if (select count(distinct (latitude,longitude)) -- distinct is implicit since lat,long are PK --count(*)
        from location
        where iso_code=new.iso_code)<1
    then
    raise exception 'Country does not have at least one location';
    end if;
return new;
end;
$$ language plpgsql;

drop trigger tg_check_country on boat;
create trigger tg_check_country
before insert or update on boat
for each row execute procedure tg_check_country_proc();




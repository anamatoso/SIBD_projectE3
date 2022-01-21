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
        if (new.start_date <= reserva.end_date) and (new.end_date >= reserva.start_date) then
            raise exception 'Reservation_Overlap' using hint ='The reservation overlaps with another on the data base';
        end if;
    end loop;
    return new;
    close cursor_reservation;
END;
$$ LANGUAGE plpgsql;

--drop trigger tg_insert_reservation on reservation;
create trigger tg_insert_reservation
before insert or update ON reservation
FOR EACH ROW EXECUTE PROCEDURE tg_insert_reservation_proc();

--IC2
--pescadinha de rabo na boca

--IC3
CREATE OR REPLACE FUNCTION tg_check_country_proc()
RETURNS TRIGGER AS
$$
begin
    if (select count(distinct latitude,longitude) -- distinct is implicit since lat,long are PK --count(*)
        from location
        where iso_code=new.iso_code)<1
    then
    raise exception 'Country does not have at least one location';
    end if;
return new;
end;
$$ language plpgsql;

--drop trigger tg_check_country on boat;
CREATE TRIGGER tg_check_country
before insert or update on boat
FOR EACH ROW EXECUTE PROCEDURE tg_check_country_proc();





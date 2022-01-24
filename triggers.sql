-- TRIGGERS to ensure the app functions properly

-- verify if sailor is already owner (aka in table person) before inserting
CREATE OR REPLACE FUNCTION chk_sailor_proc() RETURNS TRIGGER AS
$$
BEGIN
    IF (NEW.id,NEW.iso_code) NOT IN (SELECT id,iso_code FROM person) THEN
        INSERT INTO person VALUES(id, name, iso_code);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER chk_sailor
BEFORE INSERT ON sailor
FOR EACH ROW EXECUTE PROCEDURE chk_sailor_proc();


-- verify if owner is already sailor (aka in table person) before inserting
-- verify if sailor is also owner (aka in table person) before deleting
-- verify if owner is also sailor (aka in table person) before deleting

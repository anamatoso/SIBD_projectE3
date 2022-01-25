-- TRIGGERS to ensure the app functions properly

-- verify if sailor is already owner (aka in table person) before inserting
CREATE OR REPLACE FUNCTION chk_person_proc() RETURNS TRIGGER AS
$$
BEGIN
    IF (NEW.id,NEW.iso_code) IN (SELECT id,iso_code FROM person) THEN
        RETURN NULL;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER chk_person ON person;
CREATE TRIGGER chk_person
BEFORE INSERT ON person
FOR EACH ROW EXECUTE PROCEDURE chk_person_proc();

-- old
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
CREATE OR REPLACE FUNCTION chk_sailor_del_proc() RETURNS TRIGGER AS
$$
BEGIN
    IF (OLD.id,OLD.iso_code) NOT IN (SELECT id,iso_code FROM owner) THEN --not owner
        DELETE FROM person WHERE id=OLD.id AND iso_code=OLD.iso_code;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS chk_sailor_del ON sailor;
CREATE TRIGGER chk_sailor_del
AFTER DELETE ON sailor
FOR EACH ROW EXECUTE PROCEDURE chk_sailor_del_proc();

-- verify if owner is also sailor (aka in table person) before deleting
CREATE OR REPLACE FUNCTION chk_owner_del_proc() RETURNS TRIGGER AS
$$
BEGIN
    IF (OLD.id,OLD.iso_code) NOT IN (SELECT id,iso_code FROM sailor) THEN --not sailor
        DELETE FROM person WHERE id=OLD.id AND iso_code=OLD.iso_code;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS chk_owner_del ON owner;
CREATE TRIGGER chk_owner_del
AFTER DELETE ON owner
FOR EACH ROW EXECUTE PROCEDURE chk_owner_del_proc();

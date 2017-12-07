
CREATE TABLE customer.physical_person (
	dni                           text UNIQUE NOT NULL,
	surname                       text NOT NULL,
	name                          text NOT NULL,
	birthday                      timestamp with time zone NOT NULL,
	cuit                          text PRIMARY KEY REFERENCES customer.person(cuit) ON DELETE CASCADE
);


CREATE OR REPLACE FUNCTION customer.physical_person (
	IN p_dni                      text,
	IN p_surname                  text,
	IN p_name                     text,
	IN p_birthday                 timestamp with time zone,
	IN p_cuit                     text,
	IN p_iibb                     text DEFAULT NULL
) RETURNS boolean AS $$
DECLARE 
	dni_count           integer;
	person_ok           boolean;
	
BEGIN 
	dni_count = count(1) FROM customer.physical_person WHERE dni = p_dni;
	
	IF dni_count != 0
	THEN 
		RAISE WARNING 'YA EXISTE UNA PERSONA CON ESE DNI';
		RETURN FALSE;
	END IF;
	
	IF date_part('years', age(now(), p_birthday)) < 18
	THEN 
		RAISE WARNING 'ERROR: LA PERSONA ES MENOR DE EDAD';
		RETURN FALSE;
	END IF;
	
	IF p_iibb IS NOT NULL
	THEN
		person_ok := customer.person(p_cuit, p_iibb);
	ELSE 
		person_ok := customer.person(p_cuit);
	END IF;
	
	IF NOT person_ok 
	THEN
		RAISE WARNING 'ERROR: CUIT O IIBB YA EXISTE';
		RETURN FALSE;
	ELSE 
		INSERT INTO customer.physical_person VALUES (
			p_dni,
			p_surname,
			p_name,
			p_birthday,
			p_cuit
		);
		
		RETURN TRUE;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_identify_by_dni (
	IN p_dni                      text
) RETURNS customer.physical_person AS 
$$
	SELECT * FROM customer.physical_person WHERE dni = p_dni;
$$ LANGUAGE sql STRICT STABLE
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_identify_by_cuit (
	IN p_cuit                     text
) RETURNS customer.physical_person AS 
$$
	SELECT * FROM customer.physical_person WHERE cuit = p_cuit;
$$ LANGUAGE sql STRICT STABLE
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_lookup (
	IN p_surname                  text
) RETURNS SETOF customer.physical_person AS 
$$
	SELECT * FROM customer.physical_person WHERE surname = p_surname;
$$ LANGUAGE sql STRICT STABLE
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_lookup (
	IN p_name                     text,
	IN p_surname                  text
) RETURNS SETOF customer.physical_person AS 
$$
	SELECT * FROM customer.physical_person WHERE (name, surname) = (p_name, p_surname);
$$ LANGUAGE sql STRICT STABLE
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_get_dni (
	IN p_physical_person          customer.physical_person
) RETURNS text AS
$$
	SELECT p_physical_person.dni;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_get_surname (
	IN p_physical_person          customer.physical_person
) RETURNS text AS
$$
	SELECT p_physical_person.surname;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_get_name (
	IN p_physical_person          customer.physical_person
) RETURNS text AS
$$
	SELECT p_physical_person.name;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_get_birthday (
	IN p_physical_person          customer.physical_person
) RETURNS timestamp with time zone AS
$$
	SELECT p_physical_person.birthday;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_get_cuit (
	IN p_physical_person          customer.physical_person
) RETURNS text AS
$$
	SELECT p_physical_person.cuit;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_get_age (
	IN p_physical_person          customer.physical_person
) RETURNS integer AS
$$
	SELECT date_part('years', age(now(), p_physical_person.birthday))::integer;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.physical_person_get_iibb (
	IN p_physical_person          customer.physical_person
) RETURNS text AS
$$
	SELECT iibb FROM customer.person WHERE cuit = p_physical_person.cuit;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;

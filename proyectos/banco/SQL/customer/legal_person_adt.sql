
CREATE TABLE customer.legal_person (
	cuit                     text PRIMARY KEY REFERENCES customer.person(cuit) ON DELETE CASCADE,
	legal_name               text NOT NULL,
	fantasy_name             text,
	constitution_date        timestamp with time zone NOT NULL
);


CREATE OR REPLACE FUNCTION customer.legal_person ( 
	IN p_cuit                     text,
	IN p_legal_name               text,
	IN p_constitution_date        timestamp with time zone,
	IN p_iibb                     text,
	IN p_fantasy_name             text DEFAULT NULL
) RETURNS boolean AS $$
BEGIN
	IF EXISTS (SELECT 1 FROM customer.legal_person WHERE cuit = p_cuit)
	THEN 
		RAISE WARNING 'ERROR: YA EXISTE UNA PERSONA LEGAL CON ESE CUIT';
		RETURN FALSE;
	END IF;
	
	IF NOT customer.person(p_cuit, p_iibb)
	THEN 
		RAISE WARNING 'ERROR: YA EXISTE UNA PERSONA CON ESE CUIT';
		RETURN FALSE;
	ELSE 
		INSERT INTO customer.legal_person
			VALUES(p_cuit, p_legal_name, p_fantasy_name, p_constitution_date);
		
		RETURN TRUE;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.legal_person_identify_by_cuit (
	IN p_cuit                     text
) RETURNS customer.legal_person AS 
$$
	SELECT * FROM customer.legal_person WHERE cuit = p_cuit;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.legal_person_identify_by_iibb (
	IN p_iibb                     text
) RETURNS customer.legal_person AS
$$
	SELECT a.* FROM customer.legal_person a NATURAL INNER JOIN customer.person b
		WHERE b.iibb = p_iibb;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.legal_person_lookup_by_legal_name (
	IN p_legal_name               text
)  RETURNS SETOF customer.legal_person AS
$$
	SELECT * FROM customer.legal_person WHERE legal_name = p_legal_name;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.legal_person_lookup_by_fantasy_name (
	IN p_fantasy_name             text
)  RETURNS SETOF customer.legal_person AS
$$
	SELECT * FROM customer.legal_person WHERE fantasy_name = p_fantasy_name;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.legal_person_get_cuit (
	IN p_legal_person             customer.legal_person
) RETURNS text AS 
$$
	SELECT p_legal_person.cuit;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT; 


CREATE OR REPLACE FUNCTION customer.legal_person_get_legal_name (
	IN p_legal_person             customer.legal_person
) RETURNS text AS 
$$
	SELECT p_legal_person.legal_name;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT; 


CREATE OR REPLACE FUNCTION customer.legal_person_get_fantasy_name (
	IN p_legal_person             customer.legal_person
) RETURNS text AS 
$$
	SELECT p_legal_person.fantasy_name;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT; 


CREATE OR REPLACE FUNCTION customer.legal_person_set_fantasy_name (
	IN p_legal_person             customer.legal_person,
	IN p_fantasy_name             text
) RETURNS boolean AS $$
BEGIN 
	IF EXISTS (SELECT 1 FROM customer.legal_person a WHERE a = p_legal_person)
	THEN 
		UPDATE customer.legal_person SET fantasy_name = p_fantasy_name
			WHERE cuit = p_legal_person.cuit;
		
		RETURN TRUE;
	ELSE 
		RAISE WARNING 'La persona legal ingresada NO EXISTE';
		RETURN FALSE;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.legal_person_get_constitution_date (
	IN p_legal_person             customer.legal_person
) RETURNS timestamp with time zone AS 
$$
	SELECT p_legal_person.constitution_date;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT; 


CREATE OR REPLACE FUNCTION customer.legal_person_get_iibb (
	IN p_legal_person             customer.legal_person
) RETURNS text AS 
$$
	SELECT iibb FROM customer.person WHERE cuit = p_legal_person.cuit;
$$ LANGUAGE sql STABLE STRICT
SET search_path FROM CURRENT; 

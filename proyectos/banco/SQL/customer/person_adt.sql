
CREATE TABLE customer.person(
	cuit                text PRIMARY KEY,
	iibb                text UNIQUE
);


CREATE OR REPLACE FUNCTION customer.person(
	IN p_cuit           text,
	IN p_iibb           text
) RETURNS boolean AS $$
DECLARE 
	cuit_count          integer;
	iibb_count          integer;
	
BEGIN
	cuit_count := count(1) FROM customer.person WHERE cuit = p_cuit;
	iibb_count := count(1) FROM customer.person WHERE iibb = p_iibb;
	
	IF cuit_count = 0 AND iibb_count = 0
	THEN 
		INSERT INTO customer.person VALUES(p_cuit, p_iibb);
		RETURN TRUE;
	ELSE 
		RAISE WARNING 'CUIT O IIBB YA EXISTEN EN LA BASE DE DATOS';
		RETURN FALSE;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT
SET search_path FROM CURRENT;


CREATE OR REPLACE FUNCTION customer.person(
	IN p_cuit           text
) RETURNS boolean AS $$
DECLARE 
	cuit_count          integer;
	
BEGIN
	cuit_count := count(1) FROM customer.person WHERE cuit = p_cuit;
	
	IF cuit_count = 0
	THEN 
		INSERT INTO customer.person(cuit) VALUES(p_cuit);
		RETURN TRUE;
	ELSE 
		RAISE WARNING 'CUIT YA EXISTEN EN LA BASE DE DATOS';
		RETURN FALSE;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE STRICT
SET search_path FROM CURRENT;

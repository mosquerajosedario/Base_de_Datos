
CREATE TABLE customer.contact_information (
	contact_id          serial PRIMARY KEY,
	address             text,
	phone               text,
	email               text,
	cuit                text NOT NULL REFERENCES customer.person(cuit) ON DELETE CASCADE
);


CREATE OR REPLACE FUNCTION customer.contact_information (
	IN p_cuit           text,
	IN p_address        text DEFAULT NULL,
	IN p_phone          text DEFAULT NULL,
	IN p_email          text DEFAULT NULL
) RETURNS boolean AS $$
DECLARE 

BEGIN 
	IF NOT EXISTS (SELECT 1 FROM customer.person WHERE cuit = p_cuit)
	THEN 
		RAISE WARNING 'ERROR: LA PERSONA NO EXISTE';
		RETURN FALSE;
	END IF;
	
	IF p_address IS NULL AND p_phone IS NULL AND p_email IS NULL 
	THEN
		RAISE WARNING 'ERROR: NINGUN DATO SUMINISTRADO';
		RETURN FALSE;
	ELSE 
		INSERT INTO customer.contact_information (address, phone, email, cuit)
			VALUES(p_address, p_phone, p_email, p_cuit);
		
		RETURN TRUE;
	END IF;
END;
$$ LANGUAGE plpgsql VOLATILE
SET search_path FROM CURRENT;

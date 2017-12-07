
CREATE TABLE accounting.movement (
	movement_id              serial PRIMARY KEY,
	movement_timestamp       timestamp with time zone NOT NULL DEFAULT now(),
	movement_description     text NOT NULL,
	account_id               integer NOT NULL REFERENCES accounting.account(account_id) ON DELETE CASCADE,
	quantity                 double precision NOT NULL CHECK (quantity != 0)
);

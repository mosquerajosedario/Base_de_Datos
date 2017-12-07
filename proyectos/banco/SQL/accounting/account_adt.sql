
CREATE TABLE accounting.account (
	account_id                         serial PRIMARY KEY,
	owner_cuit                         text NOT NULL REFERENCES customer.person(cuit) ON DELETE CASCADE,
	opening_date                       timestamp with time zone NOT NULL DEFAULT now(),
	account_type                       account_type NOT NULL DEFAULT 'CAJA DE AHORROS',
	authorized_uncovered_balance       double precision NOT NULL DEFAULT 0 CHECK (authorized_uncovered_balance <= 0),
	balance                            double precision NOT NULL DEFAULT 0 CHECK (balance >= authorized_uncovered_balance)
);

.phony: clean

CLIENT = psql
FLAGS = -c

all: deploy 

deploy: banco.sql
	$(CLIENT) $(FLAGS) "DROP DATABASE IF EXISTS banco" postgres
	$(CLIENT) $(FLAGS) "CREATE DATABASE banco" postgres
	$(CLIENT) banco < banco.sql

banco.sql: \
	configuration.sql \
	customer/person_adt.sql \
	customer/contact_information_adt.sql \
	customer/physical_person_adt.sql \
	customer/legal_person_adt.sql \
	accounting/account_adt.sql \
	accounting/movement_adt.sql
	
	touch banco.sql
	cat configuration.sql >> banco.sql
	cat customer/person_adt.sql >> banco.sql
	cat customer/contact_information_adt.sql >> banco.sql
	cat customer/physical_person_adt.sql >> banco.sql
	cat customer/legal_person_adt.sql >> banco.sql
	cat accounting/account_adt.sql >> banco.sql
	cat accounting/movement_adt.sql >> banco.sql

clean:
	$(RM) banco.sql

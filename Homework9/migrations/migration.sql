DROP TABLE IF EXISTS public.user_profiles;
DROP TABLE IF EXISTS public.users;
DROP TABLE IF EXISTS account.accounts;
DROP TABLE IF EXISTS ordersproduct.orders;
DROP TABLE IF EXISTS ordersproduct.products;
DROP TABLE IF EXISTS notification.notifications;
DROP TABLE IF EXISTS payment.payments;
DROP TABLE IF EXISTS warehouse.availableproducts;
DROP TABLE IF EXISTS warehouse.reservedproducts;
DROP TABLE IF EXISTS delivery.availabletimeslots;
DROP TABLE IF EXISTS delivery.timeslotsreserved;

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    login text COLLATE pg_catalog."default",
    password text COLLATE pg_catalog."default",
    is_logged_in boolean,
	CONSTRAINT "PK_users" PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.users
    OWNER to otuspostgres;

CREATE TABLE IF NOT EXISTS public.user_profiles
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	user_id bigint NOT NULL,
    first_name text COLLATE pg_catalog."default",
	last_name text COLLATE pg_catalog."default",
	email text COLLATE pg_catalog."default",
	CONSTRAINT "PK_user_profiles" PRIMARY KEY (id),
    CONSTRAINT "FK_user_profiles_users" FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION   
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.user_profiles
    OWNER to otuspostgres;		
	

	
CREATE SCHEMA IF NOT EXISTS account
AUTHORIZATION pg_database_owner;

GRANT USAGE ON SCHEMA account TO PUBLIC;

GRANT ALL ON SCHEMA account TO pg_database_owner;


CREATE TABLE IF NOT EXISTS account.accounts
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	user_id bigint NOT NULL,
	user_name text COLLATE pg_catalog."default",
	amount bigint NOT NULL,	
	CONSTRAINT "PK_accounts" PRIMARY KEY (id)   
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS account.accounts
    OWNER to otuspostgres;	
	

CREATE SCHEMA IF NOT EXISTS ordersproduct
AUTHORIZATION pg_database_owner;

GRANT USAGE ON SCHEMA ordersproduct TO PUBLIC;

GRANT ALL ON SCHEMA ordersproduct TO pg_database_owner;		


CREATE TABLE IF NOT EXISTS ordersproduct.products
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	name text COLLATE pg_catalog."default",
    cost bigint NOT NULL,	
	CONSTRAINT "PK_products" PRIMARY KEY (id)    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ordersproduct.products
    OWNER to otuspostgres;	
	
INSERT INTO ordersproduct.products(name, cost) VALUES ('table', 500);		
INSERT INTO ordersproduct.products(name, cost) VALUES ('chair', 200);
INSERT INTO ordersproduct.products(name, cost) VALUES ('divan', 700);



CREATE TABLE IF NOT EXISTS ordersproduct.orders
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	user_id bigint NOT NULL,		
	product_id bigint NOT NULL,	
	product_name text COLLATE pg_catalog."default",	
    status bigint NOT NULL,
	corellation_id text COLLATE pg_catalog."default",
	CONSTRAINT "PK_orders" PRIMARY KEY (id),
	CONSTRAINT "FK_orders_products" FOREIGN KEY (product_id)
        REFERENCES ordersproduct.products (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION      
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ordersproduct.orders
    OWNER to otuspostgres;

CREATE SCHEMA IF NOT EXISTS notification
AUTHORIZATION pg_database_owner;

GRANT USAGE ON SCHEMA notification TO PUBLIC;

GRANT ALL ON SCHEMA notification TO pg_database_owner;		


CREATE TABLE IF NOT EXISTS notification.notifications
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	order_id bigint NOT NULL,	
    email_text text COLLATE pg_catalog."default",
	email_status bigint NOT NULL,	
	CONSTRAINT "PK_notifications" PRIMARY KEY (id)    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS notification.notifications
    OWNER to otuspostgres;	
	
	
CREATE SCHEMA IF NOT EXISTS payment
AUTHORIZATION pg_database_owner;

GRANT USAGE ON SCHEMA payment TO PUBLIC;

GRANT ALL ON SCHEMA payment TO pg_database_owner;		


CREATE TABLE IF NOT EXISTS payment.payments
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	order_id bigint NOT NULL,
	user_id bigint NOT NULL,
	status bigint NOT NULL,	
	CONSTRAINT "PK_payments" PRIMARY KEY (id)    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS payment.payments
    OWNER to otuspostgres;		
	
	
CREATE SCHEMA IF NOT EXISTS warehouse
AUTHORIZATION pg_database_owner;

GRANT USAGE ON SCHEMA warehouse TO PUBLIC;

GRANT ALL ON SCHEMA warehouse TO pg_database_owner;		

CREATE TABLE IF NOT EXISTS warehouse.availableproducts
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	product_id bigint NOT NULL,
	product_name text COLLATE pg_catalog."default",	
	quantity bigint NOT NULL,
	CONSTRAINT "PK_availableproducts" PRIMARY KEY (id)    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.availableproducts
    OWNER to otuspostgres;
	
INSERT INTO warehouse.availableproducts(product_id, product_name, quantity) VALUES (1,'table', 1);		
INSERT INTO warehouse.availableproducts(product_id, product_name, quantity) VALUES (2,'chair', 1);
INSERT INTO warehouse.availableproducts(product_id, product_name, quantity) VALUES (3,'divan', 1);	
	

CREATE TABLE IF NOT EXISTS warehouse.reservedproducts
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	order_id bigint NOT NULL,
	user_id bigint NOT NULL,
	product_id bigint NOT NULL,	
	product_name text COLLATE pg_catalog."default",	
	prepared boolean NOT NULL DEFAULT FALSE,	
	CONSTRAINT "PK_productsreserved" PRIMARY KEY (id)    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.productsreserved
    OWNER to otuspostgres;		
	


CREATE SCHEMA IF NOT EXISTS delivery
AUTHORIZATION pg_database_owner;

GRANT USAGE ON SCHEMA delivery TO PUBLIC;

GRANT ALL ON SCHEMA delivery TO pg_database_owner;		

CREATE TABLE IF NOT EXISTS delivery.availabletimeslots
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	product_id bigint NOT NULL,
	product_name text COLLATE pg_catalog."default",		
	timeslots_count bigint NOT NULL,	   
	CONSTRAINT "PK_availabletimeslots" PRIMARY KEY (id)    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS delivery.availabletimeslots
    OWNER to otuspostgres;

INSERT INTO delivery.availabletimeslots(product_id, product_name, timeslots_count) VALUES (1,'table', 1);		
INSERT INTO delivery.availabletimeslots(product_id, product_name, timeslots_count) VALUES (2,'chair', 0);
INSERT INTO delivery.availabletimeslots(product_id, product_name, timeslots_count) VALUES (3,'divan', 1);
	

CREATE TABLE IF NOT EXISTS delivery.timeslotsreserved
(
    id bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
	order_id bigint NOT NULL,
	user_id bigint NOT NULL,	
	product_id bigint NOT NULL,
	product_name text COLLATE pg_catalog."default",	
	CONSTRAINT "PK_timeslotsreserved" PRIMARY KEY (id)    
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS delivery.timeslotsreserved
    OWNER to otuspostgres;	
	
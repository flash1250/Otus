-- Table: public.users

-- DROP TABLE IF EXISTS public.users;

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
	
	
	
	
INSERT INTO public.users(
login, password, is_logged_in)
VALUES ('John', 'Snow', false);
-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.3-beta1
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---
-- object: admin_projeto | type: ROLE --
DROP ROLE IF EXISTS admin_projeto;
CREATE ROLE admin_projeto WITH ;
-- ddl-end --


-- Database creation must be performed outside a multi lined SQL file.
-- These commands were put in this file only as a convenience.
--
-- object: "softo_db" | type: DATABASE --
-- DROP DATABASE IF EXISTS "softo_db";
--CREATE DATABASE "softo_db";
-- ddl-end --


-- object: public.users | type: TABLE --
-- DROP TABLE IF EXISTS public.users CASCADE;
CREATE TABLE public.users (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	tenantid uuid NOT NULL,
	languageid uuid NOT NULL,
	timezoneid uuid NOT NULL,
	firstname varchar(200) NOT NULL,
	lastname varchar(200) NOT NULL,
	email varchar(300) NOT NULL,
	emailconfirmeddate timestamp with time zone,
	passwordhash varchar,
  salt varchar,
	securitystamp uuid NOT NULL,
	accessfailedcount smallint NOT NULL,
	lockoutenddate timestamp with time zone,
	adminblockeddate timestamp with time zone,
	avatarimageuploadeddate timestamp with time zone,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_users PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.users OWNER TO admin_projeto;
-- ddl-end --

-- object: public.userlogins | type: TABLE --
-- DROP TABLE IF EXISTS public.userlogins CASCADE;
CREATE TABLE public.userlogins (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	userid uuid NOT NULL,
	provider varchar(20) NOT NULL,
	providerkey varchar(128) NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_userlogins PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.userlogins OWNER TO admin_projeto;
-- ddl-end --

-- object: public.tenants | type: TABLE --
-- DROP TABLE IF EXISTS public.tenants CASCADE;
CREATE TABLE public.tenants (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar(150) NOT NULL,
	url varchar(400),
	imageuploadeddate timestamp with time zone,
	defaulttimezoneid uuid NOT NULL,
	defaultlanguageid uuid NOT NULL,
	defaultcurrencyid uuid,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_tenants PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.tenants OWNER TO admin_projeto;
-- ddl-end --

-- object: public.languages | type: TABLE --
-- DROP TABLE IF EXISTS public.languages CASCADE;
CREATE TABLE public.languages (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar(100) NOT NULL,
	isocode varchar(6) NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_languages PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.languages OWNER TO admin_projeto;
-- ddl-end --

-- object: public.currencies | type: TABLE --
-- DROP TABLE IF EXISTS public.currencies CASCADE;
CREATE TABLE public.currencies (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name character varying(50) NOT NULL,
	symbol character varying(5) NOT NULL,
	isocode character varying(3) NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_currencies PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.currencies OWNER TO admin_projeto;
-- ddl-end --

-- object: public.roles | type: TABLE --
-- DROP TABLE IF EXISTS public.roles CASCADE;
CREATE TABLE public.roles (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	tenantid uuid NOT NULL,
	name varchar(150) NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_roles PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.roles OWNER TO admin_projeto;
-- ddl-end --

-- object: public.userroles | type: TABLE --
-- DROP TABLE IF EXISTS public.userroles CASCADE;
CREATE TABLE public.userroles (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	userid uuid NOT NULL,
	roleid uuid NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_userroles PRIMARY KEY (id)

);
-- ddl-end --
COMMENT ON TABLE public.userroles IS E'admin\noperador de CRM';
-- ddl-end --
ALTER TABLE public.userroles OWNER TO admin_projeto;
-- ddl-end --

-- object: fk_tenants_users | type: CONSTRAINT --
-- ALTER TABLE public.users DROP CONSTRAINT IF EXISTS fk_tenants_users CASCADE;
ALTER TABLE public.users ADD CONSTRAINT fk_tenants_users FOREIGN KEY (tenantid)
REFERENCES public.tenants (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: public.templates | type: TABLE --
-- DROP TABLE IF EXISTS public.templates CASCADE;
CREATE TABLE public.templates (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_templates PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.templates OWNER TO admin_projeto;
-- ddl-end --

-- object: public.timezones | type: TABLE --
-- DROP TABLE IF EXISTS public.timezones CASCADE;
CREATE TABLE public.timezones (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar(100) NOT NULL,
	isocode varchar(6) NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_timezones PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.timezones OWNER TO admin_projeto;
-- ddl-end --

-- object: fk_timezones_tenants | type: CONSTRAINT --
-- ALTER TABLE public.tenants DROP CONSTRAINT IF EXISTS fk_timezones_tenants CASCADE;
ALTER TABLE public.tenants ADD CONSTRAINT fk_timezones_tenants FOREIGN KEY (defaulttimezoneid)
REFERENCES public.timezones (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_languages_users | type: CONSTRAINT --
-- ALTER TABLE public.users DROP CONSTRAINT IF EXISTS fk_languages_users CASCADE;
ALTER TABLE public.users ADD CONSTRAINT fk_languages_users FOREIGN KEY (languageid)
REFERENCES public.languages (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_languages_tenants | type: CONSTRAINT --
-- ALTER TABLE public.tenants DROP CONSTRAINT IF EXISTS fk_languages_tenants CASCADE;
ALTER TABLE public.tenants ADD CONSTRAINT fk_languages_tenants FOREIGN KEY (defaultlanguageid)
REFERENCES public.languages (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_currencies_tenants | type: CONSTRAINT --
-- ALTER TABLE public.tenants DROP CONSTRAINT IF EXISTS fk_currencies_tenants CASCADE;
ALTER TABLE public.tenants ADD CONSTRAINT fk_currencies_tenants FOREIGN KEY (defaultcurrencyid)
REFERENCES public.currencies (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_timezones_users | type: CONSTRAINT --
-- ALTER TABLE public.users DROP CONSTRAINT IF EXISTS fk_timezones_users CASCADE;
ALTER TABLE public.users ADD CONSTRAINT fk_timezones_users FOREIGN KEY (timezoneid)
REFERENCES public.timezones (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_users_userlogins | type: CONSTRAINT --
-- ALTER TABLE public.userlogins DROP CONSTRAINT IF EXISTS fk_users_userlogins CASCADE;
ALTER TABLE public.userlogins ADD CONSTRAINT fk_users_userlogins FOREIGN KEY (userid)
REFERENCES public.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_users_userroles | type: CONSTRAINT --
-- ALTER TABLE public.userroles DROP CONSTRAINT IF EXISTS fk_users_userroles CASCADE;
ALTER TABLE public.userroles ADD CONSTRAINT fk_users_userroles FOREIGN KEY (userid)
REFERENCES public.users (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: public.systemconfigurations | type: TABLE --
-- DROP TABLE IF EXISTS public.systemconfigurations CASCADE;
CREATE TABLE public.systemconfigurations (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	tenantid uuid,
	generaldatatypeid uuid NOT NULL,
	name varchar(100) NOT NULL,
	description varchar(1000),
	tag varchar(20) NOT NULL,
	isglobal bool NOT NULL,
	ishidden bool NOT NULL,
	intvalue integer,
	boolvalue bool,
	stringvalue varchar,
	uuidvalue uuid,
	timestampvalue timestamp with time zone,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_systemconfigurations PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.systemconfigurations OWNER TO admin_projeto;
-- ddl-end --

-- object: fk_tenants_systemconfigurations | type: CONSTRAINT --
-- ALTER TABLE public.systemconfigurations DROP CONSTRAINT IF EXISTS fk_tenants_systemconfigurations CASCADE;
ALTER TABLE public.systemconfigurations ADD CONSTRAINT fk_tenants_systemconfigurations FOREIGN KEY (tenantid)
REFERENCES public.tenants (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: public.generaldatatypes | type: TABLE --
-- DROP TABLE IF EXISTS public.generaldatatypes CASCADE;
CREATE TABLE public.generaldatatypes (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar(40) NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_generaldatatypes PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.generaldatatypes OWNER TO admin_projeto;
-- ddl-end --

-- object: fk_generaldatatypes_systemconfigurations | type: CONSTRAINT --
-- ALTER TABLE public.systemconfigurations DROP CONSTRAINT IF EXISTS fk_generaldatatypes_systemconfigurations CASCADE;
ALTER TABLE public.systemconfigurations ADD CONSTRAINT fk_generaldatatypes_systemconfigurations FOREIGN KEY (generaldatatypeid)
REFERENCES public.generaldatatypes (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: idx_users_tenantid_email | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_users_tenantid_email CASCADE;
CREATE INDEX idx_users_tenantid_email ON public.users
	USING btree
	(
	  tenantid
	);
-- ddl-end --

-- object: idx_userroles_userid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_userroles_userid CASCADE;
CREATE INDEX idx_userroles_userid ON public.userroles
	USING btree
	(
	  userid
	);
-- ddl-end --

-- object: idx_systemconfigurations_tenantid_tag | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_systemconfigurations_tenantid_tag CASCADE;
CREATE INDEX idx_systemconfigurations_tenantid_tag ON public.systemconfigurations
	USING btree
	(
	  tenantid,
	  tag
	);
-- ddl-end --

-- object: idx_tenants_url | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_tenants_url CASCADE;
CREATE INDEX idx_tenants_url ON public.tenants
	USING btree
	(
	  url
	);
-- ddl-end --

-- object: idx_languages_isocode | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_languages_isocode CASCADE;
CREATE INDEX idx_languages_isocode ON public.languages
	USING btree
	(
	  isocode
	);
-- ddl-end --

-- object: idx_currencies_isocode | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_currencies_isocode CASCADE;
CREATE INDEX idx_currencies_isocode ON public.currencies
	USING btree
	(
	  isocode
	);
-- ddl-end --

-- object: public.generalfunctionalities | type: TABLE --
-- DROP TABLE IF EXISTS public.generalfunctionalities CASCADE;
CREATE TABLE public.generalfunctionalities (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar(150) NOT NULL,
	tag varchar(50) NOT NULL,
	description varchar(500),
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_generalfunctionalities PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.generalfunctionalities OWNER TO admin_projeto;
-- ddl-end --

-- object: public.rolefunctionalities | type: TABLE --
-- DROP TABLE IF EXISTS public.rolefunctionalities CASCADE;
CREATE TABLE public.rolefunctionalities (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	roleid uuid NOT NULL,
	generalfunctionalityid uuid NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_rolefunctionalities PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.rolefunctionalities OWNER TO admin_projeto;
-- ddl-end --

-- object: fk_tenants_roles | type: CONSTRAINT --
-- ALTER TABLE public.roles DROP CONSTRAINT IF EXISTS fk_tenants_roles CASCADE;
ALTER TABLE public.roles ADD CONSTRAINT fk_tenants_roles FOREIGN KEY (tenantid)
REFERENCES public.tenants (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_roles_rolefunctionalities | type: CONSTRAINT --
-- ALTER TABLE public.rolefunctionalities DROP CONSTRAINT IF EXISTS fk_roles_rolefunctionalities CASCADE;
ALTER TABLE public.rolefunctionalities ADD CONSTRAINT fk_roles_rolefunctionalities FOREIGN KEY (roleid)
REFERENCES public.roles (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_generalfunctionalities_rolefunctionalities | type: CONSTRAINT --
-- ALTER TABLE public.rolefunctionalities DROP CONSTRAINT IF EXISTS fk_generalfunctionalities_rolefunctionalities CASCADE;
ALTER TABLE public.rolefunctionalities ADD CONSTRAINT fk_generalfunctionalities_rolefunctionalities FOREIGN KEY (generalfunctionalityid)
REFERENCES public.generalfunctionalities (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: idx_rolefunctionalities_roleid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_rolefunctionalities_roleid CASCADE;
CREATE INDEX idx_rolefunctionalities_roleid ON public.rolefunctionalities
	USING btree
	(
	  roleid
	);
-- ddl-end --

-- object: idx_rolefunctionalities_generalfunctionalityid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_rolefunctionalities_generalfunctionalityid CASCADE;
CREATE INDEX idx_rolefunctionalities_generalfunctionalityid ON public.rolefunctionalities
	USING btree
	(
	  generalfunctionalityid
	);
-- ddl-end --

-- object: fk_roles_userroles | type: CONSTRAINT --
-- ALTER TABLE public.userroles DROP CONSTRAINT IF EXISTS fk_roles_userroles CASCADE;
ALTER TABLE public.userroles ADD CONSTRAINT fk_roles_userroles FOREIGN KEY (roleid)
REFERENCES public.roles (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: idx_userroles_roleid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_userroles_roleid CASCADE;
CREATE INDEX idx_userroles_roleid ON public.userroles
	USING btree
	(
	  roleid
	);
-- ddl-end --

-- object: idx_roles_tenantid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_roles_tenantid CASCADE;
CREATE INDEX idx_roles_tenantid ON public.roles
	USING btree
	(
	  tenantid
	);
-- ddl-end --

-- object: idx_timezones_isocode | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_timezones_isocode CASCADE;
CREATE INDEX idx_timezones_isocode ON public.timezones
	USING btree
	(
	  isocode
	);
-- ddl-end --

-- object: public.tenantlanguages | type: TABLE --
-- DROP TABLE IF EXISTS public.tenantlanguages CASCADE;
CREATE TABLE public.tenantlanguages (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	tenantid uuid NOT NULL,
	languageid uuid NOT NULL,
	isactive bool NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_tenantlanguages PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.tenantlanguages OWNER TO admin_projeto;
-- ddl-end --

-- object: fk_tenants_tenantlanguages | type: CONSTRAINT --
-- ALTER TABLE public.tenantlanguages DROP CONSTRAINT IF EXISTS fk_tenants_tenantlanguages CASCADE;
ALTER TABLE public.tenantlanguages ADD CONSTRAINT fk_tenants_tenantlanguages FOREIGN KEY (tenantid)
REFERENCES public.tenants (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_languages_tenantlanguages | type: CONSTRAINT --
-- ALTER TABLE public.tenantlanguages DROP CONSTRAINT IF EXISTS fk_languages_tenantlanguages CASCADE;
ALTER TABLE public.tenantlanguages ADD CONSTRAINT fk_languages_tenantlanguages FOREIGN KEY (languageid)
REFERENCES public.languages (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: idx_tenantlanguages_tenantid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_tenantlanguages_tenantid CASCADE;
CREATE INDEX idx_tenantlanguages_tenantid ON public.tenantlanguages
	USING btree
	(
	  tenantid
	);
-- ddl-end --

-- object: idx_tenantlanguages_languageid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_tenantlanguages_languageid CASCADE;
CREATE INDEX idx_tenantlanguages_languageid ON public.tenantlanguages
	USING btree
	(
	  languageid
	);
-- ddl-end --

-- object: public.tenantcurrencies | type: TABLE --
-- DROP TABLE IF EXISTS public.tenantcurrencies CASCADE;
CREATE TABLE public.tenantcurrencies (
	id uuid NOT NULL,
	alternativeid bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	tenantid uuid NOT NULL,
	currencyid uuid NOT NULL,
	isactive bool NOT NULL,
	createddate timestamp with time zone NOT NULL,
	updateddate timestamp with time zone,
	deleteddate timestamp with time zone,
	CONSTRAINT pk_tenantcurrencies PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public.tenantcurrencies OWNER TO admin_projeto;
-- ddl-end --

-- object: fk_tenants_tenantcurrencies | type: CONSTRAINT --
-- ALTER TABLE public.tenantcurrencies DROP CONSTRAINT IF EXISTS fk_tenants_tenantcurrencies CASCADE;
ALTER TABLE public.tenantcurrencies ADD CONSTRAINT fk_tenants_tenantcurrencies FOREIGN KEY (tenantid)
REFERENCES public.tenants (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: fk_currencies_tenantcurrencies | type: CONSTRAINT --
-- ALTER TABLE public.tenantcurrencies DROP CONSTRAINT IF EXISTS fk_currencies_tenantcurrencies CASCADE;
ALTER TABLE public.tenantcurrencies ADD CONSTRAINT fk_currencies_tenantcurrencies FOREIGN KEY (currencyid)
REFERENCES public.currencies (id) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: idx_tenantcurrencies_tenantid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_tenantcurrencies_tenantid CASCADE;
CREATE INDEX idx_tenantcurrencies_tenantid ON public.tenantcurrencies
	USING btree
	(
	  tenantid
	);
-- ddl-end --

-- object: idx_tenantcurrencies_currencyid | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_tenantcurrencies_currencyid CASCADE;
CREATE INDEX idx_tenantcurrencies_currencyid ON public.tenantcurrencies
	USING btree
	(
	  currencyid
	);
-- ddl-end --

-- object: idx_userlogins_userid_provider | type: INDEX --
-- DROP INDEX IF EXISTS public.idx_userlogins_userid_provider CASCADE;
CREATE INDEX idx_userlogins_userid_provider ON public.userlogins
	USING btree
	(
	  userid,
	  provider
	);
-- ddl-end --


INSERT INTO public.languages (id,"name",isocode,createddate,updateddate,deleteddate) VALUES
	 ('354ebebe-e736-4358-ae75-5995e2a61714','Português','pt_BR','2020-11-11 07:10:10-03',NULL,NULL),
	 ('c05ae051-b4ed-4226-8ae6-2de27e982256','Español','es','2020-11-11 07:10:10-03',NULL,NULL),
	 ('6dd278b7-57ce-4fb8-aee2-67e0ffb43ce9','English','en_US','2020-11-11 07:10:10-03',NULL,NULL);

INSERT INTO public.timezones (id,"name",isocode,createddate,updateddate,deleteddate) VALUES
	 ('1fabf17f-1d05-4646-9190-900d9858deb2','America/Sao_Paulo','BR','2020-11-25 12:13:10.435-03',NULL,NULL);


INSERT INTO public.tenants (id,"name",imageuploadeddate,createddate,updateddate,deleteddate,defaulttimezoneid,defaultlanguageid,defaultcurrencyid) VALUES
	 ('b985238f-1db1-476b-8f85-0a0f68707e8f','default',NULL,'2020-11-25 12:18:06.117-03',NULL,NULL,'1fabf17f-1d05-4646-9190-900d9858deb2','354ebebe-e736-4358-ae75-5995e2a61714',NULL);


INSERT INTO public.roles (id,tenantid ,"name",createddate,updateddate,deleteddate) VALUES
	 ('300b92ed-850a-47cd-9134-1bcd2fa678fd','b985238f-1db1-476b-8f85-0a0f68707e8f','Administrador','2020-12-02 00:00:00-03',NULL,NULL),
	 ('353bb163-531a-4a2f-9a3e-04aae6a24587','b985238f-1db1-476b-8f85-0a0f68707e8f','Comum','2020-12-02 00:00:00-03',NULL,NULL);

INSERT INTO public.users (id,firstname ,lastname ,email,emailconfirmeddate,passwordhash,salt,securitystamp,accessfailedcount,lockoutenddate,avatarimageuploadeddate,createddate,updateddate,deleteddate,languageid,tenantid,timezoneid) VALUES
	 ('1d7b054b-2d78-4f16-a72d-3eae28c1deaa','Admin','Softo','admin@sof.to','2020-12-02 17:26:51.595-03','$2a$10$HGFFCCWY8fA3Yey0k0qfG./QMd5KTkgetd1SO/eqTixdI7vGZ0OlW','$2a$10$HGFFCCWY8fA3Yey0k0qfG.','b90e0b55-f7d2-4c22-bba0-dc7248beba81',0,NULL,NULL,'2020-12-02 00:00:00-03','2020-12-02 17:43:26.395-03',NULL,'354ebebe-e736-4358-ae75-5995e2a61714','b985238f-1db1-476b-8f85-0a0f68707e8f','1fabf17f-1d05-4646-9190-900d9858deb2');

INSERT INTO public.userroles (id,createddate,updateddate,deleteddate,roleid,userid) VALUES
	 ('8f936a61-0c33-43a5-98ea-1b702ac6af33','2020-12-02 00:00:00-03',NULL,NULL,'300b92ed-850a-47cd-9134-1bcd2fa678fd','1d7b054b-2d78-4f16-a72d-3eae28c1deaa');

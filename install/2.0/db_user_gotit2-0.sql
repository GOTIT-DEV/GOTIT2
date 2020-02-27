-- db_user_gotit1-1 : Default admin account TO CHANGE : login = admin / password = adminGOTIT
INSERT INTO public.user_db(
	 id, username, password, email, role, salt, name, institution, date_of_creation, date_of_update, creation_user_name, update_user_name, is_active, user_comments)
	VALUES (1, 'admin', 'O3nuhNYmU/1ZZEH3pt2kThF1HbPzjUVSpX0UFTBxaN7y+1Qmqsbs+KzL4Hu2xXTVXsUZ87XkdXOD4Jykw4CEIQ==', 'admin@institution.fr','ROLE_ADMIN', null, 'admin name', 'institution', null, null, 1, 1 , 1, 'Default admin account TO CHANGE : login = admin / password = adminGOTIT')
	;
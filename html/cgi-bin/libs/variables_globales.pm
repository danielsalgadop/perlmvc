#!/usr/bin/perl

# place for global variables

our $q = CGI->new;
our $session;  # creo que no se usa
our %usersJson; # memory representation of users.json
our %gruposJson; # memory representation of grupos.json

our $titulo_web = "PERL MVC"; # web <title>, header <h1> and login header
our $name_cookie_that_stores_session_id = "CGISESSIONID_PERLMVC";

# %usersJson=(
# 	nombre=>"contraen_variables_globales",
# 	nombre2=>"contraen_variables_globales2"
# 	);


# Variable %user (se rellena en cargarModelos.pm)
# %user= (
# 	nombre=>valor_nombre,
# 	grupos_q_pertenece=>[grupo1,grupo3,grupox]
# 	rol=>super_admin|admin|user
# );
our %user; 
1;
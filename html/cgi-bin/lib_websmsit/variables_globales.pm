#!/usr/bin/perl

# place for global variables

our $q = CGI->new;
our $nombre_user_logeado = "nombre"; # mock por no saber guardar este dato en variable de session
our $session;  # creo que no se usa
our %userJson; # memory representation of users.json
our %gruposJson; # memory representation of grupos.json
1;
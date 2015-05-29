#!/usr/bin/perl
use warnings;
use strict;


# place for global variables

# my $nombre_app 			= "perlmvc";  # TODO bring this from globals

our $session;  # creo que no se usa
our %usersJson; # memory representation of users.json
our %gruposJson; # memory representation of grupos.json


our %user; 

package Globals;
use warnings;
use strict;
our $q = CGI->new;
our $server_ip = "http://10.0.191.102"; # in some machines you can use myIp(s)
our $titulo_web = "PERL MVC"; # web <title>, header <h1> and login header
our $name_cookie_that_stores_session_id = "CGISESSIONID_PERLMVC";
1;
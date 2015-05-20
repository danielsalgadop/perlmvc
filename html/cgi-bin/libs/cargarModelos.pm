#!/usr/bin/perl
use warnings FATAL=>all;
use strict;
use lib '.';
use variables_globales;
our $path_absoluto_modelos;
# Place used to fill variables_globales usually  from models/ (and usually in a json format)

# Ex: reading users.json 
# our %usersJson; # memory representation of users.json (must be declared in variables_globales.pm)
# sub cargarUsersJson(){
# 	my %r_fileJSON2Hash = fileJSON2Hash($path_absoluto_modelos."/users.json");
# 	if($r_fileJSON2Hash{status} eq "OK"){
# 		%usersJson=%{$r_fileJSON2Hash{hash}};
# 	}
# }
1;
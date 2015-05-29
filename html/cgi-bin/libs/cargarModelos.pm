#!/usr/bin/perl
use warnings FATAL=>all;
use strict;
use lib '.';
# Place used to fill globals usually  from models/ (and usually in a json format)

# Ex: reading users.json 
# our %usersJson; # memory representation of users.json (must be declared in globals.pm)
# sub cargarUsersJson(){
# 	my %r_fileJSON2Hash = fileJSON2Hash($Paths::modelos."/users.json");
# 	if($r_fileJSON2Hash{status} eq "OK"){
# 		%usersJson=%{$r_fileJSON2Hash{hash}};
# 	}
# }
1;
#!/usr/bin/perl
use warnings;
use strict;
use lib'.';
use cargarModelos;

sub gruposAlosQuePerteneceUser($){
	my $nombre_user = shift;
	our %usersJson;
	our %gruposJson;
	foreach my $nombre_grupo(keys(%gruposJson)){
		print "un grupo [".$nombre_grupo."]<br>\n";
	}
}

1;
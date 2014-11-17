#!/usr/bin/perl
use warnings;
use strict;
use lib'.';
use cargarModelos;

sub gruposAlosQuePerteneceUser($){
	my $nombre_user = shift;
	our %usersJson;
	our %gruposJson;
	# print Dumper(%gruposJson);
	# print "<hr>";
	# print Dumper(%usersJson);

	foreach my $numero_linea(keys(%gruposJson)){
		print "un grupo [".$numero_linea."]<br>\n";
	}
}

1;
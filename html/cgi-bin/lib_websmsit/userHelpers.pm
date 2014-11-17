#!/usr/bin/perl
use warnings;
use strict;
use lib'.';
use cargarModelos;

sub gruposAlosQuePerteneceUser($){
	my $nombre_user = shift;
	# print "RECIBIDO EN gruposAlosQuePerteneceUser \$nombre_user [$nombre_user]\n<br>";
	our %usersJson;
	our %gruposJson;
	my @grupos_q_pertenece_user;
	# print "<hr>";
	# print Dumper(%usersJson);

	foreach my $nombre_grupo(keys(%gruposJson)){
		# print "un grupo s [".$nombre_grupo."]<br>\n";
		foreach my $users_en_grupo(@{$gruposJson{$nombre_grupo}}){
			push(@grupos_q_pertenece_user,$nombre_grupo);
			# print "un user $users_en_grupo<br>\n";
		}
	}

	print "<hr>";
	print Dumper(@grupos_q_pertenece_user);
	print "<hr>";
	return(@grupos_q_pertenece_user);
}

1;
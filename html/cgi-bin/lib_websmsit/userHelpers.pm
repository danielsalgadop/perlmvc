#!/usr/bin/perl
use warnings;
use strict;
use lib'.';
# use variables_globales;
# use cargarModelos;

# our %usersJson;

# receives nombre_user_logeado
# Returns (array) grupos_q_pertenece_user
sub gruposAlosQuePerteneceUser($){
	my $nombre_user_logeado= shift;
	my @grupos_q_pertenece_user;
	our %gruposJson;

	foreach my $nombre_grupo(keys(%gruposJson)){
		foreach my $user_en_grupo(@{$gruposJson{$nombre_grupo}}){
			if($user_en_grupo eq $nombre_user_logeado){
				push(@grupos_q_pertenece_user,$nombre_grupo);
				last;   # no sigas buscando en este grupo
			}
		}
	}
	return(@grupos_q_pertenece_user);
}

sub rolesDeUser($){
	my $nombre_user_logeado= shift;
}



1;
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
	# print "RECIBIDO EN gruposAlosQuePerteneceUser \$nombre_user_logeado[$nombre_user_logeado]\n<br>";
	my @grupos_q_pertenece_user;
	# print "<hr>";
	our %gruposJson;
	# %gruposJson = (
	# 	key_a_fuego=>["valor_a_fuego1","nombre"],
	# 	key_a_fuego2=>["valor_a_fuego2"],
	# );
	&print2File({titulo=>"[asfawe531135] gruposAlosQuePerteneceUser \$nombre_user_logeado[$nombre_user_logeado] Dumper de \%gruposJson",ref=>\%gruposJson});

	# print "TRONCOOOOOOOO<br><br><br><br><br><br><br><br>";


	foreach my $nombre_grupo(keys(%gruposJson)){
		# &print2File({titulo=>"un grupo s",ref=>\$nombre_grupo});
		# print "un grupo s [".$nombre_grupo."]<br>\n";
		foreach my $user_en_grupo(@{$gruposJson{$nombre_grupo}}){
			if($user_en_grupo eq $nombre_user_logeado){
				# print "\$user_en_grupo $user_en_grupo es IGUAL a \$nombre_user_logeado $nombre_user_logeado<br>\n";
				# &print2File({titulo=>"\$user_en_grupo $user_en_grupo es IGUAL a \$nombre_user_logeado $nombre_user_logeado",ref=>\$nombre_grupo});
				push(@grupos_q_pertenece_user,$nombre_grupo);
				last;   # no sigas buscando en este grupo
			}
			# print "un user $user_en_grupo<br>\n";
		}
	}
	# &print2File({titulo=>" \$grupos_q_pertenece_user",ref=>\@grupos_q_pertenece_user});
	# @grupos_q_pertenece_user = ("a fuego dentro de gruposAlosQuePerteneceUser1", "segundo fuego de gruposAlosQuePerteneceUser1");
	return(@grupos_q_pertenece_user);
}

sub rolesDeUser($){
	my $nombre_user_logeado= shift;
}



1;
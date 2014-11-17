#!/usr/bin/perl
use warnings;
use strict;
use lib '.';
use variables_globales;
# lee user.json grupos.json
# los carga en variables_globales
# genera la info de %user
# %user= (
# 	nombre=>valor_nombre,
# 	grupos_q_pertenece=>[grupo1,grupo3,grupox]
# 	rol=>super_admin|admin|user
# );

# %user{nombre}=>valor_nombre

our $path_aboluto_jsones_modelos;
our %usersJson; # memory representation of users.json
our %gruposJson; # memory representation of grupos.json







sub cargarTodosModelos(){
	&cargarUsersJson;
	&cargarGruposJson;
}


# TODO gestionar error al cargar JSON
sub cargarUsersJson(){
	my %r_fileJSON2Hash = fileJSON2Hash($path_aboluto_jsones_modelos."/users.json");
	# &print2File({titulo=>"Dumper en cargarUsersJson users.json",ref=>\%r_fileJSON2Hash});
	if($r_fileJSON2Hash{status} eq "OK"){
		%usersJson=%{$r_fileJSON2Hash{hash}};
	}
}

sub cargarGruposJson(){
	my %r_fileJSON2Hash = fileJSON2Hash($path_aboluto_jsones_modelos."/grupos.json");
	# &print2File({titulo=>"Dumper en cargarUsersJson grupos.json",ref=>\%r_fileJSON2Hash});
	if($r_fileJSON2Hash{status} eq "OK"){
		%gruposJson=%{$r_fileJSON2Hash{hash}};
	}
}

&cargarTodosModelos();


our $nombre_user_logeado;
	&print2File({titulo=>"[antes] cargarModelos \$nombre_user_logeado[$nombre_user_logeado] Dumper de \%gruposJson",ref=>\%gruposJson});
my @grupos_q_pertenece = &gruposAlosQuePerteneceUser($nombre_user_logeado);

#           hash{ref} = (scalar|array|hash)
#           hash{titulo} = (scalar) 

# &print2File({titulo=>"LLEGAS [mmmmmmfffffaaaatt] grupos_q_pertenece dentro de cargarModelos para \$nombre_user_logeado [$nombre_user_logeado]",ref=>\@grupos_q_pertenece});
our %user;
%user = (
	nombre=>$nombre_user_logeado,
	grupos_q_pertenece=>\@grupos_q_pertenece,
	rol=>"user(TODO)"   # TODO
);
# @grupos_q_pertenece=("grupo_a_fuego1","grupo_a_fuego2","grupo_a_fuego3");
# %user = (
# 	nombre=>"nombre_a_fuego",
# 	grupos_q_pertenece=>\@grupos_q_pertenece,
# 	rol=>"user"   # TODO
# );

# %r_fileJSON2Hash = fileJSON2Hash($path_aboluto_jsones_modelos."/grupos.json");
1;
#!/usr/bin/perl
use warnings;
use strict;
use lib '.';

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
	if($r_fileJSON2Hash{status} eq "OK"){
		%usersJson=%{$r_fileJSON2Hash{hash}};
	}
}

sub cargarGruposJson(){
	my %r_fileJSON2Hash = fileJSON2Hash($path_aboluto_jsones_modelos."/grupos.json");
	if($r_fileJSON2Hash{status} eq "OK"){
		%gruposJson=%{$r_fileJSON2Hash{hash}};
	}
}



# %r_fileJSON2Hash = fileJSON2Hash($path_aboluto_jsones_modelos."/grupos.json");
1;
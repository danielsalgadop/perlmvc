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

# Returns a hash with templates
sub devolverTemplatesSms(){
	my %r_fileJSON2Hash = fileJSON2HashAgregado($path_aboluto_jsones_modelos."/templates_sms.json");
	my %return;
	$return{status} = "OK";    # Nowadays there is no error control

	# &print2File({titulo=>"Dumper en cargarUsersJson grupos.json",ref=>\%r_fileJSON2Hash});
	if($r_fileJSON2Hash{status} eq "OK"){
		$return{templates_sms}=$r_fileJSON2Hash{hash};
	}
	return(%return);
}

&cargarTodosModelos();


our $nombre_user_logeado;
my @grupos_q_pertenece = &gruposAlosQuePerteneceUser($nombre_user_logeado);

our %user;
%user = (
	nombre=>$nombre_user_logeado,
	grupos_q_pertenece=>\@grupos_q_pertenece,
	rol=>"user(TODO)"   # TODO
);
1;
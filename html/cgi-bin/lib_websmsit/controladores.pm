#!/usr/bin/perl
use warnings;
use strict;
use lib '.';
use webTemplates;
use variables_globales;
use userHelpers;
use logsHelpers;
# Es llamado desde miEnrutador
# hace los calculos necesarios y llama a los templates

our $q;
our $nombre_user_logeado;
sub cHome{
	# NO CONSIGO recuperar el valor de variable de session 'user_name'  !!!!
	# uso la ULTRA CUTREZ de our varibles_globales $nombre_user_logeado (escrito a fuego en variables_globales)
	
	# our $q;
	# my $user = $q->param("user_name");
	
	# our $session;
	# my $user = $session->param("user_name");

	# our $nombre_user_logeado;  # esto lo recuperare con variable de session
	# print "USER [$user]\n<br>";
	# print "nombre_user_logeado [$nombre_user_logeado]\n<br>";


	#### Home calcula a que grupos pertenece el usuario
	# my @grupos_user = &gruposAlosQuePerteneceUser($nombre_user_logeado);
	# my %params =(
	# 	nombre_user => $nombre_user_logeado,
	# 	grupos_user => @grupos_user,
	# );
	# our %usersJson;
	# print Dumper(%usersJson);
	# our %gruposJson;
	# print Dumper(%gruposJson);
	&wtHome();
}


sub cError(){
	&wtError();
}
# $grupo MUST exist
sub cLogs($){
	my $grupo = shift;

	print "<h1>crystal castles</h1>";
	# $grupo MUST exist !! 

	# detect if user has permissions see these group
	# TODO print a message (you dont have permission)

	my %params;

	my %r_logs2Hash1Grupo = logs2Hash1Grupo($grupo);
	if($r_logs2Hash1Grupo{status} eq "OK"){
		$params{logs_in_hash} = $r_logs2Hash1Grupo{hash}; # a hash with the log
	}
	# TODO print a ERROR page when error

	%params =(
		grupo=>$grupo,
		nombre_user=>$nombre_user_logeado
	);
	&wtLogs(\%params);
}

sub cSms(){
	&wtSms();
}

sub cDebug($){
	&wtDebug();
}
1;
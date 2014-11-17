#!/usr/bin/perl
use warnings;
use strict;
use lib '.';
use webTemplates;
use variables_globales;
use userHelpers;
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
	&gruposAlosQuePerteneceUser();
	my %params =(
		nombre_user => $nombre_user_logeado,
	);
	# our %usersJson;
	# print Dumper(%usersJson);
	# our %gruposJson;
	# print Dumper(%gruposJson);
	&wtHome(\%params);
}


sub cError(){
	&wtError();
}

sub cLogs($){
	my $grupo = shift;

	my %params =(
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
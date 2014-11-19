#!/usr/bin/perl
use warnings;
use strict;
use lib '.';
use webTemplates;
use variables_globales;
use userHelpers;
use logsHelpers;
use smsHelpers;
# Es llamado desde miEnrutador
# hace los calculos necesarios y llama a los templates

our $q;
our %user;
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
	my %params_to_template;
	$params_to_template{grupo} =$grupo;  # add grupo

	my $flag_usar_has_permissions_to_see_group = 0;
	# detect if user has permissions to see these group
	foreach my $un_grupo_candidato(@{$user{grupos_q_pertenece}}){
		if($un_grupo_candidato eq $grupo){
			# TODO print a message (you dont have permission)

			my %r_logs2Hash1Grupo = logs2Hash1Grupo($grupo);
			if($r_logs2Hash1Grupo{status} eq "OK"){
				$params_to_template{logs_as_hash} = $r_logs2Hash1Grupo{hash}; # a hash with the log
			}
			# TODO print a ERROR page when error
			$flag_usar_has_permissions_to_see_group = 1;
			last;
		}
	}
	if($flag_usar_has_permissions_to_see_group == 0){
		$params_to_template{mensaje_error} = "NO TIENES PERMISOS PARA VER este grupo";
	}
	&wtLogs(\%params_to_template);
}

sub cSms(){
	# cargar los templates_sms
	my %r_devolverTemplatesSms = devolverTemplatesSms();
	# print Dumper($r_devolverTemplatesSms{templates_sms});
	my %params;
	if ($r_devolverTemplatesSms{status} eq "OK"){  # nowadays there is no error control
		# $params{templates_sms} = $r_devolverTemplatesSms{templates_sms};
		$params{text_area_select_and_template_json} = construirTextAreaYSelectAndTemplateJsonFromHash($r_devolverTemplatesSms{templates_sms});
	}
	&wtSms(\%params);
}

sub cDebug($){
	&wtDebug();
}
1;
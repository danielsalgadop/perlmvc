#!/usr/bin/perl
# Study this options
# http://cgi-app.org/index.cgi?LoginLogoutExampleApp
# http://www.perlmonks.org/?node_id=698693
#
use warnings FATAL=>all;
use strict;
our $q;
our $path_absoluto_sessiones_cgi;
our $name_cookie_that_stores_session_id;

###################################
# Compares values
# if they are not equal removes new created session
###################################
sub cookieAndSessionEqual($){
	my $value_of_cookie = shift;
	return(0,"") unless $value_of_cookie;

	# debug2File({ref=>\$value_of_cookie,titulo=>"value_of_cookie"});
	# debug2File({ref=>\$path_absoluto_sessiones_cgi,titulo=>"path_absoluto_sessiones_cgi en miSessions"});
	my $session = new CGI::Session("driver:File", $value_of_cookie, {Directory=>$path_absoluto_sessiones_cgi}) or die CGI::Session->errstr;
	
	my $existe_alias_en_session = $session->param('alias');
	# debug2File({ref=>\$existe_alias_en_session,titulo=>"existe_alias_en_session"});
		return (1,$session) if $value_of_cookie eq $session->id();  # everything looks ok

	$session->delete();
	$session->flush(); # Recommended practice says use flush() after delete().
	return(0,"");
}

###################################
# Function: estaLogeado
# estaLogeado significa que el contenido del cookie es == al valor de la session
# looks for cookie 'logeado'
# compares value of cookie 'logeado' and compares it to session->id()
# returns{status} == OK if so
# returns{stauts} == ERROR if not,
###################################
sub estaLogeado() {
	my $existia_cookie = $q->cookie($name_cookie_that_stores_session_id);
	my ($r_cookieAndSessionEqual,$session)	= &cookieAndSessionEqual($existia_cookie);
	if ($r_cookieAndSessionEqual){
		return(status=>"OK",session=>$session);
	}
	return(status=>"ERROR");
}
###################################
# Function: sigueLogeado
# es la extension de estaLogeado Hace lo mismo y admeas comprueba que exista valor en session alias 
# returns{status} == OK if so
# returns{stauts} == ERROR if not,
###################################
sub sigueLogeado() {
	my %r_estaLogeado = &estaLogeado();
	if($r_estaLogeado{status} eq "OK")
	{
		my $session = $r_estaLogeado{session};
		if($session->param('alias') )
		{
			return 1;
		}
	}
	our $path_web_cgi;
	print $q->redirect($path_web_cgi.'/login.pl');
	exit;
	# return(status=>"ERROR");
}

###################################
# Function: credencialesOK
# used in login.pl
###################################
sub credencialesOK($){
	my $ref_params = shift;
	my %params = %{$ref_params};
    ################################
    # logic for credentials
    ################################
    our $path_absoluto_modelos;

	# TRAER datos de users.json donde estan las relacion usuario=>contraseña
	my %r_universalJsonReader = universalJsonReader($path_absoluto_modelos."/users.json");

    # debug2File({ref=>\%r_universalJsonReader,titulo=>"r_universalJsonReader"});

    my %users = %{$r_universalJsonReader{ref_json_hash}{1}};

    # debug2File({ref=>\%users,titulo=>"users"});
    # debug2File({ref=>\%params,titulo=>"params"});
    # return 1;

	foreach my $usuario(keys %users)
    {
        # debug2File({ref=>\"two equals",titulo=>"is \$users{$id}{alias}[".$users{$id}{alias}."] eq \$params{usuario}[".$params{usuario}."] AND \$users{$id}{passw} [".$users{$id}{passw}."] \$params{passw}[".$params{passw}."]"});
		return 1 if $usuario eq $params{usuario} and $users{$usuario} eq $params{passw};
	}

	return 0;  # no esta autenticado
}


1;
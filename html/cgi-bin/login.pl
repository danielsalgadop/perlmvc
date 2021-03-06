#!/usr/bin/perl
use warnings FATAL=>all;  # use in development
use strict;
use lib 'perlmvc';
use perlmvc;

# our $q; # our $q = CGI->new;
# my $q = CGI->new;
my %params = $Globals::q->Vars;
# debug2File({ref=>\%params,titulo=>"params"}) if %params;

# esta logeado?
my %r_estaLogeado = estaLogeado();
# debug2File({ref=>\%r_estaLogeado,titulo=>"estaLogeado"});

if ( $r_estaLogeado{status} eq "OK" )
{
    print $Globals::q->redirect(-uri=>$Paths::web_cgi."/index.pl"); # si estas logeado, fuera de aqui
}
# esta intentando acreditarse?
if(exists $params{usuario}) # Need this param
{
	if( &credencialesOK(\%params)) # el usuario y passw coinciden con valores en modelos
	{
		# usuario y passw OK
        # debug2File({ref=>\"credenciales OK = 1",titulo=>"Paths::sessiones [".$Paths::sessiones."] Globals::name_cookie_that_stores_session_id [".$Globals::name_cookie_that_stores_session_id."]"});

	    # genero nueva session ...
	    my $session = new CGI::Session("driver:File", undef, {Directory=>$Paths::sessiones}) or die CGI::Session->errstr; # TODO, put here AppError not a die
	    # ... y almaceno el identificativo de session en variable cookie
	    my $cookie = 
            $Globals::q->cookie(
                -name=>$Globals::name_cookie_that_stores_session_id,
                -value=>$session->id(),
                -expires=>$Globals::expire_time
	    );

	    # almaceno alias del usario en session
	    $session->param(alias => $params{usuario});
	    # creo cookie y redirijo a index.pl
	    print $Globals::q->redirect(-uri=>$Paths::web_cgi."/index.pl",-cookie=>$cookie);
	}
	&generarFormLogin("error");
}

# User has not send $params{usuario}, probably is the first time user in web
&generarFormLogin();
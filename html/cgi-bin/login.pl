#!/usr/bin/perl
use warnings FATAL=>all;  # use in development
use strict;
use lib 'perlmvc';
use perlmvc;

our $q; # our $q = CGI->new;
# my $q = CGI->new;
our $path_web_cgi;
my %params = $q->Vars;

# debug2File({ref=>\$path_web_cgi,titulo=>"aqui estas"});

# esta logeado?
my %r_estaLogeado = estaLogeado();

# debug2File({ref=>\%r_estaLogeado,titulo=>"estaLogeado"});

if ( $r_estaLogeado{status} eq "OK" ) {
    print $q->redirect(-uri=>$path_web_cgi."/index.pl"); # si estas logeado, fuera de aqui
}
# esta intentando acreditarse?
if( $params{usuario} and $params{passw}){ # Need this $params
	if( &credencialesOK(\%params)){
        # el usuario y passw coinciden con valores en modelos
        our $path_absoluto_sessiones_cgi;
        our $name_cookie_that_stores_session_id;
        # debug2File({ref=>\"credenciales OK = 1",titulo=>"path_absoluto_sessiones_cgi [".$path_absoluto_sessiones_cgi."] name_cookie_that_stores_session_id [".$name_cookie_that_stores_session_id."]"});

	    # genero nueva session ...
	    my $session = new CGI::Session("driver:File", undef, {Directory=>$path_absoluto_sessiones_cgi}) or die CGI::Session->errstr; # TODO, put here AppError not a die
	    # ... y almaceno el identificativo de session en variable cookie
	    my $cookie = 
            $q->cookie(
                -name=>$name_cookie_that_stores_session_id,
                -value=>$session->id(),
                -expires=>"+1h"
	    );

	    # almaceno alias del usario en session
	    $session->param(alias => $params{usuario});
	    # creo cookie y redirijo a index.pl
	    print $q->redirect(-uri=>$path_web_cgi."/index.pl",-cookie=>$cookie);
	}
}

# si has llegado aqui, es que es NO has logeado bien (o acabas de llegar)
# BAD credenciales


(  $params{usuario} or $params{passw} ) ? &generarFormLogin("hay_error"):&generarFormLogin();



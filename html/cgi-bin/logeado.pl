#!/usr/bin/perl
use warnings;
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use Data::Dumper;
use lib 'lib_websmsit';
use miJSON;
# use miHtml;
# use validaciones;
use variables_globales;
use variables_paths;
# use miSessions;

our $q;

unless($q->cookie("logeado")){   # la cookie debe existir
        print $q->redirect('index.pl');
}
else{
    # el valor de la cookie debe existir en el id de alguna session
    our $path_aboluto_sessiones_cgi;
    my $session = new CGI::Session("driver:File", $q->cookie("logeado"), {Directory=>$path_aboluto_sessiones_cgi."/"}) or die CGI::Session->errstr;
    if($session->id() ne $q->cookie("logeado")){   # la cookie era antigua (o generada malintencionadamente)
        print $q->redirect('index.pl');
    }
}
# almacenar 'usuario' en cookie
# my $cookie_user = $q->cookie(-name=>'logeado', -value=>12);
# 
    # -cookie => $cookie_logeado
    # );

print $q->header();
print $q->start_html(
    -title      => 'WEB SMS IT',
    -dtd        => "4.0",
    -style      => {'src' => '../css/css.css'},
    -lang       =>'es-ES',
    -script     =>[
                    {
                        -type => 'text/javascript',
                        -src => '../js/js.js',
                    }
    ]
);

print $q->h1("ESTAS LOGEADO");
print $q->div({id=>"col_izq"},ul(li(a({href=>"http://crete.org/"},"Ver LOGS")),li(a({href=>"http://crete.org/"},"Enviar SMS"))));
print $q->div({id=>"col_dere"},"Bienvenido a la web donde enviar SMS");
print $q->a({href=>"http://crete.org/"},"Crete");

print $q->end_html;
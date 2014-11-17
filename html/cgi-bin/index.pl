#!/usr/bin/perl
use warnings;
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use Data::Dumper;
use lib 'lib_websmsit';
use debug;
use miJSON;
use miEnrutador;
use miHtml;
# use validaciones;
use variables_globales;
use variables_paths;
# use miSessions;
use cargarModelos; # rellena %usersJson, %gruposJson y %user

our %usersJson;
our %gruposJson;
# &print2File({titulo=>"comprobat que Existe \%usersJson",ref=>\%usersJson});
# &print2File({titulo=>"comprobat que Existe \%gruposJson",ref=>\%gruposJson});


use userHelpers;
our $q;

unless($q->cookie("logeado")){   # la cookie debe existir
        print $q->redirect('login.pl');
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

# cargar esto solo si los keys son 0 (para evitarlo hacerlo CADA vez)

print $q->header();
our %user;
# print Dumper(%user);
# print "<hr>";
# print Dumper(%usersJson);
# print "<hr>";
# print Dumper(%gruposJson);
# print "<hr>";
&miStartHtml();
&enrutador();
print $q->end_html;
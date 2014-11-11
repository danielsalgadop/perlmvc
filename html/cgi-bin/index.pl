#!/usr/bin/perl
use warnings;
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use Data::Dumper;
use lib 'lib_websmsit';
use miJSON;
use miHtml;
use validaciones;


my $q = CGI->new;
my %params = $q->Vars;
 print $q->header();





# if (EXISTE_SESSION_LOGEADA){
	#  redireccionar al siguiente scritp
# }

# han enviado el formulario
if($params{usuario} and $params{contra}){
	# SANITIZAR valores desde perl

	# comprobar si coinciden las contraseñas
	# print Dumper(%params);

	# LOGEADO ERROR:
	# 


	# LOGEADO OK:
	# si todo va bien almacenar en session que ya estan logados
	print "SIIISISISIS\n";

	# redireccionar a siguiente script
}
&generarFormLogin();





# my $session = new CGI::Session("driver:File", undef, {Directory=>'/tmp'});

# # getting the effective session id:
# my $CGISESSID = $session->id();

# # storing data in the session
# $session->param('f_name', 'Sherzod');
# # or
# $session->param(-name=>'l_name', -value=>'Ruzmetov');

# # retrieving data
# my $f_name = $session->param('f_name');
# # or
# my $l_name = $session->param(-name=>'l_name');

# # clearing a certain session parameter
# $session->clear(["_IS_LOGGED_IN"]);

# # expire '_IS_LOGGED_IN' flag after 10 idle minutes:
# $session->expire(_IS_LOGGED_IN => '+10m');


# # expire the session itself after 1 idle hour
# $session->expire('+1h');

# # delete the session for good
# $session->delete();






print "<h1>Index</h1>";
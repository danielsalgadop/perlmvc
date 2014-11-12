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
use variables_globales;
use miSessions;

our $q;
my %params = $q->Vars;
print $q->header();

my $cookie1 = $q->cookie(-name=>'logeado', -value=>1);

print $q->header(
	-cookie => $cookie1
	);




print $q->start_html(
    -title   	=> 'WEB SMS IT',
    -dtd 		=> "4.0",
    -style   	=> {'src' => '../css/css.css'},
    -lang		=>'es-ES',
    -script		=>[
    				{
    					-type => 'text/javascript',
    					-src => '../js/js.js',
    				}
    ]
);


# existe la cookie 'logeado'
# SI => rediccionar




print $q->h1("Index3");
# if exite en cookies logeado
my  $sid = $q->cookie("logeado") || undef;
if($sid){
	print "YA ESTAS LOGEADO";
}
else{
	print "NO ESATS LOGEADO";
}
print "\n<br>";
 # (EXISTE_SESSION_LOGEADA){
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
	print "SIIISISISIS han enviado el formulario\n<br>";

	# redireccionar a siguiente script
}
else{
	print "NOOOOOOOOOOOOO han enviado el formulario\n<br>";
}
&generarFormLogin();

my $session = new CGI::Session("driver:File", undef, {Directory=>'/tmp'});

# # getting the effective session id:
my $CGISESSID = $session->id();

print "CGISESSID ".$CGISESSID."\n<br>";

use CGI::Cookie;
# Create new cookies and send them
# my $cookie1 = CGI::Cookie->new(-name=>'logeado',-value=>$CGISESSID); #  mas seguro si valor logeado es el de session
my $cookie1 = CGI::Cookie->new(-name=>'logeado',-value=>1);

my %cookies = CGI::Cookie->fetch;
my $cookie_logeado = $cookies{'logeado'}->value;


# $q->cookie("logeado",1);
# $sid = $q->cookie("logeado") || undef;
if($cookie_logeado){
	print "YA ESTAS LOGEADO";
}
else{
	print "NO ESATS LOGEADO";
}
print "\n<br>";

# # storing data in the session
$session->param('logeado', 1); # equivalent to $session->param(-name=>'l_name', -value=>'Ruzmetov');


my $esta_logeado = $session->param('logeado');  # equivalent to $esta_logeado = $session->param(-name=>'logeado');
if( $esta_logeado){
	print "SIII esta logeado";
}

# # clearing a certain session parameter
# $session->clear(["_IS_LOGGED_IN"]);

# # expire '_IS_LOGGED_IN' flag after 10 idle minutes:
# $session->expire(_IS_LOGGED_IN => '+10m');


# # expire the session itself after 1 idle hour
# $session->expire('+1h');

# # delete the session for good
# $session->delete();

# print  $q->redirect('http://www.google.com');  # no funciona
print $q->end_html;
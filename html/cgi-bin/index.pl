#!/usr/bin/perl
use warnings;
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use Data::Dumper;
use lib 'lib_websmsit';
use bootwebSMSIT;
use miJSON;
use miHtml;
use validaciones;
use variables_globales;
use variables_paths;
use miSessions;
use autenticacion;

our $q;

# SED para ahorrarme tener que escribir el formulario
# $q->param(-name=>'usuario',-value=>'nombre');
# $q->param(-name=>'contra',-value=>'contra');
# SED para ahorrarme tener que escribir el formulario
my %params = $q->Vars;
# print Dumper(%params);

my $cookie_logeado; # put / get cookie logiado
# my $cookie1 = $q->cookie(-name=>'logeado', -value=>12);

print $q->header(
	-cookie => $cookie_logeado
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

print "cookie_logeado xxxx".$cookie_logeado."\nxxxx<br>" if $cookie_logeado;
print "cookie_logeado ".$cookie_logeado."\n<br>" if $cookie_logeado;

print $q->h1("Index3");
print $q->div({id=>"errores"},"");
# if exite en cookies logeado
$cookie_logeado = $q->cookie("logeado") || undef;
if($cookie_logeado){
	&redirectUsingJavascript("logeado.pl");
}
else{
	print "NO ENCUENTRO COOKIE";
}
print "\n<br>";
 # (EXISTE_SESSION_LOGEADA){
	#  redireccionar al siguiente scritp
# }

# han enviado el formulario
if($params{usuario} and $params{contra}){
	print "SIIISISISIS han enviado el formulario\n<br>";
	# SANITIZAR valores desde perl ¿todo ok?
	# NO => mostrar error

	# TRAER datos de users.json donde estan las contraseñas
	my %r_fileJSON2Hash = fileJSON2Hash("../configs/users.json");
	my %users = %{$r_fileJSON2Hash{hash}};
	# print Dumper(%users);

	# comprobar si coinciden usuario/contraseñas
	if(&estaAtenticado($params{usuario},$params{contra},\%users)){
		# LOGEADO OK:
		print "<br> HAS LOGEADO<br>";
		our $path_aboluto_sessiones_cgi;

		# si todo va bien almacenar en session que ya estan logados
		my $session = new CGI::Session("driver:File", undef, {Directory=>$path_aboluto_sessiones_cgi});

		# # getting the effective session id:
		my $CGISESSID = $session->id();

		# # storing data in the session
		$session->param('logeado', $CGISESSID); # equivalent to $session->param(-name=>'l_name', -value=>'Ruzmetov');

		my $esta_logeado = $session->param('logeado');  # equivalent to $esta_logeado = $session->param(-name=>'logeado');
		if($esta_logeado){
			print "SIII esta logeado";
			&redirectUsingJavascript("logeado.pl");
		}
	}
	else{
		# LOGEADO ERROR:
		&errores2DivErrores("Problema en LOGIN. Revisa usuario y/o Contraseña");
	}
	# redireccionar a siguiente script
}
&generarFormLogin();
print $q->end_html;
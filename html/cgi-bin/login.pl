#!/usr/bin/perl
use warnings;
use strict;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use CGI::Cookie;
use Data::Dumper;
use lib 'lib_websmsit';
use bootwebSMSIT;
use miJSON;
use miHtml;
use validaciones;
use variables_globales;
use variables_paths;
use miSessions;
use miHtml;
use autenticacion;
use controladores;

# TODO boot_app





our $q; # our $q = CGI->new;
our $path_aboluto_sessiones_cgi;
# mirar si tiene la cookie logeado
# my $esta_logeado = $session->param('logeado');  # equivalent to $esta_logeado = $session->param(-name=>'logeado');


# $sid toma el valor de la cookie (que es el valor del id de session (si existe)) 'logeado', en caso de que no exista toma 'undef'
my $sid = $q->cookie("logeado") || undef;

my $toe=($sid)?"valor recuperado [$sid] ":" UNDEFFFF";

# $sid = "123";  # provocar que la session id tenga valor falso (como generado por usuario)
# he puesto session como 'our' para intentar recuperar el valor de "user_name", no lo consiguo
our $session;
$session = new CGI::Session("driver:File", $sid, {Directory=>$path_aboluto_sessiones_cgi."/"}) or die CGI::Session->errstr;

unless($sid){  # to avoid warning Use of uninitialized value $sid in string eq at
	$sid="";
}
# Como ya hay id para la session lo recupero (o esta recien creado (session nueva) o tiene el valor de anterior sesion)
my $sid_actual_session = $session->id();


$session->param("user_name" => "nombre" );  # SED pongo a fuego el nombre del clinte en la session

# our $nombre_user_logeado;
# $nombre_user_logeado = "nombre"; # no puedo recuperar la variable de sesion ?? lo hago asi por ahora




# TODO controlar aqui que existe el parametro session_name (donde se almacena el nombre del cliente)
if( $sid_actual_session eq $sid ){    # la session id alamcenada en servidor equivale a la almacenada en cookie
	# $toe.="valores de ids COINCICENTES \$sid_actual_session == \$sid HUBIERA REDIRECCIONADO";
	# redireccionar
	print $q->redirect('index.pl');
	# print $q->header();  #SED, para q no de error, se puede quitar en produccion
}
else{

	# Pinto la cabecera del cgi, con la cookie generada
	my $cookie_logeado = cookie(
		-name=>'logeado',
	    -value=>$sid_actual_session,
	    -expires=>'+1m',     # SED lo pongo solo 1 minutos para ver como se auto-borra, valor produccion +1m
	    );

	print $q->header(   # la cookie logeado tiene el valor de la id de la session
		-cookie => $cookie_logeado
		);
}


&miStartHtml();

# # Pinto la cabecera del cgi, con la cookie generada print $cgi->header(-cookie => $cookie );

my %params = $q->Vars;
# # existe la cookie 'logeado'
# # SI => rediccionar

# han enviado el formulario
if($params{usuario} and $params{contra}){
	print "SIIISISISIS han enviado el formulario\n<br>";
	# SANITIZAR valores desde perl ¿todo ok?
	# NO => mostrar error

	# TODO usar cargarModelos y %usersJson para comprobar las contraseñas
	# TRAER datos de users.json donde estan las contraseñas
	my %r_fileJSON2Hash = fileJSON2Hash("../configs/users.json");
	my %users = %{$r_fileJSON2Hash{hash}};
	# print Dumper(%users);

	# comprobar si coinciden usuario/contraseñas
	if(&estaAtenticado($params{usuario},$params{contra},\%users)){
		# LOGEADO OK:
		print "<br> HAS LOGEADO y path_aboluto_sessiones_cgi es[$path_aboluto_sessiones_cgi]<br>";

		# # si todo va bien almacenar en session que ya estan logados
		# my $session = new CGI::Session("driver:File", undef, {Directory=>$path_aboluto_sessiones_cgi."/"}) or die CGI::Session->errstr;

		# # # getting the effective session id:
		# my $CGISESSID = $session->id();

		# # # storing data in the session
		# $session->param('logeado', $CGISESSID); # equivalent to $session->param(-name=>'l_name', -value=>'Ruzmetov');

		# my $esta_logeado = $session->param('logeado');  # equivalent to $esta_logeado = $session->param(-name=>'logeado');
		# if($esta_logeado){
		# 	print "SIII esta logeado";
		# 	&redirectUsingJavascript("logeado.pl");
		# }
	}
	else{
		# LOGEADO ERROR:
		&errores2DivErrores("Problema en LOGIN. Revisa usuario y/o Contraseña");
	}
	# redireccionar a siguiente script
}
&generarFormLogin();

print $q->end_html;
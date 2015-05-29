#!/usr/bin/perl
package Paths;
use warnings;
use strict;

# Function that retrurns server ip, to avoid hasrdcoding, OJO no funciona en todas las maquinas
sub myIp()
{
	use Sys::Hostname qw(hostname); # not strictly necessary; exports it by default
	use Socket;
	my($localip) = inet_ntoa( (gethostbyname(hostname()))[4] );
	return $localip;
}
# my $server_ip 			= "http://10.0.191.222";  # you can use myIp() in some machines
my $nombre_app 			= "perlmvc";  # TODO bring this from globals
my $path_web 			= "/".$nombre_app."/html";    
my $path_absoluto_app 	= "/var/www/html";
our $path_web_cgi		= $Globals::server_ip."/".$nombre_app."/html/cgi-bin";
our $modelos 			= $path_absoluto_app."/".$nombre_app."/models"; # usually jsons
our $sessiones 			= "/tmp/sessiones_".$nombre_app;
our $debug_app 			= "/tmp/debug2file_".$nombre_app;
our $css 				= $path_web."/css"; 
our $js 				= $path_web."/js";
our $cgi				= $Globals::server_ip."/".$nombre_app."/html/cgi-bin";
our $web 				= $path_web_cgi."/index.pl";  # todas las rutas cuelgan de aqui
our $logs				= $path_absoluto_app."/".$nombre_app."/cgi-bin/logs";
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
my $path_web 			= "/".$Globals::nombre_app."/html";    
my $path_absoluto_app 	= "/var/www/html";
our $modelos 			= $path_absoluto_app."/".$Globals::nombre_app."/models"; # usually jsons
our $sessiones 			= "/tmp/sessiones_".$Globals::nombre_app;
our $debug_app 			= "/tmp/debug2file_".$Globals::nombre_app;
our $css 				= $path_web."/css"; 
our $js 				= $path_web."/js";
our $web_cgi			= $Globals::server_ip."/".$Globals::nombre_app."/html/cgi-bin";
our $absolute_cgi       = $path_absoluto_app."/".$Globals::nombre_app."/html/cgi-bin";
our $web 				= $web_cgi."/index.pl";  # todas las rutas cuelgan de aqui
# our $logs				= $path_absoluto_app."/".$Globals::nombre_app."/cgi-bin/logs";
our $templates         	= $absolute_cgi."/perlmvc/templates";
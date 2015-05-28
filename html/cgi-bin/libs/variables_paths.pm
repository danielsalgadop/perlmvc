#!/usr/bin/perl
use warnings;
use strict;


our $nombre_app = "perlmvc";

our $path_absoluto_sessiones_cgi = "/tmp/sessiones_".$nombre_app;
my $path_absoluto_app 			= "/var/www/html";
our $path_absoluto_debug_app	= "/tmp/debug2file_".$nombre_app;
my $path_web 					= "/".$nombre_app."/html";    
our $path_web_css 				= $path_web."/css"; 
our $path_web_js 				= $path_web."/js";

our $server_ip 					= "http://10.0.191.102";
our $path_web_cgi				= $server_ip."/".$nombre_app."/html/cgi-bin";

# our $path_absoluto_modelos = $path_absoluto_app."/".$nombre_app."/models"; # users.json y grupos.json

our $path_web_rutas				= $path_web_cgi."/index.pl";  # todas las rutas cuelgan de aqui

our $path_absoluto_logs			= $path_absoluto_app."/".$nombre_app."/cgi-bin/logs";


# Function that retrurns server ip, to avoid hasrdcoding, OJO no funciona en todas las maquinas
sub myIp()
{
	use Sys::Hostname qw(hostname); # not strictly necessary; exports it by default
	use Socket;
	my($localip) = inet_ntoa( (gethostbyname(hostname()))[4] );
	return $localip;
}
package Paths;
# use warnings;
# use strict;
my $nombre_app 			= "perlmvc";  # TODO bring this from variables_globales
my $path_absoluto_app 	= "/var/www/html";
our $modelos 			= $path_absoluto_app."/".$nombre_app."/models"; # usually jsons
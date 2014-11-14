#!/usr/bin/perl
use warnings;
use strict;


our $nombre_app = "websmsit";

our $path_aboluto_sessiones_cgi = "/tmp/sessiones_websmsit";
our $path_aboluto_app 			= "/var/www/html";    
our $path_web_css 				= "/".$nombre_app."/css"; 
our $path_web_js 				= "/".$nombre_app."/js";
# TODO calculate server ip
our $server_ip 					= "http://10.0.223.103";

our $path_aboluto_jsones_modelos = $path_aboluto_app."/".$nombre_app."/configs"; # users.json y grupos.json


our $path_web_rutas				= $server_ip."/".$nombre_app."/cgi-bin/index.pl";  # todas las rutas cuelgan de aqui
#!/usr/bin/perl
package Globals;
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
# place for global variables
our $q = CGI->new;
our $nombre_app 			= "perlmvc"; # the name of web folder in system. Used to build paths
# in some machines you can use myIp(s) to fill $server_ip
our $server_ip 				= "http://10.0.191.102"; 
# our $server_ip 				= &myIp();
our $titulo_web 			= "PERL MVC"; # web <title>, header <h1> and login header
our $name_cookie_that_stores_session_id = "CGISESSIONID_PERLMVC";
our $expire_time			= "+10s"; # time that session expires (saved in cookie)
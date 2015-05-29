#!/usr/bin/perl
package Globals;
use warnings;
use strict;
# place for global variables
our $q = CGI->new;
our $server_ip = "http://10.0.191.102"; # in some machines you can use myIp(s)
our $titulo_web = "PERL MVC"; # web <title>, header <h1> and login header
our $name_cookie_that_stores_session_id = "CGISESSIONID_PERLMVC";
1;
#!/usr/bin/perl
use warnings;
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use lib 'lib_websmsit';
use miJSON;


my $q = CGI->new;
my %params = $q->Vars;



# if(%params){
# 	print "SIIISISISIS\n";
# }
# else{
# 	print "NOOOOO\n";
# }






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






print "Content-type: text/html\n\n";
print "<h1>Index</h1>";
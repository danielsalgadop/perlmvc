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
# print $q->header();


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

print $q->h1("ESTAS LOGEADO");


# print  $q->redirect('http://www.google.com');  # no funciona
print $q->end_html;
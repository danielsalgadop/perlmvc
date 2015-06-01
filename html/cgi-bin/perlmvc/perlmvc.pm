#!/usr/bin/perl
use warnings FATAL=>all;  # use in development
use strict;

# perl core functions
use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use Data::Dumper;
#perlmvc libs
use debug;
use miJSON;
use miEnrutador;
use miHtml;
use Globals;
use Paths;
use miSessions;
use sessionHelper;
# use cargarModelos;
use controladores;
use validaciones;
use lib 'perlmvc/vendors';
use HTML::Template;
1;
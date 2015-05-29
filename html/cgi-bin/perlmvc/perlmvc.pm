#!/usr/bin/perl
use warnings FATAL=>all;  # use in development
use strict;

#perlmvc libs
use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use Data::Dumper;
use lib '.';
use debug;
use miJSON;
use miEnrutador;
use miHtml;
use globals;
use paths;
use miSessions;
use sessionHelper;
# use cargarModelos;
use controladores;
use validaciones;
1;
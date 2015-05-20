#!/usr/bin/perl
# Libs of mvc and libs of user (cgi-bin/libs) are charged
# use warnings FATAL=>all;  # use in development
# use strict;

use CGI::Carp qw(fatalsToBrowser);
use CGI qw(:standard);
use CGI::Session;
use Data::Dumper;
use lib 'libs';
use debug;
use miJSON;
use miEnrutador;
use miHtml;
use variables_globales;
use variables_paths;
use miSessions;
# use cargarModelos;
use controladores;
1;
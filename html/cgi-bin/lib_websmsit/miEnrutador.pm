#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
our $q;
use lib '.';   # the following pm are brothers of miEnrutador
use webTemplates;
use variables_globales;
use variables_paths;



# Analiza la URI
# escribe el template correspondiente
sub enrutador{
	# use URI;
	# Analizar REQUEST_URI
	our $path_web_rutas;
	our $server_ip;
	# print "server_ip/env_requesturi [".$server_ip.$ENV{REQUEST_URI}."]\n<br>";
	# print $path_web_rutas."\n<br>";

	# Sanitizar url
	# # quitar la agregacion de links (al pinchar un link se agrega a la url)
	if($server_ip.$ENV{REQUEST_URI} eq $path_web_rutas){ # estamos en landing tras login.pl
		&wtHome(); # home
	}
	else{ # 
		my @url_troceada = split("index.pl", $ENV{REQUEST_URI});
		# TODO detectar niveles 1 solo / 2, 3 etc...
		print "<br><br>".Dumper($ENV{REQUEST_URI})."<br><br>";
		print "<br><br>".Dumper(@url_troceada)."<br><br>";
		print "<br><br>".Dumper($url_troceada[-1])."<br><br>";
		if ($ENV{REQUEST_URI} =~ m/logs$/){
			&wtLogs();
		}
		elsif ($ENV{REQUEST_URI} =~ m/sms$/){
			&wtSms();
		}
		else{
			&wtError();
		}
	}
}

1;
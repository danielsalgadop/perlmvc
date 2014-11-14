#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
our $q;
use lib '.';   # the following pm are brothers of miEnrutador
use webTemplates;
use controladores;
use variables_globales;
use variables_paths;

# Analiza la URI
# llama al controlador correspondiente
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
		&cHome(); # home
	}
	else{ # 
		my @url_troceada = split("index.pl", $ENV{REQUEST_URI});
		# TODO detectar niveles 1 solo / 2, 3 etc...
		print "<br><br>".Dumper($ENV{REQUEST_URI})."<br><br>";
		print "<br><br>".Dumper(@url_troceada)."<br><br>";
		print "<br><br>".Dumper($url_troceada[-1])."<br><br>";

		my $count_niveles = () = $url_troceada[-1] =~ /\//g;
		# $count = () = $string =~ /colou?r/g; # count the number of  colours (and colors).
		# my @count_niveles = $url_troceada[-1] =~ /\//\//g;
		# nivel 1
		if($count_niveles == 1){
			# Todos los logs
			if ($ENV{REQUEST_URI} =~ m/logs$/){
				&cLogs();
			}
			elsif ($ENV{REQUEST_URI} =~ m/sms$/){
				&cSms();
			}
			else{
				&cError();
			}
		}
		elsif($count_niveles  == 2){
			# logs concretos de un solo grupo
			if ($ENV{REQUEST_URI} =~ m/logs\/(.*)$/){
				&cLogs($1);
			}
		}
		else{
			&cError();
		}
	}
}

1;
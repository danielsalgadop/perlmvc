#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;
our $q;
use lib '.';   # the following pm are brothers of miEnrutador
use webTemplates;
use variables_globales;
use variables_paths;

sub enrutador{
	# use URI;
	# Analizar REQUEST_URI
	our $path_web_rutas;
	our $server_ip;
	print "server_ip/env_requesturi [".$server_ip.$ENV{REQUEST_URI}."]\n<br>";
	print $path_web_rutas."\n<br>";

	# Sanitizar url
	# # quitar la agregacion de links (al pinchar un link se agrega a la url)
	if($server_ip.$ENV{REQUEST_URI} eq $path_web_rutas){ # estamos en landing tras login.pl
		&wtHome(); # home
	# 	my @url_troceada = split('index.pl',$ENV{REQUEST_URI});
	# 	# # me interesa la ultima parte la uri
	# 	my $nueva_url = "index.pl".$url_troceada[-1];
	# 	my $uri = URI->new($nueva_url);
	# 	# # redireccionar alli
	# 	# $ENV{REQUEST_URI} = $nueva_url;
	# 	print $q->redirect($nueva_url);
	# 	# print $q->redirect("http:/NOOOOOOO_estas_en_home");
	}
	else{
		&wtDefault();
	}
}

1;
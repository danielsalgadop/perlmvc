#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

sub enrutador{
	# Analizar REQUEST_URI
	print "\n<br>Dentro de enrutador\n<br>";
	print Dumper($ENV{REQUEST_URI});	# probar esto print CGI->new->url();

}

1;
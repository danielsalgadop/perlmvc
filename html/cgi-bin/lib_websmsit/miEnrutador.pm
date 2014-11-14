#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

sub enrutador{
	# Analizar REQUEST_URI
	print Dumper($ENV{REQUEST_URI});	# probar esto print CGI->new->url();

}

1;
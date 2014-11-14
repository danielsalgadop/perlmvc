#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

sub enrutador{
	# Analizar REQUEST_URI
	print Dumper($ENV{REQUEST_URI});

}

1;
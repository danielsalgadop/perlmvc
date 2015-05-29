#!/usr/bin/perl -w
use strict;

# Function: trimSpaces
# trimming spaces
sub trimSpaces($){
	my $str_to_trim = shift;
	$str_to_trim =~ s/^\s+|\s+$//g;
	return($str_to_trim);
}

# Function: esIp
#
sub esIp($){
	my $esIP = shift;
  # sacado del package
  # http://search.cpan.org/~romm/Config-Hosts-0.01/lib/Config/Hosts.pm
  return $esIP =~
    /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/ && ($1+0 | $2+0 | $3+0 | $4+0) < 0x100 ?
    1 : 0;
}
# Function validadorVacio
#
# comprueba si el campo esta vacio o si esta compuesto entero por espacios en blanco
#
#
sub esVacio($){
	my $estaVacio = shift;
	return $estaVacio =~/^\s*$/;
}
1;
#!/usr/bin/perl
use warnings;
use strict;

sub generarFormLogin {
print
	start_form,
	"Usuario ",textfield('usuario'),br,
	"Contraseña (ponerlo con asteriscos)",textfield('contra'),br,
	submit,
	end_form,
	hr,"\n";
}


1;
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

# Could not use $q->redirect, because it is must be delcared in header
# expects things like 'http://www.google.com' or 'script2.pl'
sub redirectUsingJavascript($){
	my $url_destiny = shift;

	print '
	<script language="javascript" type="text/javascript">
	window.location.href="'.$url_destiny.'";
	</script>';
}
1;
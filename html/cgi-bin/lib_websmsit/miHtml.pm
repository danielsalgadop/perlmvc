#!/usr/bin/perl
use warnings;
use strict;

sub generarFormLogin {
print
	start_form,
	"Usuario ",textfield('usuario'),br,
	"Contraseña (ponerlo con asteriscos)",password_field('contra'),br,
	submit,
	end_form,
	hr,"\n";
}

# Could not use $q->redirect, because it is must be delcared in header
# expects things like 'http://www.google.com' or 'script2.pl'
sub redirectUsingJavascript($){
	my $url_destiny = shift;
	print "recibido en redirectUsingJavascript url_destiny[".$url_destiny."]\n<br>";

	print "NO REDIRECCIONO por estar en DESARROLLO<br>";
	# print '
	# <script language="javascript" type="text/javascript">
	# window.location.href="'.$url_destiny.'";
	# </script>';
}

# TODO: que acepte un array
sub errores2DivErrores($){
	my $mensaje = shift;
	print '
	<script language="javascript" type="text/javascript">
	var x=document.getElementById("errores");
	x.innerHTML="'.$mensaje.'"
	</script>
	';
}

1;
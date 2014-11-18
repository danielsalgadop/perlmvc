#!/usr/bin/perl
use warnings;
use strict;

our $q;

# wrapper para CGI->start_html
sub miStartHtml{
	our $path_web_css;
	our $path_web_js;
	print $q->start_html(
	    -title      => 'WEB SMS IT',
	    -dtd        => "4.0",
	    -style      => {'src' => $path_web_css.'/css.css'},
	    -lang       =>'es-ES',
	    -script     =>[
	                    {
	                        -type => 'text/javascript',
	                        -src => $path_web_js.'/js.js',
	                    }
	    ]
	);
}


sub generarFormLogin {

	print $q->start_form(
		-method=>"POST",
		-action=>$q->self_url,  # auto-call
	);
	print
	"Usuario ",textfield('usuario'),br,
	"Contraseña (ponerlo con asteriscos)",password_field('contra'),br,
	submit,
	end_form,
	hr,"\n";
	print $q->p({class=>"prueba"},"toe toe");
}

# NOT IN USE:
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
	# NO se como pero habria que pasar esto a la parte html/js/
	my $mensaje = shift;
	print '
	<script language="javascript" type="text/javascript">
	var x=document.getElementById("errores");
	x.innerHTML="'.$mensaje.'"
	</script>
	';
}



# Receives a ref_hash of a logs_as_hash. A hash representation of a log
# hash{grupo} = (string) grupo a mostrar
# Returns a html table with logs
sub mostrarTablaLogs($){
	my $ref_logs_as_hash = shift;
	my %logs_as_hash = %{$ref_logs_as_hash};


	my @header; # saco el header como keys de la primera linea
	@header = reverse sort keys %{$logs_as_hash{1}};  # reverse sort so user and timestamp are first data

	print "<table>";
	print "<thead>";
	print "<tr>";
	foreach my $unheader(@header){
		print "<th>".$unheader."</th>";
	}
	print "</tr>";
	print "</thead>";
	print "<tbody>";
	foreach my $num_linea(sort keys %logs_as_hash){  # sort keys so every tr is the same numbre of line
		my %hash_datos_una_linea = %{$logs_as_hash{$num_linea}};
		my @data = reverse sort keys %hash_datos_una_linea; # reverse sort keys as in header
		print "<tr>";
		foreach my $un_key(@data){
			print "<td>".$hash_datos_una_linea{$un_key}."</td>";
		}
		print "</tr>";
		# print "num_linea ".$num_linea."<br>";
	}
	print "</tbody>";
	print "</table>";
	# print "<h1>mostrarTablaLogs</h1>";
}

1;
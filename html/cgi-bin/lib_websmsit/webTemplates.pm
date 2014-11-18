#!/usr/bin/perl
use warnings;
use strict;
use lib '.';   # the following pm are brothers of miEnrutador
use variables_globales;
use variables_paths;


#wt = web_templates

our $q;
our $path_web_rutas;
our %user;

#################################### Templates de paginas
sub wtHome(){
	# my $ref_params = shift;
	# my %params = %{$ref_params};
	&wtHeader();
	&colIzq;
	print '<div id="col_dere">';
	print $q->p("Bienvenido, ",b($user{nombre})," a la web donde enviar SMSxxxx"),p("perteneces a estos grupos: ");
	print "<ul>";
	foreach my $nombre_grupo(@{$user{grupos_q_pertenece}}){
		print $q->li($nombre_grupo);
	}
	print "</ul>";
	

	print '</div>';
	print $q->hr;
	# print $q->div(a({href=>$path_web_rutas."/unnivel"},"un solo nivel"),a({href=>$path_web_rutas."/dosniveles1/dosniveles2"},"dos niveles"));
	&wtFooter;
}

sub wtError(){
	&wtHeader();
	&colIzq;
	print $q->h1("No encontramos esta ruta");
	print Dumper(%ENV);
	&wtFooter;
}
sub wtLogs($){
	my $ref_params = shift;
	my %params = %{$ref_params};
	&wtHeader();
	&colIzq;
	print '<div id="col_dere">';
	print $q->h1("logs de Grupo ".$params{grupo});
	mostrarTablaLogs($params{logs_as_hash});
	print '</div>';
	# print Dumper(%params);
	&wtFooter;
}

sub wtSms(){
	&wtHeader();
	&colIzq;
	print $q->h1("sms");
	
	&wtFooter;	
}

sub wtDebug($){
	my $mensaje = shift;
	&wtHeader();
	&colIzq;
	print $q->h1($mensaje);
	
	&wtFooter;	
}
################################### COMUNES a todas
sub wtHeader(){
	print $q->h1("Envio SMS IT");
}
sub wtFooter(){
	print $q->h3("contacto Grupo PMS");
}

# va a tener la logica de poner en otro color la pagina en la que estamos
sub colIzq(){
	my $boton_seleccionado = ""; # futuro shift
	# TODO recorrer $user{groups} ( HE ESTADO PROBANDO, debo usar Template Toolkit, ya que no puedo recorrer @{user{grupos_q_pertenece}} y generar dimanicametne una li con $q)
	print $q->div({id=>"col_izq"},
		ul(
			li(
				"Ver LOGS",
				ul(
					li(
						a({href=>$path_web_rutas."/logs/grupo1"},"GRUPO1")
					)
				)
			),li(
				a({href=>$path_web_rutas."/sms"},"Enviar SMS")
			)
		),div("tus datos sonXXX (TODO)"));
	# print Dumper(%user);
	# foreach my $un_grupo(@{$user{grupos_q_pertenece}}){
	# 	print "<li>$un_grupo</li>";	
	# }
}

1;
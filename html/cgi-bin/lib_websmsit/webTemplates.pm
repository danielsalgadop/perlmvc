#!/usr/bin/perl
use warnings;
use strict;
use lib '.';   # the following pm are brothers of miEnrutador
use variables_globales;
use variables_paths;


#wt = web_templates

our $q;
our $path_web_rutas;

#################################### Templates de paginas
sub wtHome(){
	my $ref_params = shift;
	my %params = %{$ref_params};
	&wtHeader();
	&colIzq;
	print $q->div({id=>"col_dere"},"Bienvenido a la web donde enviar SMS");
	print $q->hr;
	print $q->div(a({href=>$path_web_rutas."/unnivel"},"un solo nivel"),a({href=>$path_web_rutas."/dosniveles1/dosniveles2"},"dos niveles"));
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
	if($params{grupo}){
		print $q->h1("logs de Grupo ".$params{grupo});
	}
	else{
		print $q->h1("logs TODOS LOS  GrupoS");
	}
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
	print $q->div({id=>"col_izq"},ul(li(a({href=>$path_web_rutas."/logs"},"Ver LOGS")),li(a({href=>$path_web_rutas."/sms"},"Enviar SMS"))));
}

1;
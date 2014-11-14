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
sub wtLogs(){
	&wtHeader();
	&colIzq;
	print $q->h1("logs");
	&wtFooter;
}

sub wtSms(){
	&wtHeader();
	&colIzq;
	print $q->h1("sms");
	
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
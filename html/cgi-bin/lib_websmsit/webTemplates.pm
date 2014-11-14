#!/usr/bin/perl
use warnings;
use strict;
use lib '.';   # the following pm are brothers of miEnrutador
use variables_globales;
use variables_paths;


#wt = web_templates

our $q;
our $path_web_rutas;
sub wtHome(){
	print $q->h1("ESTAS LOGEADO");
	print $q->div({id=>"col_izq"},ul(li(a({href=>"http://crete.org/"},"Ver LOGS")),li(a({href=>"http://crete.org/"},"Enviar SMS"))));
	print $q->div({id=>"col_dere"},"Bienvenido a la web donde enviar SMS");
	print $q->hr;
	print $q->div(a({href=>$path_web_rutas."/unnivel"},"un solo nivel"),a({href=>$path_web_rutas."/dosniveles1/dosniveles2"},"dos niveles"));
}

sub wtDefault(){
	print $q->h1("DEFAULT");

}
1;
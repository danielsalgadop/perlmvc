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

	if($params{mensaje_error}){   # ha ocurrido error (no tiene permisos)
		print $q->p($params{mensaje_error});
	}
	else{
		if($params{logs_as_hash} == 0){ # logs estaban vacios
			print $q->p("No existen logs, es un grupo muy nuevo");
		}
		else{ # tiene permiso y log esta relleno
			mostrarTablaLogs($params{logs_as_hash});
		}
	}
	print '</div>';  # close div id="col_dere"
	# print Dumper(%params);
	&wtFooter;
}

sub wtSms($){
	my $ref_params = shift;
	my %params = %{$ref_params};
	# my %templates_sms = %{$params{templates_sms}};


	&wtHeader();
	print $q->h1("sms");
	&colIzq;

	print '<div id="col_dere">';
	print '<form name="my_form" method="post">';
	print $params{form_text_area_select_and_template_json};
	print '</form>';
	print "</div>";
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
	print $q->div({id=>"errores"},"");
}
sub wtFooter(){
	print $q->h3("contacto Grupo PMS");
}

# va a tener la logica de poner en otro color la pagina en la que estamos
# he intentado usar $q exclusivamente, pero no se como cambiar dinamicamente el ul li interno (los grupos)
# quizas pueda usar template toolkit
sub colIzq(){
	my $boton_seleccionado = ""; # futuro shift
	# my @r_gruposAlosQuePerteneceUser = ("grupo1", "grupo3"); #esto vendra de gruposAlosQuePerteneceUser
	my @r_gruposAlosQuePerteneceUser = gruposAlosQuePerteneceUser();



	print '<div id="col_izq">';
	print "<ul>";
	print "<li>";
		print "VER LOGS";
		print "<ul>";
		foreach my $un_grupo(@{$user{grupos_q_pertenece}}){
			print '<li><a href="'.$path_web_rutas."/logs/".$un_grupo.'">'.$un_grupo.'</a></li>';
		}
		print "</ul>";
	print "</li>";
	print "<li>";
	print '<a href="'.$path_web_rutas.'/sms">Enivar SMS</a>';
	print "</li>";
	print "<div>tus datos son XXXX (TODO)</div>";
	print "</div>";   # cierro div id="col_izq"

	# TODO recorrer $user{groups} ( HE ESTADO PROBANDO, debo usar Template Toolkit, ya que no puedo recorrer @{user{grupos_q_pertenece}} y generar dimanicametne una li con $q)
	# print $q->div({id=>"col_izq"},
	# 	ul(
	# 		li(
	# 			"Ver LOGS",
	# 			ul(
	# 				li(
	# 					a({href=>$path_web_rutas."/logs/grupo1"},"GRUPO1")
	# 				)
	# 			)
	# 		),li(
	# 			a({href=>$path_web_rutas."/sms"},"Enviar SMS")
	# 		)
	# 	),div("tus datos sonXXX (TODO)"));
	# print Dumper(%user);

}

1;
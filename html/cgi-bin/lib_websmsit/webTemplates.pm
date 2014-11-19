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
	my %templates_sms = %{$params{templates_sms}};


	&wtHeader();
	&colIzq;

	
	# print "<script>";
	# print 'var templates_sms2={
	# 1:"1111 sasljfs XXX ldkfaj YYY ldkfajs XXXXXXXXXXXXX",
	# 2:"222sasljfs ldkfaj ldkfajs XXXXXXXXXXXXX",
	# 3:"333 sasljfs ldkfaj ldkfajs XXXXXXXXXXXXX",
	# debug:"template_sms2 template_sms2 template_sms2 template_sms2 template_sms2 template_sms2 template_sms2 template_sms2 template_sms2 template_sms2 template_sms2 template_sms2 asdf3 sasljfs ldkfaj ldkfajs ",

	# }';
	# print "</script>";

	# I need to construct 2 things from %templates_sms.
	# 1 - the javascritp json template_sms
	# 2 - the html select and options
	# these 3 arrays (@values_for_select_and_keys_for_js_json, @template_for_select_and_js_json, @nombre_for_select) will always have the same number of elements
	my @values_for_select_and_keys_for_js_json;
	my @template_for_select_and_js_json;
	my @nombre_for_select;

	foreach my $numero_de_linea (sort keys %templates_sms){ # el value_es_el_numero_de_linea
		push(@values_for_select_and_keys_for_js_json,$numero_de_linea);
		my %nombre_y_template = %{$templates_sms{$numero_de_linea}};

		# print Dumper(%nombre_y_template);

		foreach my $nombre(keys %nombre_y_template){
			push(@nombre_for_select,$nombre);
			push(@template_for_select_and_js_json,$nombre_y_template{$nombre});
		}
	}
	# cargar templates_sms to a js variable
	# construct javascript json template_sms
	print "<script>";
	print 'var templates_sms={';	
	my $cont=0;
	my $constructed_values_js; # this is needed for removing last comma # IE BUG
	foreach my $keys(@values_for_select_and_keys_for_js_json){
		$constructed_values_js .= $keys.':"'.$template_for_select_and_js_json[$cont].'",';
		# $constructed_values_js .= $keys.':"que buena estasaaaassa",';
		$cont++;
	}
	chop($constructed_values_js);  # remove last comma
	print $constructed_values_js;
	print '}';
	print "</script>";

	# construct html select template_select


	print '<div id="col_dere">';
	print $q->h1("sms");
	print '<form name="my_form" method="post">
			<select id="template_select">';
	$cont=0;
	foreach my $nombre(@nombre_for_select){
		print '<option value="'.$values_for_select_and_keys_for_js_json[$cont].'">'.$nombre.'</option>';
		$cont++;
	}
	print 	'</select>
		<textarea id="textarea" onKeyPress="check_length_textarea(this.form)"; onKeyDown="check_length_textarea(this.form)"; name="my_text" rows=4 cols=30>
		</textarea>
		<br>
		<input size=1 value=50 name=text_num> Characters Left
	</form>
	';
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
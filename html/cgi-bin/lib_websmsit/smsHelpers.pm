#!/usr/bin/perl
use warnings;
use strict;
use lib'.';
our $q;

# Function construirFormTextAreaYSelectAndTemplateJsonFromHash
# Recieves - (ref_hash) de los templates_sms.json
# Returns  - (string) $return. Contains form_textarea_y_select_and_template_json_to_return
# This functions constructs most of the content of the route sms
# 
sub construirFormTextAreaYSelectAndTemplateJsonFromHash($){
	my $ref_templates_sms = shift;
	my %templates_sms = %{$ref_templates_sms};

	my $return;
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

		foreach my $nombre(keys %nombre_y_template){
			push(@nombre_for_select,$nombre);
			push(@template_for_select_and_js_json,$nombre_y_template{$nombre});
		}
	}
	# cargar templates_sms to a js variable
	# construct javascript json template_sms
	$return.= "<script>";
	$return .= 'var templates_sms={';	
	my $cont=0;
	my $constructed_values_js; # this is needed for removing last comma # IE BUG
	foreach my $keys(@values_for_select_and_keys_for_js_json){
		$constructed_values_js .= $keys.':"'.$template_for_select_and_js_json[$cont].'",';
		$cont++;
	}
	chop($constructed_values_js);  # remove last comma # IE BUG
	$return .= $constructed_values_js;
	$return .= '}';
	$return .= "</script>";

	# construct html select template_select
	
	$return .='<select id="template_select">';
	$cont=0;
	foreach my $nombre(@nombre_for_select){
		$return .= '<option value="'.$values_for_select_and_keys_for_js_json[$cont].'">'.$nombre.'</option>';
		$cont++;
	}
	$return .= 	'</select>
				<textarea id="textarea" onKeyPress="check_length_textarea(this.form)"; onKeyDown="check_length_textarea(this.form)"; name="my_text" rows=4 cols=30 ></textarea>
		<input size=1 value=50 name=text_num> Characters Left';

	return($return);
}
1;
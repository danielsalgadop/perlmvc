#!/usr/bin/perl
use warnings FATAL=>all;
use strict;

# content of html's <head> tag
sub headHtmlTag{
	print $Globals::q->start_html(
		-title=> $Globals::titulo_web,
		-encoding=> "utf-8",
		-dtd=> "4.0",
		-head=>[
			meta({
				-http_equiv => 'X-UA-Compatible',
				-content=>'IE=9; IE=8; IE=7'
			}),
			meta({
				-http_equiv => 'X-UA-Compatible',
				-content=>'IE=edge'
			})
		],
		-style=>
		{
			'src' => 
				[
					$Paths::css.'/css.css',
					$Paths::css.'/bootstrap.min.css',
					$Paths::css.'/jquery.dataTables.min.css',
				]
		},
		-lang=>'es-ES',
		-script=>
		[
			{
				-type => 'text/javascript',
				-src => $Paths::js.'/jquery.1.11.2.min.js',
			},
			{
				-type => 'text/javascript',
				-src => $Paths::js.'/bootstrap.min.js',
			},
			{
				-type => 'text/javascript',
				-src => $Paths::js.'/jquery.dataTables.js',
			},
			{
				-type => 'text/javascript',
				-src => $Paths::js.'/js.js',
			},
		]
	);
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

# Collection of buttons
# navigation of miHeader
sub miNavigation(){
	################### Boton 'INICIO'
	print $Globals::q->a
	(
		{
			href=>$Paths::web,
			class=>"btn btn-default  pull-left"
		},
		"INICIO"
	);	
	################### Boton 'static_page'
	print $Globals::q->a
	(
		{
			href=>$Paths::web."/static_page",
			class=>"btn btn-default  pull-left"
		},
		"STATIC PAGE"
	);
	################### Boton 'datatable'
	print $Globals::q->a
	(
		{
			href=>$Paths::web."/datatable",
			class=>"btn btn-default  pull-left"
		},
		"DATATABLE"
	);
	################### Boton 'read value form url'
	print $Globals::q->a
	(
		{
			href=>$Paths::web."/read_value_from_url/",
			class=>"btn btn-default  pull-left"
		},
		"READ VALUE FROM URL"
	);
	################### Boton 'USER DEFINED SUBS'
	print $Globals::q->a
	(
		{
			href=>$Paths::web."/user_defined_subs",
			class=>"btn btn-default  pull-left"
		},
		"USER DEFINED SUBS"
	);
	################### Boton 'TEMPLATES'
	print $Globals::q->a
	(
		{
			href=>$Paths::web."/templates",
			class=>"btn btn-default  pull-left"
		},
		"TEMPLATES"
	);
	################### Boton 'MODEL_CHANGER'
	print $Globals::q->a
	(
		{
			href=>$Paths::web."/model_changer",
			class=>"btn btn-default  pull-left"
		},
		"MODEL CHANGER (TODO)"
	);
}


###################################
sub wtHeader(){
	print $Globals::q->header();
	headHtmlTag();
	print '<div class="container-fluid">';
	print '<div class="row">';
	print $Globals::q->div({id=>"header"},
		div
		(
			{
				style=>"padding-right:20px;float:right"
			},
			# "Bienvenido [".getterSession("alias")."]".
			"Bienvenido ".
			a
			(
				{
					href=>$Paths::web."/desconectar"
				},
				# "desconectar".imgPrinter("disconnect")
				"desconectar"
			)
		),
		h1($Globals::titulo_web),
	);
	miNavigation();
	print '</div>';
	print $Globals::q->hr;
	print $Globals::q->div({id=>"errores"},"");
}
sub wtFooter(){
	# print $Globals::q->div({id=>"footer"},h3("contacto Grupo PMS"));
	print "</div>";  #close container-fluid
	print $Globals::q->end_html;
	exit; # <<< needed to avoid 2 pages being shown. For example When an error ocurred inside a web Template and a cError=>wtError is called.
}


# returns (string) of $Globals::q, <img src="parameter">
# all images must be png and be in $path_web_img
sub imgPrinter($){
	our $path_web_img;
	my $image_wanted;
	my $return = $Globals::q->img({
		src => $path_web_img.'/'.(shift).'.png',
	});
	return($return);
}


# Function generarFormLogin
# used in login.pl
sub generarFormLogin() {
	print $Globals::q->header();  # cualquier print (aunque sea header imposibilita el redirect)
	
	&headHtmlTag();
	my $error = shift;

	print ' <div class="container"><div class="row"><div class="col-md-offset-5 col-md-3"><div class="form-login">';
	print $Globals::q->h4($Globals::titulo_web);
	print $Globals::q->span({class=>"text-danger"},"USUARIO/CONTRASE&Ntilde;A INCORRECTOS") if $error;
	# Forms
	print $Globals::q->start_form(
		-name     => 'main_form',
		-method   => 'POST',
		# -onsubmit => 'return javascript:validation_function()',
		# -action   => $Globals::q->self_url,                               # Defaults to
			 # the current program
	);
	print "usuario";
	print $Globals::q->textfield(
		-name      		=> 'usuario',
		# -value    	=> 'user1',
		-class 			=> "form-control input-sm chat-input",
		-placeholder 	=> "usuario",
		-size      		=> 20,
		-maxlength 		=> 30,
	);
	print $Globals::q->br;
	print "contrase&ntilde;a";
	print $Globals::q->password_field(
		-name      => 'passw',
		# -value     => '1',
		-class 			=> "form-control input-sm chat-input",
		-placeholder 	=> "contrasena",
		-size      => 20,
		-maxlength => 30,
	);
	print $Globals::q->br . $Globals::q->submit({class=>"btn btn-primary btn-md", value=>'Logearme'});
	print $Globals::q->end_form;
	print '</div></div></div></div>'; # cierro class="contaniner" y class="row" class="col-md-offset-5 col-md-3"y class="form-login"
	print $Globals::q->end_html;
	exit;
}
1;
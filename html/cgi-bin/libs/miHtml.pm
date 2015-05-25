#!/usr/bin/perl
use warnings FATAL=>all;
use strict;

our $q;

# wrapper para CGI->start_html
our $titulo_web;
our $path_web_rutas;


sub headHtmlTag{
	our $path_web_css;
	our $path_web_js;
	print $q->start_html(
	    -title      => $titulo_web,
	    -encoding => "utf-8",
	    -dtd        => "4.0",
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

	    -style      =>
	    {
	    	'src' => 
	    		[
	    			$path_web_css.'/css.css',
	    			$path_web_css.'/bootstrap.min.css',
	    			$path_web_css.'/jquery.dataTables.min.css',
	    		]
	    },
	    -lang       =>'es-ES',
	    -script     =>
	    [
            {
                -type => 'text/javascript',
                -src => $path_web_js.'/jquery.1.11.2.min.js',
            },
            {
                -type => 'text/javascript',
                -src => $path_web_js.'/bootstrap.min.js',
            },
            {
                -type => 'text/javascript',
                -src => $path_web_js.'/jquery.dataTables.js',
            },
            {
                -type => 'text/javascript',
                -src => $path_web_js.'/js.js',
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

# navigation of miHeader
sub miNavigation(){
	################### Boton 'INICIO'
	print $q->a
	(
		{
			href=>$path_web_rutas,
			class=>"btn btn-default  pull-left"
		},
		"INICIO"
	);	
	################### Boton 'static_page'
	print $q->a
	(
		{
			href=>$path_web_rutas."/static_page",
			class=>"btn btn-default  pull-left"
		},
		"STATIC PAGE"
	);
	################### Boton 'datatable'
	print $q->a
	(
		{
			href=>$path_web_rutas."/datatable",
			class=>"btn btn-default  pull-left"
		},
		"DATATABLE"
	);
	################### Boton 'read value form url'
	print $q->a
	(
		{
			href=>$path_web_rutas."/read_value_from_url/",
			class=>"btn btn-default  pull-left"
		},
		"READ VALUE FROM URL"
	);
	################### Boton 'MODEL_CHANGER'
	print $q->a
	(
		{
			href=>$path_web_rutas."/model_changer",
			class=>"btn btn-default  pull-left"
		},
		"MODEL CHANGER (TODO)"
	);
}


###################################
sub wtHeader(){
	print $q->header();
	headHtmlTag();
	print '<div class="container-fluid">';
	print '<div class="row">';
	print $q->h1("PERLMVC");
	miNavigation();
	print '</div>';
	print $q->hr;
	print $q->div({id=>"errores"},"");
}
sub wtFooter(){
	# print $q->div({id=>"footer"},h3("contacto Grupo PMS"));
	print "</div>";  #close container-fluid
	print $q->end_html;
	exit; # <<< needed to avoid 2 pages being shown. When an error ocurred inside a web Template and a cError=>wtError is called. 
}


# returns (string) of $q, <img src="parameter">
# all images must be png and be in $path_web_img
sub imgPrinter($){
	our $path_web_img;
	my $image_wanted;
	my $return = $q->img({
		src => $path_web_img.'/'.(shift).'.png',
	});
	return($return);
}


# Function generarFormLogin
# used in login.pl
sub generarFormLogin() {
	print $q->header();  # cualquier print (aunque sea header imposibilita el redirect)
	
	&headHtmlTag();
    my $error = shift;
    our  $header_login_index;
    print ' <div class="container"><div class="row"><div class="col-md-offset-5 col-md-3"><div class="form-login">';
    print $q->h4($header_login_index);
    print $q->span({class=>"text-danger"},"USUARIO/CONTRASE&Ntilde;A INCORRECTOS") if $error;
    # Forms
    print $q->start_form(
        -name     => 'main_form',
        -method   => 'POST',
        # -onsubmit => 'return javascript:validation_function()',
        -action   => $q->self_url,                               # Defaults to
             # the current program
    );
    print "usuario";
    print $q->textfield(
        -name      		=> 'usuario',
        # -value    	=> 'user1',
        -class 			=> "form-control input-sm chat-input",
        -placeholder 	=> "usuario",
        -size      		=> 20,
        -maxlength 		=> 30,
    );
    print $q->br;
    print "contrase&ntilde;a";
    print $q->password_field(
        -name      => 'passw',
        # -value     => '1',
        -class 			=> "form-control input-sm chat-input",
        -placeholder 	=> "contrasena",
        -size      => 20,
        -maxlength => 30,
    );
    print $q->br . $q->submit({class=>"btn btn-primary btn-md", value=>'Logearme'});
    print $q->end_form;
    print '</div></div></div></div>'; # cierro class="contaniner" y class="row" class="col-md-offset-5 col-md-3"y class="form-login"
    # miSyslog( Dumper(%params) );
    print $q->end_html;
}
1;
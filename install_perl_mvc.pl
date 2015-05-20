#!/user/bin/perl
use warnings;
use strict;
exit;
#### NOT READY TO BE USED



##################################
# it is a portable script for making the esential scaffold for perl_mvc. 
##################################
#	deploy/
#	|
#	docs/
#	|	svgs/
#	|
#	utils/
#	html/
#		|
#		js/
#		|	js.js (empty)
#		|	jquery_XXX_min.js
#		|
#		cgi-bin/
#		|	index.pl
#		|
#		|	libs_proyects_name/
#		|		miLogin.pm
#		|		miPermisos.pm
#		|		httpHelpers.pm
#		|		miEnrutador.pm
#		|		variables_globales.pm
#		|		variables_paths.pm
#		|
#		|	tests/
#		|
#		|	models/
#		|
#		css/
#		|	css.css (empty)
#		|	bootstrap_XXX.css

# Expects and Cleans the name of proyect
&usage if(!$ARGV[0] or $ARGV[0]=~/-h/);
my $proyects_name = &cleanNameProyect($ARGV[0]);
&createEmptyScaffold();
###########################################
# Creates Directories and empty Files
###########################################

sub createEmptyScaffold(){
	# makes the proyect base dir
	mkdir($proyects_name);
	# makes First level of Dirs
	foreach my $dir (qw(html utils docs)){
		mkdir($proyects_name."/".$dir);
	}

	#############################
	# makes Second level of Dirs 
	#############################
	#(html/)
	foreach my $dir (qw(js css cgi-bin)){
		mkdir($proyects_name."/html/".$dir);
	}
	#(docs)
	foreach my $dir (qw(svgs)){
		mkdir($proyects_name."/docs/".$dir);
	}

	#############################
	# makes FILES included in Second level
	#############################
	#(html/js)
	foreach my $dir (qw(js.js jquery_XXX_min.js)){
		open(TOE,">".$proyects_name."/html/js/".$dir); # open as equivalent of touch
		close TOE;
	}
	#(css/*)
	foreach my $dir (qw(css.css bootstrap_XXX.css)){
		open(TOE,">".$proyects_name."/html/css/".$dir); # open as equivalent of touch
		close TOE;
	}
	#(cgi-bin/*)
	foreach my $dir (qw(index.pl login.pl)){
		open (TOE,">".$proyects_name."/html/cgi-bin/".$dir);
		chmod 0755, $proyects_name."/html/cgi-bin/".$dir;   # makes them executable
		close TOE;
	}

	#############################
	# makes Third level of Dirs 
	#############################
	#(html/cgi-bin/libs_$proyects_name)
	foreach my $dir (("libs_".$proyects_name , "tests", "models")){
		mkdir($proyects_name."/html/cgi-bin/".$dir);
	}

	#############################
	# makes Fourth level of FILES
	#############################	
	#(html/cgi-bin/libs_$proyects_name/*)	 
	foreach my $dir (qw(miLogin.pm miPermisos.pm httpHelpers.pm miEnrutador.pm variables_globales.pm variables_paths.pm)){
		open (TOE ">".$proyects_name."/html/cgi-bin/libs_".$proyects_name."/".$dir);
		chmod 0755, $proyects_name."/html/cgi-bin/".$dir;   # makes them executable
		close TOE;
	}
}
###################################
# Function: usage
# Description:
# Usage is called when theres is no ARGV[0] or is called with -h*
###################################
sub usage(){
print "=========================
- To see these help type $0 -h
- This script expects the name of proyect
- The name must be numbers letters or '_', spaces will be translated to _;
=========================";
	exit;
}

sub cleanNameProyect($){
	my $proyects_name = shift;
	$proyects_name =~ tr/ /_/; # spaces changed to _
	$proyects_name =~ s/[^_a-zA-z0-9]//g; # remove strange names
	&usage if ($proyects_name =~/^\s*$/);
	return $proyects_name;
}

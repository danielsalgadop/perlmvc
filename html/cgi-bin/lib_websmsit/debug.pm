#!/usr/bin/perl
use warnings;
use strict;

# Functions used in debuggin



# Function print2File
# when you need to print and you cant use web explorer
# Receives: hash ref
#           hash{ref} = (scalar|array|hash)
#           hash{titulo} = (scalar) 
sub print2File($){
	my $hash_ref = shift;
	open ("DEB", ">>/tmp/debug_websmsit");
	print DEB "mala llamada [1] a print2File\n" unless $hash_ref;

	my %options_hash = %{$hash_ref};

	my $titulo = ($options_hash{titulo}) ? $options_hash{titulo} : "titulo_generico";

	print DEB "\n===PRINCIPIO de " . $titulo . "=====\n";
	if($options_hash{ref}){


	    if (ref($options_hash{ref}) eq "SCALAR") {
	        my $var = ${$options_hash{ref}};
	        print DEB Dumper($var);
	    }
	    elsif (ref($options_hash{ref}) eq "ARRAY") {
	        my @arr = @{$options_hash{ref}};
	        print DEB Dumper(@arr);
	    }
	    elsif (ref($options_hash{ref}) eq "HASH") {
	        my %has = %{$options_hash{ref}};
	        print DEB Dumper(%has);
	    }
	}else{
		print DEB "mala llamada [2] a print2File\n";
	}
	print DEB "\n==================END de " . $titulo . "=====\n\n\n";
	close DEB;
}

##########################################################################
# Function: miDump2                                                      #
# it does not use parameter $tipo. It uses ref() to detect variable type #
# Usada en desarrollo, sirve para formatear un poco mejor los Dumper,    #
#  y que sean visibles en el output del desarrollo                       #
# Parmeters:                                                             #
#   $ref_var - referencia a la variable, puede ser hash, array o string  #
#   $titulo - se usa en el output para                                   #
##########################################################################
#sub miDump2($$)
#{
 #   my $ref_var = shift;
  #  my $titulo  = shift;
   # $titulo = ($titulo) ? $titulo : "titulo_generico";
 #   print "\n\n\n===PRINCIPIO de " . $titulo . "=====\n";
#
 #   if (ref($ref_var) eq "SCALAR") {
  #      my $var = $$ref_var;
   #     print Dumper($var);
    #}
#    elsif (ref($ref_var) eq "ARRAY") {
#        my @arr = @{$ref_var};
        #print Dumper(@arr);
#    }
#    elsif (ref($ref_var) eq "HASH") {
#        my %has = %{$ref_var};
#        print Dumper(%has);
#    }
#    print "==FIN_DE " . $titulo . "===\n\n\n";
#}

1;
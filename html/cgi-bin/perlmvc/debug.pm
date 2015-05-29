#!/usr/bin/perl
use warnings FATAL=>all;
use strict;

# Functions used in debuggin


# Function debug
# when you need to print and you cant just print it in screen
# Receives: hash ref
#           hash{ref} = (scalar|array|hash)
#           hash{titulo} = (scalar)  (optinal)
# Example of use debug2File({ref=>\$ref,titulo=>"el titulo chulo"});
sub debug2File($){
	my $hash_ref = shift;
	open (DEB, ">>".$Paths::debug_app);
	print DEB "mala llamada [1] a debug\n" unless $hash_ref;

	my %options_hash = %{$hash_ref};

	my $titulo = ($options_hash{titulo}) ? $options_hash{titulo} : "titulo_generico";

	print DEB "\n===PRINCIPIO " . $titulo . "=====\n";
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
		print DEB "mala llamada [2] a debug, probablemente falte mandar una referencia\n";
	}
	print DEB "===END =========" . $titulo . "=====\n";
	close DEB;
}
1;
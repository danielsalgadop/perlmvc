#!/usr/bin/perl
use strict;
use warnings;

####################################################################
# Function: estaAtenticado
# Receives:
#		$user (string) - user written in login form
#		$contra (string) - password written in login form
# 		$ref_hash_users (hash ref) - hash of users.json
#
# Returns:
#		1 - if user/password match values of $ref_hash_users
#		0 - if user/password DONT matches values of $ref_hash_users
####################################################################
sub estaAtenticado($$$){
	my $user 	= shift;
	my $contra 	= shift;
	my $ref_hash_users = shift;
	my %hash_users = %{$ref_hash_users};

	# SED para evitar tener que escribir un usuario/password verdaderos
	return(1);  # <<<<<<<<<<<<<<<<<<<<<<<<<<<< OJO


	print "RECIBIDO en estaAtenticado user=".$user." contra=".$contra."\n<br>";
	# print Dumper(%hash_users);

	# Recorrer %hash_users
	# ver si existe el user
	# ver si coincide el contra
	foreach my $num_linea(keys %hash_users){ # ojo $num_linea es HUMANA (empieza en 1)
		print "<br>num_linea ".$num_linea."<br>";
		my %hash_datos_un_user = %{$hash_users{$num_linea}};
		print Dumper(%hash_datos_un_user);
		if($hash_datos_un_user{$user}){ # the user exists
			if($contra eq $hash_datos_un_user{$user}){ # the password coincide
				return(1);
			}
		}
	}
	return(0);
}
1;
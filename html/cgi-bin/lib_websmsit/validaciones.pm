my $validaciones="toe";


sub esUsuarioOK($){
	my $usuario = shift;
	$usuario = trimSpaces($usuario);
}

sub esContrasenyaOK($){
	return(1);
}

sub trimSpaces($){
	my $str_to_trim = shift;
	$str =~ s/^\s+|\s+$//g;
	return($str);
}

1;
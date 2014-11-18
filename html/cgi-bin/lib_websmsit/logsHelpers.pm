#!/usr/bin/perl
use warnings;
use strict;
use lib'.';
use variables_paths;

# Function logs2Hash1Grupo
# Receives:
#	nombre_grupo (string)
# Returns:
# 	%hash{status} = "OK|ERROR"
# if OK returns $return{hash} = (ref_to_hash) %logs_grupo{numero de linea} = hash
# if ERROR returns $return{mensaje} = (string) "desscription of error"
# if file doest not exist (no logs) $return{hash} = 0
sub logs2Hash1Grupo($){
	my $nombre_grupo = shift;
	my $filename_log = $nombre_grupo.".log";
	our $path_aboluto_logs;  # variables_paths
	$filename_log = $path_aboluto_logs."/".$filename_log;
	# print "Inside logs2Hash1Grupo \$filename_log [$filename_log]\n";

	my %return;
	$return{status} = "OK";

	unless(-s $filename_log){
		$return{hash} = 0;    # file does not exist or has 0 size
		return(%return);
	}
	use miJSON qw(fileJSON2HashAgregado);
	my %r_fileJSON2HashAgregado = fileJSON2HashAgregado($filename_log);
	if($r_fileJSON2HashAgregado{status} eq "OK"){
		$return{hash} = $r_fileJSON2HashAgregado{hash};
	}
	else{
		# Since fileJSON2HashAgregado has no ERROR (for now) I cant have more details
		$return{status} = "ERROR";
	}
	return(%return);
}
1;
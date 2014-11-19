#!/usr/bin/perl
use strict;
use warnings;
use lib './lib_websmsit';
use miJSON qw(CodificaJson);
use Data::Dumper;
# Script that talks with sms server
# Expects 2 Arguments
# - emails separated by commas   "email1@bt.com,email2@bt.com,email3@tb.com"
# - mensaje "error ocurrido en host ARVT00V0 afectando a region de Murcia"
# perl sms_sender.pl email1@bt.com,email2@bt.com,email3@tb.com "error ocurrido en host ARVT00V0 afectando a region de Murcia"


# control Arguments received
if(!$ARGV[1]){
	&exitWhithJsonResponse({status=>"ERROR",mensaje=>"$0 hasnt received needed arguments @ARGV"});
}
&smsSender({emails=>$ARGV[0],mensaje=>$ARGV[1]});



sub smsSender($){
	my $ref_params 			= shift;
	my %params 				= %{$ref_params};
	my %r_conect2SmsServer 	= &conect2SmsServer();
	&exitWhithJsonResponse({status=>$r_conect2SmsServer{status},mensaje=>$r_conect2SmsServer{error_mensaje}}) if $r_conect2SmsServer{status} ne "OK";

	my %r_effectiveSmsSender = &effectiveSmsSender($r_conect2SmsServer{connection});
	exitWhithJsonResponse(\%r_effectiveSmsSender);
}



sub effectiveSmsSender($){
	my $conecction = shift;
	my %return;

	# poner aqui logica de envio de sms

	# SIMULATIONS sms enviados OK
	$return{status} 	= "OK";
	$return{mensaje} 	= "SMS enviado ok";

	# SIMULATIONS wrongly sent
	# $return{status} 	= "ERROR";
	# $return{mensaje} 	= "Something wrong with sms server";

	return(%return);
}



sub exitWhithJsonResponse($){
	my $ref_params 	= shift;
	my %params 		= %{$ref_params};

	my %to_print;    # these is what de caller script will receive
	$to_print{status} 		= ($params{status})?$params{status}:"ERROR";
	$to_print{mensaje} 		= ($params{mensaje})?$params{mensaje}:"$0::exitWhithJsonResponse needs mensaje";
	
	print CodificaJson(\%to_print);
	exit;
}

# Function conect2SmsServer
# Returns hash
# 		hash{status} = OK if connection was esblished
#					- in OK -> hash{connection} = (obj) NET::Telnet conecction object
# 		hash{status} = ERROR if error ocurred
#					- in ERROR -> hash{error_mensaje} = description of error    # OJO error_mensaje
sub conect2SmsServer(){
	my %return;
	my $user 		= "usetForSmsServer";      # DUDA ¿put these in variables_globales?
	my $password 	= "passwordForSmsServer";
	# use Net::Telnet

	# SIMULATIONS connection ok
	$return{status} 	= "OK";
	$return{connection} = "mock_net_telnet_connection_obj";

	# ERROR in login
	# $return{status} 	= "ERROR";
	# $return{error_mensaje} = "login/fail";

	return(%return);
}
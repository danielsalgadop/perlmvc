#!/usr/bin/perl
use warnings;
use strict;
use lib '.';
use webTemplates;
# Es llamado desde miEnrutador
# hace los calculos necesarios y llama a los templates

our $q;
sub cHome{
	my $user = $q->session("user_name");
	print "USER ".$user."\n<br>";
	&wtHome();
}


sub cError(){
	&wtError();
}

sub cLogs($){
	my $grupo = shift;
	&wtLogs($grupo);
}

sub cSms(){
	&wtSms();
}

sub cDebug($){
	&wtDebug();
}
1;
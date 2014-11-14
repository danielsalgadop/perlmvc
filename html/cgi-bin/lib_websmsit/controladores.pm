#!/usr/bin/perl
use warnings;
use strict;
use lib '.';
use webTemplates;
# Es llamado desde miEnrutador
# hace los calculos necesarios y llama a los templates

sub cHome{
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
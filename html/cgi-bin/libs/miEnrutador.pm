#!/usr/bin/perl
use warnings FATAL=>all;  # use in development
use strict;
# Analiza la URI
# llama al controlador correspondiente
sub enrutador{

	# Analizar REQUEST_URI  # TODO try to use $ENV{PATH_INFO}

	# debug2File({ref=>\$path_web_rutas,titulo=>"path_web_rutas debe ser igual a [".$server_ip.$ENV{REQUEST_URI}."]"});

	if($ENV{REQUEST_URI} =~ /index.pl$/) # estamos en landing tras login.pl
	{
		wtHome(); # home
	}
 	elsif($ENV{REQUEST_URI} =~ m!desconectar$!){
        # esta url no tiene ni controlador ni template
        # user wants to desconectar
        disconnectSession();
    }
	elsif($ENV{REQUEST_URI} =~ /static_page$/)
	{
		wtStaticPage();
	}
	elsif($ENV{REQUEST_URI} =~ /datatable$/)
	{
		cDataTable();
	}
	elsif($ENV{REQUEST_URI} =~ m!read_value_from_url[/]*(.*)!)
	{
		wtReadValueFromUrl($1);
		wtReadValueFromUrl($1);
	}
	else
	{
		wtError();
	}
}
1;
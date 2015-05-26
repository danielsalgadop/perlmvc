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
        # go to home (that is going to redirect to login)
        our $q;
        our $path_web_cgi;
        our $name_cookie_that_stores_session_id;
        # create a cookie with negative time to expire, to delete it

        my $cookie = $q->cookie(-name=>$name_cookie_that_stores_session_id,-value=>"going_to_die",-expires=>'-1h');
        print $q->redirect(-uri=>$path_web_cgi.'/login.pl',-cookie=>$cookie);
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
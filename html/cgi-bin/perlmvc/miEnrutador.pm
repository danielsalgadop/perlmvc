#!/usr/bin/perl
use warnings FATAL=>all;
use strict;

# Analyzes URI and usually calls controller or template
sub enrutador{

	# TODO study the use of $ENV{PATH_INFO}

	if($ENV{REQUEST_URI} =~ /index.pl$/) # estamos en landing tras login.pl
	{
		wtHome(); # home
	}
 	elsif($ENV{REQUEST_URI} =~ m!desconectar$!){
        # route without controller or template
        # user wants to desconectar
        disconnectSession();
    }
	elsif($ENV{REQUEST_URI} =~ /static_page$/)
	{
		# normally when no calculation is needed you call template
		wtStaticPage();
	}
	elsif($ENV{REQUEST_URI} =~ /datatable$/)
	{
		# because you need to read models to build dataTable you call a controller (that will call template) 
		cDataTable();
	}
	elsif($ENV{REQUEST_URI} =~ m!read_value_from_url[/]*(.*)!)
	{
		wtReadValueFromUrl($1);
	}
	elsif($ENV{REQUEST_URI} =~ m!user_defined_subs$!)
	{
		cUserDefinedLib();
	}
	elsif($ENV{REQUEST_URI} =~ m!templates$!)
	{
		wtTemplates();
	}
	else
	{
		# did not match any defined route => error
		wtError("404 - Page not found");
	}
}
1;
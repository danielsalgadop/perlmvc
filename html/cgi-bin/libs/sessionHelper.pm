#!/usr/bin/perl
use warnings FATAL=>all;
use strict;
use Data::Dumper;

# returns values from session
# POR AHORA, se usa para retreive 'alias'
# Return '-1' if not founded  # OJO, problemas si el valor buscado ES -1
sub getterSession($){
	my $name_to_get 	= shift;
	my $session = returnActiveSession();
	if($session)
	{
		return $session->param($name_to_get) if $session->param($name_to_get);
	}
	return 0;
	# my $value_of_cookie = $Globals::q->cookie($Globals::name_cookie_that_stores_session_id);
	# if ($value_of_cookie) # solo si la cookie existia creo $session (sino creo sesiones cada vez q recargan pagina al no estar logados)
	# { 
	# 	my $session = new CGI::Session("driver:File", $value_of_cookie, {Directory=>$Paths::sessiones}) or die CGI::Session->errstr;
	# }
}

#
# you can store @arrays, you have to send a ref_array
sub setterSession($$){
	my $name_to_set 	= shift;
	my $value_to_set 	= shift;
	my $session = returnActiveSession();
	if($session)
	{
		$session->param(-name=>$name_to_set,-value=>$value_to_set);
	}
	return 1;
	# my $value_of_cookie = $Globals::q->cookie($Globals::name_cookie_that_stores_session_id);
	# if ($value_of_cookie)
	# { 
	# 	my $session = new CGI::Session("driver:File", $value_of_cookie, {Directory=>$Paths::sessiones}) or die CGI::Session->errstr;
	# }
	# return 1;
}


sub returnActiveSession()
{
	# use CGI qw(:standard);
	# use CGI::Session;
	# my $Globals::q = CGI->new;
	my $value_of_cookie = $Globals::q->cookie($Globals::name_cookie_that_stores_session_id);
	my $session;
	if($value_of_cookie)
	{
		$session = new CGI::Session("driver:File", $value_of_cookie, {Directory=>$Paths::sessiones}) or return 0;
	}
	return $session;
}


sub disconnectSession()
{
	# DELETE SESSION
	my $session = new CGI::Session("driver:File", getterSession("_SESSION_ID"), {Directory=>$Paths::sessiones}) or die CGI::Session->errstr;
	$session->delete();
	$session->flush(); # Recommended practice says use flush() after delete().
	        # go to home (that is going to redirect to login)

    # DELETE COOKIE
    # create a cookie with negative time to expire, to delete it

    my $cookie = $Globals::q->cookie(-name=>$Globals::name_cookie_that_stores_session_id,-value=>"going_to_die",-expires=>'-1h');
    print $Globals::q->redirect(-uri=>$Paths::cgi.'/login.pl',-cookie=>$cookie);
}

1;
#!/usr/bin/perl
use warnings FATAL=>all;  # use in development
use strict;
# core subs
use lib 'perlmvc';
use perlmvc;
# user defined subs
use lib 'libs';
use user_defined_subs;  # put here name of libs developed by user
sigueLogeado();
# update expiration (time defined in $Globals::expire)
my $cookie = $Globals::q->cookie(-name=>$Globals::name_cookie_that_stores_session_id,-value=>getterSession("_SESSION_ID"),-expires=>$Globals::expire_time);
	print $Globals::q->header(-cookie=>$cookie);
&enrutador();
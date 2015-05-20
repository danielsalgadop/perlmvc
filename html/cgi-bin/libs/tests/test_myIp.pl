#!/usr/bin/perl
use warnings FATAL=>all;
use strict;

print &myIp;


# Function that retrurns server ip, to avoid hasrdcoding
sub myIp()
{
	use Sys::Hostname qw(hostname); # not strictly necessary; exports it by default
	use Socket;
	my($localip) = inet_ntoa( (gethostbyname(hostname()))[4] );
	return $localip;
}

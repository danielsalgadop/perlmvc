#!/usr/bin/perl
use warnings FATAL=>all;
use strict;
use lib '..';
use validaciones qw(esIp);
use Test::More 'no_plan';

my @bad_ips = qw(1 2.2 3.3.3 255.255.255.256 0.0.0.256 1.1.1 2.2.2.2.2);
my @good_ips = qw(0.0.0.0 1.1.1.1 255.255.255.255);

foreach (@bad_ips)
{
	is(esIp($_),0,"bad IP [".$_."]");
}

foreach (@good_ips)
{
	is(esIp($_),1,"good IP [".$_."]");
}
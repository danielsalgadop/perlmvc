#!/usr/bin/perl
use warnings FATAL=>all;  # use in development
use strict;

# you can use any sub defined inside perlmvc
sub userSub()
{
	return trimSpaces("     Using a perlmvc function to be trimmed  ");
}
1;
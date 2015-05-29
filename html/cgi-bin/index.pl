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
&enrutador();
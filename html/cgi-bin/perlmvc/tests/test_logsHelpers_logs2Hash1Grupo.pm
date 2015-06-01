#!/usr/bin/perl
# place to try logs2Hash1Grupo

use warnings FATAL=>all;
use strict;
use Data::Dumper;
use lib '../';
use Paths;

use logsHelpers qw(logs2Hash1Grupo);
use Test::More 'no_plan';

my %r_logs2Hash1Grupo = logs2Hash1Grupo("grupo1");
print Dumper(%r_logs2Hash1Grupo);
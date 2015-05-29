#!/usr/bin/perl
# place to try cargarFicheroHistoricoNeba

use warnings FATAL=>all;
use strict;
use Data::Dumper;
use lib '../';
use CGI qw(:standard);
use globals;
use paths;
use Test::More 'no_plan';

use httpParamsControl;

# construct mock Params
$Globals::q = CGI->new( {'key1'=>'barney',
    'song'=>'I love you',
    'friends'=>[qw/Jessica George Nancy/]}
);
my %r_paramsControl;
my @expected_params;

#### TESTs OK 
@expected_params = qw(key1);
%r_paramsControl = paramsControl(\@expected_params);
ok( ($r_paramsControl{status} eq "OK" ),"todo OK" );


%r_paramsControl = paramsControl([qw/song/]);   # [qw/song/] is equivalent to ["song"]
ok( ($r_paramsControl{status} eq "OK" ),"todo OK" );


#### TEST ERROR 
push (@expected_params,"key2");# new (misssing) param

%r_paramsControl = paramsControl(\@expected_params);
ok( ($r_paramsControl{status} eq "ERROR" and $r_paramsControl{message} =~/key2/ ),"detectado falta de key2, y message lo menciona" );
# print Dumper(%r_paramsControl);


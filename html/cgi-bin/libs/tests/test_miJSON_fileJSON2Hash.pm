#!/usr/bin/perl
# place to try fileJSON2Hash

use warnings FATAL=>all;
use strict;
use Data::Dumper;
use lib '../';
use miJSON qw(fileJSON2Hash);
use Test::More 'no_plan';

my $path_al_json = "/tmp/test_miJSON_fileJSONHash.json";
`echo '{"user":"contra","user2":"contra2"}' > $path_al_json`;

my %r_fileJSON2Hash = fileJSON2Hash($path_al_json);
print Dumper(%r_fileJSON2Hash);



&limpiarTests();
sub limpiarTests(){
	`rm $path_al_json`;
}
#ok solo comprar true/false
# ok( 1 + 1 == 2 );
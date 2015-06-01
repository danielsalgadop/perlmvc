#!/usr/bin/perl
use warnings FATAL=>all;
use strict;
use lib '.';
use webTemplates;
use Globals;
# Es llamado desde miEnrutador
# hace los calculos necesarios y llama a los templates

sub cDataTable()
{
	# FAKE Read Model
	my @data;
	push ( @data, [ qw(11 12 13 14 15 16) ] );
	push ( @data, [ qw(21 22 23 24 25 26) ] );
	push ( @data, [ qw(31 32 33 34 35 36) ] );
	push ( @data, [ qw(41 42 43 44 45 46) ] );
	push ( @data, [ qw(51 52 53 54 55 56) ] );
	push ( @data, [ qw(61 62 63 64 65 66) ] );
	push ( @data, [ qw(71 72 73 74 75 76) ] );
	push ( @data, [ qw(81 82 83 84 85 86) ] );
	push ( @data, [ qw(91 92 93 94 95 96) ] );
	push ( @data, [ qw(101 102 103 104 105 106) ] );
	push ( @data, [ qw(111 112 113 114 115 116) ] );
	push ( @data, [ qw(121 122 123 124 125 126) ] );
	push ( @data, [ qw(131 132 133 134 135 136) ] );
	push ( @data, [ qw(141 142 143 144 145 146) ] );
	push ( @data, [ qw(151 152 153 154 155 156) ] );
	push ( @data, [ qw(161 162 163 164 165 166) ] );
	push ( @data, [ qw(171 172 173 174 175 176) ] );
	push ( @data, [ qw(181 182 183 184 185 186) ] );
	push ( @data, [ qw(191 192 193 194 195 196) ] );
	# pass this data to de View
	wtDataTable(\@data);
}
sub cUserDefinedLib()
{
	# interesting example
	# userSub is defined in 'libs' folder
	# but also inside it uses a sub perlmvc validaciones.pm (trimSpaces)
	wtUserDefinedLib(userSub());
}
1;
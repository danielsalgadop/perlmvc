#!/usr/bin/perl
use warnings FATAL=>all;
use strict;
# returns datetime

sub datetime(){
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
	$year = $year + 1900;
	$mon = "0".$mon if $mon =~/^\d$/;
	$mday = "0".$mday if $mday =~/^\d$/;
	$yday = "0".$yday if $yday =~/^\d$/;
	$hour = "0".$hour if $hour =~/^\d$/;
	$min = "0".$min if $min =~/^\d$/;
	$sec = "0".$sec if $sec =~/^\d$/;

	return $year."/".$mon."/".$mday."_".$hour."_".$min."_".$sec;
}

1;
#!/usr/bin/perl
use warnings;
use strict;

sub generarFormLogin {
 # use CGI qw/:standard/;
print
	start_form,
	"Usuario ",textfield('usuario'),p,
	"What's the combination?",
	checkbox_group(-name=>'words',
	-values=>['eenie','meenie','minie','moe'],
	-defaults=>['eenie','moe']),p,
	"What's your favorite color?",
	popup_menu(-name=>'color',
	-values=>['red','green','blue','chartreuse']),p,
	submit,
	end_form,
	hr,"\n";
}


1;
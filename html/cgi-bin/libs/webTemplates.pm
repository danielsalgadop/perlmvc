#!/usr/bin/perl
use warnings FATAL=>all;  # use in development
use strict;
# Place to MAP an URL => controller (or view)
# place to define web templates (wt = web_templates)

our $q;

#################################### Templates de paginas
sub wtHome(){
	wtHeader();
	print '<div class="row">';
	print $q->p("Bienvenido");
	print '</div>';
	wtFooter();
}

sub wtError(){
	wtHeader();
	print $q->h1("P&aacute;gina no encontrada");
	print Dumper(%ENV);  # coment this line in production
	wtFooter();
}

sub wtStaticPage(){
	wtHeader();
	print $q->h1
	(
		"P&aacute;gina Est&aacute;tica"
	),
	p(
		"no se usa Controlador, desde el enrutador se pasa al template",
	);
	wtFooter();
}
############################
# Function: wtDataTable
# example of a table using js library datatables
############################
sub wtDataTable($)
{
	wtHeader();
	print '<table id="example" class="table_for_datatable" width="100%" cellspacing="0">
        <thead>
            <tr>
                <th>UNO</th>
                <th>DOS</th>
                <th>TRES</th>
                <th>CUATRO</th>
                <th>CINCO</th>
                <th>SEIS</th>
            </tr>
        </thead>
        <tbody>
    ';
    foreach my $ref_row(@_)
    {
    	my @all_rows = @{$ref_row};
    		foreach my $one_row(@all_rows)
    		{
    	print '<tr>';
    			foreach my $data(@{$one_row})
    			{
	    			print '<td>';
	    				# print "222";
	    				print $data;
	    			print '</td>';
    			}
    	print '</tr>';
    		}
    }
    print '</tbody>
    ';
	wtFooter();
}


sub wtReadValueFromUrl(;$)
{
    my $value_in_url = shift;
    wtHeader();
    print $q->h3
    (
        "READ VALUE FROM URL",
    );
    if($value_in_url)
    {
        print $q->p
        (
            "VALUE in URL IS ==> "
                .h1
                (
                    $value_in_url
                ),
        );
    }
    else
    {
        print $q->p
        (
            "Add some characters to the url and reload page",
        );
    }
    wtFooter();
}
1;
#!/usr/bin/perl
use strict;
use CGI;
use DBI;
use XML::Simple;
use XML::Dumper;
use Data::Dumper;
use lib "../lib";
use MVCimple::BaseModel;
use MVCimple::Types;
use MVCimple::RenderView;

#The model read from the config globally
my $xml = new XML::Simple;
my $xmldata = $xml->XMLin("people.xml");
my $Person = new MVCimple::BaseModel('person',$xmldata->{models}->{person});



my $co = new CGI;
my $action = $co->param('action');
submit() if($action eq 'submit');
main() if($action eq undef); 


sub submit {
    print $co->header();
    $Person->store_forms($co);
    my $data = $Person->get_values();
    my $html = MVCimple::RenderView::render('submit.html',$data);
    print $html;

}


sub main {

    print $co->header();
    my $viewdata = $Person->get_forms();
    my $html = MVCimple::RenderView::render('default.html',$viewdata);

    print $html;
}

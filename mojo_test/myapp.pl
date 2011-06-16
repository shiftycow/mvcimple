#!/usr/bin/env perl
#This is an example of Using Mojolicious with MVCimple. I decided to use our MVCimple engine 
use Mojolicious::Lite;
use XML::Simple;
use lib '../lib/';
use MVCimple::BaseModel;
use MVCimple::Types;
use MVCimple::RenderView;
use MVCimple::DBConnect;
use MVCimple::Config;
#The model read from the config globally

#Read our Model in from XML
my $xml = new XML::Simple;
my $xmldata = $xml->XMLin("people.xml");
my $Person = new MVCimple::BaseModel('person',$xmldata->{models}->{person});

#Read in the Application config file
my $config = new MVCimple::Config('myapp.conf','.');

#Connect to the Database
my $dbh = MVCimple::DBConnect::connect($config);

get '/' => sub {
    my $self = shift;
    my $viewdata = $Person->get_forms();
    $self->render_text(MVCimple::RenderView::render('templates/default.html',$viewdata));
};

any '/submit' => sub {
    my $self = shift;
    $Person->store_input($self);
    my $validate = $Person->validate();
    if($validate->{error}) {
        $self->render_text($validate->{error});
    }
    else {
        my $data = $Person->get_values();
        $Person->save($dbh);
        $self->render_text(MVCimple::RenderView::render('templates/submit.html',$data));
    }


};

app->start;


#!/usr/bin/env perl
use strict;
#This is an example of Using Mojolicious with MVCimple. I decided to use our MVCimple engine 
use Mojolicious::Lite;
use XML::Simple;
use lib '../../lib/';
use MVCimple::App;
use Data::Dumper;
#The model read from the config globally

#Read our Model in from XML
my $xml = new XML::Simple;
my $xmldata = $xml->XMLin("people.xml");
my $Person = new MVCimple::BaseModel({object_name=>'person',model=>'person',models=>$xmldata->{models}});
#Read in the Application config file
my $config = new MVCimple::Config('myapp.conf','.');

#Connect to the Database
my $dbh = MVCimple::DBConnect::connect($config);

my $app = app;
$app->types->type(xsl => 'text/xml');

get '/' => sub {
    my $self = shift;
    $self->stash(success=>$self->param('success')) if($self->param('success'));
    my $viewdata = $Person->get_forms();
    $self->render('default',%$viewdata);
};

get '/view' => sub {

    my $self = shift;
    my $person_data = $Person->load($dbh);
    if($person_data->{error} =~ /no such table/) {
        $self->render('db_error');
        return;   
    }
    my $person_xml = '<?xml-stylesheet type="text/xsl" href="xsl/person.xsl"?>' . "\n";
    $person_xml .= $xml->XMLout($person_data->{data});
    $self->render(data =>$person_xml, format=>'xml');

};

any '/submit' => sub {
    my $self = shift;
    $Person->store_input($self);
    my $validate = $Person->validate();
    if($validate->{error}) {
        my $viewdata = $Person->get_forms();
        $self->render('default',(%$viewdata,errors=>$validate->{error}));
    }
    else {
        my $data = $Person->get_values();
        my $result = $Person->save($dbh);
        if($result->{error} =~ /no such table/) {
            $self->render('db_error');
            return;   
         }
        $self->redirect_to('/?success=Data%20Inserted');
    }
};
app->start;
app->types->type(xsl => 'text/xml');


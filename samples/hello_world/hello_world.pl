#!/usr/bin/perl
#
# hello_world.pl
#
# MVCimple and Mojolicious::Lite combine to form a complete 
# database-backed web application!
#

use strict;

use Data::Dumper; #DEBUG

# path to local MVCimple install
use lib "../../lib";

use Mojolicious::Lite;
use MVCimple::App;

#
# set up the data models
# This can also be done by reading data from an external XML, JSON or Storable file
#
# my $xml = new XML::Simple;
# my $models = $xml->XMLin("greeting.xml")
#
# #TODO: add JSON and Storable examples
# my $models = 
# my $models = 

my $models = {'greeting' => {
                    'id' =>
                        {'type' => 'Integer',
                         'primary_key' => 'true',
                         'auto_increment' => 'true'
                        },#end id

                    'subject' => 
                        {'type' => 'String',
                         'length' => '64',
                         'value' => 'World'
                        },#end subject

                    'predicate' =>
                        {'type' => 'String',
                         'length' => '64',
                         'value' => 'Hello'
                        }
                    }#end greeting
                };#end models

my $Greeting = new MVCimple::BaseModel('greeting',$models->{'greeting'});

# configure 
my $config = new MVCimple::Config();

$config->set("dbdriver","SQLite");
$config->set("dbname","hello_world.db");
`touch hello_world.db`; #in case it doesn't exist

my $dbh = MVCimple::DBConnect::connect($config);

#
# behavior definitions for Mojolicious Routes
#

# default view
get '/' => sub {
    my $self = shift;

    my $viewdata = {};
    $viewdata->{"forms"} = $Greeting->get_forms();
    $viewdata->{"greetings"} = $Greeting->load($dbh);
    if($viewdata->{"greetings"}->{"error"} =~ /no such table/)
    {
        $viewdata->{"message"} = "Warning: The database probably hasn't been generated.";
        $viewdata->{"message"} .= "Use the following SQL code to create it:";
        $viewdata->{"sql"} = MVCimple::GenSQL::generate_sql($models,$config);
    }

    #render the page to the browser
    my $xml = '<?xml-stylesheet type="text/xsl" href="/templates/hello_world.xsl"?>'."\n";    
    $xml .= XML::Simple::XMLout($viewdata, NoAttr=>1 );

    $self->render(data => $xml, format => 'xml');
};#end "/" route

#start Mojolicious app!
app->start;


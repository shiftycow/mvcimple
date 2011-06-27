#!/usr/bin/perl
#
# hello_world.pl
#
# MVCimple and Mojolicious::Lite combine to form a complete 
# database-backed web application!
#

use strict;
use lib "../lib";

use Mojolicious::Lite;
use MVCimple::App;

#set up the data models
my $models = {'greeting' => 
                    {'id' =>
                        {'type' => 'Integer',
                         'primary_key' => 'true',
                         'auto_increment' => 'true'
                        }
                    },#end id

                    {'subject' => 
                        {'type' => 'String',
                         'length' => '64',
                         'value' => 'Hello'
                        }
                    },#end subject

                    {'predicate' =>
                        {'type' => 'String',
                         'length' => '64',
                         'value' => 'World'
                        }
                    }#end predicate
                };#end greeting

my $Greeting = new MVCimple::BaseModel('greeting',$models->{'greeting'});

my $config = new MVCimple::Config();

$config->set("dbdriver","SQLite");
$config->set("dbname","hello_world.db");
`touch hello_world.db`; #in case it doesn't exist

my $dbh = MVCimple::DBConnect::connect($config);
#generate the database
#MVCimple::GenSQL::syncdb($models,$dbh);
print "database sync complete\n";


get '/' => sub {
    my $self = shift;
    
    my $viewdata = $Greeting->get_forms();
    $self->render_text("foo");
    $self->render_text("bar");
};

#start Mojolicious app!
app->start;


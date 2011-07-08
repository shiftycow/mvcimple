#!/usr/bin/perl
use strict;
use XML::Simple;
use Data::Dumper;
use lib "../../lib/";
use MVCimple::GenSQL;
use MVCimple::Config;

my $xml = new XML::Simple;
my $xmldata = $xml->XMLin("people.xml");

#Read in the Application config file
my $config = new MVCimple::Config('myapp.conf','.');

#print $config->element('dbdriver');
print MVCimple::GenSQL::generate_sql($xmldata->{models},$config);

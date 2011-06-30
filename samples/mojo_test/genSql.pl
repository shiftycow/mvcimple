#!/usr/bin/perl
use strict;
use XML::Simple;
use lib "../../lib/";
use MVCimple::GenSQL;

my $xml = new XML::Simple;
my $xmldata = $xml->XMLin("people.xml");
print MVCimple::GenSQL::generate_sql($xmldata->{models});

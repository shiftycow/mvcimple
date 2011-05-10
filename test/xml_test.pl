#!/usr/bin/perl
use strict;

use XML::Simple;
use XML::Dumper;
use Getopt::Long;
use Data::Dumper;

my $filename = @ARGV[0];

my $xml = new XML::Simple;

if($filename eq undef)
{
    print "filename argument missing, exiting\n";
    exit 1;
}

my $data = $xml->XMLin($filename);
print Dumper($data);
#my $xml_output = XML::Dumper::pl2xml($data);
#print $xml_output;

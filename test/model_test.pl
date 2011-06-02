#!/usr/bin/perl
use strict;

use XML::Simple;
use XML::Dumper;
use Getopt::Long;
use Data::Dumper;

use lib "../lib";
use MVCimple::BaseModel;
use MVCimple::Types;


my $filename = '../samples/sample_config.xml';
my $xml = new XML::Simple;


my $xmldata = $xml->XMLin($filename);
#print Dumper($xmldata);



my $user = new MVCimple::BaseModel('user',$xmldata->{model}->{user});
#print Dumper($user);


print Dumper($user->get_forms());

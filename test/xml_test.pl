#!/usr/bin/perl
use strict;
###############################################################################
#    This file is part of MVCimple.
#
#    MVCimple is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Lesser General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    MVCimple is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Lesser General Public License for more details.
#
#    You should have received a copy of the GNU Lesser General Public License
#    along with MVCimple.  If not, see <http://www.gnu.org/licenses/>. 
###############################################################################

use XML::Simple;
use XML::Dumper;
use Getopt::Long;
use Data::Dumper;

my $filename = $ARGV[0];
my $xml = new XML::Simple;

#if($filename eq undef)
#{
#    print "filename argument missing, exiting\n";
#    exit 1;
#}

my $data = $xml->XMLin($filename);

#my $data = {};
#$data->{"employee"} = [];
#$data->{"employee"}->[0] = {name=>"john doe", "group" => "operations"};
#$data->{"employee"}->[1] = {name=>"jane doe", "group" => "administration"};

print Dumper($data);

#print $xml->XMLout($data,NoAttr => 1);

#my $xml_output = XML::Dumper::pl2xml($data);
#print $xml_output;

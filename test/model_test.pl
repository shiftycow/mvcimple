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

use lib "../lib";
use MVCimple::BaseModel;
use MVCimple::Types;


my $filename = '../samples/sample_config.xml';
my $xml = new XML::Simple;


my $xmldata = $xml->XMLin($filename);
print Dumper($xmldata);



my $user = new MVCimple::BaseModel('user',$xmldata->{model}->{user});

print Dumper($user);


print Dumper($user->get_forms());

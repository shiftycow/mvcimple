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

#
# auto_test.pl
# provides an interface for automatic testing of MVCimple libraries
#

use lib "../lib";

#system includes
use Term::ANSIColor;
use Getopt::Long;

use Data::Dumper; #DEBUG

#local includes
use MVCimple::AutoTest;

#get CLI options
my $verbose = 0;
my $config_file = @ARGV[0];
my $xml = 0;

my $result = GetOptions("verbose" => \$verbose,
        "xml" => \$xml);

print "MVCimple auto_test.pl\n\n";
print "[ Options ] \n";
print "Verbose mode enabled\n" if($verbose);
print "Using XML::Dumper\n" if($xml);
print "Using Data::Dumper\n" if(!$xml);

#read in the config file
my $config = new MVCimple::Config($config_file,"./") if($config_file);

#print Dumper($config); #DEBUG

if($config_file eq undef)
{
    print MVCimple::AutoTest::warning();
    print " no test configuration specified, trying default test configuration './BaseModel.conf'\n";
    $config = new MVCimple::Config("BaseModel.conf","./");
}

#add command line switches to config
$config->set('xml',$xml);
$config->set('verbose',$verbose);

print "\n[ Testing ]\n";
MVCimple::AutoTest::validate($config);

print "testing complete!\n";

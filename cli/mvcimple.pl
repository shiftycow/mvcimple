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

=pod

=h1 Name

mvcimple.pl

=h1 Synopsis

mvcimple.pl --config-file <filename> [--app_path </path/to/app> --sql, --alter, --unit_test, --debug]

=cut

#system includes
use Getopt::Long;

#local includes
#TODO: find the installed path of MVCimple
use lib "../lib";
use MVCimple::GenSQL;

#get CLI options
my $debug = 0;
my $sql = 0;
my $alter = 0;
my $unit_test = 0;
my $config_file = '';
my $app_path = "./";

my $result = GetOptions("debug" => \$debug,
                        "sql" => \$sql,
                        "alter" => \$alter,
                        "unit-test" => \$unit_test,
                        "config-file" => \$config_file,
                        "app-path" => \$app_path);

#print out the command line options if debug mode is enabled
if($debug)
{
    print "Debugging mode enabled...\n";
    print "\n";
    print "[CLI Options]\n";
    print "--debug: '$debug'\n";
    print "--sql: '$sql'\n";
    print "--alter: '$alter'\n";
    print "--unit-test: '$unit_test'\n";
    print "--config-file '$config_file'\n";
    print "--app-path '$config_file'\n";
}#end cli option debugging

#check for required arguments
usage("config-file") if $config_file eq '';


#####################################
##       Helper Functions         ##
#####################################

#print out usage instructions
sub usage
{
    my ($arg) = @_;

    print "Error: Required argument '$arg' not specified\n";
    
    print "\nUsage:\n";
    print "    mvcimple.pl --config-file /path/to/filename [--app-path /path/to/app --sql, --alter, --unit_test]\n";
}

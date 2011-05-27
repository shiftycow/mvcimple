#!/usr/bin/perl
use strict;

=pod

=h1 Name

mvcimple.pl

=h1 Synopsis

mvcimple.pl --config-file <filename> [--app_path </path/to/app> --sql, --alter, --unit_test, --debug]

=cut

#system includes
use Getopt::Long;

#local includes

#get CLI options
my $debug = 0;
my $sql = 0;
my $alter = 0;
my $unit_test = 0;

my $result = GetOptions("debug" => $debug,
                        "sql" => $sql,
                        "alter" => $alter,
                        "unit-test" => $unit_test);

#print out the command line options if debug mode is enabled
if($debug)
{
    print "Debugging mode enabled, this will be quite verbose...\n";
    print "\n";
    print "[CLI Options]\n"
    print "--debug: '$debug'\n";
    print "--sql: '$sql'\n";
    print "--alter: '$alter'\n";
    print "--unit-test: '$unit_test'\n";
    print "--config-file '$config_file'\n";
}#end cli option debugging

#print out usage instructions
sub usage
{
    print "Usage:\n";
    print "    mvcimple.pl <config_file> <app_path> [--sql, --alter, --unit_test]\n";
}

#!/usr/bin/perl
#
# config_test.pl
# used to do timing tests on different versions of Config.pm
#

#system includes
use Time::HiRes;

#local includes
use lib "../lib";

#load stock config module
my $t0 = [Time::HiRes::gettimeofday];

use MVCimple::Config; #stock Config file reader

my $elapsed = Time::HiRes::tv_interval($t0,[Time::HiRes::gettimeofday]);
print "Loaded Config.pm in $elapsed\n";
print "dbuser = ".MVCimple::Config::get_config_element('dbuser')."\n";

#load cachine config module
$t0 = [Time::HiRes::gettimeofday];

#use MVCimple::ConfigCache; #config file reader that is caching-aware

my $elapsed = Time::HiRes::tv_interval($t0,[Time::HiRes::gettimeofday]);
print "Loaded ConfigCache.pm in $elapsed\n";



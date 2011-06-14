#!/usr/bin/perl
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



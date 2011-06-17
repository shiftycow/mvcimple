#!/usr/bin/perl
use strict;
package MVCimple::AutoTest;
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
# Contains common testing functions for MVCimple libraries
#

#system includes
use Time::HiRes;
use Data::Dumper;
use XML::Dumper;

#local includes
use MVCimple::Config; #stock Config file reader

#runs a list of strings through the validator methods of the specified class
sub validate
{
    my ($class, $config);

    #load the test parameter config file
    my $config = new MVCimple::Config("string_test.conf");

    my $parameters = $config->elements();

    while (my ($key, $value) = each %$parameters)
    {
        #do some testing

    }
    #test null and not-null conditions
    
}#end validate

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
use Time::HiRes; #for timing, potentially used in the future
use Data::Dumper; #for dumping data structures
use XML::Dumper; #for dumping data structures
use Term::ANSIColor; #for fancy colors

#local includes
use MVCimple::Config; #stock Config file reader

#"constants"
my $VALID = "valid";
my $INVALID = "invalid";

#runs a list of strings through the validator methods of the specified class
sub validate
{
    my ($config) = @_;

    #read the model parameters from the test file
    my $model_params = {};

    #TODO: delete elements with a mutator in Config instead of direct access
    my $model = $config->element('model');
    delete $config->{'model'};

    $model_params->{'length'} = $config->element("length");
    delete $config->{'length'}; #and delete them as we go
   
    $model_params->{'null'} = $config->element("null");
    delete $config->{'null'}; #and delete them as we go
    
    my $verbose = $config->element("verbose");
    delete $config->{'verbose'};

    my $xml = $config->element("xml");
    delete $config->{'xml'};

    # create a new test object...
    my $test_object = {};
    bless $test_object, "MVCimple::$model"; #...bless it to the proper class...
    $test_object = $test_object->new("test_object",$model_params); #...and construct it

    # since we deleted the object parameters from the config, the rest of the elements should be 
    # strings to test
    my $parameters = $config->elements();
    
    while (my ($string, $validity) = each %$parameters)
    {
        $validity = lc $validity; #force "valid" or "invalid" flag to lowercase

        print "'$string' should be $validity ";
        $test_object->set_value($string);
        
        print "\n validating...\n" if($verbose);
        my $result = $test_object->validate();
        
        if($verbose)
        {
            print "Validation Result: \n";
            print Dumper($result) if(not $xml);
            print XML::Dumper::pl2xml($result) if($xml);
        }
        
        # print pass/fail messages
        print pass() if(($result->{'error'} eq undef) and ($validity eq $VALID));
        print fail() if(($result->{'error'} eq undef) and ($validity eq $INVALID));
        
        print pass() if(($result->{'error'} ne undef) and ($validity eq $INVALID));
        print fail() if(($result->{'error'} ne undef) and ($validity eq $VALID));

        print "\n";
    }#end testing loop
    
    #test null and not-null conditions 
}#end validate

#
# helper functions to print out colorful pass/fail/warn messages
#
sub fail{
    return Term::ANSIColor::colored(" [ FAIL ] ","red");
}#end fail

sub pass{
    return Term::ANSIColor::colored(" [ PASS ] ","green");
}#end pass

sub warning{
    return Term::ANSIColor::colored(" [ WARN ] ","yellow");
}#end warning

1;

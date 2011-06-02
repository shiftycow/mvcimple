#!/usr/bin/perl
#
# testing script for the MVCimple::EMail class
#
#

use strict;
use lib "../lib";
use MVCimple::EMail;

my $email = new MVCimple::EMail('email');

print $email->to_sql()."\n";
print $email->to_input()."\n";

$email->set_value('foo@bar.com');
if($email->validate()){
    print $email->get_value();
    print " This email address is valid \n"; 
}

$email->set_value('not an email address');
if($email->validate()){
    print $email->get_value();
    print " This email address is valid \n"; 
}


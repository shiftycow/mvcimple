#!/usr/bin/perl
#
# testing script for the MVCimple::Password class
#
#

use strict;
use lib "../lib";
use MVCimple::Password;

my $password = new MVCimple::Password('password',{hash_type => "SHA-1",
                                                  salt_length => 12}
                                     );

print $password->to_sql()."\n";
print $password->to_input()."\n";
print $password->to_hash()."\n";

$password->set_value('som3cr4ppypasswd');
if($password->validate()){
    print $password->get_value();
    print " This password is valid \n"; 
}

$password->set_value('2short');
if($password->validate()){
    print $password->get_value();
    print " This password is invalid \n"; 
}


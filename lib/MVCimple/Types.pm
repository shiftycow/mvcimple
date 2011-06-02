#!/usr/bin/perl
use strict;
package MVCimple::Types;
#

=pod

=h1 Name 

Types.pm

=h2 Synopsis

This library provides a convenient interface to `use` the type libraries
included in MVCimple. These type libraries provide an object-oriented 
way to handle different data types passed around MVCimple-based applications

=cut

#define type libraries here
#use EthernetMAC;
#use IP;
#use Password;
use MVCimple::String;
use MVCimple::Number;
use MVCimple::IP;
use MVCimple::EMail;
use MVCimple::EtherMAC;
use MVCimple::Password;

1;

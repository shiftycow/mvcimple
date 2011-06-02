#!/usr/bin/perl
use strict;
use MVCimple::String;
package MVCimple::EtherMAC;
our @ISA = ("MVCimple::String");

##This needs to be finished
=pod
Ethernet MAC Address
=cut

#
# constructor
# returns: blessed reference to a new Ethernet object

sub new
{
    my ($class,$name,$model) = @_;

    my $self = {"name" => $name};
    $self->{'value'} = $model->{'value'}; 
    $self->{'length'} = 17; 

    return bless $self;
}

1;


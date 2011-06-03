#!/usr/bin/perl
use strict;
use lib "../";
use MVCimple::String;
package MVCimple::Password;
our @ISA = ("MVCimple::String");

#This needs to be finished
=pod
Password
=cut

#
# constructor
# returns: blessed reference to a new Password object

sub new
{
    my ($class,$name,$model) = @_;

    my $self = {"name" => $name};
    $self->{'value'} = $model->{'value'}; 
    $self->{'length'} = $model->{'length'}; 
    
    return bless $self;
    

}

1;


#!/usr/bin/perl
use strict;
use lib "../";
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

#We overwrite set_value so that the address can be normalized
sub set_value {
    my ($self,$value) = @_;
        $self->{'value'} = convertEther($self,$value);
}


sub validate {
    my($self) =  @_;

    return 0 if(convertEther($self,$self->{'value'}) eq undef);
    
    return 1;
}

#convertEther
#
#This is the conversion and validation method directly from Netreg and other noc Apps
sub convertEther {
    my ($self,$ether) = @_;

    if (!defined($ether)) {
        return(undef);
    }
    $ether =~ s/^0x//;
    $ether =~ s/://g;
    $ether =~ s/-//g;
    $ether =~ s/\.//g;
    $ether =~ s/ //g;
    $ether = lc($ether);
    if (!($ether =~ m/^[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$/)){
        return (undef);
    }
    $ether =~ s/^([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])/$1:$2:$3:$4:$5:$6/;
    return($ether);
}


1;


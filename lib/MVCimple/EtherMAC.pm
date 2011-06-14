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
    $self->{'null'} = $model->{'null'};
    return bless $self;
}

#We overwrite set_value so that the address can be normalized
sub set_value {
    my ($self,$value) = @_;
        $self->{'value'} = convertEther($self,$value);
        print "\nValue ='" . $self->{'value'} . "'\n\n" ;
    }


sub validate {
    my($self) =  @_;
    my $return = {};

    #Check if it's a valid string.
    $return = MVCimple::String::validate($self);
    return $return if($return->{'error'} ne undef);

    #If it's null and it's supposed to be null, succeed.
    return {"success" => ""} if($self->{'null'} and $self->{'value'} eq undef); 

    #If it's not a properly formatted MAC address or is invalid, return an error.
    return {"error"=> $self->{"name"} . " is not a valid MAC address."} if($self->{'value'} eq 0);
   
    #Otherwise, succeed.
    return {"success" => "This is a valid MAC address"};
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
        return (0);
    }
    $ether =~ s/^([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])/$1:$2:$3:$4:$5:$6/;
    return($ether);
}


1;


#!/usr/bin/perl
use strict;
use lib "../";
use MVCimple::String;
package MVCimple::EtherMAC;
our @ISA = ("MVCimple::String");
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
    
    if(convertEther($self,$self->{'value'}) eq undef){
        return {"error"=> $self->{"name"} . " is not a valid MAC address."};
    }

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
        return (undef);
    }
    $ether =~ s/^([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])([0-9a-fA-F][0-9a-fA-F])/$1:$2:$3:$4:$5:$6/;
    return($ether);
}


1;


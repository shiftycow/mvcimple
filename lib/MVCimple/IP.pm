#!/usr/bin/perl
use strict;
package MVCimple::IP;
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

use Data::Dumper; 

#This is needed to check errors on the package
use lib "../";
use MVCimple::String;
use MVCimple::Number;

=pod
IP address are unique in that they can be stored in a database in two different ways, First as a regular string '10.0.0.1' or as a 32bit unsinged integer 167772161 Therefor this class will either inherit from String or Number depending on datatype attribute, String is the default.

=cut

#
# constructor
# returns: blessed reference to a new IP object

sub new
{   
    my ($class,$name,$model) = @_;

    my $self = {"name" => $name};
    $self->{'value'} = $model->{'value'}; 
    #defaults 
    $self->{'length'}    = ($model->{'length'} eq undef)    ? 15 : $model->{'length'};
    $self->{'precision'} = ($model->{'precision'} eq undef) ? 32 : $model->{'precision'};
    $self->{'scale'}     = ($model->{'scale'} eq undef)     ? 0 : $model->{'scale'};
    $self->{'datatype'}  = ($model->{'datatype'} eq undef)  ? 'String' : $model->{'datatype'};
    $self->{'null'} = $model->{'null'};
    
    #Change the parent depending on the datatype
    our @ISA = ("MVCimple::$self->{datatype}");
    bless $self;
    return $self;
}#end constructor

#
# get_as_string
# returns: The IP address represented as a string regardless of it's initial datatype declaration. 
#
sub get_as_string
{
    my ($self) = @_;
    my $ip = $self->{'value'};
    if($self->{'datatype'} eq "Number"){ 
        return decimal2IP($self,$ip)   
    } else{
        return $ip;
    }
}


#
# get_as_number
# returns: The IP address represented as a number regardless of it's initial datatype declaration. 
#
sub get_as_number
{
    my ($self) = @_;
    my $ip = $self->{'value'};
    if($self->{'datatype'} eq "String"){ 
        return ip2Decimal($self,$ip)   
    } else{
        return $ip;
    }
}




# 
# validate
# returns: 1 or 0 depending on whether the argument is a valid IP address or not
#
sub validate
{
  my ($self) = @_;
  my $return = {};  
  print "null = '" . $self->{'null'} . "'\n"; #DEBUG
  my $ip = $self->{'value'};
  if($self->{'datatype'} eq "String") {
    $return = MVCimple::String::validate($self);
    # print Dumper($return); #DEBUG
    return $return if($return->{'error'} ne undef);
    #print "Value = " . $self->{'value'}. "\n"; #DEBUG
    return {"success" => ""} if($self->{'null'} and !length($self->{'value'}));
    return {"error" => "This is not valid IP address."} if(!checkIP($self,$ip));
  }
  if($self->{'datatype'} eq "Number") {
    $return = MVCimple::Number::validate($self);
    #print Dumper($return); #DEBUG
    return $return if($return->{'error'} ne undef);
    return {"success" => ""} if($self->{'null'} and $self->{'value'} eq "");
    return {"error" => "This is not valid IP address."} if(!checkIP($self,decimal2IP($self,$ip)));

  }
return {"success" => "This is a valid IP address."};
}#end validate


sub checkIP {
    my ($self,$ip) = @_;

    if (!defined($ip)) {
        return(0);
    }

    my @octets = split('\.',$ip);
    if ($#octets != 3) {
        return(0);
    }

    foreach my $octet (@octets) {
        unless ($octet =~ m/^\d+$/){
            return(0);
        }
        if ($octet < 0 || $octet >255){
            return(0);
        }

    }
    return(1);
} 


#   
#ip2Decimal
#Convert the IP to a numeric value
sub ip2Decimal {
    my ($self,$ip) = @_;

    if (!defined($ip)) {
        return(undef);
    }
    my $netNum = pack('C4',split('\.',$ip));
    my $tmp = unpack('N',$netNum);
    return($tmp);
}

#
# Convert a numeric IP to a string
#
sub decimal2IP {
    my ($self,$ipDecimal) = @_;

    if (!defined($ipDecimal)) {
        return(undef);
    }
    my $tmp = join('.',unpack('C4',pack('N',$ipDecimal)));
    return($tmp);
}




1;


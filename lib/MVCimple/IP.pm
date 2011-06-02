#!/usr/bin/perl
use strict;
use MVCimple::String;
use MVCimple::Number;
package MVCimple::IP;

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
    
    #Change the parent depending on the datatype
    our @ISA = ("MVCimple::$self->{datatype}");
    bless $self;
    return $self;
}#end constructor

# 
# validate
# returns: 1 or 0 depending on whether the argument is a valid IP address or not
#
sub validate
{
  my ($self) = @_;
  my $ip = $self->{'value'};
  if($self->{'datatype'} eq "String") {
        return checkIP($self,$ip);
        }
  if($self->{'datatype'} eq "Number") {
            if(($ip * 1) eq $ip) {
                return checkIP($self,decimal2IP($self,$ip));
        }
    }
return 0;
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


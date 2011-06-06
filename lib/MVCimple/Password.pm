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
    $self->{'hash_type'} = $model->{'hash_type'};
    $self->{'salt_length'} = $model->{'salt_length'};
    
    #the salt used to hash the password
    $self->{'salt'} = $model->{'salt'};
    
    #plaintext version of the password - irretrivable from hashed version
    $self->{'plaintext'} = $model->{'plaintext'};

    #hashed version of the password - derived from plaintext if present
    $self->{'hash'} = $model->{'hash'};

    if($self->{'salt'} ne undef and $self->{'plaintext'} ne undef})
    {
        
    }

    #the "value" of the password is its storable value in the form: $salt$hash
    $self->{'value'} = $model->{'value'}; 
    
    #
    #figure out the length of the database column 
    #based on the hash type and salt length
    #
    $self->{'length'} = $model->{'length'}; 

    return bless $self;
}#end constructor

# 
# to_input
# returns: HTML code representing an <input> element for a password object
#
sub to_input
{
    my ($self) = @_;

    my $html = "";
    my $name = $self->{"name"};
    my $id = $name."_input";
    my $length = $self->{"length"};

    $html .= "<input type=\"password\"";
    $html .= " id=\"$id\"";
    $html .= " name=\"$name\"";
    $html .= " onkeyup=\"check_password($id,$length)\"";
    $html .= " />\n";

    return $html;
}#end input

#
# set_value
# sets the value of the password to the string specified
# 

#
# get_hash
# returns the hash of the password object based on it's hash type, salt, and value
#

#
# set_salt
# sets the salt used to hash the password
#

#
# export
# returns the string representation of the password to store in the database
#

1;


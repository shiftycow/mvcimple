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
    $self->{'hash_type'} = $model->{'hash_type'};
    $self->{'salt_length'} = $model->{'salt_length'};
    $self->{'salt'} = $model->{'salt'};

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
1;


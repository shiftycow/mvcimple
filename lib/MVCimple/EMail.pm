#!/usr/bin/perl
use strict;
use lib "../";
use MVCimple::String;
package MVCimple::EMail;
our @ISA = qw/MVCimple::String/;
=pod

=cut

#
# constructor
# returns: blessed reference to a new EMail object
sub new
{
    my ($class,$name,$model) = @_;

    my $self = {"name" => $name};
    $self->{"value"} = $model->{'value'};
    $self->{'null'} = $model->{'null'};
    #Default length of e-mail as per RFC
    $self->{'length'}    = ($model->{'length'} eq undef)    ? 254 : $model->{'length'};
    bless $self;
    return $self;
}#end constructor
# 
# validate
# returns: 1 or 0 depending on whether the argument is a valid EMail or not
#
sub validate
{
    my ($self,$email) = @_;
    my $return = {};

    #Check if it's a valid string. 
    $return = MVCimple::String::validate($self);
    return $return if($return->{'error'} ne undef);
    
    #Check for null, if it's supposed to be null, succeed.
    return {"success" => ""} if($self->{'null'} and !length($self->{'value'}));
    
    #Check length
    $email = lc($self->{'value'});
    return {"error"=>"Email address is too long."} if(length $email >= $self->{"length"});
    
    #If it's not in the proper email address format(example@example.com), return an error. 
    if(!($email =~ /^[a-z0-9._%+-]+\@[a-z0-9.-]+\.[a-z]{2,6}$/)) {
        return {"error" => "Invalid email address format. "};
    }
    
    return {"success" => "This is a valid email address."};
}#end validate
 

1;


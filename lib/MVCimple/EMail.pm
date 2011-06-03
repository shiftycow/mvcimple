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
    $email = lc($self->{'value'});
    if($email =~ /^[a-z0-9._%+-]+\@[a-z0-9.-]+\.[a-z]{2,6}$/) {
        #return (length $email => $self->{"length"});        
        return (length $email => $self->{"length"});        
    }
    
    return 0;


}#end validate
 

1;


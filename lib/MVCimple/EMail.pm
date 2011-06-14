#!/usr/bin/perl
use strict;
use lib "../";
use MVCimple::String;
package MVCimple::EMail;
our @ISA = qw/MVCimple::String/;

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


#!/usr/bin/perl
use strict;
use lib "../";
use MVCimple::Number;
package MVCimple::Integer;
our @ISA = qw/MVCimple::Number/;

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
# returns: blessed reference to a new Integer object
sub new
{
    my $self = MVCimple::Number::new(@_);
    bless $self;
    return $self;
}#end constructor

# to_sql()
# # returns: string of SQL required to create such a Number object in a database
# #
sub to_sql
{
    my ($self) = @_;
    return $self->{"name"}." INTEGER";
}#end to_sql


1;

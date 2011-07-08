#!/usr/bin/perl
use strict;
use lib "../";
use MVCimple::String;
package MVCimple::DateTime;
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


=pod

=cut

use POSIX;

#
# constructor
# returns: blessed reference to a new DateTime object
sub new
{
    my ($class,$name,$model) = @_;
    
    my $self = {'name' => $name};
    bless $self;

    $self->{'format'} = '%Y-%m-%d %H:%M:%S';
    $self->{'format'} = $model->{'format'} if($model->{'format'} ne undef);#format specifier recognized by strftime()
    $self->{'now'}    =  $model->{'now'} if($model->{'now'} ne undef);
    $self->{'value'} = $self->now() if ($model->{now});
    $self->{'value'} = $model->{'value'} if($model->{'value'});

    return $self;
}#end constructor

#
# to_sql()
# # returns: string of SQL required to create a DateTime object in a database
# #
sub to_sql
{
    my ($self) = @_;
    return $self->{"name"}." DATE";
}#end to_sql

sub validate
{
    my ($self) = @_;
    if($self->{"now"}) {
        $self->{'value'} = $self->now();
        return({"success" => "value will be set to now()"});
    }
    # check whether the string looks like a date in the format we're using

    #return a warning if we normalized the date

}#end validate

sub set_value
{
    my ($self,$value) = @_;
    
    $self->{'value'} = $value;

    #return a warning if we normailized the date

}#end set_value

#
# normalize
# converts various formats of dates/timestamps to the standard form
# %Y-%m-%d %H-%M-%S
# 2011-06-23 17:57:48
#
sub normalize
{
    #see if we have mm/dd/yyyy

    #see if we have mm/dd/yyyy hh/mm

    #see if we have mm/dd/yyyy 
    #etc...
}#end normalize

#
# now
# returns the current time formated acording to $self->{'format'}
#
sub now
{
    my ($self) = @_;
    return POSIX::strftime($self->{'format'}, localtime);
}#end now
1;

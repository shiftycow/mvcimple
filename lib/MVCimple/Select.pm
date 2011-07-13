#!/usr/bin/perl
use strict;
package MVCimple::Select;
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

=pod
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

    ##For this we can take our list either from a establishd model or passed in the constructor
    $self->{'list'} = $model->{'list'};
    $self->{'list_model'} = $model->{'list_model'};


    #Change the parent depending on the datatype
    our @ISA = ("MVCimple::$self->{datatype}");
    bless $self;
    return $self;
}#end constructor


#Manually set the list 
sub set_list {
    my ($self,$list) = @_;
    $self->{list} = $list;

}


# to_input
# returns: HTML code representing an <input> element for a String object
#
sub to_input
{
    my ($self,$name_prefix) = @_;

    $name_prefix .= '_' if($name_prefix);
    my $html = "";
    my $name = $name_prefix . $self->{"name"};
    my $id = $name."_input";

    #If a models is beign used we need to pull the data from the model
    #TODO: Need the code to read from the give model

    $html .= "<select name=\"$name\" id=\"$id\">\n";

    my $k;
    foreach $k (sort keys %{$self->{'list'}}) 
    {
        my $value = $self->{$k};
        $html .= "<option value=\"$value\">$k</option>\n";

    }
    $html .= "</select>\n";
    return $html;
}


1;


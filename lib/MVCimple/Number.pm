#!/usr/bin/perl
use strict;
package MVCimple::Number;
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
# returns: blessed reference to a new Number object
sub new
{
    my ($class,$name,$model) = @_;

    my $self = {"name" => $name};
    
    #Number defaults;
    $self->{'scale'} = 0;
    $self->{'precision'} = 32;
    $self->{'length'} = 8;
    
    $self->{'precision'} = $model->{'precision'} if($model->{'precision'} ne undef);
    $self->{'scale'} = $model->{'scale'} if($model->{'scale'} ne undef);
    $self->{'auto_increment'} = $model->{'auto_increment'} if($model->{'auto_increment'} ne undef);
    $self->{'value'} = $model->{'value'} if($model->{'value'} ne undef);
    $self->{'null'} = $model->{'null'};    
    $self->{'fk_model'} = $model->{'fk_model'};

    bless $self;
    return $self;
}#end constructor

#
#set_value($value)
#
#
sub set_value {
    my ($self,$value) = @_;
    $self->{'value'} = $value;
}


#
#get_value()
#returns: the value of the object
#
sub get_value {

    my ($self) = @_;
    return $self->{'value'};
}


#
# to_sql()
# returns: string of SQL required to create such a Number object in a database
#
sub to_sql
{
    my ($self) = @_;
    return $self->{"name"}." numeric($self->{precision},$self->{scale})";
}#end to_sql

# 
# validate
# returns: A hash containing a success or error message depending on whether the 
# argument is a valid Number or not
#
sub validate
{
    my ($self) = @_;
   
    if($self->{'auto_increment'} and $self->{'value'} eq "") {
        return {"success"=>"auto incremented by db"};
    }

    if(!$self->{'null'} and $self->{'value'} eq ""){
        return {"error"=>$self->{"name"} . " cannot be NULL."};
    } 
    elsif(($self->{value} ne "") and ($self->{value} * 1) ne $self->{value}){ 
        return {"error"=>"$self->{name} is not a valid number"};
    } 

        return {"success"=>"The number is valid"};
}#end validate

# 
# to_input
# returns: HTML code representing an <input> element for a Number object
#
sub to_input
{
    my ($self,$name_prefix,$value) = @_;
    
    $name_prefix .= '_' if($name_prefix);

    my $html = "";
    my $name = $name_prefix . $self->{"name"};
    my $id = $name."_input";
    my $length = $self->{"length"};

    $html .= "<input type=\"text\"";
    $html .= " id=\"$id\"";
    $html .= " name=\"$name\"";
    $html .= " onkeyup=\"check_name($id,$length)\"";
    $html .= " value=\"$value\"" if $value ne undef; 
    $html .= " maxlength=\"$length\"";
    $html .= " />\n";

    #if we have an error flag set, we should put a little flag next to out input
    $html .= "<span class=\"mvcimple-error-flag\">*</span>" if($self->{'error'}); 

    return $html;
}#end input


1;


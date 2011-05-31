#!/usr/bin/perl
use strict;
package MVCimple::String;

=pod

=cut

#
# constructor
# returns: blessed reference to a new String object
sub new
{
    my ($class,$name,$model) = @_;

    my $self = {"length" => $model->{length},
                "name" => $name};
    bless $self;
    return $self;
}#end constructor

#
# to_sql($length)
# returns: string of SQL required to create such a String object in a database
#
sub to_sql
{
    my ($self) = @_;
    return $self->{"name"}." varchar(".$self->{"length"}.")";
}#end to_sql

# 
# validate
# returns: 1 or 0 depending on whether the argument is a valid String or not
#
sub validate
{
    my ($self,$string) = @_;
    
    #check length
    return (length $string > $self->{"length"});
}#end validate

# 
# to_input
# returns: HTML code representing an <input> element for a String object
#
sub to_input
{
    my ($self) = @_;

    my $html = "";
    my $name = $self->{"name"};
    my $id = $name."_input";
    my $length = $self->{"length"};

    $html .= "<input type=\"text\"";
    $html .= " id=\"$id\"";
    $html .= " name=\"$name\"";
    $html .= " onkeyup=\"check_name($id,$length)\"";
    $html .= " maxlength=\"$length\"";
    $html .= " />\n";
   
    return $html;
}#end input

#
# normalize
# returns: normalized version of the string
# 

1;


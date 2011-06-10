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
                "name" => $name,
                "value" => $model->{value},
                "null"=> $model->{null}};
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
    my ($self) = @_;
    my $return = {};
    
    if(($self->{'null'}==1 && !$self->{'value'}) || (length $self->{'value'} <= $self->{"length"} && $self->{'value'})){
        $return = {"success" => "This is a valid string"};
        return $return;
    }
    elsif($self->{'null'} != 1 && !$self->{'value'}){
        $return = {"error"=>"The number value cannot be NULL."};
        return $return;
    }
    else{
        $return = {"error"=>"This is not a valid string."};
        return $return;
    }
   
    #check length
    #return (length $self->{'value'} <= $self->{"length"});
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


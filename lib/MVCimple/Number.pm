#!/usr/bin/perl
use strict;
package MVCimple::Number;

=pod

=cut

#
# constructor
# returns: blessed reference to a new String object
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
    $self->{'length'} = $model->{'length'} if($model->{'length'} ne undef);
   
    bless $self;
    return $self;
}#end constructor

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
# returns: 1 or 0 depending on whether the argument is a valid Number or not
#
sub validate
{
    my ($self,$number) = @_;
    return 1 if(($number * 1) eq $number);
    return 0;   
    
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


1;


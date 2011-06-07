#!/usr/bin/perl
use strict;
package MVCimple::BaseModel;

#system includes 
use Data::Dumper;
use DBI;

#local includes
use lib "../lib"
use MVCimple::Config;

#This is the base model for any model Class


sub new {
   my ($class,$name,$modeldata) = @_;
   my $self = {'name' => $name};
   $self->{'columns'} = {}; 
 
   #Go though each of the model elements and bless along with returning the constructor; 
   while( my($column_name,$modelcolumn) = each(%{$modeldata})) 
    {
        $self->{'columns'}->{$column_name} = {};
        bless $self->{'columns'}->{$column_name},"MVCimple::$modelcolumn->{type}";
        $self->{'columns'}->{$column_name} = $self->{'columns'}->{$column_name}->new($column_name,$modelcolumn);   
    }
    bless $self;
    return $self;
}



sub get_column {
    my($self,$column_name) = @_;
    return $self->{columns}->{$column_name};
}

#This will return all the forms from a model that can easily be used with our template engine
sub get_forms {
 
    my ($self) = @_; 
    my $forms = {};
    my $modelname = $self->{'name'};

    while( my($name,$column_data) = each(%{$self->{columns}})) {

        #We should probably check that we have the method for the type
        $forms->{"$modelname\_$name\_form"} = $column_data->to_input(); 

    }
    return $forms;
}

#Store the values submitted for each column from CGI
sub store_input{
	my ($self,$co) = @_;
    my $modelname = $self->{'name'};
	
    while( my($name,$column_data) = each(%{$self->{columns}})) {
            $column_data->set_value($co->param($name)); 
    }
}

#
#Return a hash with all the columns and values;
#
sub get_values {
    my ($self,$co) = @_;

    my $data = {};
    while( my($name,$column_data) = each(%{$self->{columns}})) {
        $data->{$name} = $column_data->get_value();
    }
    return $data;
}

#
#
#
#
sub save {
    my ($self) = @_;
    my $dbhost = MVCimple::Config::get_config_element('dbhost');    
    my $dbpassword = MVCimple::Config::get_config_element('dbpassword');    
    my $dbsuser = MVCimple::Config::get_config_element('dbuser');    
    my $database = MVCimple::Config::get_config_element('database');    
}

1;




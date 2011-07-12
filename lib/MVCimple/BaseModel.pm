#!/usr/bin/perl
use strict;
package MVCimple::BaseModel;
#
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
#

#system includes 
use Data::Dumper;
use DBI;

#local includes
use lib "../";

use MVCimple::Types; #use all the datatypes

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
}#end new (constructor)

sub get_column {
    my($self,$column_name) = @_;
    return $self->{columns}->{$column_name};
}#end get_column

#This will return all the forms from a model that can easily be used with our template engine
sub get_forms {
 
    my ($self) = @_; 
    my $forms = {};
    my $modelname = $self->{'name'};

    while( my($name,$column_data) = each(%{$self->{columns}})) {

        #We should probably check that we have the method for the type
        $forms->{"$modelname\_$name\_form"} = $column_data->to_input($modelname); 

    }
    return $forms;
}#end get_forms

#Store the values submitted for each column from CGI
sub store_input{
	my ($self,$co) = @_;
    my $modelname = $self->{'name'};
	
    while( my($name,$column_data) = each(%{$self->{columns}})) {
            $column_data->set_value($co->param($modelname .'_'. $name)); 
    }
}#end store_input

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
}#end get_values


#validate all the elements in the model and return all the errors concatenated
sub validate {
    my ($self) = @_;
    my $return = {};
    my $error_messages;;
    my $error;

    while( my($name,$column_data) = each(%{$self->{columns}})) {
        if($column_data->validate()->{'error'} ne undef) {
            $error =1;
            $error_messages .= $column_data->validate()->{'error'} . " ";    
        }
    }
    return {"error"=>"$error_messages"} if($error);    
}#end validate


#
# The save subroutine is responsible for generating, preparing, and executing our sql INSERT # operation. All data is validated before it is inserted into the database.
# 
# returns: A hash of column names and their success or error messages
sub save {
    my ($self,$dbh) = @_;
    my $return = {};

    #Validate
    my $validate = validate($self);
    return $validate if($validate->{error});


    # Strip out extraneous auto_increment field from our sql statement.
    while( my($name,$column_data) = each(%{$self->{columns}})) {
      delete $self->{columns}->{$name}if($column_data->{'auto_increment'});
    }



    #print Dumper($return); #DEBUG 
    #print " \$error = " . $error; #DEBUG


    #my $table_prefix = MVCimple::Config::get_config_element('table_prefix');

    my $modelname = $self->{'name'};

    my $sql = "";
    #TODO Insert logic for UPDATE table
    $sql .= "INSERT INTO $modelname (";
    my $i = 0; #counter used for putting in commas
    my $columns = scalar (keys %{$self->{columns}}); # Figure out how many columns there are

    my $row_key;
    #Add column names to sql statement
    while( my($name,$column_data) = each(%{$self->{columns}})) {
        #$data->{$name} = $column_data->get_value();
      if(!$column_data->{'auto_increment'}){
        $sql .= "$name";
        $sql .= "," if ($i < $columns - 1 );
        $row_key = $name if($column_data->{'primary_key'});
        $i++;
    }   
    }  


    $sql .= ") VALUES (";

    #Add ? to sql statement
    $i = 0; 
    while( my($name,$column_data) = each(%{$self->{columns}})) {
        $sql .= "?";
        #$sql .= $column_data->get_value();
        $sql .= "," if ($i < $columns - 1);
        $i++;
    }
    $sql .= ")";
    #print $sql; #DEBUG

    my $sth = $dbh->prepare($sql)
        or return {"error" => "Can't prepare SQL statement: $DBI::errstr\n"};
    #TODO return proper error

    my @data = ();    
    while( my($name,$column_data) = each(%{$self->{columns}})) {
        push @data, $column_data->get_value();
    }
#    print "@data"; #DEBUG

    $sth->execute(@data)
        or return {"error" => "Can't execute SQL statement: $DBI::errstr\n"};
    
    #get the ID of the row we just inserted. This is really only useful on
    #auto-increment columns
    #TODO: support Oracle here (with SCHEMA)
    my $row_id = $dbh->last_insert_id(undef, undef, $modelname, $row_key);

    $dbh->commit();
    $sth->finish();
    
    return {'row_id' => $row_id};
} #end save

#Return All data from the database for the model
sub load {
    my ($self,$dbh) = @_;

    my $modelname = $self->{'name'};

    my $sql = "SELECT * FROM $modelname;";
    my $sth = $dbh->prepare($sql)
        or return {"error" => "load() can't prepare query: $DBI::errstr\n"};

    $sth->execute()
        or return {"error" => "Can't execute SQL statement: $DBI::errstr\n"};
    
    my $rows = [];
    my $i = 0;
    my $row;
    while ($row = $sth->fetchrow_hashref())
    {   
        $rows->[$i] = $row;
        $i++;
    }
    $sth->finish();
    return {"data" => $rows};
}#end load

1;




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

use MVCimple::Types; #use all datatypes

#This is the base model for any model Class


sub new {
    my ($class,$params) = @_;

    my $name = $params->{'object_name'};
    my $model_name = $params->{'model'};
    my $models = $params->{'models'};

    my $model = $models->{$model_name};
   
    #print Dumper($model); #DEBUG

    my $self = {};
    $self->{'name'} = $name;
    $self->{'columns'} = {};
    
    #Go though each of the model elements and bless along with returning the constructor; 
    while( my($column_name,$modelcolumn) = each(%{$model})) 
    {
        # mirror the attirbutes of a foreign key column, if applicable
        my $FOREIGN_KEY = lc $modelcolumn->{"foreign_key"};

        #print "fk: $FOREIGN_KEY\n"; #DEBUG
        if($FOREIGN_KEY)
        {
            my($fk_model,$fk_column) = split(/\./,$FOREIGN_KEY);
            $modelcolumn = $models->{$fk_model}->{$fk_column};
            
            $modelcolumn->{'fk_model'} = $fk_model; #remember that this column was an FK constraint
            $modelcolumn->{'fk_column'} = $fk_column; #remember that this column was an FK constraint
            #print Dumper($modelcolumn); #DEBUG
        }
        
        $self->{'columns'}->{$column_name} = {};

        bless $self->{'columns'}->{$column_name},"MVCimple::$modelcolumn->{type}";
        $self->{'columns'}->{$column_name} = $self->{'columns'}->{$column_name}->new($column_name,$modelcolumn);   
    }#end model blessing

    bless $self;
    return $self;
}#end new (constructor)

sub get_column {
    my($self,$column_name) = @_;
    return $self->{columns}->{$column_name};
}#end get_column

#This will return all the forms from a model that can easily be used with our template engine
sub get_forms {
 
    my ($self,$params) = @_; 
    my $forms = {};
    my $modelname = $self->{'name'};
    
    while( my($name,$column_data) = each(%{$self->{columns}})) {
        
        my $input_html;
        #print "foo\n";

        #if our column is a foreign key, we need to make a special widget
        #print Dumper($column_data); #DEBUG
        if($column_data->{'fk_model'})
        {
            #print "foo\n"; #DEBUG
            #create a temporary object used to load the data
            my $Obj = new MVCimple::BaseModel({object_name=> $column_data->{'fk_model'}, model => $column_data->{'fk_model'}, models => $params->{'models'}});
            
            #print Dumper($Obj); #DEBUG

            my $Select = new MVCimple::Select();
            #print Dumper($Obj->load($params->{'dbh'})); #DEBUG
            $Select->set_list($Obj->load($params->{'dbh'})->{'data'});
            $input_html = $Select->to_input($modelname);
            #print "input: $input_html\n"; #DEBUG
        }
        
        else
        {
            #We should probably check that we have the method for the type
            $input_html = $column_data->to_input($modelname,$column_data->get_value()); 
        }

        $forms->{"$modelname\_$name\_form"} = $input_html;
    }
    
    #print Dumper($forms); #DEBUG
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


#validate all the elements in the model and return the errors in a hash
sub validate {
    my ($self) = @_;
    my $error_messages = {};
    my $error;

    while( my($name,$column_data) = each(%{$self->{columns}})) {
        if($column_data->validate()->{'error'} ne undef) {
            $error = 1;
            $error_messages->{$name}  = $column_data->validate()->{'error'};
            $column_data->{'error'} = $column_data->validate()->{'error'};
            
            #empty the element so that it doesn't persist in forms or sneak
            #into a save() by accident
            $column_data->set_value();
        }
        #if the data is OK, clear any errors previously set
        else{
            delete $column_data->{'error'};
        }
    }
    return {"error" => $error_messages} if($error);
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

#Return data from the database for the model
sub load {
    my ($self,$dbh,$params,$order_by) = @_;

    my $modelname = $self->{'name'};

    my $sql = "SELECT * FROM $modelname";

    #add search parameters
    my @params;
    if($params ne undef)
    {
        my $param_index = 0;
        $sql .= " WHERE ";
        while (my ($key, $value) = each %$params)
        {
            $sql .= " AND " if $param_index > 0;
            $sql .= " $key = ?";
            
            push @params, $value;
            $param_index++;
        }
    }
    #Append an order by clause if the user specified a base model column to sort by.
    $sql .= " ORDER BY $order_by " if($order_by ne undef);


    #not sure if this is really needed
    $sql .= ";";

    my $sth = $dbh->prepare($sql)
        or return {"error" => "load() can't prepare query: $DBI::errstr\n"};

    $sth->execute(@params)
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




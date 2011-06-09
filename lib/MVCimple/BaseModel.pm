#!/usr/bin/perl
use strict;
package MVCimple::BaseModel;

#system includes 
use Data::Dumper;
use DBI;

#local includes
use lib "../lib";
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
# The save subroutine is responsible for generating, preparing, and executing our sql INSERT # operation. All data is validated before it is inserted into the database.
# 
# returns: A hash of column names and their success or error messages
sub save {
    my ($self,$dbh) = @_;
    my $return = {};
    my $error = 0;
    
    # Validate all data
    while( my($name,$column_data) = each(%{$self->{columns}})) {
        $return->{$name} = $column_data->validate();
        $error = 1 if($return->{$name}->{'error'} ne undef);
    }
    
    print Dumper($return); #DEBUG 
    print " \$error = " . $error; #DEBUG
 

    if(!$error){ 
        my $table_prefix = MVCimple::Config::get_config_element('table_prefix');

        my $modelname = $self->{'name'};

        my $sql = "";
        #TODO Insert logic for UPDATE table
        $sql .= "INSERT INTO $modelname (";
        my $i = 0; #counter used for putting in commas
        my $columns = scalar (keys %{$self->{columns}}); # Figure out how many columns there are

        #Add column names to sql statement
        while( my($name,$column_data) = each(%{$self->{columns}})) {
            #$data->{$name} = $column_data->get_value();
            $sql .= "`$name`";
            $sql .= "," if ($i < $columns - 1);
            $i++;
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
#    print $sql; #DEBUG

        my $sth = $dbh->prepare($sql)
            or die "Can't prepare SQL statement: $DBI::errstr\n";
        #TODO return proper error

        my @data = ();    
        while( my($name,$column_data) = each(%{$self->{columns}})) {
            push @data, $column_data->get_value();
        }
#    print "@data"; #DEBUG

        $sth->execute(@data)
            or die "Can't execute SQL statement: $DBI::errstr\n";
        $dbh->commit();
}
##retrieve the returned rows of data
#    my @row;
#   while (@row = $sth->fetchrow_array()){
#        print "Row: @row\n"
#    }
        
        return $return;

    } #end save


1;




#!/usr/bin/perl
use strict;
package MVCimple::GenSQL;
use Data::Dumper;
#include the built-in type libraries
use lib "../";
use MVCimple::Types;
use MVCimple::Config;

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
GenSQL.pm


 This library provides functions for generating database code for 
 MVCimple models. Currently, it only supports MySQL with InnoDB

=cut

=item generate_sql()
 This function takes a hash of models and generates the necessary 
 SQL code to build a new database based on it.
=cut
sub generate_sql
{
    my ($models,$config) = @_;
    my $sql;

    $config = new MVCimple::Config() if($config eq undef);
    my $dbdriver = $config->element('dbdriver');

    $sql.= "-- MVCimple SQL Generator --\n"; 
    foreach my $model_name (keys %$models)
    {
        $sql .= "-- Generating SQL for \"$model_name\" table --\n";

        $sql .= "DROP TABLE IF EXISTS \"$model_name\";\n";
        $sql .= "CREATE TABLE \"$model_name\"(\n";
        
        my $model = $models->{$model_name};
        my $i = 0; #counter for figuring out where to put line separators (,\n)
DEBUG: foreach my $column (keys %$model)
        {
            #next DEBUG;
            my $modelcolumn = $model->{$column};
            
            my $AUTO_INCREMENT = lc $model->{$column}->{"auto_increment"};

            #check for database constraints
            my $PRIMARY_KEY = lc $model->{$column}->{"primary_key"};
            my $FOREIGN_KEY = lc $model->{$column}->{"foreign_key"};
            my $UNIQUE = lc $model->{$column}->{"unique"};
            
            #retrieve type info from foreign key
            my $fk_model;
            my $fk_column;
            if($FOREIGN_KEY)
            {
                ($fk_model,$fk_column) = split(/\./,$FOREIGN_KEY);
                $modelcolumn = $models->{$fk_model}->{$fk_column};
            }
            
            #create an object representing the data model to use
            my $data_model = {};
            
            #TODO check available types
            bless $data_model,"MVCimple::$modelcolumn->{type}";
            #print Dumper($data_model); DEBUG
            my $object = $data_model->new($column,$modelcolumn);
            
            #Check if we need to generate auto incrementing for psql
            if($AUTO_INCREMENT and $dbdriver eq "Pg"){
                $sql .= $object->{"name"} . " SERIAL";
            }
            else{
                $sql .= $object->to_sql();
            }
            #output database constraints if specified
            $sql .= " PRIMARY KEY" if($PRIMARY_KEY);
            $sql .= ",\n    FOREIGN KEY (\"$column\") REFERENCES $fk_model(\"$fk_column\")" if($FOREIGN_KEY);
            
            #separate the columns, unless we're at the last one
            $sql .= ",\n" if($i lt (keys %$model) - 1);

            $i = $i + 1;
        }#end foreach column
        
        #I am pulling this out for now so I can pipe the output into SQLlite for testing
        #in the future we should be able to know what type of DB we are using.
        #print "\n)ENGINE = InnoDB;\n\n";
        $sql .= "\n);\n\n";
    }#end model loop

    return $sql;
}#end generate sql

1;

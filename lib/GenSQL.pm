#!/usr/bin/perl
use strict;
package GenSQL;
=pod
GenSQL.pm


 This library provides functions for generating database code for 
 MVCimple models. Currently, it only supports MySQL with InnoDB

=cut

#include the built-in type libraries
use Types;

=item generate_sql()
 This function takes a hash of models and generates the necessary 
 SQL code to build a new database based on it.
=cut
sub generate_sql
{
    my ($models,$method,$db) = @_;
    
    print "-- MVCimple SQL Generator --\n"; 
    foreach my $model_name (keys %$models)
    {
        print "-- Generating SQL for `$model_name` table --\n";

        print "DROP TABLE IF EXISTS `$model_name`;\n";
        print "CREATE TABLE `$model_name`(\n";
        
        my $model = $models->{$model_name};
        my $i = 0; #counter for figuring out where to put line separators (,\n)
DEBUG: foreach my $column (keys %$model)
        {
            #next DEBUG;
            my $type = lc $model->{$column}->{"type"};
            my $length = lc $model->{$column}->{"length"};
            
            #check for database constraints
            my $PRIMARY_KEY = lc $model->{$column}->{"PRIMARY_KEY"};
            my $FOREIGN_KEY = lc $model->{$column}->{"FOREIGN_KEY"};
            my $UNIQUE = lc $model -> {$column}->{"UNIQUE"};
            
            #retrieve type info from foreign key
            my $fk_model;
            my $fk_column;
            if($FOREIGN_KEY)
            {
                ($fk_model,$fk_column) = split(/\./,$FOREIGN_KEY);
                $type = lc $models->{$fk_model}->{$fk_column}->{"type"};
                $length = lc $models->{$fk_model}->{$fk_column}->{"length"};
            }
            
            print "    $column";
            
            #define data type
            #TODO: use Type objects for this
            print " varchar($length)" if $type eq "string";
            print " int($length)" if $type eq "number";            

            #output database constraints if specified
            print " PRIMARY KEY" if($PRIMARY_KEY);
            print ",\n    FOREIGN_KEY (`$column`) REFERENCES $fk_model(`$fk_column`)" if($FOREIGN_KEY);
            
            #separate the columns, unless we're at the last one
            print ",\n" if($i lt (keys %$model) - 1);

            $i = $i + 1;
        }#end foreach column

        print "\n)ENGINE = InnoDB;\n\n";
    }#end model loop
}#end generate sql


1;

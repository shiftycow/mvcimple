#!/usr/bin/perl
use strict;
package GenSQL;
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
            my $PRIMARY_KEY = lc $model->{$column}->{"PRIMARY_KEY"};
            my $FOREIGN_KEY = lc $model->{$column}->{"FOREIGN_KEY"};
            my $fk_model;
            my $fk_column;

            #retrieve type info from foreign key
            if($FOREIGN_KEY)
            {
                ($fk_model,$fk_column) = split(/\./,$FOREIGN_KEY);
                $type = lc $models->{$fk_model}->{$fk_column}->{"type"};
                $length = lc $models->{$fk_model}->{$fk_column}->{"length"};
            }
            
            print "    $column";
            print " varchar($length)" if $type eq "string";
            print " int($length)" if $type eq "number";
            
            print " PRIMARY KEY" if($PRIMARY_KEY);

            #output an FK contstraint if necessary
            print ",\nFOREIGN_KEY ($column) REFERENCES $fk_model($fk_column)" if($FOREIGN_KEY);
            
            #separate the columns, unless we're at the last one
            print ",\n" if($i lt (keys %$model)); 
            $i = $i + 1;
        }#end foreach column

        print ")ENGINE = InnoDB;\n\n";
    }#end model loop
}#end generate sql


1;

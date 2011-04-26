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
    
    foreach my $model_name keys($models)
    {
        print "-- Generating SQL for '$model_name' table --\n";

        print "DROP TABLE IF EXISTS $model_name\n";
        print "CREATE TABLE $model_name(\n";
        
        foreach my $column = keys ($models->{$model_name})
        {
            print "$column\n";
        }
        print ")ENGINE = InnoDB\n";
    }#end model loop
}#end generate sql

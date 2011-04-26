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
    
    foreach($models)
    {
        my $model = $_;
        print "-- Generating SQL for '$model' table --\n";

        print "DROP TABLE IF EXISTS $model\n";
        print "CREATE TABLE $model(\n";
        
        print ")ENGINE = InnoDB\n";
    }#end model loop
}#end generate sql

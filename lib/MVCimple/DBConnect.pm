#! /usr/bin/perl
use strict;
package MVCimple::DBConnect;

#system includes 
use DBI;

#local includes
use lib "../lib";
use MVCimple::Config;

   
   
   
sub connect{
    my $dbhost = MVCimple::Config::get_config_element('dbhost');    
    my $dbpassword = MVCimple::Config::get_config_element('dbpassword');    
    my $dbuser = MVCimple::Config::get_config_element('dbuser');    
    my $dbname = MVCimple::Config::get_config_element('dbname');    
    my $dbport = MVCimple::Config::get_config_element('dbport');
    my $table_prefix = MVCimple::Config::get_config_element('table_prefix');
    my $driver = MVCimple::Config::get_config_element('driver');

    my $dbh = DBI->connect("dbi:$driver:$dbname:$dbhost:$dbport",$dbuser,$dbpassword);
    #TODO Handle error

    return $dbh;

}

1;

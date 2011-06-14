#! /usr/bin/perl
use strict;
package MVCimple::DBConnect;
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
###############################################################################

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

    #print $dbhost; #DEBUG
    #print $dbpassword; #DEBUG
    #print $dbname; #DEBUG

    my $dbh = DBI->connect("dbi:$driver:$dbname",$dbuser,$dbpassword)
        or die "Can't connect to the database: $DBI::errstr\n";
    #TODO Handle error

    return $dbh;

}

1;

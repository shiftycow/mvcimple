#! /usr/bin/perl
package MVCimple::Config;
use strict;
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


#
# Config.pm
#
# This script reads the configuration file and provides an interface for acessing 
# its data
#
# Config files can include others using the syntax
# 
# something = include something.conf
# 
# In this case, the contents of something.conf will be read, comma-separated
# by line, and returned when the "something" element is references.
# 
# This feature is most useful when including long lists of things to be used 
# in drop-down menus and the like
#
###############################################################################


##################################
###    USER DEFAULTS          ###
##################################
my $FILENAME = "app_config.conf"; #name of the config file, usually no need to change
my $FOLDER = "../conf/"; #This is a realative path from the .cgi file ran
##############################################
### DO NOT CHANGE ANYTHING BELOW THIS LINE ###
##############################################
#system includes
use File::Spec;


    
sub new {
    
    my ($class,$filename,$path) = @_;
    my $self = {};
    
    #This script could be called from cron, so we need to find it's 
    #path to make it portable
    my $self->{app_path} = File::Spec->rel2abs($0);
    (undef, $self->{app_path}, undef) = File::Spec->splitpath($self->{app_path});

    #We will use the defaults in this file if nothing is specified
    $self->{config_path} = "$self->{app_path}$FOLDER";
    $self->{config_file} = $FILENAME;

    $self->{config_file} = $filename if($filename);
    $self->{config_path} = $path if($path);

    #Read the config file
    $self->{config} = read_config($self);
    #testing function
    #print %config;

    bless $self;
    return $self;
}#end new (constructor)

sub element
{
    # this function returns an element of the configuration hash
    my ($self,$key) = @_;

    #if the key references another file, fetch that file and parse it
    my $included_config;
    if($self->{config}->{$key} =~ /include (.+\.conf)/)
    {
        open(INCLUDE,"<$self->{config_path}/$1");
        while(<INCLUDE>)
        {
            chomp $_;
            $included_config .= $_.",";
        }
        close(INCLUDE);
        $self->{config}->{$key} = $included_config;
    }#end external reference
    
    return $self->{config}->{$key};
}#end element

#
# elements
# returns a hashref containing all of the elements in the config file
# -used for itterating over config elements, in particular in AutoTest.pm
#
sub elements
{
    my ($self) = @_;

    return $self->{'config'};
}#end elements

#
# remove
# removes the specified key from the config hash
# -used to remove key we don't want returned when calling elements() later
#
sub remove
{
    my ($self,$key) = @_;
    delete $self->{'config'}->{$key}
}#end remove

#
# set
# sets an element in the config file
#
sub set
{
    my ($self,$key,$value) = @_;
    $self->{'config'}->{$key} = $value;
}#end set

#
# read config
# returns a hash representing the key/value pairs in the 
# application's configuration file
#

sub read_config {
    
    my ($self) = @_;
    my $config = {}; #hash to hold config parameters

    #define the config file name
    my $DISK_CONFIG_FILE = "$self->{config_path}/$self->{config_file}";

    open(CONFIG, "<$DISK_CONFIG_FILE");
    while (<CONFIG>) {
       # chomp;                  # no newline
        s/#.*//;                # no comments
        s/^\s+//;               # no leading white
        s/\s+$//;               # no trailing white
        next unless length;     # anything left?
        my ($var, $value) = split(/\s*=\s*/, $_, 2);
        $config->{$var} = $value;
    }
    close CONFIG;
    return $config;
}

1;

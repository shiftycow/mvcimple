#! /usr/bin/perl
package MVCimple::Config;
use strict;
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
###    USER DEFINES            ###
##################################
my $FILENAME = "app_config.conf"; #name of the config file, usually no need to change

##############################################
### DO NOT CHANGE ANYTHING BELOW THIS LINE ###
##############################################

#system includes
use File::Spec;

#local includes
# section empty #

#This script could be called from cron, so we need to find it's 
#path to make it portable
my $APP_PATH = File::Spec->rel2abs($0);
(undef, $APP_PATH, undef) = File::Spec->splitpath($APP_PATH);

#Read the config file
my %config = read_config();

#testing function
#print %config;

sub get_config_element
{
    # this function returns an element of the configuration hash
    my ($key) = @_;

    #if the key references another file, fetch that file and parse it
    my $included_config;
    if($config{$key} =~ /include (.+\.conf)/)
    {
        open(INCLUDE,"<$APP_PATH/../lib/MVCimple/$1");
        while(<INCLUDE>)
        {
            chomp $_;
            $included_config .= $_.",";
        }
        close(INCLUDE);
        $config{$key} = $included_config;
    }#end external reference
    
    return $config{$key};
}#end return_config_element

#
# read config
# returns a hash representing the key/value pairs in the 
# application's configuration file
#

sub read_config {
    my %config; #hash to hold config parameters

    #define the config file name
    my $DISK_CONFIG_FILE = "$APP_PATH/../conf/$FILENAME";

    open(CONFIG, "<$DISK_CONFIG_FILE");
    while (<CONFIG>) {
       # chomp;                  # no newline
        s/#.*//;                # no comments
        s/^\s+//;               # no leading white
        s/\s+$//;               # no trailing white
        next unless length;     # anything left?
        my ($var, $value) = split(/\s*=\s*/, $_, 2);
        $config{$var} = $value;
    }
    close CONFIG;
    return %config;
}

1;

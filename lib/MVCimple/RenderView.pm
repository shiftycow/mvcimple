#!/usr/bin/perl
use strict;
package MVCimple::RenderView;
#Package that will read in the html view and intropolate it with data from a perl hash
#returning the rendered view. Support will also be addeded to render tabular data as well
#as include other static views for branding


#my $myvars = {myvar => "Evan",myvar1 => "Sala`-zar",myvar2 => "Testing",myvar3 => "Blarg", myvar4 => "Foo"};
#print render("test.html",$myvars);


sub render {
    
    my ($file,$vars) = @_;
    my ($line,$output); 
    open(FH,$file);

    #Go line by line to increae performance 
    while($line = <FH>) {

        #look for each occurrence of tag
        while($line =~ /<!--p\s*\$([A-z0-9]+)\s*-->/g)
        {
            #print "$& $1\n";
            #replace tag with the vairable
            $line =~ s//$vars->{$1}/g
        } #end regex while
    
        #save the output
        $output .= $line;
    } #end read while

    close(FH);
    return $output;
} #end render


#!/usr/bin/perl
#Code to generate web application 
#
# test comment
#
#This will be read by there one files eventually, perhaps even XML
$MODLES = { "ticket" => { 
            firstName => {type => "name" },
            lastName  => {type => "name" } }, 
                
            "user" => {
            username => {type => "name" },
            password  => {type => "password" } }  
          };

#This is the list of the default controllers, more can be added
$CONTROLLERS = {"add"=>'',"delete"=>''}; 



#This is the header for the CGI file, should also be in a custom file
my $APPHEADER =<<EOF;
#!/usr/bin/perl
use strict;
use CGI;

#Add user defined libreries

my \$co = new CGI;

my \$controller = \$co->param("controller");
main() if(\$controller eq undef);
EOF

#Start of the generator
main();

sub main {

print $APPHEADER;
print generate_controllers();

exit();
}


sub generate_controllers {

    #for each models generate controller methods 
    
    my $actions;
    #Add the default main sub
    my $subs = "sub main {\nexit();\n}\n";

    #Read in the modles and controllers
    while(($model,$values) = each(%$MODLES)) {
        while(($controller) = each(%$CONTROLLERS)) {
            $controller = ucfirst($controller);
            #Genenerate the action code
            $actions .=  "$model$controller() = if(\$controller eq \"$model$controller\")\n";       
            
            #Create the controller subroutines and fill in any needed code
            my $controllersub = get_controller_sub($controller,$model,$values);
            $subs .= "\nsub $model$controller {\n\n$controllersub\nexit();\n}\n";
        } 
   }

    #return the actions followed by the subs
    return "$actions\n$subs";
}


sub get_controller_sub {

    my ($controller,$model,$values) = @_;


    my $s;


    while(($value) = each(%$values)) {
        $s .= "    my \$model->$value = \$co->param(\"$value\");\n";        
    }

    $s .=   "    generateView('$model',\$model,'$controller');\n";


    #The plan is to the read in the predefined controllers from a file 

    return $s;
}




sub generate_views {



}



/* hello_world.js
*
*  Javascript functions for a basic MVCimple/Mojolicious Lite application
*
*******************************************************************************/

/* specify the required XSLT stylesheets */
//mvcimple_error.xsl and mvcimple_message.xsl should always be in the list
xslt_sheets = ["mvimcple_error.xsl","mvcimple_message_xsl","add_greeting.xsl"];

/*
* function to initialize the page. At minimum this should download the xslt
* resources
*/
function init()
{
    mvcimple_download_xslt(xslt_sheets);
}//end init


/*
* add a greeting
*/
function add_greeting()
{
    var form_data = $("#add_greeting_form").serialize();
    alert("adding greeting: "+form_data);
    
    //start up the waiting graphic
    mvcimple_wating_spinner("result");
    
    //send the form data to the server
    $.get("add",form_data,function(data)
                            {
                                //show any errors we received
                                mvcimple_show_data(data,"mvcimple_error.xsl","#add_greeting_result");
                                
                                //if we got any errors, stop here
                                if($("#add_greeting_result > .error").exists())
                                    return;

                                //show any messages we received
                                mvcimple_show_data(data,"mvcimple_message.xsl","#add_greeting_result");
                                 
                                //add another <li> into which we can put the new greeting
                                mvcimple_show_data(data,"add_greeting.xsl");
                            }
}//end add_greeting

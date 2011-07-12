/* mvcimple.js
*
*
*
*  This script file contains Javascript functions that are used for interactive 
*  MVCimple applications.
*
*  This library relies heavily on jQuery and the jQueryUI
*
******************************************************************************/

/*****************************************/
/**       MVCimple Global Variables     **/
/*****************************************/
var mvcimple_xslt = {};

/* default "waiting spinner" placeholder */
var spinner_html = '<div class="spinner"><img src="images/spinner.gif" alt="Loading..." /></div>';


/*****************************************/
/**    Custom jQuery extensions         **/
/*****************************************/

//test whether an element exists in the DOM tree
$.fn.exists = function(){return $(this).length > 0;}


/*****************************************/
/**         MVCimple functions          **/
/*****************************************/

/* 
* todo: add an mvcimple_init() function that includes a callback to 
* user init?
*/

/*
* mvcimple_download_xslt()
*  Pre-load XSLT stylesheets and cache them in variables so they 
*  don't get requested all the time
*/
function mvcimple_download_xslt(xsl_sheets)
{
    for(i = 0; i < xsl_sheets.length; i++)
    {
        $.get(xsl_sheets[i],null, function(data)
                        {
                            mvcimple_xslt[xsl_sheets[i]] = data;
                        });
    }
}//end mvcimple_download_xslt()

/*
* mvcimple_show_data()
* run XML returned from request through the XSLT processor and insert it
* into the specified block element of the DOM tree
*/
function mvcimple_show_data(data,xsl,div)
{
    $(div).xslt({xml: data, xsl: mvcimple_xslt[xsl]});
}//end mvcimple_show_data




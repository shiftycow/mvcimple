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
* mvcimple_download_xslt()
*  Pre-load XSLT stylesheets and cache them in variables
*/
function mvcimple_download_xslt()
{
    $.get("
}//end mvcimple_download_xslt()

/*
* mvcimple_show_data()
* run XML returned from request through the XSLT processor and insert it
* into the specified block element of the DOM tree
*/
function mvcimple_show_data(data,xsl,div)
{
}//end mvcimple_show_data


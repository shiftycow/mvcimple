<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
                <title>Hello, World!</title>
    
                <!-- links to jQuery scripts and stylesheets -->
                <link type="text/css" href="css/ui-lightness/jquery-ui-1.8.14.custom.css" rel="stylesheet" />
                <script type="text/javascript" src="js/jquery-1.5.1.min.js"></script>
                <script type="text/javascript" src="js/jquery-ui-1.8.14.custom.min.js"></script>
                
                <!-- links to MVCimple scripts and stylesheets -->
                <link type="text/css" href="css/mvcimple.css" rel="stylesheet" />
                <script type="text/javascript" src="js/mvcimple.js"></script>
                
                <!-- links to application-specific scripts and stylesheets -->
                <link type="text/css" href="css/hello_world.css" rel="stylesheet" />
                <script type="text/javascript" src="js/hello_world.js"></script> 
            </head>

            <body>
                <div id="mvcimple-container"><!--container div to keep things centered-->

                <!--output "global" messages and errors, if any-->
                <xsl:if test="count(/opt/message) &gt; 0">
                    <div class="mvcimple-message ui-state-highlight ui-corner-all">
                        <xsl:value-of select="opt/message" disable-output-escaping="yes" />
                    
                    <!--/opt might contain some SQL if we need to generate the database-->
                    <xsl:if test="count(/opt/sql) &gt; 0">
                        <div class="mvcimple-code ui-corner-all"><xsl:value-of select="opt/sql" /></div>
                    </xsl:if>
                    </div><!--end message-->
                </xsl:if>

                <xsl:if test="count(/opt/error) &gt; 0">
                    <div class="mvcimple-error ui-state-error ui-corner-all"><xsl:value-of select="/opt/error" /></div>
                </xsl:if>

                <!--output the header greeting-->
                <h2><xsl:value-of select="/opt/promo_greeting" /></h2>
                <!--end header-->
                <hr />
                            
                <h2>Add a New Greeting</h2>
                <!--output messages and errors, if any-->
                <xsl:if test="count(/opt/forms/message) &gt; 0">
                    <div class="mvcimple-message ui-state-highlight ui-corner-all"><xsl:value-of select="/opt/forms/message" /></div>
                </xsl:if>
                <!-- if we have an error, we shouldn't output the "normal" stuff-->
                <xsl:choose>
                <xsl:when test="count(/opt/forms/error) &gt; 0">
                    <div class="mvcimple-error ui-state-error ui-corner-all"><xsl:value-of select="/opt/forms/error" /></div>
                </xsl:when>
                
                <xsl:otherwise>
                <form id="add_greeting_form" action="javascript:add_greeting()" method="get">
                    <xsl:value-of select="/opt/forms/greeting_predicate_form" disable-output-escaping="yes" />,
                    <xsl:value-of select="/opt/forms/greeting_subject_form" disable-output-escaping="yes" />!
                    Tag: <xsl:value-of select="/opt/forms/greeting_tag_form" disable-output-escaping="yes" />
                    <input type="submit" name="submit" value="Submit" />
                </form>

                </xsl:otherwise>
                </xsl:choose><!--end add new greeting section-->

                <hr />
                <h2>Available Greetings</h2>
                <!--output messages and errors, if any-->
                <xsl:if test="count(/opt/greetings/message) &gt; 0">
                    <div class="mvcimple-message ui-state-highlight ui-corner-all"><xsl:value-of select="/opt/greetings/message" /></div>
                </xsl:if>
               
                <!-- if we have an error, we shouldn't output the "normal" stuff-->
                <xsl:choose>
                <xsl:when test="count(/opt/greetings/error) &gt; 0">
                    <div class="mvcimple-error ui-state-error ui-corner-all">
                        <h4>Error:</h4>
                        <div class="mvcimple-error-text ui-corner-all">
                        <xsl:value-of select="/opt/greetings/error" />
                        </div>
                    </div>
                </xsl:when>

                <xsl:otherwise>
                <ul>
                    <xsl:for-each select="/opt/greetings/data">
                    <li>
                        Greeting <xsl:value-of select="id" />: 
                        <xsl:value-of select="predicate"/>, 
                        <xsl:value-of select="subject" />!
                    </li>
                    </xsl:for-each>
                </ul>
                </xsl:otherwise>
                </xsl:choose><!--end available greetings section-->
                
                <!--output messages and errors, if any-->
                <xsl:if test="count(/opt/tags/message) &gt; 0">
                    <div class="mvcimple-message ui-state-highlight ui-corner-all"><xsl:value-of select="/opt/tags/message" /></div>
                </xsl:if>
               
                <h2>Tags</h2>
                <xsl:choose>
                <xsl:when test="count(/opt/tags/error) &gt; 0">
                    <div class="mvcimple-error ui-state-error ui-corner-all">
                        <h4>Error:</h4>
                        <div class="mvcimple-error-text ui-corner-all">
                        <xsl:value-of select="/opt/tags/error" />
                        </div>
                    </div>
                </xsl:when>

                <xsl:otherwise>
                <ul>
                    <xsl:for-each select="/opt/tags/data">
                    <li>
                        Tag <xsl:value-of select="id" />: 
                        <xsl:value-of select="name"/> 
                    </li>
                    </xsl:for-each>
                </ul>
                </xsl:otherwise>
                </xsl:choose><!--end tags section-->

                </div><!--end container-->
                
                <script type="text/javascript">
                    init(); //initialize the mvcimple javascript
                </script>
                
                </body>
            </html>
    </xsl:template>
</xsl:stylesheet>

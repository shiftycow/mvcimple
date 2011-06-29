<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
            <html>
                <head>
                </head>

                <body>
                
                <h2><xsl:value-of select="#head_greeting"></h2>
                <hr />
                
                <h2>Add a New Greeting</h2>
                <form>
                </form>

                <hr />
                <h2>Available Greetings</h2>
                
                <ol>
                    <li></li>
                </ol>
                </body>
            </html>
    </xsl:template>
</xsl:stylesheet>

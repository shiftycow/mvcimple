<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
        <html>
            <head>
            </head>
            <body>
                <h2>Users</h2>
                <table border="1">
                    <tr bgcolor="#9acd32">
                        <th>id</th>
                        <th>fname</th>
                        <th>lname</th>
                        <th>age</th>
                    </tr>
                    <xsl:for-each select="opt/anon">
                        <tr>
                            <td class = "id"><xsl:value-of select="@id"/></td>
                            <td class = "fname"><xsl:value-of select="@fname"/></td>
                            <td class = "lname"><xsl:value-of select="@lname"/></td>
                            <td class = "age"><xsl:value-of select="@age"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>


<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mei="http://www.music-encoding.org/ns/mei" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl mei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//mei:titleStmt/mei:title[1]/text()"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <meta name="Document type" class="staticSearch_desc" content="article"/>
                <meta name="Document type" class="staticSearch_desc" content="newspaper"/>
                <style>
                    .container-fluid {
                        max-width: 100% !important;
                    }
                </style>
            </head>            
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">                 
                        <div class="card card-top">
                            <div class="card-header">
                                <h1><xsl:value-of select="//mei:list/mei:head"/></h1>
                            </div>  
                            <div class="card-body">
                                <div class="yes-index" style="max-width:100%;">
                                    <xsl:apply-templates select="//mei:li"/>                                                                                
                                </div>       
                            </div>
                        </div>                                                                       
                    </div>
                    <xsl:call-template name="html_footer"/>
                    <script>
                        $(document).ready(function () {
                            createDataTable('registerTable')
                        });
                    </script>
                </div>
            </body>    
        </html>
    </xsl:template>

    <xsl:template match="mei:li">
        <table id="registerTable"
            class="table table-striped display table-responsive"
            style="max-width:100%;">            
            <thead>                
               <tr>
                   <th>
                       Personenname
                   </th>     
                   <th>
                       Alternative(r) Personenname(n)
                   </th>     
                   <th>
                       Geburtsname
                   </th>   
                   <th>
                       Pseudonym
                   </th> 
                   <th>
                       Register-ID
                   </th>  
                   <th>
                       GND
                   </th>  
                   <th>
                       Familienname
                   </th>  
                   <th>
                       Vorname
                   </th>  
                   <th>
                       Datum
                   </th>  
                   <th>
                       Schlagwörter
                   </th>  
                   <th>
                       Link
                   </th>  
                   <th>
                       Annotation
                   </th>  
               </tr>            
            </thead>
            <tbody>
                <xsl:for-each select="./mei:persName">
                    <tr>
                        <td>
                            <xsl:for-each select="./mei:persName[@type='main']">
                                <xsl:value-of select="."/>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <ul>
                                <xsl:for-each select="./mei:persName[@type='alternative']">
                                    <li><xsl:value-of select="."/></li>
                                </xsl:for-each>  
                            </ul>
                               
                        </td>
                        <td>
                            <xsl:for-each select="./mei:persName[@type='birth']">
                                <xsl:value-of select="."/>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <xsl:for-each select="./mei:persName[@type='pseudonym']">
                                <xsl:value-of select="."/>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <xsl:for-each select="./mei:identifier[@label='Register-ID']">
                                <xsl:value-of select="."/>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <xsl:for-each select="./mei:identifier[@auth='GND']">
                                <xsl:value-of select="@auth.uri"/>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <xsl:for-each select="./mei:fameName">
                                <xsl:value-of select="."/>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <xsl:for-each select="./mei:foreName">
                                <xsl:value-of select="."/>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <xsl:for-each select="./mei:date/mei:date">
                                <ul> 
                                    <label><xsl:value-of select="@type"/></label>
                                    <xsl:for-each select="child::*">
                                        <li><span class="date"><xsl:value-of select="."/></span></li>
                                    </xsl:for-each>     
                                </ul>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <xsl:for-each select="./mei:catchwords">
                                <ul>
                                    <xsl:for-each select="./mei:term">
                                        <li><xsl:value-of select="."/></li>
                                    </xsl:for-each>  
                                </ul>
                            </xsl:for-each>    
                        </td>
                        <td>
                            <ul>
                                <xsl:for-each select="./mei:ptr">
                                    <li><a href="{@target}"><xsl:value-of select="@label"/></a></li>
                                </xsl:for-each>    
                            </ul>                             
                        </td>
                        <td>
                            <xsl:for-each select="./mei:annot">
                                <ul>
                                    <label><xsl:value-of select="@label"/></label>
                                    <xsl:for-each select="child::*">
                                        <li><xsl:value-of select="."/> </li>  
                                    </xsl:for-each>                                     
                                </ul>                                
                            </xsl:for-each>    
                        </td>
                    </tr> 
                </xsl:for-each>  
            </tbody>
        </table>
    </xsl:template>
    <xsl:template match="mei:identifier">
        <span class="identifier bg-light text-dark"><xsl:value-of select="@label"/><xsl:text>: </xsl:text><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="mei:date">
        <span class="date badge bg-light text-dark"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="mei:geogName">
        <span class="geogName badge bg-light text-dark"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="mei:ptr">
        <div class="ptr">
            <a>
                <xsl:attribute name="title">
                    <xsl:value-of select="@label"/>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:value-of select="@target"/>
                </xsl:attribute>
                <xsl:value-of select="@label"/>
            </a>
        </div>
    </xsl:template>  
    <xsl:template match="mei:imprint">
        <div class="imprint">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="mei:annot">
        <div class="annot">
            <xsl:apply-templates/>
        </div>
    </xsl:template>    
    <xsl:template match="mei:notesStmt">
        <div class="card-header">
            <xsl:apply-templates/>
        </div>
    </xsl:template>  
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    version="2.0" exclude-result-prefixes="xsl xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:for-each select="//work">
            <xsl:variable name="filename"
                select="concat(replace(replace(./identifier[@label='ID'], ' ', '_'), '/', '-'),'.html')" />
            <xsl:result-document href="{$filename}">
                <xsl:variable name="doc_title">
                    <xsl:value-of select="./identifier[@label='ID']"/>
                </xsl:variable>
                <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                <html>
                    <xsl:call-template name="html_head">
                        <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                    </xsl:call-template>
                    
                    <body class="page">
                        <div class="hfeed site" id="page">
                            <xsl:call-template name="nav_bar"/>
                            
                            <div class="container-fluid">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="card">
                                            <div class="card-header">
                                                <h1><xsl:value-of select="$doc_title"/></h1>
                                            </div>
                                            
                                            <xsl:apply-templates/>
                                            
                                        </div>                                        
                                    </div>
                                </div>                       
                                
                            </div>
                            
                            <xsl:call-template name="html_footer"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>        
        
    </xsl:template>
    
    <xsl:template match="title">
        <h3><xsl:apply-templates/></h3>
    </xsl:template>
    <xsl:template match="composer">
        <h4><xsl:apply-templates/></h4>
    </xsl:template>
    <xsl:template match="creation">
        <h4><xsl:apply-templates/></h4>
    </xsl:template>
    <xsl:template match="history">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="identifier">
        <span style="display:flex;max-width:20%;flex-direction:column;" class="badge bg-light text-dark"><xsl:value-of select="@label"/><xsl:text>: </xsl:text><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="eventList">
        <div class="row">            
            <xsl:for-each select="./event">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h5><xsl:value-of select="parent::eventList/@type"/></h5>
                        </div>
                        <div class="card-body">
                            <xsl:apply-templates/>
                        </div>
                    </div>
                </div>                
            </xsl:for-each>        
        </div>
    </xsl:template>
    <xsl:template match="date">
        <span class="date"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="geogName">
        <span><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="biblList">
        <div class="card-header">
            <xsl:for-each select="./bibl">
                <ul>
                    <xsl:for-each select="child::*">
                        <li><xsl:apply-templates/></li>
                    </xsl:for-each> 
                </ul>                    
            </xsl:for-each>
        </div>            
    </xsl:template>
    <xsl:template match="ptr">
        <a>
            <xsl:attribute name="title">
                <xsl:value-of select="@label"/>
            </xsl:attribute>
            <xsl:attribute name="href">
                <xsl:value-of select="@target"/>
            </xsl:attribute>
            <xsl:value-of select="@label"/>
        </a>      
    </xsl:template>
    
</xsl:stylesheet>
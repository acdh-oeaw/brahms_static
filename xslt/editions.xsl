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
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//mei:titleStmt/mei:title[1]/text()"/>
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
                        <div class="card">
                            <div class="card-header">
                                <h1><xsl:value-of select="$doc_title"/></h1>
                            </div>
                            <div class="card-header yes-index">                                
                                <xsl:apply-templates select=".//mei:workList"/>
                            </div>
                        </div>                       
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="mei:workList">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="mei:work">
        <div>
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="mei:title">
         <xsl:choose>
             <xsl:when test="ancestor::mei:work">
                 
             </xsl:when>
             <xsl:otherwise>
                 <h3><xsl:apply-templates/></h3>
             </xsl:otherwise>
         </xsl:choose>        
    </xsl:template>
    <xsl:template match="mei:identifier">
        <span class="identifier badge bg-light text-dark"><xsl:value-of select="@label"/><xsl:text>: </xsl:text><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="mei:composer">
        <h4><xsl:apply-templates/></h4>
    </xsl:template>
    <xsl:template match="mei:creation">
        <h4><xsl:apply-templates/></h4>
    </xsl:template>
    <xsl:template match="mei:history">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="mei:eventList">
        <div class="row">            
            <xsl:for-each select="./mei:event">
                <div class="col-md-12" style="padding:1em;border:3px solid white;border-radius:.25rem;margin-bottom:1em;">
                    <xsl:apply-templates/>                    
                </div>                
            </xsl:for-each>        
        </div>
    </xsl:template>
    <xsl:template match="mei:date">
        <span class="date badge bg-light text-dark"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="mei:geogName">
        <span class="geogName badge bg-light text-dark"><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="mei:persName">
        <xsl:choose>
            <xsl:when test="not(parent::mei:composer)">
                <span class="persName badge bg-light text-dark"><xsl:apply-templates/></span>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    <xsl:template match="mei:p">
        <label><xsl:value-of select="@label"/>:</label>
        <p id="{generate-id()}">            
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="mei:biblList">                  
        <xsl:for-each select="./mei:bibl">
            <div class="card {./mei:term} {./mei:genre}" id="{substring-before(@sameas, ' ')}">
                <div class="card-header">
                    <h5><xsl:value-of select="./mei:title"/></h5>
                </div>
                <div class="card-body">
                    <p><xsl:apply-templates/></p>                    
                </div>
            </div>                
        </xsl:for-each>        
    </xsl:template>
    <xsl:template match="mei:term">
        <xsl:choose>
            <xsl:when test="ancestor::mei:work">
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose> 
    </xsl:template>
    <xsl:template match="mei:genre">
        <xsl:choose>
            <xsl:when test="ancestor::mei:work">
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose> 
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
    <xsl:template match="mei:biblScope">
        <div class="biblScope">
            <span>
                <small><xsl:value-of select="@unit"/>: <xsl:apply-templates/></small>
            </span>
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
</xsl:stylesheet>
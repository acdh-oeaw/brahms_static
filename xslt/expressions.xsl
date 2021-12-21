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
        <xsl:for-each select="collection('../data/editions')//mei:mei">
            <xsl:variable name="filename" select="concat(.//mei:workList/mei:work/@xml:id, '_expressions')" />
            <xsl:variable name="filenameFull" select="concat($filename, '.html')" />
            <xsl:result-document href="{$filenameFull}">
                <xsl:variable name="doc_title">
                    <xsl:value-of select="concat(.//mei:workList/mei:work/mei:title, ' Expressionen')"/>
                </xsl:variable>
                <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                <html>
                    <head>
                        <xsl:call-template name="html_head">
                            <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                        </xsl:call-template>
                    </head>
                    <body class="page">
                        <div class="hfeed site" id="page">
                            <xsl:call-template name="nav_bar"/>
                            
                            <div class="container-fluid">
                                <div class="row" style="margin: 5em 0;">
                                    <xsl:for-each select=".//mei:workList/mei:work/mei:expressionList/mei:expression">
                                        <xsl:variable name="id" select="@xml:id"/>
                                        <xsl:variable name="idURL" select="concat($filename, '_', $id, '.html')"/>
                                        <div class="col-md-6">
                                            <a href="{$idURL}">                                                
                                                <div class="card index-card">
                                                    <div class="card-header">
                                                        <h1><xsl:value-of select="./mei:title"/></h1>
                                                    </div>                                                                                 
                                                </div>   
                                            </a>
                                        </div>
                                        <xsl:result-document href="{$idURL}">
                                            <xsl:variable name="doc_title_2">
                                                <xsl:value-of select="concat(.//mei:workList/mei:work/mei:title, ' Expressionen ', replace($id, '_', ' '))"/>
                                            </xsl:variable>
                                            <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                                            <html>
                                                <head>
                                                    <xsl:call-template name="html_head">
                                                        <xsl:with-param name="html_title" select="$doc_title_2"></xsl:with-param>
                                                    </xsl:call-template>
                                                </head>
                                                <body class="page">
                                                    <div class="hfeed site" id="page">
                                                        <xsl:call-template name="nav_bar"/>
                                                        
                                                        <div class="container-fluid">
                                                            <div class="row" style="margin: 5em 0;">
                                                                <xsl:for-each select="./mei:history/mei:eventList/mei:event">
                                                                    <xsl:variable name="eventID" select="concat('_event_', generate-id())"/>
                                                                    <xsl:variable name="event" select="concat($filename, $eventID, '.html')"/>
                                                                    <div class="col-md-6">
                                                                        <a href="{$event}">                                                
                                                                            <div class="card index-card">
                                                                                <div class="card-header">
                                                                                    <h1><xsl:value-of select="replace($eventID, '_', ' ')"/></h1>
                                                                                </div>                                                                                 
                                                                            </div>   
                                                                        </a>
                                                                    </div>
                                                                    <xsl:result-document href="{$event}">
                                                                        <xsl:variable name="doc_title_2">
                                                                            <xsl:value-of select="concat(.//mei:workList/mei:work/mei:title, ' Expressionen ', replace($eventID, '_', ' '))"/>
                                                                        </xsl:variable>
                                                                        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                                                                        <html>
                                                                            <head>
                                                                                <xsl:call-template name="html_head">
                                                                                    <xsl:with-param name="html_title" select="$doc_title_2"></xsl:with-param>
                                                                                </xsl:call-template>
                                                                            </head>
                                                                            <body class="page">
                                                                                <div class="hfeed site" id="page">
                                                                                    <xsl:call-template name="nav_bar"/>
                                                                                    
                                                                                    <div class="container-fluid">
                                                                                        <div class="row" style="margin: 5em 0;">
                                                                                            <xsl:for-each select="./mei:biblList/mei:bibl">
                                                                                                <xsl:variable name="bibl" select="@sameas"/>
                                                                                                <xsl:variable name="biblUrl" select="concat($filename, $eventID, '_', @sameas, '.html')"/>
                                                                                                <div class="col-md-6">
                                                                                                    <a href="{$biblUrl}">                                                
                                                                                                        <div class="card index-card">
                                                                                                            <div class="card-header">
                                                                                                                <h1><xsl:value-of select="./mei:title"/><xsl:text> </xsl:text></h1>
                                                                                                            </div>  
                                                                                                            <div class="card-body">
                                                                                                                <ul>
                                                                                                                    <xsl:if test="./mei:term/text()">
                                                                                                                        <xsl:for-each select="./mei:term">
                                                                                                                            <li style="list-style:circle;"><xsl:apply-templates/></li>
                                                                                                                        </xsl:for-each>
                                                                                                                    </xsl:if>
                                                                                                                    <xsl:if test="./mei:genre/text()">
                                                                                                                        <xsl:for-each select="./mei:genre">
                                                                                                                            <li style="list-style:circle;"><xsl:apply-templates/></li>
                                                                                                                        </xsl:for-each>
                                                                                                                    </xsl:if>
                                                                                                                    <xsl:if test="./mei:author/text()">
                                                                                                                        <xsl:for-each select="./mei:author">
                                                                                                                            <li style="list-style:circle;"><xsl:apply-templates/></li>
                                                                                                                        </xsl:for-each>
                                                                                                                    </xsl:if>
                                                                                                                </ul>
                                                                                                            </div>
                                                                                                        </div>   
                                                                                                    </a>
                                                                                                </div>
                                                                                                <xsl:result-document href="{$biblUrl}">
                                                                                                    <xsl:variable name="doc_title_3">
                                                                                                        <xsl:value-of select="concat(.//mei:workList/mei:work/mei:title, ' Expressionen ', replace($eventID, '_', ' '), $bibl)"/>
                                                                                                    </xsl:variable>
                                                                                                    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                                                                                                    <html>
                                                                                                        <head>
                                                                                                            <xsl:call-template name="html_head">
                                                                                                                <xsl:with-param name="html_title" select="$doc_title_3"></xsl:with-param>
                                                                                                            </xsl:call-template>
                                                                                                        </head>
                                                                                                        <body class="page">
                                                                                                            <div class="hfeed site" id="page">
                                                                                                                <xsl:call-template name="nav_bar"/>
                                                                                                                
                                                                                                                <div class="container-fluid">
                                                                                                                    <div class="row" style="margin: 5em 0;">
                                                                                                                        <div class="col-md-12">                                             
                                                                                                                            <div class="card">
                                                                                                                                <div class="card-header">
                                                                                                                                    <h1><xsl:value-of select="./mei:title"/><xsl:text> </xsl:text></h1>
                                                                                                                                </div>
                                                                                                                                <div class="card-body">
                                                                                                                                    <xsl:apply-templates/>
                                                                                                                                </div>
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
                                                                                        </div>                   
                                                                                    </div>
                                                                                    
                                                                                    <xsl:call-template name="html_footer"/>
                                                                                </div>
                                                                            </body>
                                                                        </html>
                                                                    </xsl:result-document>
                                                                </xsl:for-each>                                                                  
                                                            </div>                   
                                                        </div>
                                                        
                                                        <xsl:call-template name="html_footer"/>
                                                    </div>
                                                </body>
                                            </html>
                                        </xsl:result-document>
                                    </xsl:for-each>
                                </div>                   
                            </div>
                            
                            <xsl:call-template name="html_footer"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="mei:title">
        
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
        <p>            
            <xsl:apply-templates/>
        </p>
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
    <xsl:template match="mei:relationList">  
        <xsl:for-each select="./mei:relation">
            <span class="badge bg-light text-dark" style="margin-right:.3em;">
                <xsl:value-of select="@rel"/>
            </span>
            <xsl:variable name="isRealizationOf" select="tokenize(@target, '\s')"/>
            <ul>
                <xsl:for-each select="$isRealizationOf">
                    <li>                    
                        <a href="{.}" title="{substring-after(., '#')}">
                            <xsl:value-of select="substring-after(., '#')"/>
                        </a>
                    </li>
                </xsl:for-each>  
            </ul>
        </xsl:for-each>
    </xsl:template>    
    <xsl:template match="mei:relatedItem">        
        <xsl:for-each select="@*">
            <span class="badge bg-light text-dark" style="margin-right:.3em;">
                <xsl:value-of select="."/>
            </span>
        </xsl:for-each>        
        <xsl:for-each select="child::*">
            <ul>
                <li><xsl:apply-templates/></li>
            </ul>
        </xsl:for-each>        
    </xsl:template>
   
</xsl:stylesheet>
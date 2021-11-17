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
            </head>            
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div id="navBarLetters" style="margin-top:4em !important;">
                            <ul class="nav nav-tabs" id="dropdown-lang">
                                <li class="nav-item">                                    
                                    <a title="back to all letters" href="toc.html" class="nav-link btn btn-round btn-backlink">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-back" viewBox="0 0 16 16">
                                            <path d="M0 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v2h2a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2v-2H2a2 2 0 0 1-2-2V2zm2-1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H2z"/>
                                        </svg>
                                    </a>
                                </li>
                                <li class="nav-item">                                    
                                    <a title="Cards" href="#diplomatic-tab" data-toggle="tab" class="nav-link btn btn-round active">
                                        diplomatic view
                                    </a>
                                </li>
                                <li class="nav-item">                                    
                                    <a title="Table" href="#xml-tab" data-toggle="tab" class="nav-link btn btn-round">
                                        TEI/XML view
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="tab-content">
                            <div class="tab-pane active" id="diplomatic-tab" tabindex="-1">                                     
                                <div class="card">
                                    <div class="card-header">
                                        <h1><xsl:value-of select="$doc_title"/></h1>
                                    </div>
                                    <div class="card-header yes-index">
                                        <xsl:apply-templates select=".//mei:workList"/>                                                                                
                                    </div>
                                </div>
                            </div>                            
                            <div class="tab-pane fade" id="xml-tab" tabindex="-1">
                                <div class="card-body">                                
                                    <iframe frameborder="0" scrolling="yes" width="100%" height="800px">
                                        <xsl:attribute name="src">
                                            <xsl:value-of select="concat('xml-view/',replace(tokenize(base-uri(.),'/')[last()],'.xml','.html'))"/>
                                        </xsl:attribute>
                                    </iframe>
                                </div>
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
    <xsl:template match="relationList">        
        <xsl:for-each select="@*">
            <span class="badge bg-light text-dark">
                <xsl:value-of select="."/>
            </span>
        </xsl:for-each>        
    </xsl:template>    
    <xsl:template match="relatedItem">        
        <xsl:for-each select="@*">
            <span class="badge bg-light text-dark">
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
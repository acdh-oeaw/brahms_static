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
                                <div class="card card-top">
                                    <div class="card-header">
                                        <h1><xsl:value-of select="$doc_title"/></h1>
                                        <div style="margin: 1.5em 0;">
                                            <xsl:for-each select="//mei:title">                                                
                                                <xsl:if test="parent::mei:expression">
                                                    <h6 class="toc">
                                                        <a href="#{parent::*/@xml:id}">
                                                            <xsl:apply-templates/>
                                                        </a>
                                                    </h6>
                                                </xsl:if>                                                
                                            </xsl:for-each>                                            
                                            <xsl:if test="//mei:perfResList">
                                                <h6 class="toc">
                                                    <a href="#perfResList">
                                                        Besetzung
                                                    </a>
                                                </h6>
                                            </xsl:if>
                                            <xsl:if test="//mei:componentList">
                                                <h6 class="toc">
                                                    <a href="#componentList">
                                                        Komponentenliste
                                                    </a>
                                                </h6>
                                            </xsl:if>                                            
                                        </div>
                                    </div>                                    
                                </div>
                                <div class="yes-index">
                                    <xsl:apply-templates select=".//mei:workList"/>                                                                                
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
        <span class="identifier bg-light text-dark"><xsl:value-of select="@label"/><xsl:text>: </xsl:text><xsl:apply-templates/></span>
    </xsl:template>
    <xsl:template match="mei:composer">
        <xsl:variable name="gnd" select="./mei:persName/@auth.uri"/>
        <div style="display:inline;">
            <h4 class="composer">
                <xsl:apply-templates/>
                <a id="composerInfoButton"
                    class="btn btn-sm"
                    type="button"
                    data-toggle="modal"
                    data-target="#composerInfo">                   
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
                        <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
                        <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
                    </svg>
                </a>
            </h4>
            <div class="modal fade" id="composerInfo" tabindex="-1" aria-labelledby="composerInfoModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Komponist Information</h5>
                        </div>
                        <div class="modal-body">
                            <dl>
                                <dt><xsl:value-of select="./mei:persName/@auth"/></dt>
                                <dd>
                                    <a target="_blank" title="GND Link" href="{concat(./mei:persName/@auth.uri, ./mei:persName/@codedval)}">
                                        <xsl:value-of select="concat(./mei:persName/@auth.uri, ./mei:persName/@codedval)"/>
                                    </a>
                                </dd>
                                <dt><xsl:value-of select="./mei:persName/@corresp/name()"/></dt>
                                <dd><xsl:value-of select="./mei:persName/@corresp"/></dd>
                            </dl>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>        
    </xsl:template>
    <xsl:template match="mei:creation">
        <h4><xsl:apply-templates/></h4>
    </xsl:template>
    <xsl:template match="mei:history">
        <div class="card-header" style="border-radius:.25rem;"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="mei:eventList">
        <div class="row">            
            <xsl:for-each select="./mei:event">
                <div id="event_{generate-id()}" class="col-md-12" 
                    style="margin: 1em 0;
                    border-bottom: 5px solid #88dbdf;
                    padding:1em 0;">
                    <xsl:if test="ancestor::mei:eventList/@type">
                        <span class="date badge bg-light text-dark">
                            <xsl:value-of select="ancestor::mei:eventList/@type"/>
                        </span>
                    </xsl:if>
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
        <p>            
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="mei:biblList">      
        <div class="row">
            <xsl:for-each select="./mei:bibl">
                <div class="col-md-6">
                    <div class="card biblList {./mei:term} {./mei:genre}" id="{substring-before(@sameas, ' ')}">
                        <div class="card-header">
                            <h5><xsl:value-of select="./mei:title"/></h5>
                        </div>
                        <div class="card-body">
                            <p><xsl:apply-templates/></p>                    
                        </div>
                    </div>   
                </div>
            </xsl:for-each>  
        </div>
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
    <xsl:template match="mei:notesStmt">
        <div class="card-header" id="notesStmt" style="padding-top:5.5em;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="mei:expressionList">
        <div class="row">
            <xsl:for-each select="./mei:expression">
                <div class="col-md-12" id="{@xml:id}" style="padding-top:4em;">
                    <h3><xsl:value-of select="./mei:title"/></h3>
                    <h6 style="text-align:center;"><small><a href="#page">Jump to the top</a></small></h6>
                    <xsl:apply-templates/>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
    <xsl:template match="mei:perfMedium">
        <div class="card-header" id="perfResList" style="padding-top:5.5em;">
            <xsl:for-each select="./mei:perfResList">
                <h6><xsl:value-of select="./mei:head"/></h6>
                <h6><small><a href="#page">Jump to the top</a></small></h6>
                <ul>
                    <xsl:for-each select="./mei:perfResList/mei:perfRes">
                        <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                </ul>                
            </xsl:for-each>    
        </div>
    </xsl:template>
    <xsl:template match="mei:componentList">
        <div class="card-header" id="componentList" style="padding-top:5.5em;">
            <h6>Komponenten</h6>
            <h6><small><a href="#page">Jump to the top</a></small></h6>
            <xsl:for-each select="./mei:work">
                <div id="{@xml:id}">
                    <ul>
                        <li><xsl:value-of select="./mei:identifier/@label"/>: <xsl:value-of select="./mei:identifier"/></li>
                        <li>Titel: <xsl:value-of select="mei:title"/></li>
                    </ul>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>
        
    
</xsl:stylesheet>
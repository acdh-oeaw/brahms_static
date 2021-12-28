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
            <xsl:variable name="filename" select=".//mei:workList/mei:work/@xml:id" />
            <xsl:variable name="filenameFull" select="concat(.//mei:workList/mei:work/@xml:id,'.html')" />
            <xsl:result-document href="{$filenameFull}">
                <xsl:variable name="doc_title">
                    <xsl:value-of select="concat(.//mei:workList/mei:work/mei:title, ' Arbeit')"/>
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
                                    <xsl:if test="count(.//mei:history/mei:eventList/mei:event) != 0">         
                                        <xsl:variable name="historyOverview" select="concat($filename, '_history', '.html')"/>
                                        <div class="col-md-12">
                                            <a href="{$historyOverview}">                                                
                                                <div class="card index-card">
                                                    <div class="card-header">
                                                        <h1>Einträge zu Bibliographien (Geschichte)</h1>
                                                    </div>                                                                                 
                                                </div>   
                                            </a>
                                        </div>                                          
                                    </xsl:if>
                                    <xsl:if test="count(.//mei:expressionList/mei:expression) != 0">    
                                        <xsl:variable name="expressionsOverview" select="concat($filename, '_expressions', '.html')"/>
                                        <div class="col-md-12">
                                            <a href="{$expressionsOverview}">
                                                <div class="card index-card">
                                                    <div class="card-header">
                                                        <h1>Einträge zu Bibliographien (Schaffung)</h1>
                                                    </div>                                                                                 
                                                </div> 
                                            </a>
                                        </div>                                          
                                    </xsl:if>                                    
                                </div>                       
                                <!--<div class="row" style="margin-bottom: 5em;">
                                    <xsl:if test="count(.//mei:perfMedium/mei:perfResList) != 0"> 
                                        <xsl:variable name="ressourcesOverview" select="concat($filename, '_ressources', '.html')"/>
                                        <div class="col-md-6">
                                            <a href="{$ressourcesOverview}">
                                                <div class="card index-card">
                                                    <div class="card-header">
                                                        <h1>Resourcen</h1>
                                                    </div>                                                                                 
                                                </div>  
                                            </a>
                                        </div>                                        
                                    </xsl:if>
                                    <xsl:if test="count(.//mei:componentList/mei:work) != 0">         
                                        <xsl:variable name="componentOverview" select="concat($filename, '_components', '.html')"/>
                                        <div class="col-md-6">
                                            <a href="{$componentOverview}">
                                                <div class="card index-card">
                                                    <div class="card-header">
                                                        <h1>Komponenten</h1>
                                                    </div>                                                                                 
                                                </div>   
                                            </a>
                                        </div>                                        
                                    </xsl:if>
                                </div>-->
                            </div>
                            
                            <xsl:call-template name="html_footer"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
   
</xsl:stylesheet>
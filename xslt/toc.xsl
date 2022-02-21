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
        <xsl:variable name="doc_title" select="'Werkverzeichnis'"/>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>            
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header">
                                <h1>Werkverzeichnis</h1>
                            </div>
                            <div class="card-body">
                                <table class="table table-striped display" id="tocTable" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Titel</th>
                                            <th scope="col">Präfix</th>
                                            <th scope="col">Opusnummer</th>                                            
                                            <th scope="col">Metadaten</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="collection('../data/editions')//mei:mei">
                                            <xsl:variable name="full_path">
                                                <xsl:value-of select="document-uri(/)"/>
                                            </xsl:variable>
                                            <xsl:variable name="filenameFull" select="concat(.//mei:workList/mei:work/@xml:id,'.html')" />
                                            <tr>
                                                <td>                                       
                                                    <xsl:value-of select="//mei:titleStmt/mei:title/text()"/>
                                                    <xsl:text>, </xsl:text>
                                                    <xsl:value-of select="//mei:workList/mei:work/mei:identifier[@label='Opus-Nummer']/text()"/>                                                    
                                                </td>
                                                <td>                                                    
                                                    <xsl:value-of select="substring-before(//mei:workList/mei:work/mei:identifier[@label='Opus-Nummer'], ' ')"/>
                                                </td>
                                                <td>                                                    
                                                    <xsl:value-of select="substring-after(//mei:workList/mei:work/mei:identifier[@label='Opus-Nummer'], ' ')"/>
                                                </td>                                                
                                                <!--<td>
                                                    <ul>                                                            
                                                        <li style="list-style:circle;">
                                                            <xsl:value-of select="count(//mei:history/mei:eventList/mei:event)"/>
                                                            <xsl:text> Einträge zu Bibliographien (Geschichte)</xsl:text>                                                            
                                                        </li>
                                                        <li style="list-style:circle;">
                                                            <xsl:value-of select="count(//mei:expressionList/mei:expression)"/>
                                                            <xsl:text> Einträge zu Bibliographien (Schaffung)</xsl:text>
                                                        </li>
                                                        <li style="list-style:circle;">
                                                            <xsl:value-of select="count(//mei:perfMedium/mei:perfResList)"/>
                                                            <xsl:text> Einträge zu Gattung</xsl:text>
                                                        </li>
                                                        
                                                        <li style="list-style:circle;">
                                                            <xsl:value-of select="count(//mei:componentList/mei:work)"/>
                                                            <xsl:text> Einträge zu Werke</xsl:text>
                                                        </li>                                                            
                                                    </ul>                                                                                                                                                                                                              
                                                </td>-->
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">                                                
                                                            <xsl:value-of select="replace(
                                                                tokenize($full_path, '/')[last()],
                                                                '.xml',
                                                                '.html')"/>
                                                        </xsl:attribute>
                                                        <svg xmlns="http://www.w3.org/2000/svg" 
                                                            width="24" 
                                                            height="24" 
                                                            fill="currentColor" 
                                                            class="bi bi-box-arrow-in-right" 
                                                            viewBox="0 0 16 16">
                                                            <path fill-rule="evenodd" 
                                                                d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                                                            <path fill-rule="evenodd" 
                                                                d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                                        </svg>                                                        
                                                    </a>
                                                    <!--<a href="{$filenameFull}">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
                                                            <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                                                            <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                                        </svg>
                                                    </a>-->
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <xsl:call-template name="html_footer"/>
                    <script type="text/javascript" src="js/dt-opus-filter.js"></script>                    
                    <script>
                        $(document).ready(function () {
                            createDataTable('tocTable')
                        });
                    </script>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="mei:div//mei:head">
        <h2 id="{generate-id()}"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="mei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="mei:list">
        <ul id="{generate-id()}"><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="mei:item">
        <li id="{generate-id()}"><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="mei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
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
                                                                                    <h5>
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="./mei:date/text()">
                                                                                                <xsl:value-of select="./mei:date"/>
                                                                                                <xsl:text>, </xsl:text>
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                <xsl:text>unbekannt</xsl:text>
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>                                                            
                                                                                        <xsl:if test="./mei:geogName[@role='place']/text()">
                                                                                            <xsl:value-of select="./mei:geogName[@role='place']"/>
                                                                                            <xsl:text>, </xsl:text>
                                                                                        </xsl:if>
                                                                                        <xsl:if test="./mei:geogName[@role='venue']/text()">
                                                                                            <xsl:value-of select="./mei:geogName[@role='venue']"/>
                                                                                            <xsl:text> - </xsl:text>
                                                                                        </xsl:if>    
                                                                                        <xsl:if test="./mei:persName[1]/text()">
                                                                                            <xsl:value-of select="./mei:persName[1]"/>
                                                                                        </xsl:if>
                                                                                        <xsl:if test="count(./mei:persName) > 1">
                                                                                            <xsl:text>(+ </xsl:text><xsl:value-of select="count(./mei:persName) - 1"/><xsl:text>)</xsl:text>
                                                                                        </xsl:if>                                                           
                                                                                    </h5>
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
                                                                                                <xsl:variable name="bibl" select="tokenize(@sameas, ' ')[1]"/>
                                                                                                <xsl:variable name="biblUrl" select="concat($filename, $eventID, '_', $bibl, '.html')"/>
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
                                                                                                        <xsl:value-of select="concat(//mei:workList/mei:work/mei:title, ' ', ./mei:title[1], ' ', ./mei:title[2])"/>
                                                                                                    </xsl:variable>
                                                                                                    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                                                                                                    <html>
                                                                                                        <head>
                                                                                                            <xsl:call-template name="html_head">
                                                                                                                <xsl:with-param name="html_title" select="$doc_title_3"></xsl:with-param>
                                                                                                            </xsl:call-template>
                                                                                                            <xsl:if test="@type = 'Rubrik_3' or @type = 'Rubrik_8'">
                                                                                                                <meta name="Filter" class="staticSearch_desc" content="Vorankündigung"/>  
                                                                                                            </xsl:if>
                                                                                                            <xsl:if test="@type = 'Rubrik_1' or @type = 'Rubrik_2'">
                                                                                                                <meta name="Filter" class="staticSearch_desc" content="Rezension"/>  
                                                                                                            </xsl:if>
                                                                                                            <xsl:for-each select="./mei:annot/mei:p[@label='Weitere_Informationen']">
                                                                                                                <xsl:if test="contains(., 'gemäß')">
                                                                                                                    <meta name="Filter" class="staticSearch_desc" content="erschlossene Quellen"/>                                                                                                                                                                        
                                                                                                                </xsl:if>         
                                                                                                            </xsl:for-each>
                                                                                                            <meta name="docTitle" class="staticSearch_docTitle">
                                                                                                                <xsl:attribute name="content">
                                                                                                                    <xsl:for-each select="ancestor::mei:event">
                                                                                                                        <xsl:value-of select="./mei:date"/>
                                                                                                                        <xsl:text>, </xsl:text>
                                                                                                                        <xsl:value-of select="./mei:geogName[@role='place']"/>
                                                                                                                        <xsl:text>, </xsl:text>
                                                                                                                        <xsl:value-of select="./mei:geogName[@role='venue']"/>
                                                                                                                        <xsl:text> - </xsl:text>
                                                                                                                        <xsl:value-of select="./mei:persName[1]"/>
                                                                                                                        <xsl:if test="count(./mei:persName) > 1">
                                                                                                                            <xsl:text>(+ </xsl:text><xsl:value-of select="count(./mei:persName) - 1"/><xsl:text>)</xsl:text>
                                                                                                                        </xsl:if>  
                                                                                                                        <xsl:text>. </xsl:text>
                                                                                                                        <xsl:value-of select="ancestor::mei:work/mei:title"/><xsl:text>, </xsl:text><xsl:value-of select="ancestor::mei:work/mei:identifier"/>
                                                                                                                        
                                                                                                                        <xsl:text> (</xsl:text>
                                                                                                                        <xsl:for-each select="./mei:biblList/mei:bibl/mei:relationList/mei:relation">
                                                                                                                            <xsl:variable name="reID" select="tokenize(@target, ' ')"/>
                                                                                                                            <xsl:variable name="rID" select="substring-after(data($reID[1]), '#')"/>
                                                                                                                            <xsl:variable name="rID2" select="substring-after(data($reID[2]), '#')"/>
                                                                                                                            <xsl:variable name="rID3" select="substring-after(data($reID[3]), '#')"/>                                                                                                
                                                                                                                            <xsl:if test="//id($rID)">
                                                                                                                                <xsl:for-each select="//id($rID)">
                                                                                                                                    <xsl:value-of select="./mei:title"/><xsl:text>, </xsl:text><xsl:value-of select="./mei:identifier"/>
                                                                                                                                    <xsl:text>; </xsl:text>
                                                                                                                                </xsl:for-each>
                                                                                                                            </xsl:if>
                                                                                                                            <xsl:if test="//id($rID2)">
                                                                                                                                <xsl:for-each select="//id($rID2)">
                                                                                                                                    <xsl:value-of select="./mei:title"/><xsl:text>, </xsl:text><xsl:value-of select="./mei:identifier"/>
                                                                                                                                    <xsl:text>; </xsl:text>
                                                                                                                                </xsl:for-each>
                                                                                                                            </xsl:if>
                                                                                                                            <xsl:if test="//id($rID3)">
                                                                                                                                <xsl:for-each select="//id($rID3)">
                                                                                                                                    <xsl:value-of select="./mei:title"/><xsl:text>, </xsl:text><xsl:value-of select="./mei:identifier"/>                                                                                                        
                                                                                                                                </xsl:for-each>
                                                                                                                            </xsl:if>                                                                                         
                                                                                                                            
                                                                                                                        </xsl:for-each>
                                                                                                                        <xsl:text>) </xsl:text>
                                                                                                                        
                                                                                                                        <xsl:text>Quelle: </xsl:text>
                                                                                                                        <xsl:for-each select="./mei:biblList/mei:bibl/mei:annot/mei:p[@label = 'Vollständiger_Nachweis']">
                                                                                                                            <xsl:apply-templates/>
                                                                                                                            <xsl:if test="position() != last()">
                                                                                                                                <xsl:text> - </xsl:text>
                                                                                                                            </xsl:if>
                                                                                                                        </xsl:for-each>                                                                                                                                                                                     
                                                                                                                        
                                                                                                                    </xsl:for-each>
                                                                                                                </xsl:attribute>
                                                                                                            </meta>
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
                                                                                                                                    <xsl:for-each select="ancestor::mei:event">
                                                                                                                                        <div class="table-responsive">
                                                                                                                                            <table class="table event-table">
                                                                                                                                                <tr>                                                                                                                        
                                                                                                                                                    <th>Datum</th>
                                                                                                                                                    <td>                                                                                                                            
                                                                                                                                                        <xsl:for-each select="./mei:date">
                                                                                                                                                            <xsl:apply-templates/>                                                                                                                                
                                                                                                                                                        </xsl:for-each>                                                                                                                                                                                                                                                            
                                                                                                                                                    </td>
                                                                                                                                                </tr>                                                                                                                    
                                                                                                                                                <tr>
                                                                                                                                                    <th>Ort</th>
                                                                                                                                                    <td>
                                                                                                                                                        <xsl:value-of select="./mei:geogName[@role='place']"/>                                                                                                                               
                                                                                                                                                    </td>
                                                                                                                                                </tr>
                                                                                                                                                <tr>                                                                                                                        
                                                                                                                                                    <th>Saal</th>
                                                                                                                                                    <td>
                                                                                                                                                        <xsl:value-of select="./mei:geogName[@role='venue']"/>                                                                                                                               
                                                                                                                                                    </td>                                                                                                                        
                                                                                                                                                </tr>
                                                                                                                                                <tr>
                                                                                                                                                    <th>Ausführende</th>                                                                                                                                                                                                                                                   
                                                                                                                                                    <xsl:for-each select="./mei:persName">
                                                                                                                                                        <td>
                                                                                                                                                            <xsl:apply-templates/><xsl:text> (</xsl:text><xsl:value-of select="@type"/><xsl:text>)</xsl:text>
                                                                                                                                                        </td>
                                                                                                                                                    </xsl:for-each>                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                </tr>
                                                                                                                                                <tr>
                                                                                                                                                    <th>Werk</th>                                                                                                                                                                                                                                                  
                                                                                                                                                    <td>
                                                                                                                                                        <xsl:value-of select="ancestor::mei:work/mei:title"/><xsl:text>, </xsl:text><xsl:value-of select="ancestor::mei:work/mei:identifier"/>
                                                                                                                                                        <br/>
                                                                                                                                                        <xsl:for-each select="./mei:biblList/mei:bibl/mei:relationList/mei:relation">
                                                                                                                                                            <xsl:variable name="reID" select="tokenize(@target, ' ')"/>
                                                                                                                                                            <xsl:variable name="rID" select="substring-after(data($reID[1]), '#')"/>
                                                                                                                                                            <xsl:variable name="rID2" select="substring-after(data($reID[2]), '#')"/>
                                                                                                                                                            <xsl:variable name="rID3" select="substring-after(data($reID[3]), '#')"/>
                                                                                                                                                            <xsl:if test="//id($rID)">
                                                                                                                                                                <xsl:for-each select="//id($rID)">
                                                                                                                                                                    <xsl:value-of select="./mei:title"/><xsl:text>, </xsl:text><xsl:value-of select="./mei:identifier"/>
                                                                                                                                                                    <br/>
                                                                                                                                                                </xsl:for-each>
                                                                                                                                                            </xsl:if>
                                                                                                                                                            <xsl:if test="//id($rID2)">
                                                                                                                                                                <xsl:for-each select="//id($rID2)">
                                                                                                                                                                    <xsl:value-of select="./mei:title"/><xsl:text>, </xsl:text><xsl:value-of select="./mei:identifier"/>
                                                                                                                                                                    <br/>
                                                                                                                                                                </xsl:for-each>
                                                                                                                                                            </xsl:if>
                                                                                                                                                            <xsl:if test="//id($rID3)">
                                                                                                                                                                <xsl:for-each select="//id($rID3)">
                                                                                                                                                                    <xsl:value-of select="./mei:title"/><xsl:text>, </xsl:text><xsl:value-of select="./mei:identifier"/>
                                                                                                                                                                </xsl:for-each>
                                                                                                                                                            </xsl:if>
                                                                                                                                                        </xsl:for-each>
                                                                                                                                                    </td>
                                                                                                                                                </tr>                                                                                                                    
                                                                                                                                            </table>
                                                                                                                                        </div>                                                                                                            
                                                                                                                                    </xsl:for-each>
                                                                                                                                    
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
        
    </xsl:template>
    <xsl:template match="mei:geogName">
        
    </xsl:template>
    <xsl:template match="mei:persName">
        
    </xsl:template>
    <xsl:template match="mei:p">
        <label><xsl:value-of select="@label"/>:</label>
        <xsl:choose>
            <xsl:when test="@label = 'Vollständiger_Nachweis'">
                <p>            
                    <xsl:apply-templates/><xsl:text> URL: </xsl:text>                       
                    <a title="{parent::mei:annot/following-sibling::mei:ptr/@label}" href="{parent::mei:annot/following-sibling::mei:ptr/@target}">
                        <xsl:value-of select="parent::mei:annot/following-sibling::mei:ptr/@label"/> 
                    </a>                    
                </p>
            </xsl:when>
            <xsl:when test="@label = 'Weitere_Informationen'">
                <p>            
                    <xsl:value-of select="replace(.,'[()]', '')"/>           
                </p>
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>
    <xsl:template match="mei:term">
        
    </xsl:template>
    <xsl:template match="mei:genre">
        
    </xsl:template>
    <xsl:template match="mei:ptr">
        
    </xsl:template>
    <xsl:template match="mei:biblScope">
        <div>            
            <span>
                <span style="text-transform:capitalize;"><xsl:value-of select="@unit"/></span>: <xsl:apply-templates/>
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
        
    </xsl:template>    
    <xsl:template match="mei:relatedItem">        
        
    </xsl:template>
   
</xsl:stylesheet>
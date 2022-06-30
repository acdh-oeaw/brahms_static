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
        <xsl:variable name="filename"
            select="replace(
                tokenize(document-uri(.), '/')[last()],
                '.xml', '')"/>
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
                        <div class="tei-logo">                           
                            <h1 style="text-align:right!important;">
                                <a href="{tokenize(document-uri(.), '/')[last()]}?format=raw" title="TEI Source">
                                    <img alt="TEI Logo" src="images/meilogo-black.png" id="tei-logo"/>
                                </a>
                            </h1>                         
                        </div>
                        <div class="card">
                            <div class="card-header">
                                <h1 style="width:5%;display:inline-block;">                                                                                        
                                    <a href="toc.html">
                                        <svg xmlns="http://www.w3.org/2000/svg" 
                                            width="24" 
                                            height="24" 
                                            fill="currentColor" 
                                            class="bi bi-box-arrow-left" 
                                            viewBox="0 0 16 16">
                                            <path fill-rule="evenodd" 
                                                d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0v2z"/>
                                            <path fill-rule="evenodd" 
                                                d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z"/>
                                        </svg>
                                    </a>
                                </h1>  
                                <h1 style="width:90%;display:inline-block;">
                                    <xsl:value-of select="concat(
                                    $doc_title,
                                    ' ',
                                    //mei:workList/mei:work/mei:identifier[1][@label='Opus-Nummer'])"/>
                                </h1>   
                                <xsl:if test="//mei:expressionList or //mei:perfResList or //mei:componentList">  
                                    <div class="text-center"
                                         style="margin-top: 2em;">
                                        <xsl:if test="//mei:expression">
                                            <xsl:for-each select="//mei:title[parent::mei:expression]">                                                
                                                <h6>
                                                    <xsl:apply-templates/>
                                                </h6>                                                                                                
                                            </xsl:for-each> 
                                        </xsl:if>
                                    </div>
                                    <div class="table-responsive">
                                        <table class="table">                                                                                                                                  
                                            <xsl:if test="//mei:perfResList">
                                                <tr>
                                                    <th class="text-right" 
                                                        style="border-top:none;width:50%;">
                                                        Besetzung
                                                    </th>
                                                    <td class="text-left" 
                                                        style="border-top:none;">
                                                        <xsl:for-each select="//mei:perfResList">
                                                            <ul style="padding:0;margin-bottom:0;">
                                                                <xsl:for-each select="./mei:perfResList/mei:perfRes">
                                                                    <li style="margin-top:0;">
                                                                        <xsl:value-of select="."/>
                                                                    </li>
                                                                </xsl:for-each>
                                                            </ul>                
                                                        </xsl:for-each> 
                                                    </td>
                                                </tr>                                                                                    
                                            </xsl:if>
                                            <xsl:if test="//mei:componentList">
                                                <tr>
                                                    <th class="text-right"
                                                        style="border-top:none;width:50%;">
                                                        Nummern
                                                    </th>
                                                    <td class="text-left"
                                                        style="border-top:none;">
                                                        <xsl:for-each select="//mei:componentList">
                                                            <ul style="padding:0;margin-bottom:0;">
                                                                <xsl:for-each select="./mei:work">    
                                                                    <xsl:variable name="filter-id"
                                                                        select="tokenize(@xml:id, '_')"/>
                                                                    <xsl:choose>
                                                                        <xsl:when test="count($filter-id) = 2">
                                                                            <li style="margin-top:0;">                                                        
                                                                                <xsl:value-of select="concat(
                                                                                    translate(./mei:title, '.', ''),
                                                                                    ' ',
                                                                                    ./mei:identifier)"/>
                                                                            </li>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>                                                                     
                                                                </xsl:for-each>           
                                                            </ul>
                                                        </xsl:for-each>
                                                    </td>                                                
                                                </tr>                                            
                                            </xsl:if>            
                                        </table>
                                    </div>                                    
                                </xsl:if>                                
                            </div>  
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped" id="workTable">
                                        <thead>
                                            <th>Datum</th>
                                            <th>Ort</th>
                                            <th>Saal</th>
                                            <th>Beteiligte</th>
                                            <th>Titel</th>
                                            <th>Details</th>
                                            <th>Alle Personen</th>
                                        </thead>
                                        <tbody><!--not(ancestor::mei:expressionList) and -->
                                            <xsl:for-each select="//mei:bibl[                                   
                                                not(parent::mei:relatedItem)]">
                                                
                                                <xsl:variable name="bibl" select="normalize-space(@sameas)"/>
                                                <xsl:variable name="biblUrl" select="concat(
                                                    replace(
                                                    translate($doc_title, '.', '')
                                                    , ' ' , '-'),
                                                    '-', $bibl, '.html')"/>                                               
                                                
                                                <tr>
                                                    <xsl:for-each select="ancestor::mei:event"> 
                                                        <xsl:choose>
                                                            <xsl:when test="./mei:date/text()">
                                                                <td>                                                                    
                                                                    <xsl:value-of select="./mei:date"/>                                                                      
                                                                </td>                                                                                                                                                  
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <td>
                                                                    <xsl:text>k.A.</xsl:text>
                                                                </td>
                                                            </xsl:otherwise>
                                                        </xsl:choose>    
                                                        <td>
                                                            <xsl:if test="./mei:geogName[@role='place']/text()">                                                                                                      
                                                                <xsl:value-of select="./mei:geogName[@role='place']"/>                                                                                       
                                                            </xsl:if>  
                                                        </td>                                                    
                                                        <td>
                                                            <xsl:if test="./mei:geogName[@role='venue']/text()">                                                     
                                                                <xsl:value-of select="./mei:geogName[@role='venue']"/>                                              
                                                            </xsl:if>
                                                        </td>
                                                        <!--<xsl:if test="ancestor::mei:work/mei:title/text()">   
                                                            <xsl:text>. </xsl:text>
                                                            <xsl:value-of select="ancestor::mei:work/mei:title"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="ancestor::mei:work/mei:identifier"/>
                                                            <xsl:text>.</xsl:text>
                                                        </xsl:if>-->                                               
                                                        <td>                                                        
                                                            <xsl:variable name="count-persons" select="count(./mei:persName)"/>
                                                            <xsl:value-of select="./mei:persName[1]"/>
                                                            <xsl:if test="$count-persons > 1">
                                                                <xsl:text>(+</xsl:text>
                                                                <xsl:value-of select="$count-persons - 1"/>
                                                                <xsl:text>)</xsl:text>
                                                            </xsl:if>                                                            
                                                            <!--<xsl:for-each select="./mei:persName">                                                                
                                                                <xsl:if test="./text()">                                                                    
                                                                    <xsl:choose>
                                                                        <xsl:when test="position() = 2">                                                                            
                                                                            <xsl:text>(+ </xsl:text>
                                                                            <xsl:value-of select="$count-persons - 1"/>
                                                                            <xsl:text>)</xsl:text>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            <xsl:apply-templates/>                                                                    
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>                                                                                                           
                                                                </xsl:if>                                                  
                                                            </xsl:for-each>-->                                                                                        
                                                        </td>
                                                    </xsl:for-each>
                                                <td>
                                                    <xsl:choose>
                                                        <xsl:when test="not(//mei:expressionList/mei:expression)">                                              
                                                            <xsl:if test="./mei:relationList/mei:relation/@target">   
                                                                <ul style="padding:0;margin-bottom:0;">
                                                                    <xsl:for-each select="./mei:relationList/mei:relation">                                                                        
                                                                        <xsl:variable name="relationID" select="tokenize(translate(@target, '#', ''), '\s')"/>
                                                                        <xsl:variable name="count" select="count($relationID)"/>
                                                                        <xsl:choose>
                                                                            <xsl:when test="$count > 1">
                                                                                <xsl:call-template name="multi-relation-loop">                                       
                                                                                    <xsl:with-param name="count" select="$count"/>
                                                                                    <xsl:with-param name="relationID" select="$relationID"/>
                                                                                    <xsl:with-param name="type" select="'table'"/>
                                                                                </xsl:call-template>                                                                                
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:variable name="refId" select="translate(@target, '#', '')"/>
                                                                                <xsl:if test="//id($refId)">
                                                                                    <xsl:for-each select="//id($refId)">
                                                                                        <li><xsl:value-of select="translate(./mei:title, '.', '')"/></li>                                                                                            
                                                                                    </xsl:for-each>
                                                                                </xsl:if>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>                                                                                                       
                                                                    </xsl:for-each>
                                                                </ul>                                                                                                  
                                                            </xsl:if>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:choose>
                                                                <xsl:when test="contains(ancestor::mei:expression/mei:title, 'erschienen')">
                                                                    <xsl:value-of select="concat(
                                                                        //mei:titleStmt/mei:title[1]/text(),
                                                                        ', ',
                                                                        //mei:work/mei:identifier[@label='Opus-Nummer'][1],
                                                                        if(ancestor::mei:expression/mei:title/text()) then(', ') else(''),
                                                                        substring-before( ancestor::mei:expression/mei:title, ' (erschienen')
                                                                        )"/>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <xsl:value-of select="concat(
                                                                        //mei:titleStmt/mei:title[1]/text(),
                                                                        ', ',
                                                                        //mei:work/mei:identifier[@label='Opus-Nummer'][1],
                                                                        if(ancestor::mei:expression/mei:title/text()) then(', ') else(''),
                                                                        ancestor::mei:expression/mei:title                                                                                                                        
                                                                        )"/>
                                                                </xsl:otherwise>
                                                            </xsl:choose>                                                                
                                                            <!--<xsl:if test="not(ancestor::mei:expression)">
                                                                <xsl:value-of select="./mei:relatedItem[@rel='host']/mei:bibl/mei:title"/>
                                                            </xsl:if>-->
                                                        </xsl:otherwise>
                                                    </xsl:choose>                                                    
                                                </td>     
                                                <td>
                                                    <a href="{$biblUrl}"> 
                                                        <svg xmlns="http://www.w3.org/2000/svg" 
                                                            width="16" 
                                                            height="16" 
                                                            fill="currentColor" 
                                                            class="bi bi-box-arrow-in-right" 
                                                            viewBox="0 0 16 16">
                                                            <path fill-rule="evenodd" 
                                                                d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                                                            <path fill-rule="evenodd" 
                                                                d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                                        </svg>
                                                    </a>
                                                </td>
                                                <td>  
                                                    <ul style="padding-left: 0;">
                                                        <xsl:for-each select="ancestor::mei:event/mei:persName">                                                                
                                                            <xsl:if test="./text()">                                                                    
                                                                <li><xsl:value-of select="."/></li>                                                                                                         
                                                            </xsl:if>                                                  
                                                        </xsl:for-each>
                                                    </ul>                                                                                                                                            
                                                </td>
                                                                                    
                                                <xsl:result-document href="{$biblUrl}">
                                                    <!--
                                                    <xsl:variable name="op_cap">
                                                        <xsl:if test="contains(//mei:workList/mei:work/mei:identifier[1], 'op.')">
                                                            <xsl:value-of select=""/>
                                                        </xsl:if>
                                                    </xsl:variable>-->
                                                    
                                                    <xsl:variable name="doc_title_3">
                                                        <xsl:value-of select="concat(//mei:workList/mei:work/mei:identifier[1], ', ', ancestor::mei:event/mei:date[1], ', ',  ./mei:title[1])"/>
                                                    </xsl:variable>
                                                    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                                                    <html>
                                                        <head>
                                                            <xsl:call-template name="html_head">
                                                                <xsl:with-param name="html_title" select="$doc_title_3"></xsl:with-param>
                                                            </xsl:call-template>  
                                                            <xsl:if test="contains(@type, 'Rubrik_3') or contains(@type, 'Rubrik_8') or contains(@type, 'Rubrik_17') or contains(@type, 'Rubrik_18') or contains(@type, 'Rubrik_80') or contains(@type, 'Rubrik_90') or contains(@type, 'Rubrik_100')">
                                                                <meta name="001 Filter"
                                                                    class="staticSearch_desc"
                                                                    content="Vorankündigung"/>  
                                                            </xsl:if>
                                                            <xsl:if test="contains(@type, 'Rubrik_1') or contains(@type, 'Rubrik_2')">
                                                                <meta name="001 Filter"
                                                                    class="staticSearch_desc"                                                                    
                                                                    content="Rezension"/>  
                                                            </xsl:if>
                                                            <xsl:if test="contains(@type, 'Rubrik_40')">
                                                                <meta name="001 Filter"
                                                                    class="staticSearch_desc"
                                                                    content="ohne erschlossene Daten"/>                                                                                                                                                                        
                                                            </xsl:if>         
                                                            <xsl:if test="ancestor::mei:work">
                                                                <xsl:for-each select="ancestor::mei:work">
                                                                    <meta name="002 Werk"
                                                                        class="staticSearch_feat"
                                                                        content="{concat(./mei:title, ', ', ./mei:identifier)}">                                                                        
                                                                    </meta>                                                                                                                     
                                                                </xsl:for-each>
                                                            </xsl:if>
                                                            <xsl:if test="ancestor::mei:work//mei:perfMedium">
                                                                <xsl:for-each select="ancestor::mei:work//mei:perfMedium/mei:perfResList/mei:perfResList/mei:perfRes">
                                                                    <meta name="003 Besetzung"
                                                                        class="staticSearch_feat"
                                                                        content="{.}">
                                                                    </meta>                                                                                                                     
                                                                </xsl:for-each>
                                                            </xsl:if>
                                                            <xsl:if test="ancestor::mei:work/mei:classification/mei:termList/mei:term">
                                                                <xsl:for-each select="ancestor::mei:work/mei:classification/mei:termList/mei:term[@type='1']">
                                                                    <meta name="004 Gattung"
                                                                        class="staticSearch_feat"
                                                                        content="{.}">
                                                                    </meta>                                                                                                                     
                                                                </xsl:for-each>
                                                            </xsl:if>
                                                            <xsl:if test="ancestor::mei:event/mei:geogName[@role='place' or @role='venue']/text()">
                                                                <xsl:for-each select="ancestor::mei:event/mei:geogName[@role='place'or @role='venue']">
                                                                    <meta name="005 Veranstaltungsort"
                                                                        class="staticSearch_feat"
                                                                        content="{.}">
                                                                    </meta> 
                                                                </xsl:for-each> 
                                                            </xsl:if>                                                                            
                                                            <xsl:if test="ancestor::mei:event/mei:persName/text()">
                                                                <xsl:for-each select="ancestor::mei:event/mei:persName">
                                                                    <meta name="006 Beteiligte Personen / Körperschaften"                                                                        
                                                                        class="staticSearch_feat"
                                                                        content="{.}">
                                                                    </meta>
                                                                    <meta name="007 Personen beteiligt als / mit"
                                                                        class="staticSearch_feat"
                                                                        content="{@type}">                                                                        
                                                                    </meta> 
                                                                </xsl:for-each>
                                                            </xsl:if>  
                                                            <xsl:if test="./mei:term/text()">
                                                                <xsl:for-each select="./mei:term">
                                                                    <meta name="008 Rubrik"
                                                                        class="staticSearch_feat">
                                                                        <xsl:if test=". = 'Rubrik_1' or . = 'Rubrik_2'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Werkkritik</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_3' or . = 'Rubrik_8'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Vorankündigung</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_4'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Werkerwähnung</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_5'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Anzeigen der Vorlage (Novitäten)</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_6'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Anzeigen der Vorlage</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_7'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Anzeigen der Redaktion (Werke)</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_9'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Brahms als Pianist</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_10'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Brahms als Dirigent</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_11'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Brahms als Editor</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_12' or . = 'Rubrik_13' or . = 'Rubrik_21'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Biographische oder historische Mitteilung</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_14'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Widmungen an Brahms</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_15'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Fremde Bearbeitung</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_16'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Vorlagen für andere Komponisten</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                        <xsl:if test=". = 'Rubrik_20'">
                                                                            <xsl:attribute name="content">
                                                                                <xsl:text>Varia</xsl:text>                                                                                                                           
                                                                            </xsl:attribute>
                                                                        </xsl:if>
                                                                    </meta>                                                                                                                     
                                                                </xsl:for-each>
                                                            </xsl:if>
                                                            <xsl:if test="./mei:author/text()">
                                                                <xsl:for-each select="./mei:author">
                                                                    <meta name="009 Verfasser"
                                                                        class="staticSearch_feat"
                                                                        content="{.}">
                                                                    </meta>                                                                                                                     
                                                                </xsl:for-each>
                                                            </xsl:if>
                                                            <xsl:if test="./mei:bibl/mei:title[1]/text()">                                                                                    
                                                                <xsl:for-each select="./mei:bibl/mei:title[1]">
                                                                    <meta name="010 Quelle"
                                                                        class="staticSearch_feat"
                                                                        content="{.}">
                                                                    </meta>   
                                                                </xsl:for-each>                                                                                                    
                                                            </xsl:if>                                                            
                                                            <xsl:if test="ancestor::mei:event/mei:date[@isodate]">
                                                                <xsl:for-each select="ancestor::mei:event/mei:date">
                                                                    <meta name="011 Zeitraum"
                                                                        class="staticSearch_date"
                                                                        content="{@isodate}">                                                                        
                                                                    </meta>
                                                                </xsl:for-each>                                                                                                                
                                                            </xsl:if>
                                                            <meta name="docTitle" class="staticSearch_docTitle">
                                                                <xsl:attribute name="content">
                                                                    <xsl:for-each select="ancestor::mei:event">  
                                                                        <xsl:text>ssStart </xsl:text>
                                                                        <xsl:choose>
                                                                            <xsl:when test="./mei:date/text()">
                                                                                <xsl:value-of select="./mei:date"/>                                                                                                
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:text>unbekannt</xsl:text>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>                                                            
                                                                        <xsl:if test="./mei:geogName[@role='place']/text()">
                                                                            <xsl:text>, </xsl:text>
                                                                            <xsl:value-of select="./mei:geogName[@role='place']"/>                                                                                            
                                                                        </xsl:if>
                                                                        <xsl:if test="./mei:geogName[@role='venue']/text()">
                                                                            <xsl:text>, </xsl:text>
                                                                            <xsl:value-of select="./mei:geogName[@role='venue']"/>                                                                                            
                                                                        </xsl:if>  
                                                                        <xsl:if test="ancestor::mei:work/mei:title/text()">
                                                                            <xsl:text>. </xsl:text>                                                                            
                                                                            <xsl:value-of select="ancestor::mei:work/mei:title"/>
                                                                            <xsl:text> </xsl:text>
                                                                            <xsl:value-of select="ancestor::mei:work/mei:identifier"/>                                                                            
                                                                        </xsl:if>  
                                                                        <!--<xsl:if test="ancestor::mei:work/mei:expressionList">
                                                                            <xsl:for-each select="ancestor::mei:work/mei:expressionList/mei:expression">
                                                                                <xsl:value-of select="replace(./mei:title, ' \(erschienen \d+\)', '')"/>
                                                                                <xsl:text> </xsl:text>
                                                                            </xsl:for-each>
                                                                        </xsl:if>-->
                                                                        <xsl:choose>
                                                                            <xsl:when test="contains(ancestor::mei:expression/mei:title, 'erschienen')">
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="substring-before(
                                                                                    ancestor::mei:expression/mei:title, ' (erschienen')"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:text> </xsl:text>
                                                                                <xsl:value-of select="ancestor::mei:expression/mei:title"/>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>                                                                
                                                                        <xsl:if test="not(ancestor::mei:expression)">
                                                                            <xsl:value-of select="./mei:relatedItem[@rel='host']/mei:bibl/mei:title"/>
                                                                        </xsl:if>
                                                                        <xsl:text>ssEnd</xsl:text>
                                                                        <xsl:text> ssStart </xsl:text>   
                                                                        <xsl:if test="./mei:persName[1]/text()">
                                                                            <xsl:value-of select="./mei:persName[1]"/>                                                                            
                                                                        </xsl:if>
                                                                        <xsl:choose>
                                                                            <xsl:when test="count(./mei:persName) > 1">
                                                                                <xsl:text> (+</xsl:text>
                                                                                <xsl:value-of select="count(./mei:persName) - 1"/>
                                                                                <xsl:text>) </xsl:text>
                                                                            </xsl:when>
                                                                            <xsl:when test="./mei:persName[1]/text() and not(//mei:expressionList/mei:expression)">
                                                                                <xsl:text>. </xsl:text>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>
                                                                                <xsl:text> </xsl:text>
                                                                            </xsl:otherwise>
                                                                        </xsl:choose>                                                                        
                                                                    </xsl:for-each>
                                                                    <xsl:choose>
                                                                        <xsl:when test="not(//mei:expressionList/mei:expression)">
                                                                            <xsl:if test="./mei:relationList/mei:relation/@target">
                                                                                <xsl:for-each select="./mei:relationList/mei:relation">
                                                                                    <xsl:variable name="relationID" select="tokenize(translate(@target, '#', ''), '\s')"/>
                                                                                    <xsl:variable name="count" select="count($relationID)"/>
                                                                                    <xsl:choose>
                                                                                        <xsl:when test="$count > 1">
                                                                                            <xsl:call-template name="multi-relation-loop">                                       
                                                                                                <xsl:with-param name="count" select="$count"/>
                                                                                                <xsl:with-param name="relationID" select="$relationID"/>
                                                                                                <xsl:with-param name="type" select="'metadata'"/>
                                                                                            </xsl:call-template>                                                                                         
                                                                                        </xsl:when>
                                                                                        <xsl:otherwise>
                                                                                            <xsl:variable name="refId" select="translate(@target, '#', '')"/>
                                                                                            <xsl:if test="//id($refId)">
                                                                                                <xsl:for-each select="//id($refId)">
                                                                                                    <xsl:value-of select="./mei:title"/>                                                                                            
                                                                                                    <xsl:text> </xsl:text> 
                                                                                                    <xsl:value-of select="./mei:identifier[@label='Opus-Nummer']"/>
                                                                                                </xsl:for-each>
                                                                                            </xsl:if>
                                                                                        </xsl:otherwise>
                                                                                    </xsl:choose>                                                                                                                                                   
                                                                                </xsl:for-each>
                                                                            </xsl:if>
                                                                        </xsl:when>
                                                                        <xsl:otherwise>
                                                                            
                                                                        </xsl:otherwise>
                                                                    </xsl:choose>                                                                    
                                                                    <xsl:text> ssEnd</xsl:text>  
                                                                    <xsl:text> ssStart </xsl:text>  
                                                                    <xsl:if test="./mei:annot/mei:p[@label='Vollständiger_Nachweis']/text()">
                                                                        <xsl:value-of select="./mei:annot/mei:p[@label='Vollständiger_Nachweis']"/>
                                                                    </xsl:if>                                                                  
                                                                    <xsl:text> ssEnd</xsl:text>  
                                                                </xsl:attribute>
                                                            </meta>
                                                        </head>
                                                        <body class="page">
                                                            <div class="hfeed site" id="page">
                                                                <xsl:call-template name="nav_bar"/>
                                                                
                                                                <div class="container-fluid">
                                                                    <div class="row">
                                                                        <div class="col-md-12">                                             
                                                                            <div class="card">
                                                                                <div class="card-header">                                                                                    
                                                                                    <h1 style="width:5%;display:inline-block;">                                                                                        
                                                                                        <a href="{$filename}.html">
                                                                                            <svg xmlns="http://www.w3.org/2000/svg" 
                                                                                                width="24" 
                                                                                                height="24" 
                                                                                                fill="currentColor" 
                                                                                                class="bi bi-box-arrow-left" 
                                                                                                viewBox="0 0 16 16">
                                                                                                <path fill-rule="evenodd" 
                                                                                                    d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0v2z"/>
                                                                                                <path fill-rule="evenodd" 
                                                                                                    d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z"/>
                                                                                            </svg>
                                                                                        </a>
                                                                                    </h1>                                                                                                                                                                                                                                                                                               
                                                                                </div>
                                                                                <div class="card-body">
                                                                                    <div class="ssSearchOn">
                                                                                        <table class="table event-table" id="workTableDetail">
                                                                                            <xsl:for-each select="ancestor::mei:event">
                                                                                                <xsl:if test="./mei:date">
                                                                                                    <tr>                                                                                                                        
                                                                                                        <th style="width:20%">Datum</th>
                                                                                                        <td>                                                                                                                            
                                                                                                            <xsl:for-each select="./mei:date">
                                                                                                                <xsl:apply-templates/>                                                                                                                                
                                                                                                            </xsl:for-each>                                                                                                                                                                                                                                                            
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </xsl:if>
                                                                                                <xsl:if test="./mei:geogName[@role='place']">
                                                                                                    <tr>
                                                                                                        <th style="width:20%">Ort</th>
                                                                                                        <td>
                                                                                                            <xsl:value-of select="./mei:geogName[@role='place']"/>                                                                                                                               
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </xsl:if>
                                                                                                <xsl:if test="./mei:geogName[@role='venue']">
                                                                                                    <tr>                                                                                                                        
                                                                                                        <th style="width:20%">Saal</th>
                                                                                                        <td>
                                                                                                            <xsl:value-of select="./mei:geogName[@role='venue']"/>                                                                                                                               
                                                                                                        </td>                                                                                                                        
                                                                                                    </tr>
                                                                                                </xsl:if>
                                                                                                <xsl:if test="./mei:persName">
                                                                                                    <tr>
                                                                                                        <th style="width:20%">Ausführende</th>     
                                                                                                        <td>
                                                                                                            <ul style="padding:0;margin-bottom:0;">
                                                                                                                <xsl:for-each select="./mei:persName">
                                                                                                                    <xsl:variable name="persUrl" select="tokenize(@corresp, '/')[last()]"/>
                                                                                                                    
                                                                                                                    <li style="margin-top:0;margin-bottom:.2em;">
                                                                                                                        <a href="personenregister-id-{$persUrl}.html">
                                                                                                                            <xsl:apply-templates/>
                                                                                                                        </a>
                                                                                                                        <xsl:text> (</xsl:text>
                                                                                                                        <xsl:value-of select="@type"/>
                                                                                                                        <xsl:text>)</xsl:text>
                                                                                                                    </li>
                                                                                                                </xsl:for-each>
                                                                                                            </ul>
                                                                                                        </td>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
                                                                                                    </tr>
                                                                                                </xsl:if>                                                                                                                                                                                                                                
                                                                                            </xsl:for-each>
                                                                                            <xsl:choose>
                                                                                                <xsl:when test="not(//mei:expressionList/mei:expression)">
                                                                                                    <xsl:if test="./mei:relationList/mei:relation/@target">
                                                                                                        <tr>
                                                                                                            <th style="width:20%">Werk</th>  
                                                                                                            <td>
                                                                                                                <xsl:for-each select="./mei:relationList/mei:relation">
                                                                                                                    <ul style="padding:0;margin-bottom:0;">
                                                                                                                        <xsl:variable name="relationID" select="tokenize(translate(@target, '#', ''), '\s')"/>
                                                                                                                        <xsl:variable name="count" select="count($relationID)"/>
                                                                                                                        <xsl:choose>
                                                                                                                            <xsl:when test="$count > 1">
                                                                                                                                <xsl:call-template name="multi-relation-loop">                                       
                                                                                                                                    <xsl:with-param name="count" select="$count"/>
                                                                                                                                    <xsl:with-param name="relationID" select="$relationID"/>
                                                                                                                                    <xsl:with-param name="type" select="'list'"/>
                                                                                                                                </xsl:call-template>                                                                                                                                
                                                                                                                            </xsl:when>
                                                                                                                            <xsl:otherwise>
                                                                                                                                <xsl:variable name="refId" select="translate(@target, '#', '')"/>
                                                                                                                                <xsl:if test="//id($refId)">
                                                                                                                                    <xsl:for-each select="//id($refId)">
                                                                                                                                        <li>
                                                                                                                                            <xsl:value-of select="ancestor::mei:workList/mei:work[1]/mei:title[1]"/>
                                                                                                                                            <xsl:text>, </xsl:text>
                                                                                                                                            <xsl:value-of select="translate(./mei:title, '.', '')"/>
                                                                                                                                            <xsl:text>, </xsl:text>
                                                                                                                                            <xsl:value-of select="./mei:identifier[@label='Opus-Nummer']"/>
                                                                                                                                        </li>                                                                                           
                                                                                                                                    </xsl:for-each>
                                                                                                                                </xsl:if>
                                                                                                                            </xsl:otherwise>
                                                                                                                        </xsl:choose>                                                                                                            
                                                                                                                    </ul>
                                                                                                                </xsl:for-each>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </xsl:if>
                                                                                                </xsl:when>
                                                                                                <xsl:otherwise>
                                                                                                    <xsl:choose>
                                                                                                        <xsl:when test="contains(ancestor::mei:expression/mei:title, 'erschienen')">
                                                                                                            <tr>
                                                                                                                <th style="width:20%">Werk</th>  
                                                                                                               <td>
                                                                                                                   <xsl:value-of select="concat(//mei:titleStmt/mei:title[1]/text(),
                                                                                                                       ', ',                                                                                                                       
                                                                                                                       //mei:work/mei:identifier[@label='Opus-Nummer'][1],
                                                                                                                       if(ancestor::mei:expression/mei:title/text()) then(', ') else(''),
                                                                                                                       substring-before(ancestor::mei:expression/mei:title, ' (erschienen')
                                                                                                                       )"/>
                                                                                                               </td>
                                                                                                            </tr>
                                                                                                        </xsl:when>
                                                                                                        <xsl:otherwise>
                                                                                                            <tr>
                                                                                                                <th style="width:20%">Werk</th>  
                                                                                                                <td>
                                                                                                                    <xsl:value-of select="concat(
                                                                                                                        //mei:titleStmt/mei:title[1]/text(),
                                                                                                                        ', ',
                                                                                                                        //mei:work/mei:identifier[@label='Opus-Nummer'][1],
                                                                                                                        if(ancestor::mei:expression/mei:title/text()) then(', ') else(''),
                                                                                                                        ancestor::mei:expression/mei:title                                                                                                                        
                                                                                                                        )"/>
                                                                                                                </td>
                                                                                                            </tr>                                                                                                            
                                                                                                        </xsl:otherwise>
                                                                                                    </xsl:choose>                                                                
                                                                                                    <!--<xsl:if test="not(ancestor::mei:expression)">
                                                                                                        <xsl:value-of select="./mei:relatedItem[@rel='host']/mei:bibl/mei:title"/>
                                                                                                    </xsl:if>-->
                                                                                                </xsl:otherwise>
                                                                                            </xsl:choose>
                                                                                              
                                                                                            <tr>
                                                                                                <th style="width:20%">Link zu ANNO (ÖNB)</th>                                                                                                                    
                                                                                                <td>
                                                                                                    <a target="_blank" href="{./mei:ptr[@label='ANNO-ÖNB']/@target}" title="{./mei:ptr[@label='ANNO-ÖNB']/@label}">
                                                                                                        <xsl:value-of select="./mei:annot/mei:p[@label='Vollständiger_Nachweis']"/>                                                                                                        
                                                                                                    </a>
                                                                                                </td>
                                                                                            </tr>
                                                                                            
                                                                                            
                                                                                            <tr>
                                                                                                <th style="width:20%">Rubrik</th>  
                                                                                                
                                                                                                <xsl:for-each select="./mei:term">
                                                                                                        <xsl:if test=". = 'Rubrik_1' or . = 'Rubrik_2'">
                                                                                                            <td>
                                                                                                                <xsl:text>Werkkritik</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                    <xsl:if test=". = 'Rubrik_3' or . = 'Rubrik_8' or . = 'Rubrik_17' or . = 'Rubrik_18' or . = 'Rubrik_80' or . = 'Rubrik_90' or . = 'Rubrik_100'">
                                                                                                            <td>
                                                                                                                <xsl:text>Vorankündigung</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_4'">
                                                                                                            <td>
                                                                                                                <xsl:text>Werkerwähnung</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_5'">
                                                                                                            <td>
                                                                                                                <xsl:text>Anzeigen der Vorlage (Novitäten)</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_6'">
                                                                                                            <td>
                                                                                                                <xsl:text>Anzeigen der Vorlage</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_7'">
                                                                                                            <td>
                                                                                                                <xsl:text>Anzeigen der Redaktion (Werke)</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_9'">
                                                                                                            <td>
                                                                                                                <xsl:text>Brahms als Pianist</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_10'">
                                                                                                            <td>
                                                                                                                <xsl:text>Brahms als Dirigent</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_11'">
                                                                                                            <td>
                                                                                                                <xsl:text>Brahms als Editor</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_12' or . = 'Rubrik_13' or . = 'Rubrik_21'">
                                                                                                            <td>
                                                                                                                <xsl:text>Biographische oder historische Mitteilung</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_14'">
                                                                                                            <td>
                                                                                                                <xsl:text>Widmungen an Brahms</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_15'">
                                                                                                            <td>
                                                                                                                <xsl:text>Fremde Bearbeitung</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_16'">
                                                                                                            <td>
                                                                                                                <xsl:text>Vorlagen für andere Komponisten</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                        <xsl:if test=". = 'Rubrik_20'">
                                                                                                            <td>
                                                                                                                <xsl:text>Varia</xsl:text>                                                                                                                           
                                                                                                            </td>
                                                                                                        </xsl:if>
                                                                                                </xsl:for-each>
                                                                                                
                                                                                                
                                                                                                
                                                                                            </tr>
                                                                                            
                                                                                            
                                                                                            
                                                                                            <xsl:if test="./mei:author/text()">
                                                                                            <tr>
                                                                                                <th style="width:20%">Verfasser</th>                                                                                                                    
                                                                                                <td>
                                                                                                    <ul style="padding:0;margin-bottom:0;">
                                                                                                        <xsl:for-each select="./mei:author">
                                                                                                            <xsl:variable name="persUrl" select="tokenize(@corresp, '/')[last()]"/>
                                                                                                            
                                                                                                            <li style="margin-top:0;margin-bottom:.2em;">
                                                                                                                <a href="personenregister-id-{$persUrl}.html">
                                                                                                                    <xsl:apply-templates/>
                                                                                                                </a>
                                                                                                            </li>
                                                                                                        </xsl:for-each>
                                                                                                    </ul>
                                                                                                </td>
                                                                                            </tr>
                                                                                            </xsl:if>
                                                                                            
                                                                                            
                                                                                            <tr>
                                                                                                <th style="width:20%">Weitere Informationen</th>
                                                                                                <td>
                                                                                                    <ul style="padding:0;margin:0;">
                                                                                                        <xsl:for-each select="./mei:annot/mei:p[@label='Weitere_Informationen']">
                                                                                                            <li style="margin:0;"><xsl:value-of select="replace(., '[()]', '')"/></li>
                                                                                                        </xsl:for-each>
                                                                                                    </ul>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <!--<tr>
                                                                                                <th>Zitierhinweis</th>
                                                                                                <td>
                                                                                                    <xsl:text> </xsl:text>
                                                                                                    <a href="{lower-case($biblUrl)}">
                                                                                                        <xsl:value-of
                                                                                                            select="lower-case($biblUrl)"/>
                                                                                                    </a>
                                                                                                    <xsl:text>, aufgerufen am </xsl:text>
                                                                                                    <span class="citationDateDe">
                                                                                                        <xsl:value-of select="format-date(current-date(), '[D].[M].[Y]')"/>
                                                                                                    </span>
                                                                                                    <xsl:text>.</xsl:text>
                                                                                                </td>
                                                                                            </tr>-->                                                                                            
                                                                                        </table>
                                                                                    </div>                                                                                                        
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
                                                </tr> 
                                            </xsl:for-each>
                                            
                                        </tbody>
                                        
                                    </table>
                                </div>                                                                
                            </div>
                        </div>
                                             
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
                <script type="text/javascript" src="js/dt-regular.js"/>
                <script>
                    $(document).ready(function () {
                        createDataTable('workTable')
                    });
                </script>
            </body>            
        </html>
    </xsl:template>      
    <xsl:template name="multi-relation-loop">
        <xsl:param name="relationID"/>        
        <xsl:param name="count"/>   
        <xsl:param name="type"/>
        <xsl:variable name="relID" select="$relationID"/>
        <xsl:variable name="count2" select="$count"/>
        <xsl:choose>
            <xsl:when test="$type = 'table'">
                <xsl:choose>
                    <xsl:when test="$count > 0">
                        <xsl:choose>
                            <xsl:when test="//id($relationID[$count])"> 
                                <xsl:for-each select="//id($relationID[$count])"> 
                                    <li style="margin-top:0;margin-bottom:.3em;">                                        
                                        <xsl:value-of select="translate(./mei:title, '.', '')"/>
                                    </li>                                                                      
                                </xsl:for-each>    
                            </xsl:when>
                            <xsl:otherwise>
                                
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:call-template name="multi-relation-loop">
                            <xsl:with-param name="count" select="$count2 - 1"/>
                            <xsl:with-param name="relationID" select="$relID"/>
                            <xsl:with-param name="type" select="'table'"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$type = 'list'">
                <xsl:choose>
                    <xsl:when test="$count > 0">
                        <xsl:choose>
                            <xsl:when test="//id($relationID[$count])"> 
                                <xsl:for-each select="//id($relationID[$count])">                                      
                                    <li style="margin-top:0;margin-bottom:.3em;">               
                                        <xsl:value-of select="ancestor::mei:workList/mei:work[1]/mei:title[1]"/>
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="translate(./mei:title, '.', '')"/>
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="./mei:identifier"/>
                                    </li> 
                                </xsl:for-each>    
                            </xsl:when>
                            <xsl:otherwise>
                                
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:call-template name="multi-relation-loop">
                            <xsl:with-param name="count" select="$count2 - 1"/>
                            <xsl:with-param name="relationID" select="$relID"/>
                            <xsl:with-param name="type" select="'list'"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="$type = 'metadata'">
                <xsl:choose>
                    <xsl:when test="$count > 0">
                        <xsl:choose>
                            <xsl:when test="//id($relationID[$count])"> 
                                <xsl:for-each select="//id($relationID[$count])"> 
                                    <xsl:value-of select="ancestor::mei:workList/mei:work[1]/mei:title[1]"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="translate(./mei:title, '.', '')"/>
                                    <xsl:text>, </xsl:text>
                                    <xsl:value-of select="./mei:identifier"/>
                                    <xsl:text> </xsl:text>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:call-template name="multi-relation-loop">
                            <xsl:with-param name="count" select="$count2 - 1"/>
                            <xsl:with-param name="relationID" select="$relID"/>
                            <xsl:with-param name="type" select="'metadata'"/>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>        
    </xsl:template>
   
</xsl:stylesheet>
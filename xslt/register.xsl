<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:mei="http://www.music-encoding.org/ns/mei" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl mei xs">
    <xsl:output encoding="UTF-8" 
        media-type="text/html" 
        method="xhtml" 
        version="1.0" 
        indent="yes" 
        omit-xml-declaration="yes"/>
    
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
                    <xsl:with-param name="html_title" 
                        select="'Personen &amp; Körperschaften'"/>
                </xsl:call-template>
                <style>
                    
                </style>
            </head>            
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div class="tei-logo">                           
                            <h1 style="text-align:right!important;">
                                <a href="{tokenize(document-uri(.))[last()]}?format=raw" title="TEI Source">
                                    <img alt="TEI Logo" src="images/TEI_Logo_36px.png" id="tei-logo"/>
                                </a>
                            </h1>                         
                        </div>
                        <div class="card card-top">
                            <div class="card-header">
                                <h1>Personen</h1>
                            </div>
                            <div class="card-body">
                                <xsl:apply-templates select="//mei:li"/>                                                       
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                    <script type="text/javascript" src="js/dt-alphabet-filter.js"/>
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
        <div class="table-responsive">
            <table id="registerTable" class="table table-striped display">            
                <thead>                
                   <tr>
                       <th>
                           Name
                       </th>     
                       <th>
                           Lebensdaten
                       </th>     
                       <th>
                           Funktion / Rolle 
                       </th>   
                       <th>
                           Metadaten 
                       </th> 
                   </tr>            
                </thead>
                <tbody>
                    <xsl:for-each select="./mei:persName">
                        <xsl:variable name="persUrl" 
                            select="concat(
                            replace(./mei:persName[@type='main'], ', ', '-'), 
                            '-', @xml:id, '.html')"/>
                        <tr>
                            <td>
                                <xsl:for-each select="./mei:persName[@type='main']">
                                    <xsl:value-of select="."/>
                                </xsl:for-each>    
                            </td>
                            <td>                            
                                <xsl:text>(</xsl:text>
                                <xsl:value-of select="./mei:date/mei:date[@type='birth']/mei:date"/>
                                <xsl:text>-</xsl:text>
                                <xsl:value-of select="./mei:date/mei:date[@type='death']/mei:date"/>
                                <xsl:text>)</xsl:text>                                                            
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
                                <a href="{$persUrl}" title="{./mei:persName[@type='main']}">
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
                        </tr>              
                        <xsl:variable name="registerUri" select="replace(tokenize(document-uri(/), '/')[last()], '.xml', '.html')"/>
                        <xsl:result-document href="{$persUrl}">
                            <xsl:variable name="doc_title_3">
                                <xsl:value-of select="concat(
                                    ancestor::mei:list/mei:head, 
                                    ' ', 
                                    ./mei:persName[@type='main'])"/>
                            </xsl:variable>
                            <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
                            <html>
                                <head>
                                    <xsl:call-template name="html_head">
                                        <xsl:with-param name="html_title" select="$doc_title_3"/>
                                    </xsl:call-template>
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
                                                                <a href="{$registerUri}">
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
                                                            <h1 style="width:85%;display:inline-block;">                                                                                                                        
                                                                <xsl:value-of select="./mei:persName[@type='main']"/>
                                                            </h1>                                                                                                        
                                                        </div>
                                                        <div class="card-body">
                                                            <div class="table-responsive">
                                                                <table class="table person-table" id="registerTableDetail">   
                                                                    <!--<xsl:if test="./mei:persName[@type='main']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Name</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:persName[@type='main']"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>-->
                                                                    <xsl:if test="./mei:famName/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Familienname</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:famName"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>                                                                
                                                                    <xsl:if test="./mei:foreName/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Vorname</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:foreName"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:persName[@type='alternative']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Name (alternativ)</th>
                                                                            <td>
                                                                                <ul style="padding:0;margin:0;">
                                                                                    <xsl:for-each select="./mei:persName[@type='alternative']">
                                                                                        <xsl:choose>
                                                                                            <xsl:when test="position() > 1">
                                                                                                <li style="margin:0;" class="fade about-text-hidden">
                                                                                                    <xsl:value-of select="."/>
                                                                                                </li>                                                                                            
                                                                                            </xsl:when>
                                                                                            <xsl:otherwise>
                                                                                                <li style="margin:0;">
                                                                                                    <xsl:value-of select="."/>
                                                                                                </li>                                                                                            
                                                                                            </xsl:otherwise>
                                                                                        </xsl:choose>                                                                                    
                                                                                    </xsl:for-each>
                                                                                    <li style="margin:0;cursor:pointer;color:#88dbdf;" 
                                                                                        id="show-text">mehr anzeigen</li>
                                                                                </ul>                                                                            
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:persName[@type='birth']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Geburtsname</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:persName[@type='birth']"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:persName[@type='pseudonym']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Pseudonym</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:persName[@type='pseudonym']"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:identifier[@label='Register-ID']/text()">
                                                                        <!--<tr>
                                                                            <th style="width:20%;"><xsl:value-of select="./mei:identifier[@label='Register-ID']/@label"/></th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:identifier[@label='Register-ID']"/>
                                                                            </td>
                                                                        </tr>-->
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:identifier[@lauth='GND']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">GND</th>
                                                                            <td>
                                                                                <xsl:value-of select="concat(
                                                                                    ./mei:identifier[@auth='GND']/@auth.uri,
                                                                                    ./mei:identifier[@auth='GND'])"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>                                                                
                                                                    <xsl:if test="./mei:date/mei:date[@type='birth']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Geburtsdatum</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:date/mei:date[@type='birth']/mei:date"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:date/mei:date[@type='birth']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Geburtsort</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:date/mei:date[@type='birth']/mei:geogName"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:date/mei:date[@type='death']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Sterbedatum</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:date/mei:date[@type='death']/mei:date"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:date/mei:date[@type='death']/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Sterbeort</th>
                                                                            <td>
                                                                                <xsl:value-of select="./mei:date/mei:date[@type='death']/mei:geogName"/>
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:catchwords/mei:term/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Funktion/Rolle</th>
                                                                            <td>
                                                                                <ul style="padding:0;margin:0;">
                                                                                    <xsl:for-each select="./mei:catchwords/mei:term">
                                                                                        <li style="margin:0;">
                                                                                            <xsl:value-of select="."/>
                                                                                        </li>
                                                                                    </xsl:for-each>
                                                                                </ul>                                                                            
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>
                                                                    <xsl:if test="./mei:ptr[@label='OeML']/@target or 
                                                                        ./mei:ptr[@label='OeBL']/@target or 
                                                                        ./mei:ptr[@label='BMLO']/@target or 
                                                                        ./mei:ptr[@label='ABLO']/@target">
                                                                            <tr>
                                                                                <th>Links</th>
                                                                                <td>
                                                                                    <ul style="padding:0;margin-bottom:0;">
                                                                                        <xsl:if test="./mei:ptr[@label='OeML']/@target and
                                                                                            not(starts-with(./mei:ptr[@label='OeML']/@target, '#'))">
                                                                                            
                                                                                            <li style="margin-top:0;margin-bottom:.2em;">
                                                                                                <a href="{./mei:ptr[@label='OeML']/@target}" 
                                                                                                    title="{./mei:ptr[@label='OeML']/@label}"
                                                                                                    target="_blank">
                                                                                                    OeML
                                                                                                </a>
                                                                                            </li>
                                                                                        </xsl:if>
                                                                                        <xsl:if test="./mei:ptr[@label='OeBL']/@target and
                                                                                            not(starts-with(./mei:ptr[@label='OeBL']/@target, '#'))"> 
                                                                                            
                                                                                            <li style="margin-top:0;margin-bottom:.2em;">
                                                                                                <a href="{./mei:ptr[@label='OeBL']/@target}" 
                                                                                                    title="{./mei:ptr[@label='OeBL']/@label}"
                                                                                                    target="_blank">
                                                                                                    OeBL
                                                                                                </a>
                                                                                            </li>
                                                                                        </xsl:if>
                                                                                        <xsl:if test="./mei:ptr[@label='BMLO']/@target and
                                                                                            not(starts-with(./mei:ptr[@label='BMLO']/@target, '#'))">
                                                                                            
                                                                                            <li style="margin-top:0;margin-bottom:.2em;">
                                                                                                <a href="{./mei:ptr[@label='BMLO']/@target}" 
                                                                                                    title="{./mei:ptr[@label='BMLO']/@label}"
                                                                                                    target="_blank">
                                                                                                    BMLO
                                                                                                </a>
                                                                                            </li>
                                                                                        </xsl:if>
                                                                                        <xsl:if test="./mei:ptr[@label='ABLO']/@target and
                                                                                            not(starts-with(./mei:ptr[@label='ABLO']/@target, '#'))">
                                                                                            
                                                                                            <li style="margin-top:0;margin-bottom:.2em;">
                                                                                                <a href="{./mei:ptr[@label='ABLO']/@target}" 
                                                                                                    title="{./mei:ptr[@label='ABLO']/@label}"
                                                                                                    target="_blank">
                                                                                                    ABLO
                                                                                                </a>
                                                                                            </li>
                                                                                        </xsl:if>
                                                                                        <xsl:if test="./mei:annot[@label='Kurzbiographie']/mei:p/@ref">
                                                                                            <xsl:for-each select="./mei:annot[@label='Kurzbiographie']/mei:p/@ref">
                                                                                                <li style="margin-top:0;margin-bottom:.2em;">
                                                                                                    <a title="Kurzbiographie" href="{.}">
                                                                                                        <xsl:value-of select="concat(
                                                                                                            'Kurzbiographie', ' Link ', position())"/>
                                                                                                    </a>                                                                                            
                                                                                                </li>
                                                                                            </xsl:for-each>
                                                                                        </xsl:if>
                                                                                    </ul>
                                                                                </td>
                                                                            </tr>
                                                                        
                                                                    </xsl:if>                                                                
                                                                    <!--<xsl:if test="./mei:annot[@label='Kommentar']/mei:p/text()">
                                                                        <tr>
                                                                            <th style="width:20%;">Kommentar</th>
                                                                            <td>
                                                                                <ul style="padding:0;margin:0;">
                                                                                    <xsl:for-each select="./mei:annot[@label='Kommentar']/mei:p">
                                                                                        <li style="margin:0;"><xsl:value-of select="."/></li>
                                                                                    </xsl:for-each>
                                                                                </ul>                                                                                                                                                       
                                                                            </td>
                                                                        </tr>
                                                                    </xsl:if>-->
                                                                </table>
                                                            </div>                                                        
                                                        </div>
                                                    </div>                                                                                                
                                                </div>                                                                                                                                                              
                                            </div>                   
                                        </div>
                                        
                                        <xsl:call-template name="html_footer"/>                                    
                                    </div>
                                    <script type="text/javascript">
                                        $('#show-text').click(function () {
                                            if ($('.about-text-hidden').hasClass('fade') == true) {
                                                $('.about-text-hidden').removeClass('fade')
                                                .addClass('active');
                                                $(this).html('weniger anzeigen');
                                            } else {
                                                $('.about-text-hidden').removeClass('active')
                                                .addClass('fade');
                                                $(this).html('mehr anzeigen');
                                            }  
                                        });
                                    </script>
                                </body>                            
                            </html>
                        </xsl:result-document>
                    </xsl:for-each>  
                </tbody>
            </table>
        </div>
    </xsl:template>    
    
</xsl:stylesheet>
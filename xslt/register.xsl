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
                    <xsl:with-param name="html_title" select="'Personen &amp; Körperschaften'"></xsl:with-param>
                </xsl:call-template>
                <style>
                    
                </style>
            </head>            
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div class="card card-top">
                            <div class="card-header">
                                <h1>Personen &amp; Körperschaften</h1>
                            </div>
                            <div class="card-body">
                                <div class="yes-index" style="max-width:100%;">
                                    <xsl:apply-templates select="//mei:li"/>                                                       
                                </div>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
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
                       Funktion/Rolle 
                   </th>   
                   <th>
                       Weitere Informationen 
                   </th> 
               </tr>            
            </thead>
            <tbody>
                <xsl:for-each select="./mei:persName">
                    <xsl:variable name="persUrl" select="concat(replace(./mei:persName[@type='main'], ', ', '-'), '-', @xml:id, '.html')"/>
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
                                Weitere Informationen
                            </a>                            
                        </td>
                    </tr>                    
                    <xsl:result-document href="{$persUrl}">
                        <xsl:variable name="doc_title_3">
                            <xsl:value-of select="concat(ancestor::mei:list/mei:head, ' ', ./mei:persName[@type='main'])"/>
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
                                        <div class="row">
                                            <div class="col-md-12">                                             
                                                <div class="card">
                                                    <div class="card-header">
                                                        <h1><xsl:value-of select="./mei:persName[@type='main']"/></h1>                                                                                                        
                                                    </div>
                                                    <div class="card-body">
                                                        <div class="table-responsive">
                                                            <table class="table">   
                                                                <xsl:if test="./mei:persName[@type='main']/text()">
                                                                    <tr>
                                                                        <th style="width:20%;">Name</th>
                                                                        <td>
                                                                            <xsl:value-of select="./mei:persName[@type='main']"/>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:persName[@type='alternative']/text()">
                                                                    <tr>
                                                                        <th style="width:20%;">Name (alternativ)</th>
                                                                        <td>
                                                                            <ul style="padding:0;margin:0;">
                                                                                <xsl:for-each select="./mei:persName[@type='alternative']">
                                                                                    <li style="margin:0;"><xsl:value-of select="."/></li>
                                                                                </xsl:for-each>
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
                                                                <xsl:if test="./mei:persName[@type='birth']/text()">
                                                                    <tr>
                                                                        <th style="width:20%;">Pseudonym</th>
                                                                        <td>
                                                                            <xsl:value-of select="./mei:persName[@type='pseudonym']"/>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:identifier[@label='Register-ID']/text()">
                                                                    <tr>
                                                                        <th style="width:20%;"><xsl:value-of select="./mei:identifier[@label='Register-ID']/@label"/></th>
                                                                        <td>
                                                                            <xsl:value-of select="./mei:identifier[@label='Register-ID']"/>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:identifier[@lauth='GND']/text()">
                                                                    <tr>
                                                                        <th style="width:20%;">GND</th>
                                                                        <td>
                                                                            <xsl:value-of select="concat(./mei:identifier[@auth='GND']/@auth.uri ,./mei:identifier[@auth='GND'])"/>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
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
                                                                                    <li style="margin:0;"><xsl:value-of select="."/></li>
                                                                                </xsl:for-each>
                                                                            </ul>                                                                            
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:ptr[@label='OeML']/@target and not(starts-with(./mei:ptr[@label='OeML']/@target, '#'))">
                                                                    <tr>
                                                                        <th style="width:20%;">OeML</th>
                                                                        <td>
                                                                            <a href="{./mei:ptr[@label='OeML']/@target}" 
                                                                               title="{./mei:ptr[@label='OeML']/@label}"
                                                                               target="_blank">
                                                                               Link
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:ptr[@label='OeBL']/@target and not(starts-with(./mei:ptr[@label='OeBL']/@target, '#'))">
                                                                    <tr>
                                                                        <th style="width:20%;">OeBL</th>
                                                                        <td>
                                                                            <a href="{./mei:ptr[@label='OeBL']/@target}" 
                                                                                title="{./mei:ptr[@label='OeBL']/@label}"
                                                                                target="_blank">
                                                                                Link
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:ptr[@label='BMLO']/@target and not(starts-with(./mei:ptr[@label='BMLO']/@target, '#'))">
                                                                    <tr>
                                                                        <th style="width:20%;">BMLO</th>
                                                                        <td>
                                                                            <a href="{./mei:ptr[@label='BMLO']/@target}" 
                                                                                title="{./mei:ptr[@label='BMLO']/@label}"
                                                                                target="_blank">
                                                                                Link
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:ptr[@label='ABLO']/@target and not(starts-with(./mei:ptr[@label='ABLO']/@target, '#'))">
                                                                    <tr>
                                                                        <th style="width:20%;">ABLO</th>
                                                                        <td>
                                                                            <a href="{./mei:ptr[@label='ABLO']/@target}" 
                                                                                title="{./mei:ptr[@label='ABLO']/@label}"
                                                                                target="_blank">
                                                                                Link
                                                                            </a>
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:annot[@label='Kurzbiographie']/mei:p/text()">
                                                                    <tr>
                                                                        <th style="width:20%;">Kurzbiographie</th>
                                                                        <td>
                                                                            <ul style="padding:0;margin:0;">
                                                                                <xsl:for-each select="./mei:annot[@label='Kurzbiographie']/mei:p">
                                                                                    <li style="margin:0;"><xsl:value-of select="."/></li>
                                                                                </xsl:for-each>
                                                                            </ul>                                                                                                                                                       
                                                                        </td>
                                                                    </tr>
                                                                </xsl:if>
                                                                <xsl:if test="./mei:annot[@label='Kommentar']/mei:p/text()">
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
                                                                </xsl:if>
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
                </xsl:for-each>  
            </tbody>
        </table>
    </xsl:template>    
    
</xsl:stylesheet>
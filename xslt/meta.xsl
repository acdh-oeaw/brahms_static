<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xi="http://www.w3.org/2001/XInclude"
    version="2.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:title[@type='main'][1]/text()"/>
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
                    
                    <div class="container-fluid" style="margin: 2em auto;">                        
                             
                        <xsl:if test="contains($doc_title, 'Rezensenten')">
                            <div class="card-body">  
                                <h1 style="margin-bottom:1em;"><xsl:value-of select="$doc_title"/></h1>
                                <ul style="text-align:center;margin:0 auto;">
                                    <xsl:for-each select="//tei:body/tei:div/tei:div">
                                        <li style="display:inline;margin-right:.5em;">
                                            <a href="#{@xml:id}">
                                                <xsl:value-of select="tokenize(./tei:head , '\s')[last()]"/>
                                            </a>                                                
                                        </li>
                                    </xsl:for-each>
                                </ul>          
                            </div>
                        </xsl:if>                                
                       
                         <xsl:apply-templates select=".//tei:body"/>
                                                      
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
                <script type="text/javascript">
                    $(document).on('click', 'a[href^="#"]', function (event) {
                        event.preventDefault();
                    
                    $('html, body').animate({
                            scrollTop: $($.attr(this, 'href')).offset().top
                        }, 500);
                    });
                </script>
            </body>
        </html>
    </xsl:template>
    
    <!--<xsl:template match="xi:include[concat('../data/meta/', @href)][@parse='xml' or not(@parse)][unparsed-text-available(concat('../data/meta/', @href))]">
        <xsl:apply-templates select="document(concat('../data/meta/', @href))//tei:body" />
    </xsl:template>-->
    <xsl:template match="tei:p">
        <xsl:choose>
            <xsl:when test="@rend='quote'">
                <p class="quote" id="{generate-id()}"><xsl:apply-templates/></p>
            </xsl:when>
            <xsl:otherwise>
                <p id="{generate-id()}">
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    <xsl:template match="tei:div">
        <div id="{@xml:id}"><xsl:apply-templates/></div>
    </xsl:template>
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend='italic'">
                <span class="italic"><xsl:apply-templates/></span>
            </xsl:when>
            <xsl:when test="@rend='bold'">
                <span class="bold"><xsl:apply-templates/></span>
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>
    <xsl:template match="tei:listRef">
        <ul style="text-align:center;margin:0 auto;padding:0;">
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="parent::tei:listRef">
                <li style="display:inline;margin-right:.5em;">
                    <a href="{@target}"><xsl:apply-templates/></a>
                </li>
            </xsl:when>
            <xsl:otherwise>
                <a target="_blank" href="{@target}"><xsl:apply-templates/></a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:head">
        <h3 style="margin:1em;">
            <xsl:apply-templates/>
        </h3>        
    </xsl:template> 
    <xsl:template match="tei:head[1]">
        <h2 style="margin:1em;">
            <xsl:apply-templates/>
        </h2>        
    </xsl:template> 
    <xsl:template match="tei:list">
        <xsl:choose>
            <xsl:when test="ancestor::tei:div/@xml:id = 'content-d1e00003'">
                <div class="row">
                    <xsl:for-each select="./tei:item">          
                        <xsl:variable name="ref-target" select="substring-after(./tei:ref/@target, '#')"/>
                        <div class="col-md-6">
                            <a title="{./tei:ref/text()} {./text()}"
                                href="{concat('zeitungen-detail-', $ref-target, '.html')}">          
                                <div class="card">
                                    <div class="card-header">
                                        <h5><xsl:value-of select="concat(./tei:ref, ' ', ./text())"/></h5>
                                    </div>
                                    <div class="card-body" style="padding:0!important;text-align:center;">
                                        <xsl:variable name="zeitungen-url" select="document(concat('../data/meta/detail/' ,//xi:include/@href))//tei:body/tei:div/tei:div[@xml:id = $ref-target]/tei:figure/tei:graphic/@url"/>
                                        <img src="{$zeitungen-url}"></img>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </xsl:for-each>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:for-each select="./tei:item">
                        <li style="list-style:circle;"><xsl:apply-templates/></li>
                    </xsl:for-each>            
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>  
    <xsl:template match="tei:figure">
        <xsl:for-each select="./tei:graphic">
            <p style="margin:1em;">
                <img src="{@url}"/>            
                <p style="margin:1em;">
                    <small>
                        <xsl:value-of select="parent::tei:figure/tei:head"/>
                    </small>
                </p>  
            </p>
        </xsl:for-each>        
    </xsl:template>  
    <xsl:template match="tei:table">
        <table class="table" style="border:none;margin-top:1.5em;">
            <tbody>
                <xsl:for-each select="./tei:row">
                    <tr>
                        <xsl:for-each select="./tei:cell">
                            <td><xsl:apply-templates/></td>
                        </xsl:for-each>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    <xsl:template match="tei:listBibl">
        <ul class="listbibl"><xsl:apply-templates/></ul>
    </xsl:template>
    <xsl:template match="tei:bibl">
        <xsl:choose>
            <xsl:when test="ancestor::tei:listBibl">
                <li>
                    <span class="bibl">
                        <xsl:apply-templates/>
                    </span>
                </li>
            </xsl:when>
            <xsl:otherwise>
                <span class="bibl">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>        
                
    </xsl:template>    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
</xsl:stylesheet>
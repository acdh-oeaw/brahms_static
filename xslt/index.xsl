<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
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
                    <xsl:with-param name="html_title" select="'Brahms-Online'"></xsl:with-param>
                </xsl:call-template>
            </head>  
            
            <body class="page">
                <div class="hfeed site" id="page" style="padding:0!important;">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container" style="max-width:100%;padding:0!important;">                        
                        <div class="wrapper" id="wrapper-hero-content" style="background-image: url('images/Startseite_Collage_Logo_ohne_Texte_1920.png');">
                            
                            <div class="container-fluid-content hero-light" id="wrapper-hero-inner" tabindex="-1">
                                <div class="row">
                                    <div class="col-md-8" style="padding: 0 0 0 4em;">
                                        <div class="main-title">
                                            <!--<h1 style="color:#615a60;padding:.2em;margin:0;">Brahms-Online</h1>-->
                                            <h3 style="color:#000;padding:.2em .5em;margin:0;text-align:left;">
                                                Willkommen auf Brahms-online! <br/> 
                                                Hier finden Sie Informationen zur Brahms-Rezeption in Wien 1862-1902.
                                            </h3>
                                        </div>                                          
                                        <button class="btn btn-round" style="padding: 1em;margin:1em;">
                                            <a href="01-ueber-das-projekt.html" style="font-size:22px;color:#000;">Über das Projekt</a>
                                        </button>
                                        <button class="btn btn-round" style="padding: 1em;margin:1em;">
                                            <a href="search.html" style="font-size:22px;color:#000;">Zur Datenbank-Suche</a>
                                        </button>
                                    </div>
                                </div>                                          
                                <div class="quote-box">
                                    <p>"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam."</p>
                                </div>
                            </div>                                  
                        </div>
                    </div>
                    <xsl:call-template name="html_footer"/>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
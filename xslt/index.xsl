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
                    <xsl:with-param name="html_title" select="'Brahms-Online – Best Brahms Site'"></xsl:with-param>
                </xsl:call-template>
            </head>  
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container">                        
                        <div class="wrapper" id="wrapper-hero-content">
                            
                            <div class="container-fluid-content hero-light" id="wrapper-hero-inner" tabindex="-1">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="main-title">
                                            <h1 style="color:#615a60;padding:.5em;margin:0;">Brahms-Online</h1>
                                            <h4 style="color:#615a60;padding:.2em .5em;margin:0;text-align:left;">Willkommen auf Brahms-online! Hier finden Sie Informationen zur Brahms-Rezeption in Wien 1862-1902.</h4>
                                        </div>                                          
                                        <button class="btn btn-round" style="margin:1em;text-align:center;">
                                            <a href="01-ueber-das-projekt.html"
                                                style="font-size:18px;color:#444;">Über das Projekt</a>
                                        </button>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="card">
                                            <div class="card-body">                                        
                                                <h5>Suche</h5>       
                                                <p style="margin-bottom:.5em;">Durchsuchen Sie die Datenbank über diverse Suchfunktionen:</p>
                                                <form class="form-inline my-2 my-lg-0 navbar-search-form"
                                                    method="get"
                                                    action="search.html"
                                                    role="search">
                                                    <input class="form-control navbar-search" id="s" name="q" type="text" placeholder="Search" value="" autocomplete="off" />
                                                    <button type="submit" class="navbar-search-icon">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
                                                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
                                                        </svg>
                                                    </button>
                                                </form>                                        
                                            </div>                                                                       
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
    </xsl:template>
    
</xsl:stylesheet>
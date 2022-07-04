<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <div class="wrapper-fluid wrapper-navbar sticky-navbar" id="wrapper-navbar" >
            <a class="skip-link screen-reader-text sr-only" href="#content">Skip to content</a>
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container-fluid" >
                    <!-- Your site title as branding in the menu -->
                    <a href="index.html" class="navbar-brand custom-logo-link" rel="home" itemprop="url"><img src="{$project_logo}" class="img-fluid" title="{$project_short_title}" alt="{$project_short_title}" itemprop="logo" /></a><!-- end custom logo -->
                    <!--<a class="navbar-brand site-title-with-logo" rel="home" href="index.html" title="{$project_short_title}" itemprop="url"><xsl:value-of select="$project_short_title"/></a>-->
                    <span style="margin-left:-1.7em;" class="badge bg-light text-dark">in development</span>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                        <!-- Your menu goes here -->
                        <ul id="main-menu" class="navbar-nav" style="margin-right:0!important;">
                            <li class="nav-item dropdown">
                                <a title="Projekt" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Projekt<span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Über das Projekt" href="01-ueber-das-projekt.html" class="nav-link">Über das Projekt</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Wiener Presse" href="02-wiener-presse.html" class="nav-link">Wiener Presse</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Zeitungen" href="03-00-Zeitungen-allgemein.html" class="nav-link">Zeitungen</a>
                                    </li>                                    
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Rezensenten" href="04-rezensenten.html" class="nav-link">Rezensenten</a>
                                    </li>
                                </ul>                                
                            </li>
                            <li class="nav-item dropdown">
                                <a title="Brahms’ Wien" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Brahms’ Wien<span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Brahms in Wien" href="05-brahms-in-wien.html" class="nav-link">Brahms in Wien</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Auffuhrungsorte" href="06-auffuehrungsorte.html" class="nav-link">Aufführungsorte</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Brahms-Interpret*innen" href="07-interpretinnen.html" class="nav-link">Brahms-Interpret*innen</a>
                                    </li>
                                </ul>                                
                            </li>
                            <li class="nav-item dropdown">
                                <a title="Datenbank" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Datenbank<span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Wiener Presse" href="02-benutzerhinweise.html" class="nav-link">Benutzerhinweise</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Suche" href="search.html" class="nav-link">Suche</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Personen" href="Personenregister-verkuerzt.html" class="nav-link">Personen</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Werke" href="toc.html" class="nav-link">Werke</a>
                                    </li>                                  
                                </ul>                                
                            </li>
                            <li class="nav-item dropdown">
                                <a title="Forschung" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Forschung<span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">                                    
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Literatur" href="08-literatur.html" class="nav-link">Literatur</a>
                                    </li>
                                </ul>                                
                            </li>
                            <!--<li class="nav-item"><a title="Suche" href="index.html" class="nav-link">Suche</a></li>
                            <li class="nav-item"><a title="Personen" href="Personenregister-verkuerzt.html" class="nav-link">Personen</a></li>
                            <li class="nav-item"><a title="Werke" href="toc.html" class="nav-link">Werke</a></li>-->
                            <li class="nav-item"><a title="Kontakt" href="09-kontakt.html" class="nav-link">Kontakt</a></li>
                        </ul>                        
                        <!--<form class="form-inline my-2 my-lg-0 navbar-search-form" method="get" action="search.html" role="search">
                            <input class="form-control navbar-search" id="s" name="q" type="text" placeholder="Search" value="" autocomplete="off" />
                            <button type="submit" class="navbar-search-icon">
                                <i data-feather="search"></i>
                            </button>
                        </form>-->
                    </div>
                    <!-- .collapse navbar-collapse -->
                </div>
                <!-- .container -->
            </nav>
            <!-- .site-navigation -->
        </div>
    </xsl:template>
</xsl:stylesheet>
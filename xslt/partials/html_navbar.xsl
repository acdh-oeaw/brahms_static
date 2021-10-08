<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xsl tei xs" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <xsl:param name="site_title">
            Brahms Online
        </xsl:param>
        <div class="wrapper-fluid wrapper-navbar sticky-navbar" id="wrapper-navbar" >
            <a class="skip-link screen-reader-text sr-only" href="#content">Skip to content</a>
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container" >
                    <!-- Your site title as branding in the menu -->
                    <a href="https://brahmsonline.acdh-dev.oeaw.ac.at/" class="navbar-brand custom-logo-link" rel="home" itemprop="url"><img src="images/Logo_Farbe_58bcc1_Transp-1-e1627912863339.png" class="img-fluid" title="{$site_title}" alt="{$site_title}" itemprop="logo" /></a><!-- end custom logo -->
                    <a class="navbar-brand site-title-with-logo" rel="home" href="index.html" title="{$site_title}" itemprop="url"><!--<xsl:value-of select="$site_title"/>--></a>
                    <span style="margin-left:-1.7em;" class="badge bg-light text-dark">in development</span>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navbarNavDropdown">
                        <!-- Your menu goes here -->
                        <ul id="main-menu" class="navbar-nav">
                            <li class="nav-item dropdown">
                                <a title="Papers" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Über das Projekt <span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Allgemein" href="https://brahmsonline.acdh-dev.oeaw.ac.at/allgemein/" class="nav-link">Allgemein</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Vorgeschichte" href="https://brahmsonline.acdh-dev.oeaw.ac.at/about/vorgeschichte/" class="nav-link">Vorgeschichte</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Wiener Arbeitsstelle" href="https://brahmsonline.acdh-dev.oeaw.ac.at/about/wiener-arbeitsstelle/" class="nav-link">Wiener Arbeitsstelle</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Zeitungen" href="https://brahmsonline.acdh-dev.oeaw.ac.at/about/zeitungen/" class="nav-link">Zeitungen</a>
                                    </li>
                                </ul>                                
                            </li>
                            <li class="nav-item dropdown">
                                <a title="Wien zu Brahms-Zeit" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Wien zu Brahms-Zeit <span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Brahms in Wien" href="https://brahmsonline.acdh-dev.oeaw.ac.at/brahms-in-wien/" class="nav-link">Brahms in Wien</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Aufführungsorte" href="https://brahmsonline.acdh-dev.oeaw.ac.at/auffuhrungsorte/" class="nav-link">Aufführungsorte</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Brahms-Interpreten" href="https://brahmsonline.acdh-dev.oeaw.ac.at/brahms-interpreten/" class="nav-link">Brahms-Interpreten</a>
                                    </li>
                                </ul>                                
                            </li> 
                            <li class="nav-item dropdown">
                                <a title="Die Wiener Presse" href="#" data-toggle="dropdown" class="nav-link dropdown-toggle">Die Wiener Presse <span class="caret"></span></a>
                                <ul class=" dropdown-menu" role="menu">
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Allgemein" href="https://brahmsonline.acdh-dev.oeaw.ac.at/die-wiener-presse/" class="nav-link">Allgemein</a>
                                    </li>
                                    <li class="nav-item dropdown-submenu">
                                        <a title="Rezensenten" href="https://brahmsonline.acdh-dev.oeaw.ac.at/rezensenten/" class="nav-link">Rezensenten</a>
                                    </li>
                                </ul>                                
                            </li>
                            <li class="nav-item"><a title="Datenbank" href="index.html" class="nav-link">Datenbank</a></li>
                            <li class="nav-item"><a title="Kontakt" href="https://brahmsonline.acdh-dev.oeaw.ac.at/kontakt/" class="nav-link">Kontakt</a></li>                       
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
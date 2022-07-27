<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Datenbanksuche'"/>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml"
              lang="de">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
                </xsl:call-template>
            </head>  
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header">
                                <h1>
                                    <xsl:value-of select="$doc_title"/>
                                    <a id="searchInfoModalButton" class="btn btn-sm" type="button" data-toggle="modal" data-target="#searchInfoModal">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-info-square" viewBox="0 0 16 16">
                                            <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
                                            <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
                                        </svg>
                                    </a> 
                                </h1>
                            </div>
                            <div class="card-body">
                                <div id="staticSearch"/>                            
                            </div>
                        </div>
                    </div>
                    
                    <xsl:call-template name="html_footer"/>
                    <!-- Modal -->
                    <div class="modal fade" id="searchInfoModal" tabindex="-1" aria-labelledby="searchInfoModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Search Options Info</h5>
                                </div>
                                <div class="modal-body">
                                    <ul>
                                        <li>Stemming of terms (e.g. ‘wait’ will also retrieve ‘waiting’, ‘waits’, ‘waited’ etc.).</li>
                                        <li>Boolean search operators. Adding + (plus) before a word means that search results must contain that word, and adding a - (minus) means that results must not contain that word. Words without plus or minus are treated as may contain, contributing to the score of any retrieved document.</li>
                                        <li>Phrasal searches. Any quoted phrase will be searched as-is, and when quoted phrases are included in a search, any hit document must contain at least one of them.</li>
                                        <li>Wildcard searches, using the asterisk (*), question mark (?) and character classes ([ab]). So you can search for lo[uv]e? to find ‘loved’, ‘loued’, ‘loves’, ‘louer’, etc.</li>
                                        <li>Search filtering. Select specific document types, date ranges, or other features.</li>
                                        <li>Autocomplete. Type in at least one letter to get results. If you type letters seperated by space you will receive autocomplete options for each space seperated word or phrase.
                                            <ul>
                                                <li>For single word autocomplete select the suggestions by clicking in order to copy them into the main search input panel.</li>
                                                <li>For multi word autocomplete select the suggestions of each column by clicking in order to copy them to a specific input field of each column. Adapt the input fields to your needs using the above explained wildcards and other options before using the copy button.</li>
                                                <li>The arrow up (copy) symbol pastes the values of the column input fields to the main search input field.</li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script type="text/javascript" src="js/ssFilterUpdate.js"/>
            </body>            
        </html>
    </xsl:template>
</xsl:stylesheet>
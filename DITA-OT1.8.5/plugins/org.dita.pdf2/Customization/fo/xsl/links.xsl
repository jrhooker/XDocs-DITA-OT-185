<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic-mapmerge="http://www.idiominc.com/opentopic/mapmerge"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="opentopic-mapmerge opentopic-func related-links xs"
    version="2.0">
    
      <xsl:template match="*[contains(@class, ' topic/table ')][*[contains(@class, ' topic/title ')]]" mode="retrieveReferenceTitle">
        <xsl:call-template name="insertVariable">
            <xsl:with-param name="theVariableID" select="'Table'"/>
            <xsl:with-param name="theParameters">
                <xsl:variable name="tablecount"><xsl:value-of select="count(preceding::*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]])"/></xsl:variable>
                <xsl:variable name="revhistorycount"><xsl:value-of select="count(preceding::*[contains(@class, ' topic/table ')][descendant::pmc-revhistory])"/></xsl:variable>
                <number>
                    <xsl:value-of select="($tablecount - $revhistorycount) + 1"/>
                </number>
                <title>
                    <xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="insert-text"/>
                </title>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <!-- The following template was put in place to ensure that xrefs to ol/li elements have the correct -->
    
    <xsl:template name="preceding-count-li-reference">
        <xsl:param name="preceding-ol"/>
        <xsl:param name="element"/>
        <xsl:param name="current-ol-count" select="1"/>
        <xsl:param name="current-li-count" select="0"/>
        <xsl:choose>
            <xsl:when
                test="$element/parent::*[contains(@class, ' topic/ol ')]/
                preceding-sibling::*[contains(@class, ' topic/ol ')]
                [number($current-ol-count)][contains(@otherprops, 'continue-numbering')]">
                <xsl:variable name="temp-ol"
                    select="count($element/parent::*[contains(@class, ' topic/ol ')]/
                    preceding-sibling::*[contains(@class, ' topic/ol ')][$current-ol-count]/*[contains(@class, ' topic/li ')])"/>
                <xsl:call-template name="preceding-count-li-reference">
                    <xsl:with-param name="element" select="$element"/>
                    <xsl:with-param name="current-ol-count" select="number($current-ol-count) + 1"/>
                    <xsl:with-param name="current-li-count" select="number($current-li-count) + number($temp-ol)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="$element/parent::*[contains(@class, ' topic/ol ')]/
                preceding-sibling::*[contains(@class, ' topic/ol ')]
                [number($current-ol-count)][contains(@otherprops, 'start-numbering')]">
                <xsl:variable name="temp-ol"
                    select="count($element/parent::*[contains(@class, ' topic/ol ')]/preceding-sibling::*[contains(@class, ' topic/ol ')]
                    [$current-ol-count]/child::*[contains(@class, ' topic/li ')])"/>
                <xsl:value-of select="number($current-li-count) + number($temp-ol)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$current-li-count"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

 <xsl:template match="*" mode="insertReferenceTitle">
        <xsl:param name="href"/>
        <xsl:param name="titlePrefix"/>
        <xsl:param name="destination"/>
        <xsl:param name="element"/>
        
        <xsl:variable name="referenceContent">
            <xsl:choose>
                <xsl:when test="not($element) or ($destination = '')">
                    <xsl:text>#none#</xsl:text>
                </xsl:when>
                <xsl:when test="contains($element/@class,' topic/li ') and 
                    contains($element/parent::*/@class,' topic/ol ')">                      
                    <xsl:text>[ </xsl:text>                    
                    <xsl:variable name="tnumber">
                        <xsl:value-of select="count(//*[@id = $element/@id]/preceding-sibling::*) + 1"></xsl:value-of>
                    </xsl:variable>
                    <xsl:variable name="preceding-count">
                        <xsl:choose>
                            <xsl:when
                                test="$element/parent::*[contains(@class, ' topic/ol ')][contains(@otherprops, 'continue-numbering')]">
                                <xsl:call-template name="preceding-count-li-reference">
                                    <xsl:with-param name="element" select="$element"/>
                                    <xsl:with-param name="preceding-ol"
                                        select="count($element/parent::*[contains(@class, ' topic/ol ')]/preceding-sibling::*[contains(@class, ' topic/ol ')])"
                                    />
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>0</xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>                    
                    <xsl:value-of
                        select="number($tnumber) + number($preceding-count)"/>
                    
                    <xsl:text> ] </xsl:text> 
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$element" mode="retrieveReferenceTitle"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        
        <xsl:if test="not($titlePrefix = '')">
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="$titlePrefix"/>
            </xsl:call-template>
        </xsl:if>
        
        <xsl:choose>
            <xsl:when test="not($element) or ($destination = '') or $referenceContent='#none#'">
                <xsl:choose>
                    <xsl:when test="*[not(contains(@class,' topic/desc '))] | text()">
                        <xsl:apply-templates select="*[not(contains(@class,' topic/desc '))] | text()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$href"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:copy-of select="$referenceContent"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
<xsl:template name="insertPageNumberCitation">
        <xsl:param name="isTitleEmpty"/>
        <xsl:param name="destination"/>
        <xsl:param name="element"/>        
        <xsl:choose>
            <xsl:when test="not($element) or ($destination = '')"/>
            <xsl:when test="contains($element/@class,' topic/li ') and contains($element/parent::*/@class,' topic/ol ')"/>
            <xsl:when test="$isTitleEmpty">
                <fo:inline>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'Page'"/>
                        <xsl:with-param name="theParameters">
                            <pagenum>
                                <fo:inline>
                                    <fo:page-number-citation ref-id="{$destination}"/>
                                </fo:inline>
                            </pagenum>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:inline>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'On the page'"/>
                        <xsl:with-param name="theParameters">
                            <pagenum>
                                <fo:inline>
                                   <fo:page-number-citation ref-id="{$destination}"/>
                                </fo:inline>
                            </pagenum>
                        </xsl:with-param>
                    </xsl:call-template>
                </fo:inline>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


   

</xsl:stylesheet>

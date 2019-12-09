<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic-mapmerge="http://www.idiominc.com/opentopic/mapmerge"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:related-links="http://dita-ot.sourceforge.net/ns/200709/related-links"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="opentopic-mapmerge opentopic-func related-links xs"
    version="2.0">
    
    <xsl:template match="*[contains(@class,' topic/xref ')]" name="topic.xref">
        <fo:inline>
            <xsl:call-template name="commonattributes"/>
        </fo:inline>
        
        <xsl:variable name="destination" select="opentopic-func:getDestinationId(@href)"/>
        <xsl:variable name="element" select="key('key_anchor',$destination, $root)[1]"/>
        
        <xsl:variable name="referenceTitle" as="node()*">
            <xsl:apply-templates select="." mode="insertReferenceTitle">
                <xsl:with-param name="href" select="@href"/>
                <xsl:with-param name="titlePrefix" select="''"/>
                <xsl:with-param name="destination" select="$destination"/>
                <xsl:with-param name="element" select="$element"/>
            </xsl:apply-templates>
        </xsl:variable>
        
        <fo:basic-link xsl:use-attribute-sets="xref">
            <xsl:call-template name="buildBasicLinkDestination">
                <xsl:with-param name="scope" select="@scope"/>
                <xsl:with-param name="format" select="@format"/>
                <xsl:with-param name="href" select="@href"/>
            </xsl:call-template>
            
            <xsl:choose>
                <xsl:when test="(string-length(text()[1]) &gt; 0) and not(@scope = 'external' or not(empty(@format) or  @format = 'dita')) and exists($referenceTitle)">
                    <xsl:apply-templates mode="pmc_processUserXrefContent"/>
                </xsl:when>
                <xsl:when test="not(@scope = 'external' or not(empty(@format) or  @format = 'dita')) and exists($referenceTitle)">
                    <xsl:copy-of select="$referenceTitle"/>
                </xsl:when>
                <xsl:when test="not(@scope = 'external' or not(empty(@format) or  @format = 'dita'))">
                    <xsl:call-template name="insertPageNumberCitation">
                        <xsl:with-param name="isTitleEmpty" select="true()"/>
                        <xsl:with-param name="destination" select="$destination"/>
                        <xsl:with-param name="element" select="$element"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="*[not(contains(@class,' topic/desc '))] | text()">
                            <xsl:apply-templates select="*[not(contains(@class,' topic/desc '))] | text()" mode="pmc_processUserXrefContent" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="@href"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </fo:basic-link>
        
        <!--
        Disable because of the CQ#8102 bug
        <xsl:if test="*[contains(@class,' topic/desc ')]">
          <xsl:call-template name="insertLinkDesc"/>
        </xsl:if>
    -->
        
        <xsl:if test="not(@scope = 'external' or not(empty(@format) or  @format = 'dita')) and exists($referenceTitle) and not($element[contains(@class, ' topic/fn ')])">
            <!-- SourceForge bug 1880097: should not include page number when xref includes author specified text -->
            <xsl:if test="not(processing-instruction()[name()='ditaot'][.='usertext'])">
                <xsl:call-template name="insertPageNumberCitation">
                    <xsl:with-param name="destination" select="$destination"/>
                    <xsl:with-param name="element" select="$element"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
        
    </xsl:template>
    <!-- The following templates allow the xref template above to function without adding unwanted content -->
    
    <xsl:template match="*[contains(@class,' topic/indexterm ')]" mode="pmc_processUserXrefContent"/>
    
    <xsl:template match="*[contains(@class,' topic/shortdesc ')]" mode="pmc_processUserXrefContent"/>
    
    <xsl:template match="*[contains(@class,' topic/desc ')]" mode="pmc_processUserXrefContent"/>
    
    <xsl:template match="*" mode="pmc_processUserXrefContent">
        <xsl:apply-templates select="self::node()"/>
    </xsl:template>
    
    
    
</xsl:stylesheet>
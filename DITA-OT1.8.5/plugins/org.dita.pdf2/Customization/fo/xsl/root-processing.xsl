<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic-i18n="http://www.idiominc.com/opentopic/i18n"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:opentopic="http://www.idiominc.com/opentopic"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    version="2.0">
     
    <xsl:template name="createLegalBackMatter">
        <!--<fo:page-sequence master-reference="legal-first" format="1" xsl:use-attribute-sets="__force__page__count">            
            <xsl:call-template name="insertLegalStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <xsl:call-template name="createLegal"/>
            </fo:flow>
        </fo:page-sequence> -->
        
        <fo:page-sequence master-reference="index-sequence" xsl:use-attribute-sets="__force__page__count">
            
            <xsl:call-template name="insertIndexStaticContents"/>
            
            <fo:flow flow-name="xsl-region-body">
                <fo:marker marker-class-name="current-header">
                   Legal
                </fo:marker>
                <xsl:call-template name="createLegal"/>
            </fo:flow>
            
        </fo:page-sequence>
        
    </xsl:template>    
    
      
    <xsl:template match="/" name="rootTemplate">
        <xsl:call-template name="validateTopicRefs"/>
        
        <fo:root xsl:use-attribute-sets="__fo__root">
            <xsl:call-template name="createMetadata"/>
            <xsl:call-template name="createLayoutMasters"/>
            
            <xsl:call-template name="createBookmarks"/>
            
            <xsl:call-template name="createFrontMatter"/>
            
            <xsl:if test="not($retain-bookmap-order)">
                <xsl:call-template name="createToc"/>
            </xsl:if>
            
            <!--            <xsl:call-template name="createPreface"/>-->
            
            <xsl:apply-templates/>
            
            <xsl:if test="not($retain-bookmap-order)">
                <xsl:call-template name="createIndex"/>
            </xsl:if>
            <xsl:call-template name="createLegalBackMatter"/>
        </fo:root>
    </xsl:template>
   
  
    
</xsl:stylesheet>
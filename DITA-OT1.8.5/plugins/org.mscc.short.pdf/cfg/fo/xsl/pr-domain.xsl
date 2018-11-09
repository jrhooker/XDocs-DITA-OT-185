<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="*[contains(@class,' pr-d/parml ')]">
        <xsl:call-template name="generateAttrLabel"/>
        <xsl:variable name="level" select="count(ancestor::*[contains(@class,' pr-d/parml ')])"/>
        
        <fo:block xsl:use-attribute-sets="parml">
            <xsl:call-template name="commonattributes"/>
            <xsl:attribute name="margin-left"><xsl:value-of select="$level * 5"/>mm</xsl:attribute>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' pr-d/plentry ')]">
        <fo:block xsl:use-attribute-sets="plentry">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' pr-d/pd ')]">
        <xsl:variable name="level" select="count(ancestor::*[contains(@class,' pr-d/parml ')])"/>
        <fo:block>
            <xsl:call-template name="commonattributes"/>
            <xsl:attribute name="margin-left"><xsl:value-of select="$level * 2.5"
            />mm</xsl:attribute>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- Adaptations for csr-reg elements -->
    
    <xsl:template match="*[contains(@class, ' csrreg-d/csrreg-instances ')]">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' csrreg-d/instance-start ')]">
        <fo:inline>[ <xsl:value-of select="."/> : </fo:inline>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' csrreg-d/instance-stop ')]">
        <fo:inline><xsl:value-of select="."/> ]</fo:inline>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' csrreg-d/csrreg-offset ')]">
        <fo:inline>_<xsl:value-of select="."/></fo:inline>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' struct-d/msb ')]">
        <fo:inline xsl:use-attribute-sets="ph">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:inline>
        <fo:inline xsl:use-attribute-sets="ph">
            <xsl:text>:</xsl:text>
        </fo:inline>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' struct-d/lsb ')]">
        <fo:inline xsl:use-attribute-sets="ph">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' m-software-d/desc-title ')]">
        <fo:block xsl:use-attribute-sets="desc-title">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>
        
    <xsl:template match="*[contains(@class,' m-software-d/field-enum-name ')]">        
        <fo:inline xsl:use-attribute-sets="ph">
            <xsl:text> [  </xsl:text>
        </fo:inline>
        <fo:inline xsl:use-attribute-sets="tt">
            <xsl:call-template name="commonattributes"/>
            <xsl:attribute name="font-size">8pt</xsl:attribute>
            <xsl:apply-templates/>
        </fo:inline>
        <fo:inline xsl:use-attribute-sets="ph">
            <xsl:text>  ] </xsl:text>
        </fo:inline>
    </xsl:template>
    
</xsl:stylesheet>
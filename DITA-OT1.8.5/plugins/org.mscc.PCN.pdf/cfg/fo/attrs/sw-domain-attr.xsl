<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:attribute-set name="msgph" use-attribute-sets="base-font">
        <xsl:attribute name="font-family"><xsl:value-of select="$monospace.font.family"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="msgblock"  use-attribute-sets="pre">        
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="msgnum">        
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="cmdname"  use-attribute-sets="base-font">
        <xsl:attribute name="font-family"><xsl:value-of select="$monospace.font.family"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="varname">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="filepath" use-attribute-sets="base-font">
        <xsl:attribute name="font-family"><xsl:value-of select="$monospace.font.family"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="userinput" use-attribute-sets="base-font">
        <xsl:attribute name="font-family"><xsl:value-of select="$monospace.font.family"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="systemoutput" use-attribute-sets="base-font">
        <xsl:attribute name="font-family"><xsl:value-of select="$monospace.font.family"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
    </xsl:attribute-set>
    
    
</xsl:stylesheet>
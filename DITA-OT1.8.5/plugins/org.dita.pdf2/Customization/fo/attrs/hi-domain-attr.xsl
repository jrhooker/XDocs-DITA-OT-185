<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    
    <xsl:attribute-set name="b">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="i">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="u">
        <xsl:attribute name="text-decoration">underline</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="tt">
        <xsl:attribute name="font-family"><xsl:value-of select="$monospace.font.family"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sup">
        <xsl:attribute name="baseline-shift">super</xsl:attribute>
        <xsl:attribute name="font-size">75%</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sub">
        <xsl:attribute name="baseline-shift">sub</xsl:attribute>
        <xsl:attribute name="font-size">75%</xsl:attribute>
    </xsl:attribute-set>
    
    
</xsl:stylesheet>
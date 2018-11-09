<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:excel="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:html="http://www.w3.org/TR/REC-html40"  
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    version="2.0">
    <!--
    <xsl:template match="/">
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    
    <xsl:template match="*">
        <xsl:apply-templates></xsl:apply-templates>
    </xsl:template>
    -->
    <xsl:include href="Excel2xhtml.xsl"/>
    
    <xsl:template match="xref[contains(@otherprops, 'spreadsheet')]">
        <xsl:variable name="excel" select="document(@href)"/>
        <xsl:call-template name="process.spreadsheet">
            <xsl:with-param name="content" select="$excel"/>
            <xsl:with-param name="sheet" tunnel="yes" select="substring-after(@otherprops, 'spreadsheet:')"/>
        </xsl:call-template>       
    </xsl:template>    
        
</xsl:stylesheet>

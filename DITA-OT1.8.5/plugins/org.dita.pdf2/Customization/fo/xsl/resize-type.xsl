<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:template name="resize_font">
        <xsl:if test="contains(@otherprops, 'type_size') or ancestor::*[contains(@class, ' topic/table ')][contains(@otherprops, 'type_size')]">
            <xsl:variable name="type_size">
                <xsl:choose>
                    <xsl:when test="contains(@otherprops, 'type_size')">
                        <xsl:call-template name="define-type-size"><xsl:with-param name="string" select="@otherprops"/></xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="temp" select="ancestor::*[contains(@class, ' topic/table ')][contains(@otherprops, 'type_size')]/@otherprops"/>
                        <xsl:call-template name="define-type-size"><xsl:with-param name="string" select="$temp[1]"/></xsl:call-template>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="font-size"><xsl:value-of select="$type_size"/>pt</xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="define-type-size">
        <xsl:param name="string"/>
        <xsl:choose>
            <xsl:when test="contains($string, 'font_size20')">20</xsl:when>
            <xsl:when test="contains($string, 'font_size19')">19</xsl:when>
            <xsl:when test="contains($string, 'font_size18')">18</xsl:when>
            <xsl:when test="contains($string, 'font_size17')">17</xsl:when>
            <xsl:when test="contains($string, 'font_size16')">16</xsl:when>
            <xsl:when test="contains($string, 'font_size15')">15</xsl:when>
            <xsl:when test="contains($string, 'font_size14')">14</xsl:when>
            <xsl:when test="contains($string, 'font_size13')">13</xsl:when>
            <xsl:when test="contains($string, 'font_size12')">12</xsl:when>
            <xsl:when test="contains($string, 'font_size11')">11</xsl:when>
            <xsl:when test="contains($string, 'font_size10')">10</xsl:when>
            <xsl:when test="contains($string, 'font_size9')">9</xsl:when>
            <xsl:when test="contains($string, 'font_size8')">8</xsl:when>
            <xsl:when test="contains($string, 'font_size7')">7</xsl:when>
            <xsl:when test="contains($string, 'font_size6')">6</xsl:when>
            <xsl:when test="contains($string, 'font_size5')">5</xsl:when>
            <xsl:when test="contains($string, 'font_size4')">4</xsl:when>
            <xsl:when test="contains($string, 'font_size3')">3</xsl:when>
            <xsl:when test="contains($string, 'font_size2')">2</xsl:when>
            <xsl:when test="contains($string, 'font_size1')">1</xsl:when>
            <xsl:otherwise><xsl:value-of select="substring-after($string, 'type_size')"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

   <xsl:param name="SHOWCOMMENTS">
        <xsl:choose>
            <xsl:when test="//pmc_iso[1]/show_comments[1]/@show_comments = 'YES'">YES</xsl:when>
            <xsl:otherwise>NO</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <!-- TOC -->
    <!-- The following is the depth of the TOC indent in millimeters -->
    <xsl:param name="tocindentinMM" select="10"/>

    <xsl:attribute-set name="topic">
        <xsl:attribute name="break-before">
            <xsl:choose>
                <xsl:when test="@outputclass='pagebreak'">page</xsl:when>
                <xsl:otherwise>auto</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="refbody">
        <xsl:attribute name="keep-together.within-page">auto</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="reference">
        <xsl:attribute name="break-before">
            <xsl:choose>
                <xsl:when test="@outputclass='pagebreak'">page</xsl:when>
                <xsl:otherwise>auto</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="keep-together.within-page">auto</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="concept">
        <xsl:attribute name="break-before">
            <xsl:choose>
                <xsl:when test="@outputclass='pagebreak'">page</xsl:when>
                <xsl:otherwise>auto</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="keep-together.within-page">auto</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="task">
        <xsl:attribute name="break-before">
            <xsl:choose>
                <xsl:when test="@outputclass='pagebreak'">page</xsl:when>
                <xsl:otherwise>auto</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="keep-together.within-page">auto</xsl:attribute>
    </xsl:attribute-set>
   
</xsl:stylesheet>

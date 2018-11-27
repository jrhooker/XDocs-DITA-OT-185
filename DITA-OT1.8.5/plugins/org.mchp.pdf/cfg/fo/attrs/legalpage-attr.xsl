<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:attribute-set name="__legalpage">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__legalpage__title">
        <xsl:attribute name="margin-top">80mm</xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">22pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">140%</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__legalpage__subtitle">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">18pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">140%</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__legalpage__owner">
        <xsl:attribute name="margin-top">3pc</xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">11pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="line-height">normal</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__legalpage__owner__container">
        <xsl:attribute name="position">absolute</xsl:attribute>
        <xsl:attribute name="top">210mm</xsl:attribute>
        <xsl:attribute name="bottom">20mm</xsl:attribute>
        <xsl:attribute name="right">20mm</xsl:attribute>
        <xsl:attribute name="left">20mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__legalpage__owner__container_content">
        <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__legalpage__mainbooktitle">
        <!--<xsl:attribute name=""></xsl:attribute>-->
    </xsl:attribute-set>

    <xsl:attribute-set name="__legalpage__booklibrary">
        <!--<xsl:attribute name=""></xsl:attribute>-->
    </xsl:attribute-set>
  

</xsl:stylesheet>

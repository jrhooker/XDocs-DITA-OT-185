<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:attribute-set name="linklist.title">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>
    
    <!--Common-->
    <xsl:attribute-set name="li.itemgroup">
        <xsl:attribute name="space-after">0pt</xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <!--Unordered list-->
    <xsl:attribute-set name="ul">
        <xsl:attribute name="margin-left">.5em</xsl:attribute>
        <xsl:attribute name="provisional-distance-between-starts">5mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <!--        <xsl:attribute name="margin-left">-8pt</xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li">
        <xsl:attribute name="space-after">0.0pt</xsl:attribute>
        <xsl:attribute name="space-before">0.0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__label__content">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ul.li__content">
    </xsl:attribute-set>
    
    <!--Ordered list-->
    <xsl:attribute-set name="ol">
        
        <xsl:attribute name="provisional-distance-between-starts">5mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <!--		<xsl:attribute name="margin-left">-8pt</xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.block">    
        <xsl:attribute name="space-after">7pt</xsl:attribute>
        <xsl:attribute name="space-before">7pt</xsl:attribute>
        <!--		<xsl:attribute name="margin-left">-8pt</xsl:attribute>-->
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li">
        <xsl:attribute name="space-after">5pt</xsl:attribute>
        <xsl:attribute name="space-before">5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="p.ol.ul.sl">
        <xsl:attribute name="space-after">1.5pt</xsl:attribute>
        <xsl:attribute name="space-before">0.0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__label__content">
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ol.li__content">
    </xsl:attribute-set>
    
    <!--Simple list-->
    <xsl:attribute-set name="sl">
        <xsl:attribute name="provisional-distance-between-starts">5mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">1mm</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="space-before">3pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sl.sli">
        <xsl:attribute name="space-after">0.5pt</xsl:attribute>
        <xsl:attribute name="space-before">0.5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sl.sli__label">
        <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-line">always</xsl:attribute>
        <xsl:attribute name="end-indent">label-end()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sl.sli__label__content">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sl.sli__body">
        <xsl:attribute name="start-indent">body-start()</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="sl.sli__content">
    </xsl:attribute-set>
    
</xsl:stylesheet>
<?xml version='1.0'?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    version="2.0">

  <xsl:attribute-set name ="__lotf__heading" use-attribute-sets="__toc__header">
  </xsl:attribute-set>

  <xsl:attribute-set name="__lotf__indent" use-attribute-sets="__toc__indent__booklist">
    <xsl:attribute name="space-before">0pt</xsl:attribute>
    <xsl:attribute name="space-after">0pt</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name ="__lotf__content" use-attribute-sets="base-font">
    <xsl:attribute name="font-weight">normal</xsl:attribute>
    <xsl:attribute name="space-before">0pt</xsl:attribute>
    <xsl:attribute name="space-after">0pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name ="__lotf__leader">
    <xsl:attribute name="leader-pattern">dots</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="__lotf__title" use-attribute-sets="__lotf__content">
  </xsl:attribute-set>
  
  <xsl:attribute-set name="__lotf__page-number">
    <xsl:attribute name="keep-together.within-line">always</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>

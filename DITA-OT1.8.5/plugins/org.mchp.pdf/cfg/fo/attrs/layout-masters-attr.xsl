<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA Open Toolkit project.
  See the accompanying license.txt file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <xsl:param name="SHOWBORDERS">0</xsl:param>

  <xsl:attribute-set name="simple-page-master">
    <xsl:attribute name="page-width">
      <xsl:value-of select="$page-width"/>
    </xsl:attribute>
    <xsl:attribute name="page-height">
      <xsl:value-of select="$page-height"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="toc-page-master">
    <xsl:attribute name="page-width">
      <xsl:value-of select="$page-width"/>
    </xsl:attribute>
    <xsl:attribute name="page-height">
      <xsl:value-of select="$page-height"/>
    </xsl:attribute>   
  </xsl:attribute-set>

  <xsl:attribute-set name="frontmatter-page-master">
    <xsl:attribute name="page-width">
      <xsl:value-of select="$frontmatter-page-width"/>
    </xsl:attribute>
    <xsl:attribute name="page-height">
      <xsl:value-of select="$frontmatter-page-height"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="coverpage-master">
    <xsl:attribute name="page-width">
      <xsl:value-of select="$page-width"/>
    </xsl:attribute>
    <xsl:attribute name="page-height">
      <xsl:value-of select="$page-height"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- legacy attribute set -->

  <xsl:attribute-set name="frontmatter-region-body.odd">
    <xsl:attribute name="margin-top">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">2cm</xsl:attribute>
    <xsl:attribute name="margin-left">2cm</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="frontmatter-region-body.even"
    use-attribute-sets="frontmatter-region-body.odd"/>

  <xsl:attribute-set name="region-body" use-attribute-sets="region-body.odd"> </xsl:attribute-set>

  <xsl:attribute-set name="region-body.odd">  
    <xsl:attribute name="margin-top">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}">
      <xsl:value-of select="$page-margin-inside"/>
    </xsl:attribute>
    <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}">
      <xsl:value-of select="$page-margin-outside"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-body.even">  
    <xsl:attribute name="margin-top">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-left' else 'margin-right'}">
      <xsl:value-of select="$page-margin-inside"/>
    </xsl:attribute>
    <xsl:attribute name="{if ($writing-mode = 'lr') then 'margin-right' else 'margin-left'}">
      <xsl:value-of select="$page-margin-outside"/>
    </xsl:attribute>
  </xsl:attribute-set>


  <xsl:attribute-set name="toc-body.odd">  
    <xsl:attribute name="margin-top">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">2cm</xsl:attribute>
    <xsl:attribute name="margin-left">3cm</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="toc-body.even">  
    <xsl:attribute name="margin-top">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin-bottom">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">2cm</xsl:attribute>
    <xsl:attribute name="margin-left">3cm</xsl:attribute>
  </xsl:attribute-set>  


  <xsl:attribute-set name="region-body__frontmatter.odd"
    use-attribute-sets="frontmatter-region-body.odd"> </xsl:attribute-set>
  <xsl:attribute-set name="region-body__frontmatter.even"
    use-attribute-sets="frontmatter-region-body.even"> </xsl:attribute-set>
  
  
  <xsl:attribute-set name="region-body__coverpage" use-attribute-sets="region-body.odd">
    <xsl:attribute name="margin-right">2cm</xsl:attribute>
    <xsl:attribute name="margin-left">2.5cm</xsl:attribute>
  </xsl:attribute-set>

  <!-- legacy attribute set -->
  <xsl:attribute-set name="region-body__index" use-attribute-sets="region-body__index.odd"/>

  <xsl:attribute-set name="region-body__index.odd" use-attribute-sets="region-body.odd">
    <xsl:attribute name="column-count">2</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-body__index.even" use-attribute-sets="region-body.even">
    <xsl:attribute name="column-count">2</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-before__coverpage">
    <xsl:attribute name="extent">12cm</xsl:attribute>
    <xsl:attribute name="margin">2cm</xsl:attribute>
    <xsl:attribute name="display-align">before</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-before">
    <xsl:attribute name="extent">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="display-align">before</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-after__coverpage">
    <xsl:attribute name="extent">12cm</xsl:attribute>
    <xsl:attribute name="margin">1cm</xsl:attribute>
    <xsl:attribute name="display-align">after</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="region-after">
    <xsl:attribute name="extent">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="display-align">after</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="legal.region-before">
    <xsl:attribute name="extent">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="margin">
      <xsl:value-of select="$page-margin-top"/>
    </xsl:attribute>
    <xsl:attribute name="display-align">before</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="legal.region-after">
    <xsl:attribute name="extent">
      <xsl:value-of select="$page-margin-bottom"/>
    </xsl:attribute>
    <xsl:attribute name="display-align">after</xsl:attribute>
  </xsl:attribute-set>

</xsl:stylesheet>

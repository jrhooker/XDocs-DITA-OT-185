<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

  <xsl:import href="lot-lof-attr.xsl"/>

  <xsl:import href="lot-lof-attr.xsl"/>

  <xsl:import href="toc-attr.xsl"/>

  <xsl:import href="resize-font.xsl"/>

  <!--<xsl:import href="rotate-table-entries.xsl"/>-->

  <xsl:import href="title-attribute-sets.xsl"/>

  <xsl:import href="unsorted-attribute-sets.xsl"/>

  <xsl:import href="frontmatter-attr.xsl"/>

  <xsl:import href="coverpage-attr.xsl"/>

  <xsl:import href="legalpage-attr.xsl"/>

  <xsl:import href="hi-domain-attr.xsl"/>

  <xsl:import href="xref-attr.xsl"/>

  <xsl:import href="lists-attr.xsl"/>

  <xsl:import href="commons-attr.xsl"/>

  <xsl:import href="tables-attr.xsl"/>

  <xsl:import href="sw-domain-attr.xsl"/>

  <xsl:import href="pr-domain-attr.xsl"/>

  <xsl:import href="ui-domain-attr.xsl"/>

  <xsl:import href="pmc-custom-attr.xsl"/> 

  <xsl:import href="static-content-attr.xsl"/>

  <xsl:import href="layout-masters-attr.xsl"/>

  <xsl:variable name="showcallers" select="0"/>
  <xsl:variable name="SHOWBORDERS" select="0"/> 
  
  <xsl:param name="chapterLayout">BASIC</xsl:param>
  <xsl:param name="appendixLayout">BASIC</xsl:param>
  <xsl:param name="partLayout">BASIC</xsl:param>
  <xsl:param name="noticesLayout">BASIC</xsl:param>
  
  <xsl:param name="retain-bookmap-order">retain</xsl:param>
  <xsl:param name="topicTitle.numLevel" select="5"/>

  <!-- The default of 215.9mm x 279.4mm is US Letter size (8.5x11in) -->
  <xsl:variable name="page-width">215.9mm</xsl:variable>
  <xsl:variable name="page-height">279.4mm</xsl:variable>

  <xsl:variable name="frontmatter-page-width">215.9mm</xsl:variable>
  <xsl:variable name="frontmatter-page-height">279.4mm</xsl:variable>

  <!-- This is the default, but you can set the margins individually below. -->
  <xsl:variable name="page-margins">25mm</xsl:variable>

  <!-- Change these if your page has different margins on different sides. -->
  <xsl:variable name="page-margin-inside">3cm</xsl:variable>
  <xsl:variable name="page-margin-outside" select="$page-margins"/>
  <xsl:variable name="page-margin-top">2.5cm</xsl:variable>
  <xsl:variable name="page-margin-bottom">2cm</xsl:variable>

  <xsl:variable name="page-margin-inside-frontmatter">3cm</xsl:variable>
  <xsl:variable name="page-margin-outside-frontmatter" select="$page-margins"/>


  <!--The side column width is the amount the body text is indented relative to the margin. -->
  <xsl:variable name="side-col-width">0mm</xsl:variable>

  <xsl:variable name="mirror-page-margins" select="false()"/>

  <!-- Basic PMC Font values -->
  <xsl:param name="body.font.size">10pt</xsl:param>
  <xsl:variable name="default-font-size" select="$body.font.size"/>
  <xsl:variable name="default-table-font-size">8pt</xsl:variable>
  <xsl:variable name="default-table-line-height">10pt</xsl:variable>
  <xsl:variable name="default-line-height">12pt</xsl:variable>
  <!-- keep the body.font.size and the body.font.master aligned on the same value. the body.font.master is used for proprotional calculations -->
  <xsl:param name="body.font.master" select="10"/>
  <xsl:param name="title.font.master" select="14"/>
  <xsl:param name="body.font.size.small">8pt</xsl:param>
  <xsl:param name="header.font.size">14pt</xsl:param>
  <xsl:param name="footer.font.size">8pt</xsl:param>
  <xsl:param name="toc.font.size">10pt</xsl:param>
  <xsl:param name="body.font.family">sans</xsl:param>
  <xsl:param name="header.font.family">sansTitle</xsl:param>
  <xsl:param name="header.font.color">#000000</xsl:param>
  <xsl:param name="dingbat.font.family">symbol</xsl:param>
  <xsl:param name="monospace.font.family">Courier</xsl:param>
  <xsl:param name="sans.font.family">sans</xsl:param>
  <xsl:param name="title.font.family">sansTitle</xsl:param>
  <xsl:param name="symbol.font.family">symbol</xsl:param>
  <xsl:param name="title.font.color">#000000</xsl:param>
  <xsl:param name="title.border.font.color">#000000</xsl:param>
  <xsl:param name="minor.title.font.color">#000000</xsl:param>
  <!-- Formatting for Legal Info page -->
  <xsl:param name="legal.font.family">sans</xsl:param>
  <xsl:param name="legal.font.size">9pt</xsl:param>
  <!-- Table params -->
  <xsl:param name="table.rule.color">#cccccc</xsl:param>
  <xsl:param name="table.head.rule.color">#cccccc</xsl:param>
  <xsl:param name="table.head.font.color">#ffffff</xsl:param>
  <xsl:param name="table.head.font.family">sansTitle</xsl:param>
  <xsl:param name="table.head.font.weight">bold</xsl:param>
  <xsl:param name="table.foot.rule.color">#cccccc</xsl:param>
  <xsl:param name="table.frame.rule.color">#cccccc</xsl:param>
  <xsl:param name="table.vertical.rule.color">#cccccc</xsl:param>
  <xsl:param name="table.frame.border.color">#cccccc</xsl:param>
  <xsl:param name="table.header.background.color">#555555</xsl:param>
  <xsl:param name="table.cell.border.color">#ffffff</xsl:param>
  <xsl:param name="table.row.color.1">#dddddd</xsl:param>
  <xsl:param name="table.row.color.2">#eeeeee</xsl:param>
  <xsl:param name="table.frame.border.thickness">1pt</xsl:param>
  <xsl:param name="table.cell.border.thickness">1pt</xsl:param>
  
  
  
</xsl:stylesheet>

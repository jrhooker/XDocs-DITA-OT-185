<?xml version="1.0" encoding="UTF-8" ?>
<!-- This file is part of the DITA Open Toolkit project hosted on 
     Sourceforge.net. See the accompanying license.txt file for 
     applicable licenses.-->
<!-- (c) Copyright IBM Corp. 2004, 2005 All Rights Reserved. -->

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- stylesheet imports -->
<xsl:import href="plugin:org.dita.xhtml:xsl/xslhtml/map2TOC.xsl"/>

<!-- default "output extension" processing parameter ('.html')-->
<xsl:param name="OUTEXT" select="'.html'"/><!-- "htm" and "html" are valid values -->
<xsl:param name="TEMPDIR" >this</xsl:param>
  <xsl:param name="BASEDIR"></xsl:param>

  <xsl:output
    method="xml"
    omit-xml-declaration="no"
    encoding="UTF-8"
    doctype-public="-//Sun Microsystems Inc.//DTD JavaHelp Map Version 2.0//EN"
    doctype-system="http://java.sun.com/products/javahelp/map_2_0.dtd"
    indent="yes"/>

<xsl:template match="*[contains(@class,' map/map ')]" mode="toctop">
  <map version="2.0">
    <xsl:apply-templates select="*[contains(@class,' map/topicref ')]"/>
  </map>
</xsl:template>

<xsl:template match="*[contains(@class,' map/topicref ')]" mode="tocentry">
  <xsl:param name="infile"/>
  <xsl:param name="outroot"/>
  <xsl:param name="outfile"/>
  <xsl:param name="nodeID"/>
  <xsl:param name="isFirst"/>
  <xsl:param name="subtopicNodes"/>
  <xsl:param name="title"/>
  <xsl:variable name="topicID">
    <xsl:choose>
      <xsl:when test="document(concat('file:///', translate($BASEDIR, '\', '/'), '/', $infile))/*[contains(@class, ' topic/topic ')]/@id"><xsl:value-of select="document(concat('file:///', translate($BASEDIR, '\', '/'), '/', $infile))/*[contains(@class, ' topic/topic ')]/@id"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="concat('file:///', translate($BASEDIR, '\', '/'), '/', $infile)"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:if test="$isFirst">
    <xsl:if test="$outfile and $outfile!=''">
      <xsl:variable name="targetID" select="translate($outroot, '\/.', '___')"/>
      <mapID target="{$targetID}" url="{$outfile}"/>
    <mapID target="{$topicID}" url="{$outfile}"/>
    </xsl:if>
    <xsl:apply-templates select="$subtopicNodes"/>
  </xsl:if>
</xsl:template>

<!-- suppress default processing because title not used in JavaHelp map -->
<xsl:template match="*[contains(@class,' map/topicref ')]" mode="title">
  <xsl:param name="isFirst"/>
  <xsl:param name="infile"/>
  <xsl:param name="nodeID"/>
  <xsl:param name="outfile"/>
</xsl:template>

</xsl:stylesheet>

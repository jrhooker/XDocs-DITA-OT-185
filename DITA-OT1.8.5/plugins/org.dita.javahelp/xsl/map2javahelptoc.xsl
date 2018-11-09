<?xml version="1.0" encoding="UTF-8" ?>
<!-- This file is part of the DITA Open Toolkit project hosted on 
     Sourceforge.net. See the accompanying license.txt file for 
     applicable licenses.-->
<!-- (c) Copyright IBM Corp. 2004, 2005 All Rights Reserved. -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:svg="http://www.w3.org/2000/svg" 
  xmlns:xlink="http://www.w3.org/1999/xlink" 
  exclude-result-prefixes="xs" version="2.0" >

<!-- stylesheet imports -->
  <xsl:import href="plugin:org.dita.xhtml:xsl/xslhtml/map2TOC.xsl"/>

  <!-- default "output extension" processing parameter ('.html')-->
  <xsl:param name="OUTEXT" select="'.html'"/>
  <!-- "htm" and "html" are valid values -->
<xsl:param name="ARGS.INPUT"/>
  <xsl:param name="text-encoding" as="xs:string" select="'iso-8859-1'"/>
  <xsl:param name="BASEDIR"/>
  <xsl:param name="BASEDIR2" select="translate($BASEDIR, '\', '/')"/>
  <xsl:param name="OUTPUTDIR"/>
  <xsl:param name="OUTPUTDIR2" select="translate($OUTPUTDIR, '\', '/')"/>
  <xsl:param name="DITATEMPDIR"/>
  <xsl:param name="CSSPATH"/>
  <xsl:param name="CSS"/>
  <xsl:param name="DITATEMPDIR2" select="translate($DITATEMPDIR, '\', '/')"/>
  <xsl:param name="text-uri" as="xs:string"
    select="concat('file:///', $DITATEMPDIR2, '/fullditatopic.list')"/>
  
  <xsl:param name="ditatempdir-cleaned" select="translate($DITATEMPDIR, '\', '/')"/>
  <xsl:param name="argsinput-cleaned" select="translate($ARGS.INPUT, '\', '/')"/>
    
  <xsl:param name="temp1" select="translate(concat('file:///',$BASEDIR, '/', $ARGS.INPUT), '\', '\')"/>
  <xsl:param name="temp2" select="translate($ARGS.INPUT, '\', '/')"/>        
    
  <xsl:param name="ditamap">
      <xsl:call-template name="substring-after-last-javahelp">
        <xsl:with-param name="input" select="$ARGS.INPUT"/>
        <xsl:with-param name="substr">/</xsl:with-param>
      </xsl:call-template>
    </xsl:param>
    
  <xsl:param name="ditamap-concat" select="concat('file:///', $BASEDIR2, '/', $ditamap)"/>
    
  <xsl:param name="ditamapISO" select="document($ditamap-concat)"/>
  <!--<xsl:param name="ditamapISO" select="document('file:///C:\Temp\DITA-OT1.8.5\temp\temp20171002144054678\PublishTest.ditamap')"/>-->
  <xsl:param name="pmc_title"><xsl:value-of select="$ditamapISO//pmc_iso[1]/pmc_title"></xsl:value-of></xsl:param> 
   

  <xsl:output    method="xml"    omit-xml-declaration="no"    encoding="UTF-8"
    doctype-public="-//Sun Microsystems Inc.//DTD JavaHelp TOC Version 2.0//EN"
    doctype-system="http://java.sun.com/products/javahelp/toc_2_0.dtd"    indent="yes"/>

  <xsl:template match="*[contains(@class,' map/map ')]" mode="toctop">
  <toc version="2.0">
    <tocitem text="{translate($pmc_title, '&#xA;', '')}">
        <xsl:apply-templates select="*[contains(@class,' map/topicref ')]"/>
  </tocitem>
    </toc>
  </xsl:template>

  <xsl:template match="*[contains(@class,' map/topicref ')]" mode="tocentry">
  <xsl:param name="infile"/>
  <xsl:param name="outroot"/>
  <xsl:param name="outfile"/>
  <xsl:param name="nodeID"/>
  <xsl:param name="isFirst"/>
  <xsl:param name="subtopicNodes"/>
  <xsl:param name="title"/>
  <xsl:choose>
  <xsl:when
 test="(@toc and translate(@toc, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='no')
  					or (@processing-role='resource-only')">
    <!-- <xsl:variable name="results">  -->
    <!-- Process children nodes. -->
        <!--     <xsl:apply-templates select="$subtopicNodes"/> -->
    <xsl:apply-templates select="./*[contains(@class, ' map/topicref ')]"/>
    <!-- </xsl:variable>  -->
    <!-- <xsl:text/>  -->
  </xsl:when>
  <xsl:when test="string-length($title) &gt; 1">
    <tocitem text="{$title}">
      <xsl:if test="$outroot and $outroot!=''">
        <xsl:attribute name="target">
          <xsl:value-of select="translate($outroot, '\/.', '___')"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="$subtopicNodes"/>
    </tocitem>
  </xsl:when>
  <xsl:otherwise>
    <xsl:apply-templates select="$subtopicNodes"/>
  </xsl:otherwise>
  </xsl:choose>
  </xsl:template>

  <!-- do nothing when meeting with reltable -->
  <xsl:template match="*[contains(@class,' map/reltable ')]"/>


  <xsl:template name="substring-before-last-javahelp">
    <xsl:param name="input" />
    <xsl:param name="substr" />
    <xsl:if test="$substr and contains($input, $substr)">
      <xsl:variable name="temp" select="substring-after($input, $substr)" />
      <xsl:value-of select="substring-before($input, $substr)" />
      <xsl:if test="contains($temp, $substr)">
        <xsl:value-of select="$substr" />
        <xsl:call-template name="substring-before-last-javahelp">
          <xsl:with-param name="input" select="$temp" />
          <xsl:with-param name="substr" select="$substr" />
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="substring-after-last-javahelp">
    <xsl:param name="input"/>
    <xsl:param name="substr"/>
    
    <!-- Extract the string which comes after the first occurence -->
    <xsl:variable name="temp" select="substring-after($input,$substr)"/>
    
    <xsl:choose>
      <!-- If it still contains the search string the recursively process -->
      <xsl:when test="$substr and contains($temp,$substr)">
        <xsl:call-template name="substring-after-last-javahelp">
          <xsl:with-param name="input" select="$temp"/>
          <xsl:with-param name="substr" select="$substr"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$temp"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>

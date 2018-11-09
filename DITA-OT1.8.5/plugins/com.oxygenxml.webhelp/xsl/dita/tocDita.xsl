<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2015 Syncro Soft SRL, Romania.  All rights reserved.
Licensed under the terms stated in the license file EULA_Webhelp.txt 
available in the base directory of this Oxygen Webhelp plugin.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
            xmlns:relpath="http://dita2indesign/functions/relpath"
            xmlns:oxygen="http://www.oxygenxml.com/functions"
            xmlns="http://www.oxygenxml.com/ns/webhelp/toc"
            exclude-result-prefixes="relpath oxygen"
            version="2.0">
    
  <xsl:import href="dita-utilities.xsl"/>
  <xsl:import href="../functions.xsl"/>
    
  <!-- Extension of output files for example .html -->
  <xsl:param name="OUT_EXT" select="'.html'"/>
    <!-- the file name containing filter/flagging/revision information
        (file name and extension only - no path).  - testfile: revflag.dita -->
    <xsl:param name="FILTERFILE"/>
    
    <!-- The document tree of filterfile returned by document($FILTERFILE,/)-->
    <xsl:variable name="FILTERFILEURL">
        <xsl:choose>
            <xsl:when test="not($FILTERFILE)"/> <!-- If no filterfile leave empty -->
            <xsl:when test="starts-with($FILTERFILE, 'file:')">
                <xsl:value-of select="$FILTERFILE"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="starts-with($FILTERFILE, '/')">
                        <xsl:text>file://</xsl:text><xsl:value-of select="$FILTERFILE"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>file:/</xsl:text><xsl:value-of select="$FILTERFILE"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="FILTERDOC"
        select="if (string-length($FILTERFILEURL) > 0)
        then document($FILTERFILEURL, /)
        else ()"/>
    
    <xsl:variable name="passthrough-attrs" as="element()*"
        select="$FILTERDOC/val/prop[@action = 'passthrough']"/>

  <xsl:key name="kTopicHrefs" 
               match="*[contains(@class, ' map/topicref ')]
                            [@href]
                            [not(@scope) or @scope = 'local']
                            [not(@processing-role) or @processing-role = 'normal']
                            [not(@format) or @format = 'dita' or @format = 'DITA']" 
               use="@href"/>
    
    <xsl:template match="/">
        <xsl:result-document href="toc.xml" method="xhtml">
            <toc>
                <title>
                    <xsl:choose>
                        <xsl:when test="/*[contains(@class,' map/map ')]/*[contains(@class,' topic/title ')]">
                          <xsl:apply-templates select="/*[contains(@class,' map/map ')]/*[contains(@class,' topic/title ')]" 
                                               mode="surround-with-span"/>
                        </xsl:when>
                        <xsl:when test="/*[contains(@class,' map/map ')]/@title">
                            <xsl:value-of select="/*[contains(@class,' map/map ')]/@title"/>
                        </xsl:when>
                    </xsl:choose>
                </title>
                <xsl:apply-templates mode="toc-webhelp"/>
            </toc>
        </xsl:result-document>
  </xsl:template>
    
    
  <xsl:template match="text()" mode="toc-webhelp"/>
    

  <xsl:template match="*[contains(@class, ' bookmap/booklists ')]" 
                mode="toc-webhelp"/>
    
  <xsl:template match="*[contains(@class, ' bookmap/frontmatter ') 
                              or contains(@class, ' bookmap/backmatter ')
                              or (contains(@class, ' bookmap/notices ') and not(@href) and not(@navtitle))
                              or (contains(@class, ' bookmap/preface ') and not(@href) and not(@navtitle))
                              or contains(@class, ' mapgroup-d/topicgroup ')
                              or (contains(@class, ' bookmap/part ') and not(@href) and not(@navtitle))]"
                mode="toc-webhelp"
                priority="1">
        <xsl:apply-templates mode="toc-webhelp"/>
  </xsl:template>
    
  <xsl:template match="*[@class]" mode="surround-with-span">
      <span class="{oxygen:extractLastClassValue(@class)}">
          <xsl:apply-templates mode="surround-with-span"/>
      </span>
  </xsl:template>
  
  <xsl:template match="text()" mode="surround-with-span toc-title">
      <xsl:value-of select="."/>
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/tm ')]" mode="toc-title">
    <xsl:apply-templates mode="toc-title"/>
    <xsl:choose>
        <xsl:when test="@tmtype='service'"> SM </xsl:when>
        <xsl:when test="@tmtype='tm'"> &#8482; </xsl:when>
        <xsl:when test="@tmtype='reg'"> &#174; </xsl:when>
        <xsl:otherwise>
            <xsl:text>[Error in tm type]</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
    
  <xsl:template match="*[contains(@class, ' map/topicref ') 
                  and not(contains(@class, ' bookmap/booklists ')) 
                  and not(@processing-role='resource-only')
                  and not(@toc='no')
                  and not(ancestor::*[contains(@class, ' map/reltable ')])
                  or contains(@class, ' bookmap/part ')]" 
               mode="toc-webhelp">
        <topic>
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]">
                    <xsl:attribute name="title">
                        <xsl:apply-templates 
                            select="*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]"
                            mode="toc-title"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="@navtitle">
                    <xsl:attribute name="title" select="@navtitle"/>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="@copy-to">
                    <xsl:attribute name="href">
                        <xsl:call-template name="replace-extension">
                            <xsl:with-param name="filename" select="@copy-to"/>
                            <xsl:with-param name="extension" select="$OUT_EXT"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="@href">
                    <xsl:attribute name="href">
                        <xsl:call-template name="replace-extension">
                            <xsl:with-param name="filename" select="@href"/>
                            <xsl:with-param name="extension" select="$OUT_EXT"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="href" select="'javascript:void(0)'"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="@collection-type">
                <xsl:attribute name="collection-type" select="@collection-type"/>
            </xsl:if>
            <xsl:if test="@outputclass">
              <xsl:attribute name="outputclass" select="@outputclass"/>
            </xsl:if>
            <xsl:if test="@scope and not(@scope='local')">
                <xsl:attribute name="scope" select="@scope"/>
            </xsl:if>
            <xsl:if test="exists($passthrough-attrs)">
                <xsl:for-each select="@*">
                    <xsl:if test="$passthrough-attrs[@att = name(current()) and (empty(@val) or (some $v in tokenize(current(), '\s+') satisfies $v = @val))]">
                        <xsl:attribute name="data-{name()}" select="."/>
                    </xsl:if>
                </xsl:for-each>
            </xsl:if>
            <xsl:if test="generate-id(key('kTopicHrefs', @href)[1]) = generate-id()">
                <xsl:variable name="resourceid" select="*[contains(@class, ' map/topicmeta ')]/@resourceid"/>
                <xsl:if test="string-length($resourceid) > 0">
                    <xsl:attribute name="data-id"><xsl:value-of select="$resourceid"/></xsl:attribute>
                </xsl:if>
            </xsl:if>
            <xsl:apply-templates mode="toc-webhelp"/>
        </topic>
    </xsl:template>
</xsl:stylesheet>
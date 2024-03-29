<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2015 Syncro Soft SRL, Romania.  All rights reserved.
Licensed under the terms stated in the license file EULA_Webhelp.txt 
available in the base directory of this Oxygen Webhelp plugin.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:File="java:java.io.File" 
  exclude-result-prefixes="xs xhtml File"
  version="2.0">

  <xsl:include href="common.xsl"/>
  
  <!-- 
    Flag indicating the output is feedback enabled. 
  -->
  <xsl:variable name="IS_FEEDBACK_ENABLED" select="string-length($WEBHELP_PRODUCT_ID) > 0"/>
    
  
  <!-- 
    Create the meta element for the description. 
    De reverificat:
    - EXM-18345  
    - De verificat ca merge paramentrul CSS prin care se specifica un CSS aditional.    
  -->
  <!-- If it already has a description, normalize it.-->
  <xsl:template match="*:meta[@name='description']" mode="fixup_desktop">
    <xsl:element name="meta" namespace="{namespace-uri()}">
      <xsl:attribute name="name">description</xsl:attribute>
      <xsl:attribute name="content"><xsl:value-of select="normalize-space(@content)"/></xsl:attribute>
    </xsl:element>
  </xsl:template>
  <!-- Has no description. Compute one. -->
  <xsl:template match="*:head[not(*:meta[@name='description']) or
                              string-length(normalize-space(*:meta[@name='description'])) = 0]" 
                          mode="fixup_desktop">
    <xsl:copy>
      <!-- Compute a description from the text body. -->
      <xsl:variable name="text" select="normalize-space(string-join(//*:div[contains(@class, 'body')]//text(), ' '))"/>
      <xsl:variable name="textStart">
        <xsl:choose>
          <xsl:when test="string-length($text) &lt; 200">
            <xsl:value-of select="$text"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:variable name="description" 
                select="string-join(tokenize(substring($text, 1, 201), ' ')[position() &lt; last()], ' ')"/>
            <xsl:value-of select="concat($description, ' ...')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <xsl:variable name="trimmed" select="translate($textStart, '&#xA;&#xD;&#x9;', '')"/>
      <xsl:element name="meta" namespace="{namespace-uri()}">
        <xsl:attribute name="name">description</xsl:attribute>
        <xsl:attribute name="content"><xsl:value-of select="$trimmed"/></xsl:attribute>
      </xsl:element>

      <!-- Add the webhelp standard CSS and JS-->
      <xsl:call-template name="generateHeadContent"/>      
    </xsl:copy>
  </xsl:template>
  
  <!-- Add the webhelp standard CSS and JS -->
  <xsl:template match="*:head" mode="fixup_desktop">
    <xsl:copy>
      <xsl:apply-templates mode="fixup_desktop" select="@*"/>
      <xsl:text xml:space="preserve">        
      </xsl:text>
      <xsl:call-template name="generateHeadContent"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template name="generateHeadContent">
      <xsl:apply-templates 
          select="*[not(local-name() = 'link' 
                    and @rel='stylesheet' 
                    and not(contains(@href, 'commonltr.css'))
                    and not(contains(@href, 'commonrtl.css')))]" 
          mode="fixup_desktop"/>
    <xsl:call-template name="jsAndCSS">
      <xsl:with-param name="namespace" select="namespace-uri(/*)"/>
    </xsl:call-template>
  </xsl:template>
  
  <!-- 
    Divert the commonltr.css from the standard DITA-OT location to our resources folder.  
  -->
  <xsl:template match="*:link[ends-with(@href, 'commonltr.css')]" mode="fixup_desktop">
    <xsl:element name="link" namespace="{namespace-uri()}">
      <xsl:attribute name="rel">stylesheet</xsl:attribute>
      <xsl:attribute name="type">text/css</xsl:attribute>
      <xsl:attribute name="href"><xsl:value-of select="concat($PATH2PROJ, 'oxygen-webhelp/resources/css/commonltr.css')"/></xsl:attribute>
      <xsl:comment/>
    </xsl:element>
  </xsl:template>
    
    <xsl:template match="*:link[ends-with(@href, 'commonrtl.css')]" mode="fixup_desktop">
      <xsl:element name="link" namespace="{namespace-uri()}">
        <xsl:attribute name="rel">stylesheet</xsl:attribute>
        <xsl:attribute name="type">text/css</xsl:attribute>
        <xsl:attribute name="href"><xsl:value-of select="concat($PATH2PROJ, 'oxygen-webhelp/resources/css/commonrtl.css')"/></xsl:attribute>
        <xsl:comment/>
      </xsl:element>
    </xsl:template>
    
  <!-- 
    Divert the webhelp_topic.css from the standard DITA-OT location to our resources folder.  
  -->
  <xsl:template match="*:link[ends-with(@href, 'webhelp_topic.css')]" mode="fixup_desktop">
    <xsl:element name="link" namespace="{namespace-uri()}">
      <xsl:attribute name="rel">stylesheet</xsl:attribute>
      <xsl:attribute name="type">text/css</xsl:attribute>
      <xsl:attribute name="href"><xsl:value-of select="concat($PATH2PROJ, 'oxygen-webhelp/resources/css/webhelp_topic.css')"/></xsl:attribute>
      <xsl:comment/>
    </xsl:element>
  </xsl:template>
    
  
  <!-- 
    Adds the highlight/initializing JavaScript to the body element. 
  -->
  <xsl:template match="*:body" mode="fixup_desktop">
    <xsl:copy>
      <xsl:choose>
        <xsl:when test="$IS_FEEDBACK_ENABLED">
          <xsl:attribute name="onload">init('<xsl:value-of select="$PATH2PROJ"/>')</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="onload">highlightSearchTerm()</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:attribute name="class">frmBody</xsl:attribute>
      <xsl:apply-templates mode="fixup_desktop" select="@*"/>
        
      <!-- Custom JavaScript code set by param webhelp.body.script -->
      <xsl:call-template name="jsInBody"/>

      <xsl:apply-templates mode="fixup_desktop"/>
      
      <!-- Injects the feedback div. -->
      <xsl:call-template name="generateFeedbackDiv"/>
    </xsl:copy>
  </xsl:template>


    <xsl:template match="//*[contains(@class,'relinfo')]/*:div
                                   | //*[contains(@class,'linklist')]/*:div" 
                      mode="fixup_desktop">
    <xsl:copy>
      <xsl:apply-templates select="@*" mode="fixup_desktop"/>
      <xsl:choose>
        <xsl:when test="@class">
          <xsl:attribute name="class"><xsl:value-of select="concat(@class, ' related_link')"/></xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="class">related_link</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates mode="fixup_desktop"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="br" mode="fixup_desktop">
      <br xmlns="http://www.w3.org/1999/xhtml"/>
  </xsl:template>


  <!-- 
        Generic copy. 
  -->
  <xsl:template match="node() | @*" mode="fixup_desktop">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*" mode="fixup_desktop" />
    </xsl:copy>
  </xsl:template>
  
  
  <!--
  <xsl:template match="/">
    <xsl:apply-templates mode="fixup_desktop" select="/html"/>
  </xsl:template>-->
  
</xsl:stylesheet>
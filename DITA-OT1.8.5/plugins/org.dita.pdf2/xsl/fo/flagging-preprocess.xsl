<?xml version="1.0" encoding="utf-8"?><!-- Deprecated since 2.2 --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function" exclude-result-prefixes="xsl opentopic-func" xmlns:suitesol="http://suite-sol.com/namespaces/mapcounts" version="2.0">

   <xsl:import href="flag-rules.xsl"></xsl:import>
   <xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"></xsl:import>
   <xsl:import href="plugin:org.dita.base:xsl/common/output-message.xsl"></xsl:import>
  
   

   <!--preserve the doctype-->
   <xsl:output method="xml" encoding="UTF-8" indent="no"></xsl:output>


   <xsl:param name="filterFile" select="&apos;&apos;"></xsl:param>

   <!-- The document tree of filterfile returned by document($FILTERFILE,/)-->

   <!-- Define the error message prefix identifier -->
   <!-- Deprecated since 2.3 -->
   <xsl:variable name="msgprefix">DOTX</xsl:variable>

   <xsl:variable name="FILTERFILEURL">
      <xsl:choose>
         <xsl:when test="not($filterFile)"></xsl:when>
         <!-- If no filterFile leave empty -->
         <xsl:when test="starts-with($filterFile,&apos;file:&apos;)">
            <xsl:value-of select="$filterFile"></xsl:value-of>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="starts-with($filterFile,&apos;/&apos;)">
                  <xsl:text>file://</xsl:text>
                  <xsl:value-of select="$filterFile"></xsl:value-of>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>file:/</xsl:text>
                  <xsl:value-of select="$filterFile"></xsl:value-of>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:variable>

   <xsl:variable name="flagsParams" select="document($FILTERFILEURL,/)"></xsl:variable>
   
   <xsl:template match="*" mode="flagging">
      <xsl:param name="pi-name"></xsl:param>
      <xsl:param name="id"></xsl:param>
      <xsl:param name="flagrules"></xsl:param>

      <xsl:if test="$flagrules">
         <xsl:variable name="conflictexist">
            <xsl:apply-templates select="." mode="conflict-check">
               <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
            </xsl:apply-templates>
         </xsl:variable>

         <xsl:variable name="style">
            <xsl:call-template name="gen-style">
               <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param>
               <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
            </xsl:call-template>
         </xsl:variable>
        

         <xsl:if test="string-length($style) &gt; 0">

            <xsl:element name="suitesol:{$pi-name}">
               <xsl:attribute name="id">
                  <xsl:value-of select="$id"></xsl:value-of>
               </xsl:attribute>
               <xsl:attribute name="style">
                  <xsl:value-of select="$style"></xsl:value-of>
               </xsl:attribute>
            </xsl:element>
         </xsl:if>
       </xsl:if>
           
   </xsl:template>

   <xsl:template match="*" mode="changebar">
      <xsl:param name="pi-name"></xsl:param>
      <xsl:param name="id"></xsl:param>
      <xsl:param name="flagrules"></xsl:param>

      <xsl:if test="$flagrules">
         <xsl:for-each select="$flagrules/*[@changebar]">
            
            <xsl:element name="{concat(&apos;suitesol:changebar-&apos;,$pi-name)}">
               <xsl:attribute name="id">
                  <xsl:value-of select="concat($id,&apos;_&apos;,count(preceding::*))"></xsl:value-of>
               </xsl:attribute>
               <xsl:if test="$pi-name=&apos;start&apos;">
                  <xsl:attribute name="changebar">
                     <xsl:value-of select="@changebar"></xsl:value-of>
                  </xsl:attribute>
               </xsl:if>
            </xsl:element>
         </xsl:for-each>

      </xsl:if>

   </xsl:template>

   <xsl:template match="*" mode="copy-contents">

      <xsl:param name="id"></xsl:param>
      <xsl:param name="flagrules"></xsl:param>

      <xsl:call-template name="start-flagit">
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:call-template>

      <xsl:copy>
         <xsl:apply-templates select="@*"></xsl:apply-templates>

         <xsl:apply-templates></xsl:apply-templates>

      </xsl:copy>

      <xsl:call-template name="end-flagit">
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:call-template>

   </xsl:template>
   
   <!-- Don't flag topics, just like in the HTML output -->
   <xsl:template match="*[contains(@class, &apos; topic/topic &apos;)]" priority="50">
      <xsl:copy>
         <xsl:apply-templates select="@*"></xsl:apply-templates>
         <xsl:apply-templates></xsl:apply-templates>
      </xsl:copy>
   </xsl:template>
              
   <!-- For these elements, the flagging style can be applied directly to the fo element 
        already being created by the default DITA-OT processing -->
   <xsl:template match="*[contains(@class, &apos; topic/image &apos;) or contains(@class,&apos; topic/table &apos;) or                 contains(@class, &apos; topic/ol &apos;) or                 contains(@class, &apos; topic/ul &apos;) or contains(@class, &apos; topic/sl &apos;)]" priority="50">

      <xsl:variable name="id">
         <xsl:value-of select="generate-id(.)"></xsl:value-of>
      </xsl:variable>

      <xsl:variable name="flagrules">
         <xsl:apply-templates select="." mode="getrules">
         </xsl:apply-templates>
      </xsl:variable>
      
      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">start</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
      
      <xsl:call-template name="start-flagit">
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:call-template>
      
      <xsl:copy>
         <xsl:apply-templates select="@*"></xsl:apply-templates>

         <xsl:apply-templates select="." mode="flagging">
            <xsl:with-param name="pi-name">flagging-inside</xsl:with-param>
            <xsl:with-param name="id" select="$id"></xsl:with-param>
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:apply-templates>


         <xsl:apply-templates></xsl:apply-templates>

      </xsl:copy>
      
      <xsl:call-template name="end-flagit">
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:call-template>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">end</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
      
   </xsl:template>

   <!-- For these elements, the flagging style must be applied to a new fo:block around the element,
        which for now is place-held by the suitesol:flagging-outside element -->
   <xsl:template match="*[contains(@class, &apos; topic/simpletable &apos;) or contains(@class, &apos; topic/dl &apos;) or contains(@class, &apos; topic/note &apos;) or contains(@class, &apos; pr-d/codeblock &apos;) or contains(@class, &apos; ui-d/screen &apos;)]" priority="40">

      <xsl:variable name="id">
         <xsl:value-of select="generate-id(.)"></xsl:value-of>
      </xsl:variable>

      <xsl:variable name="flagrules">
         <xsl:apply-templates select="." mode="getrules">
         </xsl:apply-templates>
      </xsl:variable>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">start</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>

      <xsl:variable name="style">
         <xsl:if test="$flagrules">
            <xsl:variable name="conflictexist">
               <xsl:apply-templates select="." mode="conflict-check">
                  <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
               </xsl:apply-templates>
            </xsl:variable>
            <xsl:call-template name="gen-style">
               <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param>
               <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>

      <xsl:choose>
         <xsl:when test="string-length(normalize-space($style)) &gt; 0">
            <suitesol:flagging-outside style="{$style}">
               <xsl:apply-templates select="." mode="copy-contents">
                  <xsl:with-param name="id" select="$id"></xsl:with-param>
                  <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>

               </xsl:apply-templates>
            </suitesol:flagging-outside>
         </xsl:when>
         <!-- If there's no style, don't bother creating the surrounding block -->
         <xsl:otherwise>
            <xsl:apply-templates select="." mode="copy-contents">
               <xsl:with-param name="id" select="$id"></xsl:with-param>
               <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>

            </xsl:apply-templates>
         </xsl:otherwise>
      </xsl:choose>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">end</xsl:with-param>
         <xsl:with-param name="id">
            <xsl:value-of select="$id"></xsl:value-of>
         </xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>

   </xsl:template>

   <!-- For these elements, the flagging style must be applied to a new fo:inline around the element,
      which for now is place-held by the suitesol:flagging-outside-inline element -->
   <xsl:template match="*[contains(@class, &apos; topic/xref &apos;) or contains(@class, &apos; topic/link &apos;)]" priority="40">

      <xsl:variable name="id">
         <xsl:value-of select="generate-id(.)"></xsl:value-of>
      </xsl:variable>

      <xsl:variable name="flagrules">
         <xsl:apply-templates select="." mode="getrules">
         </xsl:apply-templates>
      </xsl:variable>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">start</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>

      <xsl:variable name="style">
         <xsl:if test="$flagrules">
            <xsl:variable name="conflictexist">
               <xsl:apply-templates select="." mode="conflict-check">
                  <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
               </xsl:apply-templates>
            </xsl:variable>
            <xsl:call-template name="gen-style">
               <xsl:with-param name="conflictexist" select="$conflictexist"></xsl:with-param>
               <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
            </xsl:call-template>
         </xsl:if>
      </xsl:variable>

      <xsl:choose>
         <xsl:when test="string-length(normalize-space($style)) &gt; 0">
            <suitesol:flagging-outside-inline style="{$style}">
               <xsl:apply-templates select="." mode="copy-contents">
                  <xsl:with-param name="id" select="$id"></xsl:with-param>
                  <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>

               </xsl:apply-templates>
            </suitesol:flagging-outside-inline>
         </xsl:when>

         <xsl:otherwise>
            <xsl:apply-templates select="." mode="copy-contents">
               <xsl:with-param name="id" select="$id"></xsl:with-param>
               <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>

            </xsl:apply-templates>
         </xsl:otherwise>
      </xsl:choose>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">end</xsl:with-param>
         <xsl:with-param name="id">
            <xsl:value-of select="$id"></xsl:value-of>
         </xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
   </xsl:template>


   <!-- For these elements, the flagging style can be applied directly to the fo element 
      already being created by the default DITA-OT processing, but now the startflag and endflag images 
      are placed inside the element rather than before and after it -->
   <xsl:template match="*[contains(@class,&apos; topic/entry &apos;) or contains(@class, &apos; topic/stentry &apos;) or                contains(@class, &apos; topic/dd &apos;) or contains(@class, &apos; topic/dt &apos;) or                 contains(@class, &apos; topic/ddhd &apos;) or contains(@class, &apos; topic/dthd &apos;)]" priority="30">

      <xsl:variable name="id">
         <xsl:value-of select="generate-id(.)"></xsl:value-of>
      </xsl:variable>
      
      <xsl:variable name="flagrules">
         <xsl:apply-templates select=". | parent::*" mode="getrules">
         </xsl:apply-templates>
      </xsl:variable>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">start</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
      
      <xsl:copy>

         <xsl:apply-templates select="@*"></xsl:apply-templates>

         <!-- copy attributes from parents -->       
         <xsl:apply-templates select="." mode="flagging">
            <xsl:with-param name="pi-name">flagging-inside</xsl:with-param>
            <xsl:with-param name="id" select="$id"></xsl:with-param>
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:apply-templates>
     
         <xsl:call-template name="start-flagit">
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:call-template>

         <xsl:apply-templates></xsl:apply-templates>

         <xsl:call-template name="end-flagit">
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:call-template>
    
      </xsl:copy>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">end</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
      
   </xsl:template>

   <!-- For these elements, the flagging style can be applied directly to the fo element 
      already being created by the default DITA-OT processing, 
      but startflag and endflag images are not supported (where would they go?) -->
   <xsl:template match="*[contains(@class,&apos; topic/tgroup &apos;) or contains(@class, &apos; topic/thead &apos;) or                contains(@class,&apos; topic/tfoot &apos;) or contains(@class,&apos; topic/tbody &apos;) or contains(@class,&apos; topic/row &apos;) or contains(@class, &apos; topic/strow &apos;) or                contains(@class, &apos; topic/dlentry &apos;) or contains(@class, &apos; topic/dlhead &apos;) or                 contains(@class, &apos; topic/sthead &apos;)]" priority="20">

      <xsl:variable name="id">
         <xsl:value-of select="generate-id(.)"></xsl:value-of>
      </xsl:variable>
      <xsl:variable name="flagrules">
         <xsl:apply-templates select="." mode="getrules">
         </xsl:apply-templates>
      </xsl:variable>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">start</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
      
      <xsl:copy>
         <xsl:apply-templates select="@*"></xsl:apply-templates>

         <xsl:apply-templates select="." mode="flagging">
            <xsl:with-param name="pi-name">flagging-inside</xsl:with-param>
            <xsl:with-param name="id" select="$id"></xsl:with-param>
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:apply-templates>

         <xsl:apply-templates></xsl:apply-templates>        
      </xsl:copy>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">end</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
      
   </xsl:template>
                
   <!-- For all other elements, we try to apply the flagging style directly to the fo element 
      already being created by the default DITA-OT processing, and place the startflag and endflag images 
      inside the element -->
   <xsl:template match="*" priority="-1">

      <xsl:variable name="id">
         <xsl:value-of select="generate-id(.)"></xsl:value-of>
      </xsl:variable>

      <xsl:variable name="flagrules">
         <xsl:apply-templates select="." mode="getrules">
         </xsl:apply-templates>
      </xsl:variable>

      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">start</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
      
      <xsl:copy>
         <xsl:apply-templates select="@*"></xsl:apply-templates>

         <xsl:apply-templates select="." mode="flagging">
            <xsl:with-param name="pi-name">flagging-inside</xsl:with-param>
            <xsl:with-param name="id" select="$id"></xsl:with-param>
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:apply-templates>

         <xsl:call-template name="start-flagit">
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:call-template>

         <xsl:apply-templates></xsl:apply-templates>

         <xsl:call-template name="end-flagit">
            <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
         </xsl:call-template>
        
      </xsl:copy>
      
      <xsl:apply-templates select="." mode="changebar">
         <xsl:with-param name="pi-name">end</xsl:with-param>
         <xsl:with-param name="id" select="$id"></xsl:with-param>
         <xsl:with-param name="flagrules" select="$flagrules"></xsl:with-param>
      </xsl:apply-templates>
      
   </xsl:template>

   <xsl:template match="@*" priority="-1">
      <xsl:copy-of select="."></xsl:copy-of>
   </xsl:template>

   <!-- copy over all comments so that <a> won't be empty -->
   <xsl:template match="comment() | processing-instruction() | text()">
      <xsl:copy-of select="."></xsl:copy-of>
   </xsl:template>  
   
   <xsl:template name="gen-style">
      <xsl:param name="conflictexist" select="&apos;false&apos;"></xsl:param>
      <xsl:param name="flagrules"></xsl:param>

      <xsl:variable name="colorprop">
         <xsl:choose>
            <xsl:when test="contains(@class, &apos; topic/image &apos;)">
               <xsl:text>border-style:solid;border-width:1pt;border-color:</xsl:text>
            </xsl:when>
            <xsl:otherwise>color:</xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <xsl:variable name="back-colorprop">
         <xsl:choose>
            <xsl:when test="contains(@class, &apos; topic/image &apos;)">
               <xsl:text>border-style:solid;border-width:3pt;border-color:</xsl:text>
            </xsl:when>
            <xsl:otherwise>background-color:</xsl:otherwise>
         </xsl:choose>
      </xsl:variable>
      
      <xsl:choose>
         <xsl:when test="$conflictexist=&apos;true&apos; and $flagsParams/val/style-conflict[@foreground-conflict-color or @background-conflict-color]">
            <xsl:call-template name="output-message">

            </xsl:call-template>

            <xsl:if test="$flagsParams/val/style-conflict[@foreground-conflict-color]">
               <xsl:value-of select="$colorprop"></xsl:value-of>
               <xsl:value-of select="$flagsParams/val/style-conflict/@foreground-conflict-color"></xsl:value-of>
               <xsl:text>;</xsl:text>
            </xsl:if>
            <xsl:if test="$flagsParams/val/style-conflict[@background-conflict-color]">
               <xsl:value-of select="$back-colorprop"></xsl:value-of>
               <xsl:value-of select="$flagsParams/val/style-conflict/@background-conflict-color"></xsl:value-of>
               <xsl:text>;</xsl:text>
            </xsl:if>

         </xsl:when>
         <xsl:when test="$conflictexist=&apos;false&apos; and $flagrules/*[@color or @backcolor]">

            <xsl:if test="$flagrules/*[@color]">
               <xsl:value-of select="$colorprop"></xsl:value-of>
               <xsl:value-of select="$flagrules/*[@color]/@color"></xsl:value-of>
               <xsl:text>;</xsl:text>
            </xsl:if>
            <xsl:if test="$flagrules/*[@backcolor]">
               <xsl:value-of select="$back-colorprop"></xsl:value-of>
               <xsl:value-of select="$flagrules/*[@backcolor]/@backcolor"></xsl:value-of>
               <xsl:text>;</xsl:text>
            </xsl:if>

         </xsl:when>
      </xsl:choose>
      
      <xsl:for-each select="$flagrules/*[@style]">
            <xsl:choose>
               <xsl:when test="./@style=&apos;bold&apos;">
                  <xsl:text>font-weight:</xsl:text>
               </xsl:when>
               <xsl:when test="./@style=&apos;italics&apos; or ./@style=&apos;italic&apos;">
                  <xsl:text>font-style:</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>text-decoration:</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
               <xsl:when test="./@style=&apos;double-underline&apos;">
                  <xsl:text>underline</xsl:text>
               </xsl:when>
               <xsl:when test="./@style=&apos;italics&apos;">
                  <xsl:text>italic</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="./@style"></xsl:value-of>
               </xsl:otherwise>
            </xsl:choose>
             <xsl:text>;</xsl:text>
      </xsl:for-each>
   </xsl:template>

   <xsl:template name="start-flagit">
      <xsl:param name="flagrules"></xsl:param>
      <xsl:apply-templates select="$flagrules/*[1]" mode="start-flagit"></xsl:apply-templates>
   </xsl:template>

   <xsl:template match="prop|revprop" mode="start-flagit">
      <xsl:choose>
         <!-- Ensure there's an image to get, otherwise don't insert anything -->
         <xsl:when test="startflag/@imageref">
            <xsl:variable name="imgsrc" select="startflag/@imageref"></xsl:variable>
            <image class="- topic/image " placement="inline">
               <xsl:attribute name="href">                  
                  <xsl:value-of select="$imgsrc"></xsl:value-of>
               </xsl:attribute>
               <xsl:if test="startflag/alt-text">
                  <xsl:attribute name="alt">
                     <xsl:value-of select="startflag/alt-text"></xsl:value-of>
                  </xsl:attribute>
               </xsl:if>
            </image>
         </xsl:when>
         <xsl:when test="startflag/alt-text">
            <xsl:value-of select="startflag/alt-text"></xsl:value-of>
         </xsl:when>
         <xsl:when test="@img">
            <!-- output the flag -->
            <image class="- topic/image " placement="inline">
               <xsl:attribute name="href">                  
                  <xsl:value-of select="@img"></xsl:value-of>
               </xsl:attribute>               
            </image>
         </xsl:when>
         <xsl:otherwise></xsl:otherwise>
         <!-- that flag not active -->
      </xsl:choose>
      <xsl:apply-templates select="following-sibling::*[1]" mode="start-flagit"></xsl:apply-templates>
   </xsl:template>

   <xsl:template name="end-flagit">
      <xsl:param name="flagrules">
         <!--xsl:call-template name="getrules"/-->
      </xsl:param>
      <xsl:apply-templates select="$flagrules/*[last()]" mode="end-flagit"></xsl:apply-templates>
   </xsl:template>

   <xsl:template match="prop|revprop" mode="end-flagit">
      <xsl:choose>
         <!-- Ensure there's an image to get, otherwise don't insert anything -->
         <xsl:when test="endflag/@imageref">
            <xsl:variable name="imgsrc" select="endflag/@imageref"></xsl:variable>
            <image class="- topic/image " placement="inline">
               <xsl:attribute name="href">               
                  <xsl:value-of select="$imgsrc"></xsl:value-of>
               </xsl:attribute>
               <xsl:if test="endflag/alt-text">
                  <xsl:attribute name="alt">
                     <xsl:value-of select="endflag/alt-text"></xsl:value-of>
                  </xsl:attribute>
               </xsl:if>
            </image>
         </xsl:when>
         <xsl:when test="endflag/alt-text">
            <xsl:value-of select="endflag/alt-text"></xsl:value-of>
         </xsl:when>
         <!-- not necessary to add logic for @img. original ditaval does not support end flag. -->
         <xsl:otherwise></xsl:otherwise>
         <!-- that flag not active -->
      </xsl:choose>
      <xsl:apply-templates select="preceding-sibling::*[1]" mode="end-flagit"></xsl:apply-templates>
   </xsl:template>


</xsl:stylesheet>
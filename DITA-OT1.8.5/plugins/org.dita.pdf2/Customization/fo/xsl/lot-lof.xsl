<?xml version='1.0'?>



<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
  xmlns:opentopic="http://www.idiominc.com/opentopic"
  xmlns:exsl="http://exslt.org/common"
  xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
  xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder"
  extension-element-prefixes="exsl"
  exclude-result-prefixes="opentopic exsl opentopic-index dita2xslfo ot-placeholder"
  version="2.0">
  
  <xsl:variable name="tableset">
    <!-- path modified to remove pmc-revhistory elements -->
    <xsl:for-each select="//*[contains (@class, ' topic/table ')][*[contains(@class, ' topic/title ' )]][not(descendant::pmc-revhistory)]">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:if test="not(@id)">
          <xsl:attribute name="id">
            <xsl:call-template name="get-id"/>
          </xsl:attribute>
        </xsl:if>
      </xsl:copy>
    </xsl:for-each>
  </xsl:variable>
  
  <xsl:variable name="figureset">
    <xsl:for-each select="//*[contains (@class, ' topic/fig ')][*[contains(@class, ' topic/title ' )]]">
      <xsl:copy>
        <xsl:copy-of select="@*"/>
        <xsl:if test="not(@id)">
          <xsl:attribute name="id">
            <xsl:call-template name="get-id"/>
          </xsl:attribute>
        </xsl:if>
      </xsl:copy>
    </xsl:for-each>
  </xsl:variable>
  
  
  <!--   LOT   -->
  
  <xsl:template match="ot-placeholder:tablelist">
    <xsl:if test="//*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ' )]">
      <!--exists tables with titles-->
      <fo:page-sequence master-reference="toc-sequence" format="i" xsl:use-attribute-sets="__force__page__count">
        <xsl:call-template name="insertTocStaticContents"/>
        <fo:flow flow-name="xsl-region-body">
          <fo:block start-indent="0in">
            <xsl:call-template name="createLOTHeader"/>
            <!-- This is the template for the LOT -->
            <xsl:apply-templates select="//*[contains (@class, ' topic/table ')][child::*[contains(@class, ' topic/title ' )]]" mode="list.of.tables"/>
          </fo:block>
        </fo:flow>
        
      </fo:page-sequence>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="createLOTHeader">
    <fo:block xsl:use-attribute-sets="__lotf__heading" id="{$id.lot}">
      <fo:marker marker-class-name="current-header">
        <xsl:call-template name="insertVariable">
          <xsl:with-param name="theVariableID" select="'List of Tables'"/>
        </xsl:call-template>
      </fo:marker>
      <xsl:call-template name="insertVariable">
        <xsl:with-param name="theVariableID" select="'List of Tables'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>
  
  <!-- The following template removes the Revision History tables from the LOT -->
  <xsl:template match="*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ' )]][descendant::*[contains(@class, ' pmcrevhis-d/pmc-revhistory ')]]" mode="list.of.tables" priority="1000"/>
  
  <xsl:template match="*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ' )]]" mode="list.of.tables">  
    <fo:block xsl:use-attribute-sets="__lotf__content">
      <fo:basic-link xsl:use-attribute-sets="__toc__link">
        <xsl:attribute name="internal-destination">
          <xsl:call-template name="get-id"/>
        </xsl:attribute>          
        <fo:inline xsl:use-attribute-sets="__lotf__title">
          <xsl:call-template name="insertVariable">
            <xsl:with-param name="theVariableID" select="'Table'"/>
            <xsl:with-param name="theParameters">
              <number>
                <xsl:variable name="id">
                  <xsl:call-template name="get-id"/>
                </xsl:variable>
                <xsl:variable name="tableNumber">
                  <!-- This path has been altered to remove the number from the Revision History tables. -->
                  <xsl:number format="1" value="(count($tableset/*[@id = $id]/preceding-sibling::*) + 1) - count($tableset/*[@id = $id]/preceding-sibling::*[descendant::pmc-revhistory])" />
                </xsl:variable>
                <xsl:value-of select="$tableNumber"/>
              </number>
              <title>
                <xsl:apply-templates select="./*[contains(@class, ' topic/title ')]" mode="insert-text"/>
              </title>
            </xsl:with-param>
          </xsl:call-template>
        </fo:inline>
        
        <fo:inline xsl:use-attribute-sets="__lotf__page-number">
          <fo:leader xsl:use-attribute-sets="__lotf__leader"/>
          <fo:page-number-citation>
            <xsl:attribute name="ref-id">
              <xsl:call-template name="get-id"/>
            </xsl:attribute>
          </fo:page-number-citation>
        </fo:inline>
        
      </fo:basic-link>
    </fo:block>
    
  </xsl:template>
  
  <xsl:template match="*[contains(@class, ' topic/ph ')]" mode="insert-text">
    <fo:inline xsl:use-attribute-sets="ph">
      <xsl:call-template name="commonattributes"/>
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>
  
  <!--   LOF   -->
  
  <xsl:template match="ot-placeholder:figurelist">
    <xsl:if test="//*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ' )]">
      <!--exists figures with titles-->
      <fo:page-sequence master-reference="toc-sequence" format="i" xsl:use-attribute-sets="__force__page__count">
        
        <xsl:call-template name="insertTocStaticContents"/>
        <fo:flow flow-name="xsl-region-body">
          <fo:block start-indent="0in">
            <xsl:call-template name="createLOFHeader"/>
            
            <xsl:apply-templates select="//*[contains (@class, ' topic/fig ')][child::*[contains(@class, ' topic/title ' )]]" mode="list.of.figures"/>
          </fo:block>
        </fo:flow>
        
      </fo:page-sequence>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="createLOFHeader">
    <fo:block xsl:use-attribute-sets="__lotf__heading" id="{$id.lof}">
      <fo:marker marker-class-name="current-header">
        <xsl:call-template name="insertVariable">
          <xsl:with-param name="theVariableID" select="'List of Figures'"/>
        </xsl:call-template>
      </fo:marker>
      <xsl:call-template name="insertVariable">
        <xsl:with-param name="theVariableID" select="'List of Figures'"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="*[contains (@class, ' topic/fig ')][child::*[contains(@class, ' topic/title ' )]]" mode="list.of.figures">   
    
    <fo:block xsl:use-attribute-sets="__lotf__content">
      <fo:basic-link xsl:use-attribute-sets="__toc__link">
        <xsl:attribute name="internal-destination">
          <xsl:call-template name="get-id"/>
        </xsl:attribute>          
        <fo:inline xsl:use-attribute-sets="__lotf__title">
          <xsl:call-template name="insertVariable">
            <xsl:with-param name="theVariableID" select="'Figure'"/>
            <xsl:with-param name="theParameters">
              <number>
                <xsl:variable name="id">
                  <xsl:call-template name="get-id"/>
                </xsl:variable>
                <xsl:variable name="figureNumber">
                  <xsl:number format="1" value="count($figureset/*[@id = $id]/preceding-sibling::*) + 1" />
                </xsl:variable>
                <xsl:value-of select="$figureNumber"/>
              </number>
              <title>
                <xsl:apply-templates select="./*[contains(@class, ' topic/title ')]" mode="insert-text"/>
              </title>
            </xsl:with-param>
          </xsl:call-template>
        </fo:inline>
        
        <fo:inline xsl:use-attribute-sets="__lotf__page-number">
          <fo:leader xsl:use-attribute-sets="__lotf__leader"/>
          <fo:page-number-citation>
            <xsl:attribute name="ref-id">
              <xsl:call-template name="get-id"/>
            </xsl:attribute>
          </fo:page-number-citation>
        </fo:inline>
        
      </fo:basic-link>
    </fo:block>
    
  </xsl:template>
  
</xsl:stylesheet>

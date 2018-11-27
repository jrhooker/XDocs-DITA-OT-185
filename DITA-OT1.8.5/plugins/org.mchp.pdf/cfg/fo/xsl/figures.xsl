<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    exclude-result-prefixes="opentopic-func xs dita2xslfo dita-ot"
    version="2.0">
   

    <xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]">
        <xsl:variable name="chapter-number">
            <xsl:variable name="chapter-id" select="ancestor::*[contains(@class, 'topic/topic')][parent::*[contains(@class, 'map/map')]]/@id"/>
            <xsl:apply-templates select="//*[@id = $chapter-id]" mode="topicTitleNumber"/>
        </xsl:variable>
        <fo:block xsl:use-attribute-sets="table.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="'Table'"/>
                <xsl:with-param name="theParameters">
                    <number>
                        <xsl:value-of select="$chapter-number"/>
                        <xsl:text>-</xsl:text>
                        <xsl:number level="any" count="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')][not(ancestor::table/descendant::pmc-revhistory)]" from="/"/>
                    </number>
                    <title>
                        <xsl:apply-templates/>
                    </title>
                </xsl:with-param>
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="*[contains(@class,' topic/fig ')]/*[contains(@class,' topic/title ')]">
        <xsl:variable name="chapter-number">
            <xsl:variable name="chapter-id" select="ancestor::*[contains(@class, 'topic/topic')][parent::*[contains(@class, 'map/map')]]/@id"/>
            <xsl:apply-templates select="//*[@id = $chapter-id]" mode="topicTitleNumber"/>
        </xsl:variable>
        <fo:block xsl:use-attribute-sets="fig.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="insertVariable">
                <xsl:with-param name="theVariableID" select="'Figure'"/>
                <xsl:with-param name="theParameters">
                    <number>
                        <xsl:if test="string-length($chapter-number) &gt; 0">
                            <xsl:value-of select="$chapter-number"/>
                            <xsl:text>-</xsl:text>
                        </xsl:if>                        
                        <xsl:number level="any" count="*[contains(@class, ' topic/fig ')][child::*[contains(@class, ' topic/title ')]]" from="/"/>
                    </number>
                    <title>
                        <xsl:apply-templates/>
                    </title>
                </xsl:with-param>
            </xsl:call-template>
        </fo:block>
    </xsl:template>
    
    
     
  
    
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    exclude-result-prefixes="opentopic-func xs dita2xslfo dita-ot" version="2.0">

    <!--  Choicetable processing changed for localization -->
    <xsl:template match="*[contains(@class, ' task/choicetable ')]">
        <fo:table xsl:use-attribute-sets="choicetable">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="univAttrs"/>
            <xsl:call-template name="globalAtts"/>

            <xsl:choose>
                <xsl:when test="@relcolwidth">
                    <xsl:variable name="fix-relcolwidth">
                        <xsl:apply-templates select="." mode="fix-relcolwidth"/>
                    </xsl:variable>
                    <xsl:call-template name="createSimpleTableColumns">
                        <xsl:with-param name="theColumnWidthes" select="$fix-relcolwidth"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="createSimpleTableColumns">
                        <xsl:with-param name="theColumnWidthes">1* 4*</xsl:with-param>
                    </xsl:call-template>
                </xsl:otherwise>
            </xsl:choose>

            <xsl:choose>
                <xsl:when test="*[contains(@class, ' task/chhead ')]">
                    <xsl:apply-templates select="*[contains(@class, ' task/chhead ')]"/>
                </xsl:when>
                <xsl:otherwise>
                    <fo:table-header xsl:use-attribute-sets="chhead">
                        <fo:table-row xsl:use-attribute-sets="chhead__row">
                            <fo:table-cell xsl:use-attribute-sets="chhead.choptionhd">
                                <fo:block xsl:use-attribute-sets="chhead.choptionhd__content">
                                    <xsl:call-template name="insertVariable">
                                        <xsl:with-param name="theVariableID" select="'Options'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="chhead.chdeschd">
                                <fo:block xsl:use-attribute-sets="chhead.chdeschd__content">
                                    <xsl:call-template name="insertVariable">
                                        <xsl:with-param name="theVariableID" select="'Description'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                </xsl:otherwise>
            </xsl:choose>

            <fo:table-body xsl:use-attribute-sets="choicetable__body">
                <xsl:apply-templates select="*[contains(@class, ' task/chrow ')]"/>
            </fo:table-body>

        </fo:table>
    </xsl:template>

    <xsl:template name="getTableColsep">
        <xsl:variable name="spanname" select="@spanname"/>
        <xsl:variable name="colname" select="@colname"/>
        <xsl:choose>
            <xsl:when test="@colsep">
                <xsl:value-of select="@colsep"/>
            </xsl:when>
            <xsl:when
                test="ancestor::*[contains(@class, ' topic/tgroup ')][1]/*[contains(@class, ' topic/colspec ')][@colname = $colname]/@colsep">
                <xsl:value-of
                    select="ancestor::*[contains(@class, ' topic/tgroup ')][1]/*[contains(@class, ' topic/colspec ')][@colname = $colname]/@colsep"
                />
            </xsl:when>
            <xsl:when test="ancestor::*[contains(@class, ' topic/tgroup ')][1]/@colsep">
                <xsl:value-of select="ancestor::*[contains(@class, ' topic/tgroup ')][1]/@colsep"/>
            </xsl:when>
            <xsl:when test="ancestor::*[contains(@class, ' topic/table ')][1]/@colsep">
                <xsl:value-of select="ancestor::*[contains(@class, ' topic/table ')][1]/@colsep"/>
            </xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="getTableRowsep">
        <xsl:variable name="colname" select="@colname"/>
        <xsl:variable name="spanname" select="@spanname"/>
        <xsl:choose>
            <xsl:when test="@rowsep">
                <xsl:value-of select="@rowsep"/>
            </xsl:when>
            <xsl:when test="ancestor::*[contains(@class, ' topic/row ')][1]/@rowsep">
                <xsl:value-of select="ancestor::*[contains(@class, ' topic/row ')][1]/@rowsep"/>
            </xsl:when>
            <xsl:when
                test="ancestor::*[contains(@class, ' topic/tgroup ')][1]/*[contains(@class, ' topic/colspec ')][@colname = $colname]/@rowsep">
                <xsl:value-of
                    select="ancestor::*[contains(@class, ' topic/tgroup ')][1]/*[contains(@class, ' topic/colspec ')][@colname = $colname]/@rowsep"
                />
            </xsl:when>
            <xsl:when test="ancestor::*[contains(@class, ' topic/tgroup ')][1]/@rowsep">
                <xsl:value-of select="ancestor::*[contains(@class, ' topic/tgroup ')][1]/@rowsep"/>
            </xsl:when>
            <xsl:when test="ancestor::*[contains(@class, ' topic/table ')][1]/@rowsep">
                <xsl:value-of select="ancestor::*[contains(@class, ' topic/table ')][1]/@rowsep"/>
            </xsl:when>
            <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- changed number-cells parameter to default to a value of 2 to handle choicetables. -->
    <xsl:template match="*" mode="fix-relcolwidth">
        <xsl:param name="number-cells" as="xs:integer">2</xsl:param>
        <xsl:variable name="relcolwidth-tokens" select="tokenize(normalize-space(@relcolwidth), '\s+')" as="xs:string*"/>
        <xsl:variable name="number-relwidths" select="count($relcolwidth-tokens)" as="xs:integer"/>
        <xsl:variable name="result" as="xs:string*">
            <xsl:sequence select="$relcolwidth-tokens"/>
            <xsl:for-each select="1 to ($number-cells - $number-relwidths)">1*</xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$result" separator=" "/>
    </xsl:template>

</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">    
     
    <!-- Colors for background of table cells -->
    
    <xsl:template name="findBackgroundColor">
        <xsl:choose>
            <xsl:when test="@bg_color">
                <xsl:attribute name="background-color">
                    <xsl:value-of select="@bg_color"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="parent::*[contains(@class, ' topic/row ')][@bg_color]">
                <xsl:attribute name="background-color">
                    <xsl:value-of select="parent::*[contains(@class, ' topic/row ')]/@bg_color"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="@namest">
                        <xsl:variable name="namest" select="@namest"/>
                        <xsl:if
                            test="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][@colname = $namest]/@bg_color">
                            <xsl:attribute name="background-color">
                                <xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][@colname = $namest]/@bg_color"
                                />
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="current_cell">
                            <xsl:call-template name="determine-current-cell">
                                <xsl:with-param name="dataset"
                                    select="preceding-sibling::*[contains(@class, ' topic/entry ')]"
                                />
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:if
                            test="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][number($current_cell)]/@bg_color">
                            <xsl:attribute name="background-color">
                                <xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][number($current_cell)]/@bg_color"
                                />
                            </xsl:attribute>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="determine-current-cell">
        <!-- A template to determine the correct colspec element that an individual cell refers too -->
        <xsl:param name="dataset"/>
        <xsl:param name="running_count" select="0"/>
        <xsl:param name="position" select="1"/>
        <xsl:choose>
            <xsl:when test="$position &lt;= count($dataset)">
                <xsl:choose>
                    <xsl:when test="$dataset[$position][@namest]">
                        <xsl:variable name="namest" select="$dataset[$position]/@namest"/>
                        <xsl:variable name="nameend" select="$dataset[$position]/@nameend"/>
                        <xsl:variable name="starting_colpec"
                            select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][@colname = $namest]/position()"/>
                        <xsl:variable name="ending_colspec"
                            select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][@colname = $nameend]/position()"/>
                        <xsl:call-template name="determine-current-cell">
                            <xsl:with-param name="dataset" select="$dataset"/>
                            <xsl:with-param name="running_count"
                                select="$running_count + ($ending_colspec - $starting_colpec) + 1"/>
                            <xsl:with-param name="position" select="$position + 1"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="determine-current-cell">
                            <xsl:with-param name="dataset" select="$dataset"/>
                            <xsl:with-param name="running_count" select="$running_count + 1"/>
                            <xsl:with-param name="position" select="$position + 1"/>
                        </xsl:call-template>
                    </xsl:otherwise>
                    
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- This whole exercise has been to determine how many cells preceed the current one, so add one more to bring us up to the present. -->
                <xsl:value-of select="$running_count + 1"/>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="*[contains(@class, ' topic/li ')]" mode="retrieveReferenceTitle">
        <xsl:value-of select="count(preceding-sibling::*[contains(@class, ' topic/li ')]) + 1"/>
    </xsl:template>
    
    <xsl:template match="*" mode="placeImage">
        <xsl:param name="imageAlign"/>
        <xsl:param name="href"/>
        <xsl:param name="height"/>
        <xsl:param name="width"/>
        <!--Using align attribute set according to image @align attribute-->
        <xsl:call-template name="processAttrSetReflection">
            <xsl:with-param name="attrSet" select="concat('__align__', $imageAlign)"/>
            <xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
        </xsl:call-template>
        <fo:external-graphic src="url({$href})" xsl:use-attribute-sets="image">
            <!--Setting image height if defined-->
            <xsl:if test="$height">
                <xsl:attribute name="content-height">
                    <!--The following test was commented out because most people found the behavior
                 surprising.  It used to force images with a number specified for the dimensions
                 *but no units* to act as a measure of pixels, *if* you were printing at 72 DPI.
                 Uncomment if you really want it. -->
                    <xsl:choose>
                        <xsl:when test="not(string(number($height)) = 'NaN')">
                            <xsl:value-of select="concat($height div 92,'in')"/>
                        </xsl:when>
                        <xsl:when test="$height">
                            <xsl:value-of select="$height"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <!--Setting image width if defined-->
            <xsl:if test="$width">
                <xsl:attribute name="content-width">
                    <xsl:choose>
                        <xsl:when test="not(string(number($width)) = 'NaN')">
                            <xsl:value-of select="concat($width div 92,'in')"/>
                        </xsl:when>
                        <xsl:when test="$width">
                            <xsl:value-of select="$width"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="not($width) and not($height) and @scale">
                <xsl:attribute name="content-width">
                    <xsl:value-of select="concat(@scale,'%')"/>
                </xsl:attribute>
            </xsl:if>
        </fo:external-graphic>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/ol ')]">
        <fo:block xsl:use-attribute-sets="ol.block">
            <fo:list-block xsl:use-attribute-sets="ol">
                <xsl:call-template name="commonattributes"/>
                <xsl:apply-templates/>
            </fo:list-block>
        </fo:block>
    </xsl:template>
    
    <!-- PMC mod start -->
    
    <xsl:template match="*[contains(@class, ' topic/indexterm ')]" mode="#all"></xsl:template>
    
    <!-- prevent indexterms from showing up in xref -->
    <xsl:template match="*[contains(@class,' topic/indexterm ')]" mode="pmc_gettitle"/>
    
    <xsl:template match="*" mode="pmc_gettitle">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- PMC mod end -->
    
    <!-- The univAttrs template is remmed out to get around a bug with publishing diffed files. Might have to revisit this later -->
    <xsl:template name="univAttrs">
        <!-- <xsl:apply-templates select="@platform | @product | @audience | @otherprops | @importance | @rev | @status"/> -->
    </xsl:template>
    
    <!-- getTitle template override. See demo\fo\xsl\fo\commons.xsl -->
    <xsl:template name="getTitle">
        <!--
            get fully-processed title content by whatever mechanism
        -->
        <xsl:variable name="titleNumber">
            <!-- Add title numbers to topic titles ONLY-->
            <xsl:if test="parent::*[contains(@class,'topic/topic')]">
                <xsl:call-template name="getTitleNumber"/>
            </xsl:if>
        </xsl:variable>
        <xsl:choose>
            <!-- add keycol here once implemented-->
            <xsl:when test="@spectitle">
                <xsl:value-of select="@spectitle"/>
            </xsl:when>
            <!-- Suppress numbering of the glossary -->
            <xsl:when test="parent::*[contains(@class,'topic/topic')][@id = //*/glossarylist/@id]">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block provisional-distance-between-starts="20mm"
                    provisional-label-separation="5mm">
                    <fo:list-item>
                        <fo:list-item-label end-indent="label-end()" text-align="start">
                            <fo:block>
                                this is the titlenumber<xsl:value-of select="$titleNumber"/>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()" text-align="start">
                            <fo:block>
                                <xsl:apply-templates/>
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="getTOCTitle">
        <!--
            get fully-processed title content by whatever mechanism
        -->
        <xsl:variable name="titleNumber">
            <!-- Add title numbers to topic titles ONLY-->
            <xsl:if test="parent::*[contains(@class,'topic/topic')]">
                <xsl:call-template name="getTitleNumber"/>
            </xsl:if>
        </xsl:variable>
        <xsl:choose>
            <!-- add keycol here once implemented-->
            <xsl:when test="@spectitle">
                <xsl:value-of select="@spectitle"/>
            </xsl:when>
            <!-- Suppress numbering of the glossary -->
            <xsl:when test="parent::*[contains(@class,'topic/topic')][@id = //*/glossarylist/@id]">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-item-body start-indent="body-start()" text-align="start">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="getTOCTitleNumber">
        <xsl:if test="parent::*[contains(@class,'topic/topic')]">
            <xsl:call-template name="getTitleNumber"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:variable name="topicNumbers">
        <xsl:for-each
            select="//*[contains(@class, ' topic/topic ') and not(contains(@class, ' bkinfo/bkinfo ')) and not(contains(@outputclass, ' nonumbering '))]">
            <topic guid="{generate-id()}">
                <xsl:call-template name="commonattributes"/>
            </topic>
        </xsl:for-each>
    </xsl:variable>
    
    <xsl:template match="*[contains(@class,' topic/ph ')][@text_color]">
        <fo:inline>
            <xsl:attribute name="color" select="@text_color"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <!-- draft-comment templates end -->
    <xsl:template match="*[contains(@class,' struct-d/lsb ')]">
        <fo:inline xsl:use-attribute-sets="ph">
            <xsl:call-template name="commonattributes"/>
            <xsl:text>:</xsl:text>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
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
    
    <!-- The following template checks to see if the parameter passed to it can be called a number. If not, it assumes that it already has a unit value 
        (e.g. in, mm, cm, px) attached. If it does not, it appends px and returns the value. -->
    
    <xsl:template name="add-unit-type">
        <xsl:param name="input"/>
        <xsl:choose>
            <!-- If the value passed has anything other than numbers it should fail the first condition and fall through to the second -->
            <xsl:when test="number(normalize-space($input)) &gt; 0">
                <xsl:value-of select="number(normalize-space($input))"/>
                <xsl:text>px</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$input"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Strip enumvalues and headerfile-name elements from output -->
    
    <xsl:template
        match="*[contains(@class, ' struct-d/enumvalue ')] | *[contains(@class, ' struct-d/headerfile-name ')] "/>
    
    
</xsl:stylesheet>
<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:exsl="http://exslt.org/common"
    xmlns:opentopic-index="http://www.idiominc.com/opentopic/index"
    xmlns:exslf="http://exslt.org/functions"
    xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
    xmlns:dita2xslfo="http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
    extension-element-prefixes="exsl"
    exclude-result-prefixes="opentopic exsl opentopic-index exslf opentopic-func dita2xslfo xs"
    version="2.0">

    <xsl:param name="topicTitle.numLevel" select="5"/>

  <xsl:template match="*[contains(@class, ' topic/tbody ')]/*[contains(@class, ' m-software-d/field ')]/*[contains(@class, ' m-software-d/field-type ')]">
        <fo:table-cell xsl:use-attribute-sets="tbody.row.entry">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="rotate_entry"/>
            <xsl:call-template name="applySpansAttrs"/>
            <xsl:call-template name="applyAlignAttrs"/>
            <xsl:call-template name="generateTableEntryBorder"/>
            <xsl:call-template name="findBackgroundColor"/>
            <fo:block xsl:use-attribute-sets="tbody.row.entry__content">
                <xsl:call-template name="processEntryContent"/>
                <xsl:if test="@sticky = 'yes'"><fo:block xsl:use-attribute-sets="b">STICKY</fo:block></xsl:if>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/fig ')]">
        <fo:block xsl:use-attribute-sets="fig" keep-together.within-page="always">
            <xsl:apply-templates select="*[contains(@class,' topic/title ')]"/>
            <fo:block xsl:use-attribute-sets="fig" keep-together.within-page="always">
                <xsl:call-template name="commonattributes"/>
                <xsl:if test="not(@id)">
                    <xsl:attribute name="id">
                        <xsl:call-template name="get-id"/>
                    </xsl:attribute>
                </xsl:if>
            <xsl:apply-templates select="*[not(contains(@class,' topic/title '))]"/>
            </fo:block>
            </fo:block>
    </xsl:template>

    <!-- Watermark -->
    <xsl:param name="watermark">
        <xsl:choose>
            <xsl:when test="string-length(//pdf_watermark[1]/fig/image/@href) &gt; 1">
                <xsl:value-of select="//pdf_watermark[1]/fig/image/@href"/>
            </xsl:when>
            <xsl:otherwise>/SysConfig/boilerplate/graphics/watermark/watermark.svg</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:template match="@background-image" mode="layout-masters-processing">
        <xsl:attribute name="background-image">
            <xsl:value-of select="concat('url(xdapp://',$watermark,')')"/>
        </xsl:attribute>
    </xsl:template>

    <!-- Overridden to remove the graphic -->
    <xsl:template match="*[contains(@class,' topic/note ')]">
        <xsl:variable name="noteImagePath">
            <xsl:apply-templates select="." mode="setNoteImagePath"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not($noteImagePath = '')">
                <fo:table xsl:use-attribute-sets="note__table">
                    <fo:table-column xsl:use-attribute-sets="note__image__column"/>
                    <fo:table-column xsl:use-attribute-sets="note__text__column"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell xsl:use-attribute-sets="note__image__entry">
                                <fo:block>
                                    <!--<fo:external-graphic src="url('{concat($artworkPrefix, $noteImagePath)}')" xsl:use-attribute-sets="image"/>-->
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell xsl:use-attribute-sets="note__text__entry">
                                <xsl:apply-templates select="." mode="placeNoteContent"/>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="." mode="placeNoteContent"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="startPageNumbering">
        <!--BS: uncomment if you need reset page numbering at first chapter-->

        <xsl:variable name="id"
            select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id"/>
        <xsl:variable name="mapTopic" select="key('map-id', $id)"/>

        <xsl:if
            test="not(($mapTopic/preceding::*[contains(@class, ' bookmap/chapter ') or contains(@class, ' bookmap/part ')])
            or ($mapTopic/ancestor::*[contains(@class, ' bookmap/chapter ') or contains(@class, ' bookmap/part ')]))">
            <xsl:attribute name="initial-page-number">1</xsl:attribute>
        </xsl:if>

    </xsl:template>

    <xsl:template name="insertChapterFirstpageStaticContent">
        <xsl:param name="type"/>
        <fo:block>
            <xsl:attribute name="id">
                <xsl:call-template name="generate-toc-id"/>
            </xsl:attribute>
        </fo:block>
    </xsl:template>

    <!-- Topic/Chapter Numbering  -->

    <xsl:template match="*" mode="getTitle">
        <xsl:variable name="topic" select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]"/>
        <xsl:variable name="level" select="count(ancestor::*[contains(@class,' topic/topic ')])"/>       
        <xsl:variable name="id" select="$topic/@id"/>
        <xsl:variable name="mapTopics" select="key('map-id', $id)"/>
        <fo:list-block start-indent="-20mm" provisional-distance-between-starts="20mm"
            provisional-label-separation="5mm">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()" text-align="start">
                    <fo:block>
                        <xsl:if test="$level &lt; (number($topicTitle.numLevel) + number(1))">
                            <xsl:apply-templates select="$mapTopics[1]" mode="topicTitleNumber"/>
                        </xsl:if>
                    </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()" text-align="start">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="*" mode="getTitleTOC">
        <xsl:variable name="topic" select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]"/>
        <xsl:variable name="level" select="count(ancestor::*[contains(@class,' topic/topic ')])"/>       
        <xsl:variable name="id" select="$topic/@id"/>
        <xsl:variable name="mapTopics" select="key('map-id', $id)"/>
        <fo:inline>
            <xsl:if test="$level &lt; (number($topicTitle.numLevel) + number(1))">
                <xsl:apply-templates select="$mapTopics[1]" mode="topicTitleNumber"/>
            </xsl:if>           
        </fo:inline>
        <xsl:text>  </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template
        match="*[contains(@class, ' bookmap/chapter ')] | *[contains(@class, ' map/topicref ')][not(ancestor-or-self::*[contains(@class,' bookmap/frontmatter ')])]"
        mode="topicTitleNumber" priority="1">
        <xsl:number format="1"
            count="*[contains(@class, ' map/topicref ')]
            [not(ancestor-or-self::*[contains(@class,' bookmap/frontmatter ')])]
            | *[contains(@class, ' bookmap/chapter ')]"
            level="multiple"/>
    </xsl:template>

    <xsl:template
        match="*[contains(@class, ' map/topicref ')][not(ancestor-or-self::*[contains(@class,' bookmap/frontmatter ')])][ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]]"
        mode="topicTitleNumber" priority="2">
        <xsl:number format="A.1"
            count="*[contains(@class, ' map/topicref ')][not(ancestor-or-self::*[contains(@class,' bookmap/frontmatter ')])][ancestor-or-self::*[contains(@class, ' bookmap/appendix ')]]"
            level="multiple"/>
    </xsl:template>

    <xsl:template
        match="*[contains(@class, ' bookmap/chapter ')] | *[contains(@class, ' bookmap/bookmap ')]/opentopic:map/*[contains(@class, ' map/topicref ')]"
        mode="tocPrefix"/>

    <!-- Gets navigation title of current topic, used for bookmarks/TOC -->
    <xsl:template name="getNavTitle">
        <xsl:variable name="topicref" select="key('map-id', @id)[1]"/>    
        <xsl:choose>
            <xsl:when
                test="$topicref/@locktitle='yes' and $topicref/*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]">
                <xsl:apply-templates select="$topicref/*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/navtitle ')]/node()" />
            </xsl:when>
            <xsl:when test="$topicref/@locktitle='yes' and $topicref/@navtitle">
                <xsl:value-of select="$topicref/@navtitle"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="*[contains(@class,' topic/title ')]" mode="getTitleTOC"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    

    <!--  Bookmap Chapter processing  -->
    <xsl:template name="processTopicChapter">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:variable name="level" as="xs:integer">
                        <xsl:apply-templates select="." mode="get-topic-level"/>
                    </xsl:variable>
                    <xsl:if test="$level eq 1">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="1"/>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                                <xsl:apply-templates select="." mode="getTitleNoNum"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'chapter'"/>
                    </xsl:call-template>

                    <fo:block xsl:use-attribute-sets="topic.title">
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>

                    <!--<xsl:if test="$SHOWCOMMENTS = 'YES'">
                        <fo:table border-collapse="yes">
                            <fo:table-column column-width="1.85mm"/>
                            <fo:table-column column-width="15cm"/>
                            <fo:table-column column-width="1.85mm"/>
                            <fo:table-body border-collapse="yes">
                                
                                <fo:table-row background-color="#fbbabd" height="1.85mm" width="1.85mm">
                                    <fo:table-cell height="1.85mm" width="1.85mm">
                                        <fo:block/>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block padding="1mm" font-size="7pt"><xsl:text>Location: </xsl:text><xsl:variable name="path-to-file">
                                            <xsl:choose>
                                                <xsl:when test="string-length(@xtrf) &gt; 1"><xsl:value-of select="@xtrf"/></xsl:when>
                                                <xsl:otherwise>no path</xsl:otherwise>                                                
                                            </xsl:choose>
                                        </xsl:variable><xsl:variable name="xdocs-target">                                                
                                            <xsl:value-of select="concat('xdocs://Production', $path-to-file)"/>
                                        </xsl:variable><fo:basic-link xsl:use-attribute-sets="xref">
                                            <xsl:attribute name="external-destination">url('<xsl:value-of select="$xdocs-target"/>')</xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="string-length(@xtrf) &gt; 1"><xsl:value-of select="replace(@xtrf, '/', '​/')"/></xsl:when>
                                                <xsl:otherwise>no path</xsl:otherwise>                                                
                                            </xsl:choose>
                                        </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell height="1.85mm" width="1.85mm">
                                        <fo:block/>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                            </fo:table-body>      
                        </fo:table>
                    </xsl:if>-->

                    <xsl:choose>
                        <xsl:when test="$chapterLayout='BASIC'">
                            <xsl:apply-templates
                                select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                contains(@class, ' topic/prolog '))]"/>
                            <xsl:apply-templates select="." mode="buildRelationships"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>



    <!-- Topic Notices -->

    <xsl:template name="processTopicNotices">
        <fo:page-sequence master-reference="body-sequence" format="i"
            xsl:use-attribute-sets="__force__page__count">
            <!--<xsl:call-template name="startPageNumbering"/>-->
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:if test="not(ancestor::*[contains(@class, ' topic/topic ')])">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:number format="1"/>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                                <xsl:apply-templates select="." mode="getTitle"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'notices'"/>
                    </xsl:call-template>

                    <fo:block xsl:use-attribute-sets="topic.title">
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>

                    <xsl:choose>
                        <xsl:when test="$noticesLayout='BASIC'">
                            <xsl:apply-templates
                                select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                contains(@class, ' topic/prolog '))]"/>
                            <xsl:apply-templates select="." mode="buildRelationships"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <!-- template added to override numbering on section title -->

    <xsl:template match="*[contains(@class,' topic/section ')]/*[contains(@class,' topic/title ')]">
        <fo:block xsl:use-attribute-sets="section.title">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!--  Bookmap Appendix processing  -->
    <xsl:template name="processTopicAppendix">
        <fo:page-sequence master-reference="body-sequence"
            xsl:use-attribute-sets="__force__page__count">
            <xsl:call-template name="startPageNumbering"/>
            <xsl:call-template name="insertBodyStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block xsl:use-attribute-sets="topic">
                    <xsl:call-template name="commonattributes"/>
                    <xsl:variable name="level" as="xs:integer">
                        <xsl:apply-templates select="." mode="get-topic-level"/>
                    </xsl:variable>
                    <xsl:if test="$level eq 1">
                        <fo:marker marker-class-name="current-topic-number">
                            <xsl:variable name="topicref"
                                select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
                            <xsl:for-each select="$topicref">
                                <xsl:number count="*[contains(@class,' bookmap/appendix ')]"
                                    format="1"/>
                            </xsl:for-each>
                        </fo:marker>
                        <fo:marker marker-class-name="current-header">
                            <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                                <xsl:apply-templates select="." mode="getTitleNoNum"/>
                            </xsl:for-each>
                        </fo:marker>
                    </xsl:if>

                    <xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>

                    <xsl:call-template name="insertChapterFirstpageStaticContent">
                        <xsl:with-param name="type" select="'appendix'"/>
                    </xsl:call-template>

                    <fo:block xsl:use-attribute-sets="topic.title">
                        <xsl:call-template name="pullPrologIndexTerms"/>
                        <xsl:for-each select="child::*[contains(@class,' topic/title ')]">
                            <xsl:apply-templates select="." mode="getTitle"/>
                        </xsl:for-each>
                    </fo:block>

                    <!--<xsl:if test="$SHOWCOMMENTS = 'YES'">
                        <fo:table border-collapse="yes">
                            <fo:table-column column-width="1.85mm"/>
                            <fo:table-column column-width="15cm"/>
                            <fo:table-column column-width="1.85mm"/>
                            <fo:table-body border-collapse="yes">
                                
                                <fo:table-row background-color="#fbbabd" height="1.85mm" width="1.85mm">
                                    <fo:table-cell height="1.85mm" width="1.85mm">
                                        <fo:block/>
                                    </fo:table-cell>
                                    <fo:table-cell>
                                        <fo:block padding="1mm" font-size="7pt"><xsl:text>Location: </xsl:text><xsl:variable name="path-to-file">
                                            <xsl:choose>
                                                <xsl:when test="string-length(@xtrf) &gt; 1"><xsl:value-of select="@xtrf"/></xsl:when>
                                                <xsl:otherwise>no path</xsl:otherwise>                                                
                                            </xsl:choose>
                                        </xsl:variable><xsl:variable name="xdocs-target">                                                
                                            <xsl:value-of select="concat('xdocs://Production', $path-to-file)"/>
                                        </xsl:variable><fo:basic-link xsl:use-attribute-sets="xref">
                                            <xsl:attribute name="external-destination">url('<xsl:value-of select="$xdocs-target"/>')</xsl:attribute>
                                            <xsl:choose>
                                                <xsl:when test="string-length(@xtrf) &gt; 1"><xsl:value-of select="replace(@xtrf, '/', '​/')"/></xsl:when>
                                                <xsl:otherwise>no path</xsl:otherwise>                                                
                                            </xsl:choose>
                                        </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell height="1.85mm" width="1.85mm">
                                        <fo:block/>
                                    </fo:table-cell>
                                </fo:table-row>
                                
                            </fo:table-body>      
                        </fo:table>
                    </xsl:if>-->

                    <xsl:choose>
                        <xsl:when test="$appendixLayout='BASIC'">
                            <xsl:apply-templates
                                select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
                                contains(@class, ' topic/prolog '))]"/>
                            <xsl:apply-templates select="." mode="buildRelationships"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates select="." mode="createMiniToc"/>
                        </xsl:otherwise>
                    </xsl:choose>

                    <xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
                    <xsl:call-template name="pullPrologIndexTerms.end-range"/>
                </fo:block>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>

    <xsl:template match="*" mode="getTitleNoNum">
        <xsl:variable name="topic"
            select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]"/>
        <xsl:variable name="id" select="$topic/@id"/>
        <xsl:variable name="mapTopics" select="key('map-id', $id)"/>
        <fo:list-block start-indent="-20mm" provisional-distance-between-starts="20mm"
            provisional-label-separation="5mm">
            <fo:list-item>
                <fo:list-item-label end-indent="label-end()" text-align="start">
                    <fo:block> </fo:block>
                </fo:list-item-label>
                <fo:list-item-body start-indent="body-start()" text-align="start">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:list-item-body>
            </fo:list-item>
        </fo:list-block>
    </xsl:template>

</xsl:stylesheet>

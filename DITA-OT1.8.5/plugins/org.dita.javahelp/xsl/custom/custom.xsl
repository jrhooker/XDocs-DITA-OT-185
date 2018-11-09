<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:param name="text-encoding" as="xs:string" select="'iso-8859-1'"/>
    <xsl:param name="DITATEMPDIR"/>
    <xsl:param name="CSSPATH"/>
    <xsl:param name="CSS"/>
    <xsl:param name="DITATEMPDIR2" select="translate($DITATEMPDIR, '\', '/')"/>
    <xsl:param name="text-uri" as="xs:string"
        select="concat('file:///', $DITATEMPDIR2, '/fullditatopic.list')"/>

    <!-- paragraphs -->

    <xsl:template match="*[contains(@class, ' topic/ph ')]" name="topic.ph">
        <xsl:choose>
            <xsl:when test="@keyref">
                <xsl:apply-templates select="." mode="turning-to-link">
                    <xsl:with-param name="keys" select="@keyref"/>
                    <xsl:with-param name="type" select="'ph'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setidaname"/>
                    <xsl:if test="@text_color">
                        <xsl:attribute name="style">color:<xsl:value-of select="@text_color"
                            />;</xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="add-br-for-empty-cmd"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/p ')][@otherprops = 'figure-list']">
        <xsl:choose>
            <xsl:when test="@keyref">
                <xsl:apply-templates select="." mode="turning-to-link">
                    <xsl:with-param name="keys" select="@keyref"/>
                    <xsl:with-param name="type" select="'ph'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setidaname"/>
                    <xsl:choose>
                        <xsl:when test="unparsed-text-available($text-uri, $text-encoding)">
                            <xsl:call-template name="text2xml">
                                <xsl:with-param name="format">figure</xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="error">
                                <xsl:text>Error reading "</xsl:text>
                                <xsl:value-of select="$text-uri"/>
                                <xsl:text>" (encoding "</xsl:text>
                                <xsl:value-of select="$text-encoding"/>
                                <xsl:text>").</xsl:text>
                            </xsl:variable>
                            <xsl:message>
                                <xsl:value-of select="$error"/>
                            </xsl:message>
                            <xsl:value-of select="$error"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="add-br-for-empty-cmd"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/p ')][@otherprops = 'table-list']">
        <xsl:choose>
            <xsl:when test="@keyref">
                <xsl:apply-templates select="." mode="turning-to-link">
                    <xsl:with-param name="keys" select="@keyref"/>
                    <xsl:with-param name="type" select="'ph'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setidaname"/>
                    <xsl:choose>
                        <xsl:when test="unparsed-text-available($text-uri, $text-encoding)">
                            <xsl:call-template name="text2xml">
                                <xsl:with-param name="format">table</xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="error">
                                <xsl:text>Error reading "</xsl:text>
                                <xsl:value-of select="$text-uri"/>
                                <xsl:text>" (encoding "</xsl:text>
                                <xsl:value-of select="$text-encoding"/>
                                <xsl:text>").</xsl:text>
                            </xsl:variable>
                            <xsl:message>
                                <xsl:value-of select="$error"/>
                            </xsl:message>
                            <xsl:value-of select="$error"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="add-br-for-empty-cmd"/>
    </xsl:template>




    <xsl:template name="text2xml">
        <xsl:param name="format"/>
        <xsl:variable name="text" select="unparsed-text($text-uri, $text-encoding)"/>
        <xsl:analyze-string select="$text" regex="(.*)\n">
            <xsl:matching-substring>
                <xsl:choose>
                    <xsl:when test="$format = 'table'">
                        <xsl:call-template name="process-tables-from-topics">
                            <xsl:with-param name="topic">
                                <xsl:value-of select="normalize-space(regex-group(1))"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$format = 'figure'">
                        <xsl:call-template name="process-figures-from-topics">
                            <xsl:with-param name="topic">
                                <xsl:value-of select="normalize-space(regex-group(1))"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>


    <xsl:template name="process-figures-from-topics">
        <xsl:param name="topic"/>
        <xsl:variable name="content"
            select="document(concat('file:///', $DITATEMPDIR2, '/', $topic))"/>
        <xsl:for-each select="$content//*[contains(@class, ' topic/fig ')]">
            <p>
                <xsl:value-of
                    select="ancestor::*[contains(@class, ' topic/topic ' )]/*[contains(@class, ' topic/title ' )]"/>
                <xsl:text>: </xsl:text>
                <xsl:element name="a">                   
                    <xsl:choose>
                        <xsl:when test="contains($topic, '.xml')">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(substring-before($topic, '.xml'), '.html')"
                                />#<xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/topic ' )]/@id"
                                />__<xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="contains($topic, '.dita')">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(substring-before($topic, '.dita'), '.html')"
                                />#<xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/topic ' )]/@id"
                                />__<xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:when>
                    </xsl:choose>                  
                    <xsl:value-of select="*[contains(@class, ' topic/title ' )]"/>
                </xsl:element>
            </p>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="process-tables-from-topics">
        <xsl:param name="topic"/>
        <xsl:variable name="content"
            select="document(concat('file:///', $DITATEMPDIR2, '/', $topic))"/>
        <xsl:for-each
            select="$content//*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]]">
            <p>
                <xsl:value-of
                    select="ancestor::*[contains(@class, ' topic/topic ' )]/*[contains(@class, ' topic/title ' )]"/>
                <xsl:text>: </xsl:text>
                <xsl:element name="a">
                    <xsl:choose>
                        <xsl:when test="contains($topic, '.xml')">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(substring-before($topic, '.xml'), '.html')"
                                />#<xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/topic ' )]/@id"
                                />__<xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="contains($topic, '.dita')">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(substring-before($topic, '.dita'), '.html')"
                                />#<xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/topic ' )]/@id"
                                />__<xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:when>
                    </xsl:choose>            
                    <xsl:value-of select="*[contains(@class, ' topic/title ' )]"/>
                </xsl:element>
            </p>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>

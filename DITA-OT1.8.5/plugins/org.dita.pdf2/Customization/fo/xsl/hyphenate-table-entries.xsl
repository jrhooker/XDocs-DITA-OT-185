<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <!-- The following hack ensures that table entries that cannot be hyphenated conventionally will nevertheless break across lines rather than just condensing into a single black streak in the table -->
    
    <!-- This template is divided into two stages so that we can treat camelcase or full caps variables differently than we treat underscore or special character cases -->
    
    <xsl:template name="hyphenate-tableentries">
        <xsl:param name="entry" select="''"/>
        <xsl:choose>
            <xsl:when test="$tableentry.hyphenate = ''">
                <xsl:value-of select="$entry"/>
            </xsl:when>
            <xsl:when test="string-length($entry) &gt; 1">
                <xsl:variable name="char" select="substring($entry, 1, 1)"/>
                <xsl:value-of select="$char"/>
                <xsl:if test="contains($tableentry.hyphenate.chars, $char)">
                    <!-- Do not hyphen in-between // -->
                    <xsl:if test="not($char = '/' and substring($entry,2,1) = '/')">
                        <xsl:copy-of select="$tableentry.hyphenate"/>
                    </xsl:if>
                </xsl:if>
                <!-- recurse to the next character -->
                <xsl:call-template name="hyphenate-tableentries">
                    <xsl:with-param name="entry" select="substring($entry, 2)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$entry"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:param name="tableentry.hyphenate.chars">,_.-/&amp;;:0123456789~`@#$%^*-</xsl:param>
    <xsl:param name="tableentry.hyphenate">​</xsl:param>
    
    <xsl:template name="hyphenate-tableentriesCAPS">
        <xsl:param name="entry" select="''"/>
        <xsl:choose>
            <xsl:when test="$tableentry.hyphenateCAPS = ''">
                <xsl:value-of select="$entry"/>
            </xsl:when>
            <xsl:when test="string-length($entry) &gt; 1">
                <xsl:variable name="char" select="substring($entry, 1, 1)"/>
                <xsl:value-of select="$char"/>
                <xsl:if test="contains($tableentry.hyphenate.charsCAPS, $char)">
                    <!-- Do not hyphen in-between // -->
                    <xsl:if test="not($char = '/' and substring($entry,2,1) = '/')">
                        <xsl:copy-of select="$tableentry.hyphenateCAPS"/>
                    </xsl:if>
                </xsl:if>
                <!-- recurse to the next character -->
                <xsl:call-template name="hyphenate-tableentriesCAPS">
                    <xsl:with-param name="entry" select="substring($entry, 2)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$entry"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:param name="tableentry.hyphenate.charsCAPS">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:param>
    <xsl:param name="tableentry.hyphenateCAPS">&#173;​</xsl:param>
       
    <xsl:template match="*[contains(@class, ' topic/entry ')]//text() | *[contains(@class, ' topic/stentry ')]//text()">
        <xsl:variable name="stage1">
            <xsl:call-template name="hyphenate-tableentries">
                <xsl:with-param name="entry" select="."/>
            </xsl:call-template>
        </xsl:variable>
      
        <xsl:call-template name="hyphenate-tableentriesCAPS">
            <xsl:with-param name="entry" select="$stage1"/>
        </xsl:call-template>
      
    </xsl:template>
</xsl:stylesheet>
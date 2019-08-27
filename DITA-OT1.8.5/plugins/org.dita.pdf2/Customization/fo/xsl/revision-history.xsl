<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:opentopic="http://www.idiominc.com/opentopic" extension-element-prefixes="fn"
    exclude-result-prefixes="opentopic" version="2.0">

    <xsl:template
        match="*[contains(@class, ' topic/table ')][descendant::*[contains(@class, ' pmcrevhis-d/pmc-revhistory ')]]">
        <xsl:variable name="revisions"
            select="descendant::*[contains(@class, ' pmcrevhis-d/pmc-revision ')][not(@role = 'internal')][not(@otherprops = 'internal')]"/>
        <fo:block>
            <xsl:for-each select="$revisions">
                <xsl:sort select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"
                    order="descending"/>
                <fo:block keep-with-next="always" xsl:use-attribute-sets="revision.title">Revision
                        <xsl:value-of select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"
                    /></fo:block>
                <xsl:choose>
                    <xsl:when
                        test="string-length(*[contains(@class, ' pmcrevhis-d/pmc-description ')]) &gt; 0">
                        <xsl:apply-templates
                            select="*[contains(@class, ' pmcrevhis-d/pmc-description ')]/*"
                            mode="revisionhistory-strip-internal"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block keep-with-next="always" xsl:use-attribute-sets="p">Revision
                                <xsl:value-of
                                select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"/> was
                            published in <xsl:value-of
                                select="*[contains(@class, ' pmcrevhis-d/pmc-date ')]"/>. The
                            following is a summary of the changes in revision <xsl:value-of
                                select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"/> of
                            this document.</fo:block>
                    </xsl:otherwise>
                </xsl:choose>


            </xsl:for-each>
        </fo:block>
    </xsl:template>


</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template
        match="*[contains(@class, ' topic/table ')][descendant::*[contains(@class, ' pmcrevhis-d/pmc-revhistory ')]]">
        <xsl:variable name="revisions"
            select="descendant::*[contains(@class, ' pmcrevhis-d/pmc-revision ')][not(@role='internal')][not(@otherprops='internal')]"/>
        <div class="revision-history">     
            <xsl:for-each select="$revisions">
                <xsl:sort select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"
                    order="descending"/>
                <h3 class="revision-title">Revision <xsl:value-of
                    select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"/></h3>
                <div class="revision-intro">Revision <xsl:value-of
                    select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"/> was published
                    in <xsl:value-of select="*[contains(@class, ' pmcrevhis-d/pmc-date ')]"/>. The
                    following is a summary of the changes in revision <xsl:value-of
                        select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"/> of this
                    document.</div>
                <xsl:apply-templates select="*[contains(@class, ' pmcrevhis-d/pmc-description ')]/*" mode="revisionhistory-strip-internal" />
            </xsl:for-each>           
        </div>
    </xsl:template>
    
    <!-- The following sections should strip any parts of the revision history that are designated "internal" -->
    
    <xsl:template match="pmc_revdescription" mode="revisionhistory-strip-internal">
        <xsl:choose>
            <xsl:when test="@role='internal' or @otherprops='internal'"/>
            <xsl:when
                test="descendant::node()/@role='internal' or descendant::node()/@otherprops='internal'">
                <xsl:apply-templates mode="revisionhistory-strip-internal"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="ul" mode="revisionhistory-strip-internal">
        <xsl:choose>
            <xsl:when test="@role='internal' or @otherprops='internal'"/>
            <xsl:when
                test="descendant::node()/@role='internal' or descendant::node()/@otherprops='internal'">
                <ul>
                    <xsl:apply-templates mode="revisionhistory-strip-internal"/>
                </ul>
            </xsl:when>
            <xsl:otherwise>
                <ul>
                    <xsl:apply-templates/>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="li" mode="revisionhistory-strip-internal">
        <xsl:choose>
            <xsl:when test="@role='internal' or @otherprops='internal'"/>
            <xsl:when
                test="descendant::node()/@role='internal' or descendant::node()/@otherprops='internal'">
                <li>
                    <xsl:apply-templates mode="revisionhistory-strip-internal"/>                        
                </li>
            </xsl:when>
            <xsl:otherwise>
                <li>
                    <xsl:apply-templates mode="revisionhistory-strip-internal"/>
                </li>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="p" mode="revisionhistory-strip-internal">
        <xsl:choose>
            <xsl:when test="@otherprops='internal' or @role='internal'"/>
            <xsl:otherwise>
                <p class="p">
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
</xsl:stylesheet>
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:param name="filtervalue.options">audience,media,product,pmc_package,pmc_phy,pmc_switch,ddr-width,component,pcie-drive-ports,pcie-host-ports,raid-support,sas-ports</xsl:param>
    
    <!-- concat all the filter values on a PMC-ISO element to create an ID -->
    
    <xsl:template name="concatfilters">
        <xsl:param name="currentcount" select="1"/>
        <xsl:param name="combinedfilter"/>
        <xsl:variable name="pmc_iso" select="//pmc_iso"></xsl:variable>
        <xsl:variable name="count" select="count($pmc_iso[1]/@*)"/>
        <xsl:choose>
            <xsl:when test="$currentcount &lt;= $count and ($pmc_iso[1]/@*[number($currentcount)]/name() = tokenize($filtervalue.options, ','))">
                <xsl:call-template name="concatfilters">
                    <xsl:with-param name="currentcount"><xsl:value-of select="$currentcount + 1"/></xsl:with-param>
                    <xsl:with-param name="combinedfilter"><xsl:value-of select="concat($combinedfilter, '__', $pmc_iso[1]/@*[number($currentcount)])"/></xsl:with-param>
                </xsl:call-template>            
            </xsl:when>
            <xsl:when test="$currentcount &lt;= $count and not($pmc_iso[1]/@*[number($currentcount)]/name() = tokenize($filtervalue.options, ','))">
                <xsl:call-template name="concatfilters">
                    <xsl:with-param name="currentcount"><xsl:value-of select="$currentcount + 1"/></xsl:with-param>
                    <xsl:with-param name="combinedfilter"><xsl:value-of select="$combinedfilter"/></xsl:with-param>
                </xsl:call-template>            
            </xsl:when>
            <xsl:otherwise>               
                <xsl:value-of select="$combinedfilter"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template> 
  

    
</xsl:stylesheet>
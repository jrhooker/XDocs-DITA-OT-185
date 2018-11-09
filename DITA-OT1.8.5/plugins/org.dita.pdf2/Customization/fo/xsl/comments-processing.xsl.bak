<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    exclude-result-prefixes="xs"
    version="2.0">   
    
    <xsl:param name="SHOWCOMMENTS">NO</xsl:param>
    <xsl:param name="SHOWCOMMENTS-NUM" select="0"/>
    
    <xsl:param name="TEST" select="1"/>
    
    <xsl:template match="*[contains(@class,' topic/draft-comment ')]">
        
        <xsl:variable name="draft-comment-bgcolor">
            <xsl:choose>
                <xsl:when test="contains(@outputclass, 'JIRA')">#CAFFCB</xsl:when>
                <xsl:when test="contains(@outputclass, 'PMCREQDB')">#FEF7B6</xsl:when>
                <xsl:when test="contains(@outputclass, 'CADPREP')">#CACAFF</xsl:when>
                <xsl:when test="contains(@outputclass, 'PREP')">#CACAFF</xsl:when>
                <xsl:otherwise>#fbbabd</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:if test="$SHOWCOMMENTS-NUM = 1">
            <fo:table border-collapse="collapse">
                <fo:table-body border-collapse="collapse">
                    <fo:table-row background-color="#fbbabd" height="1.85mm" width="1.85mm">
                        <xsl:attribute name="background-color" select="$draft-comment-bgcolor"/>
                        <fo:table-cell height="1.85mm" width="1.85mm">
                            <fo:block/>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block padding="1mm">
                                <xsl:attribute name="id">
                                    <xsl:choose>
                                        <xsl:when test="@id">
                                            <xsl:value-of select="@id"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="generate-id()"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <fo:block font-weight="bold">Author: <xsl:value-of select="@author"
                                /> / Time: <xsl:value-of select="@time"/>
                                </fo:block>
                                <fo:block>
                                    <xsl:apply-templates mode="process-comment-content"/>
                                </fo:block>
                                <xsl:if test="string-length(@outputclass) &gt; 0">
                                    <fo:block>
                                        <xsl:apply-templates mode="process-pmc-comments"/>
                                        <!-- find the templates for this mode in the front-matter_1.0.xsl file -->
                                    </fo:block>
                                </xsl:if>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell height="1.85mm" width="1.85mm">
                            <fo:block/>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </xsl:if>
    </xsl:template>
    
    <!-- templates for processing the content of draft-comments. The index entries which appear in the authored XML for some of these comments are flipped into Terms in the at the merge topics stage -->
    
    <!-- The actual content of the comments is handled by the process-pmc-comments mode -->
    <xsl:template match="text()[parent::pmc-requirement]" mode="process-comment-content"> </xsl:template>
    
    <xsl:template match="*" mode="process-comment-content">
        <xsl:choose>
            <xsl:when test="$SHOWCOMMENTS-NUM = 1">
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="pmc-indexterm" mode="process-comment-content">
        <xsl:choose>
            <xsl:when test="$SHOWCOMMENTS-NUM = 1">
                <fo:block>
                    <xsl:text> / </xsl:text>
                    <xsl:apply-templates mode="process-comment-content"/>
                </fo:block>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="term | keyword | indexterm" mode="process-comment-content">
        <xsl:choose>
            <xsl:when test="$SHOWCOMMENTS-NUM = 1">
                <xsl:text> / </xsl:text>
                <xsl:apply-templates mode="process-comment-content"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="term/term/term[ancestor::pmc-requirement]" mode="process-comment-content">
        <xsl:choose>
            <xsl:when test="$SHOWCOMMENTS-NUM = 1">
                <xsl:choose>
                    <xsl:when test="contains(., 'JIRA-') or contains(., 'PMCREQDB-')">
                        <xsl:variable name="TARGET">
                            <xsl:choose>
                                <xsl:when test="contains(., 'JIRA-')">
                                    <xsl:text>https://jira-agile.pmcs.com:8443/browse/</xsl:text>
                                    <xsl:value-of select="substring-after(., 'JIRA-')"/>
                                </xsl:when>
                                <xsl:when test="contains(., 'PMCREQDB-')">
                                    <xsl:text>http://layton/reqmgr2/view.php?xid=</xsl:text>
                                    <xsl:value-of select="substring-after(., 'PMCREQDB-')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="LABEL">
                            <xsl:choose>
                                <xsl:when test="contains(., 'JIRA-')">
                                    <xsl:value-of select="substring-after(., 'JIRA-')"/>
                                </xsl:when>
                                <xsl:when test="contains(., 'PMCREQDB-')">
                                    <xsl:value-of select="substring-after(., 'PMCREQDB-')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:text> / </xsl:text>
                        <fo:basic-link external-destination="url('{$TARGET}')" color="blue"
                            text-decoration="none">
                            <xsl:value-of select="$LABEL"/>
                        </fo:basic-link>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> / </xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="pmc-indexterm/indexterm/indexterm[ancestor::pmc-requirement]"
        mode="process-comment-content">
        <xsl:choose>
            <xsl:when test="$SHOWCOMMENTS-NUM = 1">
                <xsl:choose>
                    <xsl:when test="contains(., 'JIRA-') or contains(., 'PMCREQDB-')">
                        <xsl:variable name="TARGET">
                            <xsl:choose>
                                <xsl:when test="contains(., 'JIRA-')">
                                    <xsl:text>https://jira-agile.pmcs.com:8443/browse/</xsl:text>
                                    <xsl:value-of select="substring-after(., 'JIRA-')"/>
                                </xsl:when>
                                <xsl:when test="contains(., 'PMCREQDB-')">
                                    <xsl:text>http://layton/reqmgr2/view.php?xid=</xsl:text>
                                    <xsl:value-of select="substring-after(., 'PMCREQDB-')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="LABEL">
                            <xsl:choose>
                                <xsl:when test="contains(., 'JIRA-')">
                                    <xsl:value-of select="substring-after(., 'JIRA-')"/>
                                </xsl:when>
                                <xsl:when test="contains(., 'PMCREQDB-')">
                                    <xsl:value-of select="substring-after(., 'PMCREQDB-')"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="."/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:text> / </xsl:text>
                        <fo:basic-link external-destination="url('{$TARGET}')" color="blue"
                            text-decoration="none">
                            <xsl:value-of select="$LABEL"/>
                        </fo:basic-link>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text> / </xsl:text>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
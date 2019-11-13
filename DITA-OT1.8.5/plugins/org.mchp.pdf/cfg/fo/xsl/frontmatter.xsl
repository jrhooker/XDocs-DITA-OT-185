<?xml version="1.0" encoding="UTF-8"?><!--
Copyright © 2004-2006 by Idiom Technologies, Inc. All rights reserved.
IDIOM is a registered trademark of Idiom Technologies, Inc. and WORLDSERVER
and WORLDSTART are trademarks of Idiom Technologies, Inc. All other
trademarks are the property of their respective owners.

IDIOM TECHNOLOGIES, INC. IS DELIVERING THE SOFTWARE "AS IS," WITH
ABSOLUTELY NO WARRANTIES WHATSOEVER, WHETHER EXPRESS OR IMPLIED,  AND IDIOM
TECHNOLOGIES, INC. DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE AND WARRANTY OF NON-INFRINGEMENT. IDIOM TECHNOLOGIES, INC. SHALL NOT
BE LIABLE FOR INDIRECT, INCIDENTAL, SPECIAL, COVER, PUNITIVE, EXEMPLARY,
RELIANCE, OR CONSEQUENTIAL DAMAGES (INCLUDING BUT NOT LIMITED TO LOSS OF
ANTICIPATED PROFIT), ARISING FROM ANY CAUSE UNDER OR RELATED TO  OR ARISING
OUT OF THE USE OF OR INABILITY TO USE THE SOFTWARE, EVEN IF IDIOM
TECHNOLOGIES, INC. HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.

Idiom Technologies, Inc. and its licensors shall not be liable for any
damages suffered by any person as a result of using and/or modifying the
Software or its derivatives. In no event shall Idiom Technologies, Inc.'s
liability for any damages hereunder exceed the amounts received by Idiom
Technologies, Inc. as a result of this transaction.

These terms and conditions supersede the terms and conditions in any
licensing agreement to the extent that such terms and conditions conflict
with those set forth herein.

This file is part of the DITA Open Toolkit project hosted on Sourceforge.net. 
See the accompanying license.txt file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:opentopic="http://www.idiominc.com/opentopic" extension-element-prefixes="fn"
    exclude-result-prefixes="opentopic" version="2.0">

    <xsl:param name="SHOWCOMMENTS">NO</xsl:param>
    <xsl:param name="SHOWCOMMENTS-NUM" select="0"/>
    <xsl:param name="FRONTMATTER">1</xsl:param>

    <!--          
                    <xsl:call-template name="createPMCFrontMatter"></xsl:call-template>
                    <xsl:call-template name="createCoverPage"/>
                    <xsl:call-template name="createLegal"/>
                    <xsl:call-template name="createRevisionHistory"/>
                 -->

    <xsl:template name="createFrontMatter_1.0">
        <xsl:if test="number($FRONTMATTER) = 1">
            <fo:page-sequence master-reference="front-matter" format="i"
                xsl:use-attribute-sets="page-sequence.frontmatter">
                <xsl:call-template name="insertFrontMatterStaticContents"/>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block-container xsl:use-attribute-sets="__frontmatter">
                        <xsl:call-template name="createPMCFrontMatter"/>
                        <fo:block/>
                    </fo:block-container>
                    <fo:block-container xsl:use-attribute-sets="__frontmatter">
                        <xsl:call-template name="createDetailedRevisionHistory"/>
                        <fo:block/>
                    </fo:block-container>
                </fo:flow>
            </fo:page-sequence>
        </xsl:if>
        <fo:page-sequence master-reference="coverpage" format="i" initial-page-number="1"
            xsl:use-attribute-sets="page-sequence.cover">
            <xsl:call-template name="insertCoverStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block-container xsl:use-attribute-sets="__coverpage">
                    <xsl:call-template name="createCoverPage"/>
                </fo:block-container>
            </fo:flow>
        </fo:page-sequence>
        <!--<fo:page-sequence master-reference="legal" format="i" xsl:use-attribute-sets="page-sequence.legal">
            <xsl:call-template name="insertLegalStaticContents"/>
            <fo:flow flow-name="xsl-region-body">
                <fo:block-container>
                    <xsl:call-template name="createLegal"/>
                </fo:block-container>
            </fo:flow>
        </fo:page-sequence>  -->
        <!-- JRH: will have to put process in place here for handling of legacy revision history -->
        <xsl:if
            test="not(//*[contains(@class, ' topic/topic ')]//*[contains(@class, ' pmcrevhist-d/asdfasfd ')])">
            <fo:page-sequence master-reference="body-sequence" format="i"
                xsl:use-attribute-sets="page-sequence.body">
                <xsl:call-template name="insertBodyStaticContents"/>
                <fo:flow flow-name="xsl-region-body">
                    <fo:block-container>
                        <fo:block>
                            <xsl:call-template name="createRevisionHistory"/>
                        </fo:block>
                    </fo:block-container>
                </fo:flow>
            </fo:page-sequence>
        </xsl:if>
    </xsl:template>


    <!-- PMC legal data -->
    <xsl:include href="pmc-legal-front-matter.xsl"/>


    <xsl:variable name="pmc_iso" select="//bookmeta/pmc_iso"/>


    <xsl:template name="createPMCFrontMatter">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="1cm">
            <fo:table border-before-width.conditionality="retain" border-collapse="collapse"
                border-left-style="none" border-right-style="none" border-top-style="none"
                border-bottom-style="none" table-layout="fixed" width="100%">
                <fo:table-column column-number="1" column-width="20%"/>
                <fo:table-column column-number="2" column-width="40%"/>
                <fo:table-column column-number="3" column-width="20%"/>
                <fo:table-column column-number="4" column-width="20%"/>
                <fo:table-body end-indent="0pt" start-indent="0pt">
                    <fo:table-row>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt" border-right-width="0pt" border-right-style="solid"
                            border-right-color="black">
                            <fo:block text-align="left" font-weight="bold"
                                font-family="{$body.font.family}" font-size="10pt">Title:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt" number-columns-spanned="3">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt">
                                <xsl:value-of select="$pmc_iso[1]/pmc_title"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt" border-right-width="0pt" border-right-style="solid"
                            border-right-color="black">
                            <fo:block text-align="left" font-weight="bold"
                                font-family="{$body.font.family}" font-size="10pt"
                                >Abstract:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt" number-columns-spanned="3">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt">
                                <xsl:apply-templates select="$pmc_iso[1]/pmc_abstract"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt" border-right-width="0pt" border-right-style="solid"
                            border-right-color="black">
                            <fo:block text-align="left" font-weight="bold"
                                font-family="{$body.font.family}" font-size="10pt">Marketing
                                No.:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt">
                                <xsl:value-of select="$pmc_iso[1]/pmc_productnumber"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt">
                            <fo:block text-align="left" font-weight="bold"
                                font-family="{$body.font.family}" font-size="10pt">Revision
                                Date:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt">
                                <xsl:choose>
                                    <xsl:when test="$pmc_iso[1]/pmc_issue_date[1]">
                                        <xsl:value-of select="$pmc_iso[1]/pmc_issue_date[1]"/>
                                    </xsl:when>
                                    <xsl:otherwise>No pmc_issue_date defined.</xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt" border-right-width="0pt" border-right-style="solid"
                            border-right-color="black">
                            <fo:block text-align="left" font-weight="bold"
                                font-family="{$body.font.family}" font-size="10pt">Document
                                No.:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt">
                                <xsl:value-of select="$pmc_iso[1]/pmc_document_id[1]"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt"> </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt"> </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt" border-right-width="0pt" border-right-style="solid"
                            border-right-color="black"> </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt"> </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt"> </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt"> </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt" border-right-width="0pt" border-right-style="solid"
                            border-right-color="black"> </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt"> </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt"> </fo:table-cell>
                        <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                            padding-bottom="2pt">
                            <fo:block text-align="left" font-family="{$body.font.family}"
                                font-size="10pt"> </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template name="createDetailedRevisionHistory">
        <xsl:choose>
            <xsl:when test="//pmc-revhistory[ancestor::topic]/pmc-revision">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="2pc">
                    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                        font-size="12pt" hyphenate="false" space-after.minimum="0.4em"
                        space-after.optimum="0.6em" space-after.maximum="0.8em"
                        keep-with-next.within-column="always" text-align="left"
                        font-family="{$body.font.family}">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID"
                                select="'PMCDetailedRevisionHistory'"/>
                        </xsl:call-template>
                    </fo:block>
                    <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                        border-before-width.conditionality="retain" border-collapse="collapse"
                        border-left-style="solid" border-right-style="solid"
                        border-top-style="solid" border-bottom-style="solid"
                        border-left-width="0.5pt" border-right-width="0.5pt"
                        border-top-width="0.5pt" border-bottom-width="0.5pt"
                        border-left-color="{$table.rule.color}"
                        border-right-color="{$table.rule.color}"
                        border-top-color="{$table.rule.color}"
                        border-bottom-color="{$table.rule.color}" table-layout="fixed">
                        <fo:table-column column-number="1" column-width="1cm"/>
                        <fo:table-column column-number="2" column-width="1.5cm"/>
                        <fo:table-column column-number="3" column-width="1.5cm"/>
                        <fo:table-column column-number="4" column-width="13cm"/>
                        <fo:table-header end-indent="0pt" start-indent="0pt">
                            <fo:table-row keep-with-next.within-column="always"
                                background-color="#eeeeee">
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCIssueNumber'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCIssueDate'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCPreparedBy'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCDetailsOfChange'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body end-indent="0pt" start-indent="0pt">
                            <xsl:for-each select="//pmc-revhistory[ancestor::topic]/pmc-revision">
                                <fo:table-row>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}" text-align="left">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:value-of
                                                select="*[contains(@class, ' pmcrevhis-d/pmc-rev-number ')]"
                                            />
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:value-of
                                                select="*[contains(@class, ' pmcrevhis-d/pmc-date ')]"
                                            />
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:value-of
                                                select="*[contains(@class, ' pmcrevhis-d/pmc-name ')]"
                                            />
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}" text-align="left"
                                        font-size="{$body.font.size.small}">
                                        <xsl:apply-templates
                                            select="*[contains(@class, ' pmcrevhis-d/pmc-description ')]/*"/>

                                        <fo:block font-family="{$body.font.family}" font-size="1pt"
                                        />
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </xsl:when>
            <xsl:when test="$pmc_iso[1]/pmc_revhistory/pmc_revision">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="2pc">
                    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                        font-size="12pt" hyphenate="false" space-after.minimum="0.4em"
                        space-after.optimum="0.6em" space-after.maximum="0.8em"
                        keep-with-next.within-column="always" text-align="left"
                        font-family="{$body.font.family}">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID"
                                select="'PMCDetailedRevisionHistory'"/>
                        </xsl:call-template>
                    </fo:block>
                    <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                        border-before-width.conditionality="retain" border-collapse="collapse"
                        border-left-style="solid" border-right-style="solid"
                        border-top-style="solid" border-bottom-style="solid"
                        border-left-width="0.5pt" border-right-width="0.5pt"
                        border-top-width="0.5pt" border-bottom-width="0.5pt"
                        border-left-color="{$table.rule.color}"
                        border-right-color="{$table.rule.color}"
                        border-top-color="{$table.rule.color}"
                        border-bottom-color="{$table.rule.color}" table-layout="fixed">
                        <fo:table-column column-number="1" column-width="1cm"/>
                        <fo:table-column column-number="2" column-width="1.5cm"/>
                        <fo:table-column column-number="3" column-width="1.5cm"/>
                        <fo:table-column column-number="4" column-width="13cm"/>
                        <fo:table-header end-indent="0pt" start-indent="0pt">
                            <fo:table-row keep-with-next.within-column="always"
                                background-color="#eeeeee">
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCIssueNumber'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCIssueDate'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCPreparedBy'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCDetailsOfChange'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body end-indent="0pt" start-indent="0pt">
                            <xsl:choose>
                                <xsl:when test="$pmc_iso[1]/pmc_revhistory/pmc_revision">
                                    <xsl:for-each select="$pmc_iso[1]/pmc_revhistory/pmc_revision">
                                        <fo:table-row>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}"
                                                text-align="left">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="revnumber | pmc_rev_number"
                                                  />
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="date | pmc_date"/>

                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="pmc_name"/>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}"
                                                text-align="left"
                                                font-size="{$body.font.size.small}">
                                                <xsl:apply-templates select="pmc_revdescription"/>
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="1pt"/>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:table-row>
                                        <fo:table-cell padding-left="2pt" padding-right="2pt"
                                            padding-top="2pt" padding-bottom="2pt"
                                            border-bottom-width="0.5pt" border-bottom-style="solid"
                                            border-bottom-color="black" border-right-width="0.5pt"
                                            border-right-style="{$table.rule.color}"
                                            border-right-color="{$table.rule.color}"
                                            text-align="left">
                                            <fo:block font-family="{$body.font.family}"
                                                font-size="{$body.font.size.small}"/>
                                        </fo:table-cell>
                                        <fo:table-cell padding-left="2pt" padding-right="2pt"
                                            padding-top="2pt" padding-bottom="2pt"
                                            border-bottom-width="0.5pt" border-bottom-style="solid"
                                            border-bottom-color="{$table.rule.color}"
                                            border-right-width="0.5pt" border-right-style="solid"
                                            border-right-color="{$table.rule.color}">
                                            <fo:block font-family="{$body.font.family}"
                                                font-size="{$body.font.size.small}"/>
                                        </fo:table-cell>
                                        <fo:table-cell padding-left="2pt" padding-right="2pt"
                                            padding-top="2pt" padding-bottom="2pt"
                                            border-bottom-width="0.5pt" border-bottom-style="solid"
                                            border-bottom-color="{$table.rule.color}"
                                            border-right-width="0.5pt" border-right-style="solid"
                                            border-right-color="{$table.rule.color}">
                                            <fo:block font-family="{$body.font.family}"
                                                font-size="{$body.font.size.small}"/>
                                        </fo:table-cell>
                                        <fo:table-cell padding-left="2pt" padding-right="2pt"
                                            padding-top="2pt" padding-bottom="2pt"
                                            border-bottom-width="0.5pt" border-bottom-style="solid"
                                            border-bottom-color="{$table.rule.color}"
                                            font-family="{$body.font.family}">
                                            <fo:block font-family="{$body.font.family}"
                                                font-size="{$body.font.size.small}"/>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:otherwise>
                            </xsl:choose>

                        </fo:table-body>

                    </fo:table>
                </fo:block>
            </xsl:when>

        </xsl:choose>

        <xsl:if test="number($SHOWCOMMENTS-NUM) = 1">
            <xsl:if
                test="//*[contains(@class, ' topic/draft-comment ')][not(contains(@outputclass, 'CADPREP'))][not(contains(@outputclass, 'JIRA'))][not(contains(@outputclass, 'PMCREQDB'))]">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="2pc">
                    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                        font-size="10pt" hyphenate="false" space-after.minimum="0.4em"
                        space-after.optimum="0.6em" space-after.maximum="0.8em"
                        keep-with-next.within-column="always" text-align="left"
                        font-family="{$body.font.family}"> Reviewer Remarks </fo:block>
                    <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                        border-before-width.conditionality="retain" border-collapse="collapse"
                        border-left-style="solid" border-right-style="solid"
                        border-top-style="solid" border-bottom-style="solid"
                        border-left-width="0.5pt" border-right-width="0.5pt"
                        border-top-width="0.5pt" border-bottom-width="0.5pt"
                        border-left-color="{$table.rule.color}"
                        border-right-color="{$table.rule.color}"
                        border-top-color="{$table.rule.color}"
                        border-bottom-color="{$table.rule.color}" table-layout="fixed">
                        <fo:table-column column-number="1" column-width="0.75in"/>
                        <fo:table-column column-number="2" column-width="0.5in"/>
                        <fo:table-column column-number="3" column-width="4.5in"/>
                        <fo:table-header end-indent="0pt" start-indent="0pt">
                            <fo:table-row keep-with-next.within-column="always">
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}">
                                        Reviewer </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Page
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Remark
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body end-indent="0pt" start-indent="0pt">
                            <xsl:for-each
                                select="//*[contains(@class, ' topic/draft-comment ')][not(contains(@outputclass, 'CADPREP'))][not(contains(@outputclass, 'JIRA'))][not(contains(@outputclass, 'PMCREQDB'))]">
                                <fo:table-row>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:value-of select="@author"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <fo:basic-link color="blue"
                                                internal-destination="{generate-id()}">
                                                <xsl:choose>
                                                  <xsl:when test="@id">
                                                  <fo:page-number-citation>
                                                  <xsl:attribute name="ref-id" select="@id"/>
                                                  </fo:page-number-citation>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <fo:page-number-citation ref-id="{generate-id()}"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <fo:block>
                                            <xsl:apply-templates/>
                                        </fo:block>
                                        <fo:block font-family="{$body.font.family}" font-size="1pt"
                                        />
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>

            </xsl:if>

            <xsl:if
                test="//*[contains(@class, ' topic/draft-comment ')][contains(@outputclass, 'CADPREP')]">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="2pc">
                    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                        font-size="10pt" hyphenate="false" space-after.minimum="0.4em"
                        space-after.optimum="0.6em" space-after.maximum="0.8em"
                        keep-with-next.within-column="always" text-align="left"
                        font-family="{$body.font.family}"> CAD PREP Comments </fo:block>
                    <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                        border-before-width.conditionality="retain" border-collapse="collapse"
                        border-left-style="solid" border-right-style="solid"
                        border-top-style="solid" border-bottom-style="solid"
                        border-left-width="0.5pt" border-right-width="0.5pt"
                        border-top-width="0.5pt" border-bottom-width="0.5pt"
                        border-left-color="{$table.rule.color}"
                        border-right-color="{$table.rule.color}"
                        border-top-color="{$table.rule.color}"
                        border-bottom-color="{$table.rule.color}" table-layout="fixed">
                        <fo:table-column column-number="1" column-width="0.75in"/>
                        <fo:table-column column-number="2" column-width="0.75in"/>
                        <fo:table-column column-number="3" column-width="0.5in"/>
                        <fo:table-column column-number="4" column-width="4in"/>
                        <fo:table-header end-indent="0pt" start-indent="0pt">
                            <fo:table-row keep-with-next.within-column="always">
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}">
                                        Commentor </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Page
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> PREP#
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Remark
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body end-indent="0pt" start-indent="0pt">
                            <xsl:for-each
                                select="//*[contains(@class, ' topic/draft-comment ')][contains(@outputclass, 'CADPREP')]">
                                <fo:table-row>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:value-of select="@author"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <fo:basic-link color="blue"
                                                internal-destination="{generate-id()}">
                                                <xsl:choose>
                                                  <xsl:when test="@id">
                                                  <fo:page-number-citation>
                                                  <xsl:attribute name="ref-id" select="@id"/>
                                                  </fo:page-number-citation>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <fo:page-number-citation ref-id="{generate-id()}"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:value-of
                                                select="substring-after(*[contains(@class, 'topic/keyword')][1], 'CADPREP-')"
                                            />
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <fo:block>
                                            <xsl:apply-templates mode="process-pmc-comments"/>
                                        </fo:block>
                                        <fo:block font-family="{$body.font.family}" font-size="1pt"
                                        />
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </xsl:if>

            <xsl:if
                test="//*[contains(@class, ' topic/draft-comment ')][contains(@outputclass, 'JIRA')]">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="2pc">
                    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                        font-size="10pt" hyphenate="false" space-after.minimum="0.4em"
                        space-after.optimum="0.6em" space-after.maximum="0.8em"
                        keep-with-next.within-column="always" text-align="left"
                        font-family="{$body.font.family}"> JIRA Comments </fo:block>
                    <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                        border-before-width.conditionality="retain" border-collapse="collapse"
                        border-left-style="solid" border-right-style="solid"
                        border-top-style="solid" border-bottom-style="solid"
                        border-left-width="0.5pt" border-right-width="0.5pt"
                        border-top-width="0.5pt" border-bottom-width="0.5pt"
                        border-left-color="{$table.rule.color}"
                        border-right-color="{$table.rule.color}"
                        border-top-color="{$table.rule.color}"
                        border-bottom-color="{$table.rule.color}" table-layout="fixed">
                        <fo:table-column column-number="1" column-width="0.75in"/>
                        <fo:table-column column-number="2" column-width="0.5in"/>
                        <fo:table-column column-number="3" column-width="1.5in"/>
                        <fo:table-column column-number="4" column-width="3in"/>
                        <fo:table-header end-indent="0pt" start-indent="0pt">
                            <fo:table-row keep-with-next.within-column="always">
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}">
                                        Commentor </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Page
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> JIRA#
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Remark
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body end-indent="0pt" start-indent="0pt">
                            <xsl:for-each
                                select="//*[contains(@class, ' topic/draft-comment ')][contains(@outputclass, 'JIRA')]">
                                <fo:table-row>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:value-of select="@author"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <fo:basic-link color="blue"
                                                internal-destination="{generate-id()}">
                                                <xsl:choose>
                                                  <xsl:when test="@id">
                                                  <fo:page-number-citation>
                                                  <xsl:attribute name="ref-id" select="@id"/>
                                                  </fo:page-number-citation>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <fo:page-number-citation ref-id="{generate-id()}"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:variable name="JIRA-TARGET">
                                                <xsl:text>https://jira-agile.pmcs.com:8443/browse/</xsl:text>
                                                <xsl:value-of
                                                  select="substring-after(term/term/term, 'JIRA-')"
                                                />
                                            </xsl:variable>
                                            <fo:basic-link
                                                external-destination="url('{$JIRA-TARGET}')"
                                                color="blue" text-decoration="none">
                                                <xsl:value-of
                                                  select="substring-after(term/term/term, 'JIRA-')"
                                                />
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <fo:block>
                                            <xsl:apply-templates mode="process-pmc-comments"/>
                                        </fo:block>
                                        <fo:block font-family="{$body.font.family}" font-size="1pt"
                                        />
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </xsl:if>

            <xsl:if
                test="//*[contains(@class, ' topic/draft-comment ')][contains(@outputclass, 'PMCREQDB')]">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="2pc">
                    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                        font-size="10pt" hyphenate="false" space-after.minimum="0.4em"
                        space-after.optimum="0.6em" space-after.maximum="0.8em"
                        keep-with-next.within-column="always" text-align="left"
                        font-family="{$body.font.family}"> PMCREQDB Requirement Comments </fo:block>
                    <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                        border-before-width.conditionality="retain" border-collapse="collapse"
                        border-left-style="solid" border-right-style="solid"
                        border-top-style="solid" border-bottom-style="solid"
                        border-left-width="0.5pt" border-right-width="0.5pt"
                        border-top-width="0.5pt" border-bottom-width="0.5pt"
                        border-left-color="{$table.rule.color}"
                        border-right-color="{$table.rule.color}"
                        border-top-color="{$table.rule.color}"
                        border-bottom-color="{$table.rule.color}" table-layout="fixed">
                        <fo:table-column column-number="1" column-width="0.75in"/>
                        <fo:table-column column-number="2" column-width="0.5in"/>
                        <fo:table-column column-number="3" column-width="1.5in"/>
                        <fo:table-column column-number="4" column-width="3in"/>
                        <fo:table-header end-indent="0pt" start-indent="0pt">
                            <fo:table-row keep-with-next.within-column="always">
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}">
                                        Commentor </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Page
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}">
                                        PMCREQDB# </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Remark
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body end-indent="0pt" start-indent="0pt">
                            <xsl:for-each
                                select="//*[contains(@class, ' topic/draft-comment ')][contains(@outputclass, 'PMCREQDB')]">
                                <fo:table-row>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:value-of select="@author"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <fo:basic-link color="blue"
                                                internal-destination="{generate-id()}">
                                                <xsl:choose>
                                                  <xsl:when test="@id">
                                                  <fo:page-number-citation>
                                                  <xsl:attribute name="ref-id" select="@id"/>
                                                  </fo:page-number-citation>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <fo:page-number-citation ref-id="{generate-id()}"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:variable name="PMCREQDB-TARGET">
                                                <xsl:text>http://layton/reqmgr2/view.php?xid=</xsl:text>
                                                <xsl:value-of
                                                  select="substring-after(term/term/term, 'PMCREQDB-')"
                                                />
                                            </xsl:variable>
                                            <fo:basic-link
                                                external-destination="url('{$PMCREQDB-TARGET}')"
                                                color="blue" text-decoration="none">
                                                <xsl:value-of
                                                  select="substring-after(term/term/term, 'PMCREQDB-')"
                                                />
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <fo:block>
                                            <xsl:apply-templates mode="process-pmc-comments"/>
                                        </fo:block>
                                        <fo:block font-family="{$body.font.family}" font-size="1pt"
                                        />
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </xsl:if>

            <xsl:if
                test="//*[contains(@class, ' topic/topic ')][not(ancestor-or-self::*[namespace-uri() = 'http://www.idiominc.com/opentopic' and local-name() = 'map'])][descendant-or-self::*[contains(@rev, 'deltaxml-')]][not(descendant::*[contains(@class, ' topic/topic ')])]">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="2pc">
                    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                        font-size="10pt" hyphenate="false" space-after.minimum="0.4em"
                        space-after.optimum="0.6em" space-after.maximum="0.8em"
                        keep-with-next.within-column="always" text-align="left"
                        font-family="{$body.font.family}"> Changed Topics </fo:block>
                    <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                        border-before-width.conditionality="retain" border-collapse="collapse"
                        border-left-style="solid" border-right-style="solid"
                        border-top-style="solid" border-bottom-style="solid"
                        border-left-width="0.5pt" border-right-width="0.5pt"
                        border-top-width="0.5pt" border-bottom-width="0.5pt"
                        border-left-color="{$table.rule.color}"
                        border-right-color="{$table.rule.color}"
                        border-top-color="{$table.rule.color}"
                        border-bottom-color="{$table.rule.color}" table-layout="fixed">

                        <fo:table-column column-number="1" column-width="0.5in"/>
                        <fo:table-column column-number="2" column-width="5in"/>
                        <fo:table-header end-indent="0pt" start-indent="0pt">
                            <fo:table-row keep-with-next.within-column="always">
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Page
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{concat($body.font.master * 0.8, 'pt')}"> Title
                                        (Path) </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body end-indent="0pt" start-indent="0pt">
                            <xsl:for-each
                                select="//*[contains(@class, ' topic/topic ')][not(ancestor-or-self::*[namespace-uri() = 'http://www.idiominc.com/opentopic' and local-name() = 'map'])][descendant-or-self::*[contains(@rev, 'deltaxml-')]][not(descendant::*[contains(@class, ' topic/topic ')])]">
                                <fo:table-row>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:variable name="id" select="@id"/>
                                            <fo:basic-link color="blue" internal-destination="{$id}">
                                                <xsl:choose>
                                                  <xsl:when test="@id">
                                                  <fo:page-number-citation>
                                                  <xsl:attribute name="ref-id" select="@id"/>
                                                  </fo:page-number-citation>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <fo:page-number-citation ref-id="{generate-id()}"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <fo:block>
                                            <xsl:value-of
                                                select="*[contains(@class, ' topic/title ')]"/>
                                                (<xsl:value-of select="replace(@xtrf, '/', '​/')"/>) </fo:block>
                                        <fo:block font-family="{$body.font.family}" font-size="1pt"
                                        />
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </xsl:if>
        </xsl:if>

        <xsl:variable name="PREPTOPICS"
            select="//*[contains(@class, ' topic/ph ')][contains(@otherprops, 'PREP')]"/>
        <xsl:if test="//*[contains(@class, ' topic/ph ')][contains(@otherprops, 'PREP')]">
            <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="2pc">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                    font-size="10pt" hyphenate="false" space-after.minimum="0.4em"
                    space-after.optimum="0.6em" space-after.maximum="0.8em"
                    keep-with-next.within-column="always" text-align="left"
                    font-family="{$body.font.family}"> PREPS for Fixes</fo:block>
                <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                    border-before-width.conditionality="retain" border-collapse="collapse"
                    border-left-style="solid" border-right-style="solid" border-top-style="solid"
                    border-bottom-style="solid" border-left-width="0.5pt" border-right-width="0.5pt"
                    border-top-width="0.5pt" border-bottom-width="0.5pt"
                    border-left-color="{$table.rule.color}" border-right-color="{$table.rule.color}"
                    border-top-color="{$table.rule.color}" border-bottom-color="{$table.rule.color}"
                    table-layout="fixed">

                    <fo:table-column column-number="1" column-width="0.5in"/>
                    <fo:table-column column-number="2" column-width="5in"/>
                    <fo:table-header end-indent="0pt" start-indent="0pt">
                        <fo:table-row keep-with-next.within-column="always">
                            <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                                padding-bottom="2pt" border-bottom-width="0.5pt"
                                border-bottom-style="solid"
                                border-bottom-color="{$table.rule.color}" border-right-width="0.5pt"
                                border-right-style="solid" border-right-color="{$table.rule.color}"
                                background-color="#eeeeee" text-align="left">
                                <fo:block font-family="{$body.font.family}"
                                    font-size="{concat($body.font.master * 0.8, 'pt')}"> Page
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-left="2pt" padding-right="2pt" padding-top="2pt"
                                padding-bottom="2pt" border-bottom-width="0.5pt"
                                border-bottom-style="solid"
                                border-bottom-color="{$table.rule.color}" background-color="#eeeeee"
                                text-align="left">
                                <fo:block font-family="{$body.font.family}"
                                    font-size="{concat($body.font.master * 0.8, 'pt')}"> PREP
                                    Number, Title (Path) </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-header>
                    <fo:table-body end-indent="0pt" start-indent="0pt">
                        <xsl:for-each select="$PREPTOPICS">
                            <xsl:sort select="." order="ascending" data-type="number"/>
                            <!-- Tokenize the otherprops element and then check to make sure that at least one of the values literally equals PREP. This prevents matching on thinges like PREPARED, etc. -->
                            <xsl:variable name="PREP_CHECK">
                                <xsl:call-template name="tokenize">
                                    <xsl:with-param name="string" select="@otherprops"/>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:if test="$PREP_CHECK/token = 'PREP'">
                                <fo:table-row>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        border-right-width="0.5pt" border-right-style="solid"
                                        border-right-color="{$table.rule.color}">
                                        <fo:block font-family="{$body.font.family}"
                                            font-size="{$body.font.size.small}">
                                            <xsl:variable name="id"
                                                select="ancestor::*[contains(@class, ' topic/body ')]/parent::*[contains(@class, ' topic/topic ')]/@id"/>
                                            <fo:basic-link color="blue" internal-destination="{$id}">
                                                <xsl:choose>
                                                  <xsl:when test="$id">
                                                  <fo:page-number-citation>
                                                  <xsl:attribute name="ref-id" select="$id"/>
                                                  </fo:page-number-citation>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <fo:page-number-citation ref-id="{generate-id()}"
                                                  />
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </fo:basic-link>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding-left="2pt" padding-right="2pt"
                                        padding-top="2pt" padding-bottom="2pt"
                                        border-bottom-width="0.5pt" border-bottom-style="solid"
                                        border-bottom-color="{$table.rule.color}"
                                        font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <fo:block>
                                            <xsl:value-of select="."/>
                                            <xsl:text>, </xsl:text>
                                            <xsl:value-of
                                                select="ancestor::*[contains(@class, ' topic/body ')]/parent::*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]"
                                            />
                                        </fo:block>
                                        <fo:block font-family="{$body.font.family}" font-size="1pt"
                                        />
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:if>
                        </xsl:for-each>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </xsl:if>

    </xsl:template>

    <xsl:template name="createRevisionHistory">
        <!-- If a topic with a pmc-revhistory element is present in the file, process that instead of the pmc_iso content. -->
        <xsl:choose>
            <xsl:when test="//topic[descendant::pmc-revhistory]">
                <fo:block> </fo:block>
            </xsl:when>
            <xsl:when test="$pmc_iso[1]/pmc_revhistory/pmc_revision">
                <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-before="page"
                    margin-top="1cm" margin-left="0cm">
                    <fo:marker marker-class-name="current-header">
                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'PMCRevisionHistory'"/>
                        </xsl:call-template>
                    </fo:marker>
                    <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" font-weight="bold"
                        font-size="10pt" hyphenate="false" space-after.minimum="0.4em"
                        space-after.optimum="0.6em" space-after.maximum="0.8em"
                        keep-with-next.within-column="always" text-align="left"
                        font-family="{$body.font.family}">

                        <xsl:call-template name="insertVariable">
                            <xsl:with-param name="theVariableID" select="'PMCRevisionHistory'"/>
                        </xsl:call-template>

                        <xsl:if test="$pmc_iso[1]/pubdate or $pmc_iso[1]/pmc_issue_date">
                            <xsl:text> : </xsl:text>
                            <xsl:value-of select="$pmc_iso[1]/pubdate"/>
                            <xsl:value-of select="$pmc_iso[1]/pmc_issue_date"/>
                        </xsl:if>

                    </fo:block>
                    <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                        border-before-width.conditionality="retain" border-collapse="collapse"
                        border-left-style="solid" border-right-style="solid"
                        border-top-style="solid" border-bottom-style="solid"
                        border-left-width="0.5pt" border-right-width="0.5pt"
                        border-top-width="0.5pt" border-bottom-width="0.5pt"
                        border-left-color="{$table.rule.color}"
                        border-right-color="{$table.rule.color}"
                        border-top-color="{$table.rule.color}"
                        border-bottom-color="{$table.rule.color}" table-layout="fixed">
                        <fo:table-column column-number="1" column-width="1.5cm"/>
                        <fo:table-column column-number="2" column-width="1.5cm"/>
                        <fo:table-column column-number="3" column-width="13.5cm"/>
                        <fo:table-header end-indent="0pt" start-indent="0pt">
                            <fo:table-row keep-with-next.within-column="always">
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCIssueNumber'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    border-bottom-color="{$table.rule.color}"
                                    border-right-width="0.5pt" border-right-style="solid"
                                    border-right-color="{$table.rule.color}"
                                    background-color="#eeeeee" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCIssueDate'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-left="2pt" padding-right="2pt"
                                    padding-top="2pt" padding-bottom="2pt"
                                    border-bottom-width="0.5pt" border-bottom-style="solid"
                                    background-color="#eeeeee"
                                    border-bottom-color="{$table.rule.color}" text-align="left">
                                    <fo:block font-family="{$body.font.family}"
                                        font-size="{$body.font.size.small}">
                                        <xsl:call-template name="insertVariable">
                                            <xsl:with-param name="theVariableID"
                                                select="'PMCDetailsOfChange'"/>
                                        </xsl:call-template>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-header>
                        <fo:table-body end-indent="0pt" start-indent="0pt">
                            <xsl:for-each select="$pmc_iso[1]/pmc_revhistory/pmc_revision">
                                <xsl:choose>
                                    <xsl:when test="@role = 'internal' or @otherprops = 'internal'"/>
                                    <xsl:when test="@role = 'external' or @otherprops = 'external'">
                                        <fo:table-row>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}"
                                                text-align="left">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="revnumber | pmc_rev_number"
                                                  />
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="date | pmc_date"/>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                font-family="{$body.font.family}"
                                                font-size="{$body.font.size.small}"
                                                text-align="left">
                                                <xsl:apply-templates select="pmc_revdescription"
                                                  mode="revhistory-passthrough"/>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:when>
                                    <xsl:when
                                        test="descendant::*/@role = 'external' or descendant::*/@otherprops = 'external'">
                                        <fo:table-row>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}"
                                                text-align="left">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="revnumber | pmc_rev_number"
                                                  />
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="date | pmc_date"/>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="5pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                font-family="{$body.font.family}"
                                                font-size="{$body.font.size.small}"
                                                text-align="left">
                                                <fo:block/>
                                                <xsl:apply-templates select="pmc_revdescription"
                                                  mode="revisionhistory"/>

                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <fo:table-row>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}"
                                                text-align="left">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="revnumber | pmc_rev_number"
                                                  />
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="2pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                border-right-width="0.5pt"
                                                border-right-style="solid"
                                                border-right-color="{$table.rule.color}">
                                                <fo:block font-family="{$body.font.family}"
                                                  font-size="{$body.font.size.small}">
                                                  <xsl:value-of select="date | pmc_date"/>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding-left="5pt" padding-right="2pt"
                                                padding-top="2pt" padding-bottom="2pt"
                                                border-bottom-width="0.5pt"
                                                border-bottom-style="solid"
                                                border-bottom-color="{$table.rule.color}"
                                                font-family="{$body.font.family}"
                                                font-size="{$body.font.size.small}"
                                                text-align="left">
                                                <fo:block/>
                                                <xsl:apply-templates select="pmc_revdescription"
                                                  mode="revisionhistory-strip-internal"/>

                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </xsl:when>
            <xsl:otherwise>
                <fo:block/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--<xsl:template name="createCoverPage">
        <fo:block xmlns:rx="http://www.renderx.com/XSL/Extensions"
            xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="9mm" margin-left="2cm"
            margin-right=".5cm" space-before.minimum="0.5em" space-before.optimum="1em"
            space-before.maximum="2em" space-after.minimum="0.5em" space-after.optimum="1em"
            space-after.maximum="2em" keep-together.within-column="always" break-after="page"
            hyphenate="false">
            <fo:block text-align="right" font-family="{$title.font.family}" color="#ffffff"
                font-size="18pt" space-before="10pt">.</fo:block>
            <fo:block border-before-style="groove" border-after-style="groove" text-align="left"
                font-family="{$title.font.family}" font-size="18pt" space-before="5pt"
                font-weight="bold">
                <xsl:if test="string-length(normalize-space($pmc_iso[1]/pmc_productname[1])) &gt; 1">
                    <xsl:for-each select="$pmc_iso[1]/pmc_productname">
                        <fo:inline>
                            <xsl:value-of select="."/>
                        </fo:inline>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if
                    test="string-length(normalize-space($pmc_iso[1]/pmc_productnumber[1])) &gt; 1">
                    <xsl:for-each select="$pmc_iso[1]/pmc_productnumber">
                        <fo:inline text-align="right" font-family="{$title.font.family}"
                            font-size="18pt" space-before="5pt" font-weight="bold">
                            <xsl:value-of select="."/>
                        </fo:inline>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="string-length(normalize-space($pmc_iso[1]/pmc_doc_type[1])) &gt; 1">
                    <xsl:choose>
                        <xsl:when test="$pmc_iso[1]/pmc_doc_type = $pmc_iso[1]/pmc_title"/>
                        <xsl:otherwise>
                            <fo:inline text-align="right" font-family="{$title.font.family}"
                                font-size="19pt" space-before="5pt" font-weight="bold">
                                <xsl:value-of select="$pmc_iso[1]/pmc_doc_type"/>
                            </fo:inline>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <xsl:if test="string-length(normalize-space($pmc_iso[1]/subtitle[1])) &gt; 1">
                    <fo:block text-align="right" font-family="{$title.font.family}"
                        font-size="20pt" space-before="5pt" font-weight="bold">
                        <xsl:value-of select="$pmc_iso[1]/subtitle[1]/text()"/>
                    </fo:block>
                </xsl:if>
                <xsl:if
                    test="string-length(normalize-space($pmc_iso[1]/pmc_dev_status/@dev_status)) &gt; 1">
                    <fo:block text-align="right" font-family="{$title.font.family}" font-size="12pt"
                        space-before="5pt" font-weight="bold" color="#aaaaaa">
                        <xsl:value-of select="$pmc_iso[1]/pmc_dev_status/@dev_status"/>
                    </fo:block>
                </xsl:if>
                <fo:block text-align="right" font-family="{$title.font.family}" font-size="12pt"
                    space-before="5pt" font-weight="bold" color="#aaaaaa">
                    <xsl:choose>
                        <xsl:when
                            test="string-length(normalize-space($pmc_iso[1]/pubdate[1])) &gt; 1 or string-length(normalize-space($pmc_iso[1]/pmc_issue_date)) &gt; 1">

                            <xsl:if test="$pmc_iso[1]/pubdate or $pmc_iso[1]/pmc_issue_date">
                                <xsl:value-of select="$pmc_iso[1]/pubdate"/>
                                <xsl:value-of select="$pmc_iso[1]/pmc_issue_date"/>
                            </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="getDateMonth"/>, <xsl:call-template
                                name="getDateYear"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:block>
            <xsl:variable name="first.book.content">1</xsl:variable>
        </fo:block>


    </xsl:template>-->

    <xsl:template name="createCoverPage">
        <fo:block xmlns:rx="http://www.renderx.com/XSL/Extensions"
            xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:block>.</fo:block>
            <xsl:variable name="logo">
                <xsl:call-template name="insertVariable">
                    <xsl:with-param name="theVariableID" select="'microchip_logo'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="title">
                <xsl:if test="string-length(normalize-space($pmc_iso[1]/pmc_title[1])) &gt; 1">
                    <xsl:for-each select="$pmc_iso[1]/pmc_title">
                        <xsl:apply-templates select="."/>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if
                    test="string-length(normalize-space($pmc_iso[1]/pmc_productnumber[1])) &gt; 1">
                    <xsl:for-each select="$pmc_iso[1]/pmc_productnumber">
                        <xsl:value-of select="."/>
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="string-length(normalize-space($pmc_iso[1]/pmc_doc_type[1])) &gt; 1">
                    <xsl:choose>
                        <xsl:when test="$pmc_iso[1]/pmc_doc_type = $pmc_iso[1]/pmc_title"/>
                        <xsl:otherwise>
                            <xsl:value-of select="$pmc_iso[1]/pmc_doc_type"/>
                            <xsl:text> </xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                <xsl:if test="string-length(normalize-space($pmc_iso[1]/pmc_productname[1])) &gt; 1">
                    <xsl:for-each select="$pmc_iso[1]/pmc_productname">
                        <xsl:value-of select="."/>
                        <xsl:text> </xsl:text>
                    </xsl:for-each>
                </xsl:if>
              
            </xsl:variable>

            <fo:block text-align="left">
                <fo:external-graphic src="url({concat($customizationDir.url, $logo)})" width="3.5cm"
                    content-width="scale-to-fit" content-height="scale-to-fit"/>
            </fo:block>
            <fo:block border-top-color="black" border-top-width="1.5mm" border-top-style="solid"
                border-bottom-color="black" border-bottom-width="1.5mm" border-bottom-style="solid"
                margin-top="1mm">
                <fo:block border-top-color="black" border-top-width="1pt" border-top-style="solid"
                    margin-top=".75mm" border-bottom-color="black" border-bottom-width="1pt"
                    border-bottom-style="solid" margin-bottom=".75mm">
                    <fo:block padding-top="2mm" padding-bottom="2mm"
                        font-family="{$title.font.family}" font-size="18pt" font-weight="bold">
                        <fo:block>
                            <xsl:value-of select="normalize-space($title)"/>
                        </fo:block>

                    </fo:block>
                </fo:block>                
            </fo:block>
            <fo:block text-align="center" font-family="{$title.font.family}" font-size="12pt"
                space-before="5pt" font-weight="bold">
                <xsl:if
                    test="string-length(normalize-space($pmc_iso[1]/pmc_dev_status/@dev_status)) &gt; 1">
                    <xsl:value-of select="$pmc_iso[1]/pmc_dev_status/@dev_status"/> / </xsl:if>
                <xsl:choose>
                    <xsl:when
                        test="string-length(normalize-space($pmc_iso[1]/pubdate[1])) &gt; 1 or string-length(normalize-space($pmc_iso[1]/pmc_issue_date)) &gt; 1">
                        
                        <xsl:if test="$pmc_iso[1]/pubdate or $pmc_iso[1]/pmc_issue_date">
                            <xsl:value-of select="$pmc_iso[1]/pubdate"/>
                            <xsl:value-of select="$pmc_iso[1]/pmc_issue_date"/>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="getDateMonth"/>, <xsl:call-template
                            name="getDateYear"/>
                    </xsl:otherwise>
                </xsl:choose>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template name="getDateYear">
        <xsl:variable name="date">
            <xsl:value-of select="fn:current-date()"/>
        </xsl:variable>
        <xsl:value-of select="substring-before($date, '-')"/>
    </xsl:template>

    <xsl:template name="getDateMonth">
        <xsl:variable name="date">
            <xsl:value-of select="fn:current-date()"/>
        </xsl:variable>
        <xsl:variable name="month_start">
            <xsl:value-of select="substring-after($date, '-')"/>
        </xsl:variable>
        <xsl:variable name="month_end">
            <xsl:value-of select="substring-before($month_start, '-')"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains($month_end, '12')">December</xsl:when>
            <xsl:when test="contains($month_end, '11')">November</xsl:when>
            <xsl:when test="contains($month_end, '10')">October</xsl:when>
            <xsl:when test="contains($month_end, '09')">September</xsl:when>
            <xsl:when test="contains($month_end, '08')">August</xsl:when>
            <xsl:when test="contains($month_end, '07')">July</xsl:when>
            <xsl:when test="contains($month_end, '06')">June</xsl:when>
            <xsl:when test="contains($month_end, '05')">May</xsl:when>
            <xsl:when test="contains($month_end, '04')">April</xsl:when>
            <xsl:when test="contains($month_end, '03')">March</xsl:when>
            <xsl:when test="contains($month_end, '02')">February</xsl:when>
            <xsl:when test="contains($month_end, '01')">January</xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- This section filters the contents of the pmc_revhistory element to determine what parts of them to display in the revision history of external documents -->

    <xsl:template match="pmc_revdescription">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="pmc_revdescription" mode="revhistory-passthrough">
        <xsl:apply-templates mode="revhistory-passthrough"/>
    </xsl:template>

    <xsl:template match="pmc_revdescription" mode="revisionhistory">
        <xsl:choose>
            <xsl:when test="@role = 'external' or @otherprops = 'external'">
                <xsl:apply-templates mode="revhistory-passthrough"/>
            </xsl:when>
            <xsl:when
                test="descendant::node()/@role = 'external' or descendant::node()/@otherprops = 'external'">
                <xsl:apply-templates mode="revisionhistory"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates mode="revhistory-passthrough"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ul" mode="revisionhistory">
        <xsl:choose>
            <xsl:when test="@role = 'external' or @otherprops = 'external'">
                <fo:list-block space-before.optimum="4pt" space-before.minimum="2pt"
                    space-before.maximum="8pt" space-after.optimum="4pt" space-after.minimum="2pt"
                    space-after.maximum="8pt" provisional-label-separation="0.2em"
                    provisional-distance-between-starts="1.0em">
                    <xsl:apply-templates mode="revhistory-passthrough"/>
                </fo:list-block>
            </xsl:when>
            <xsl:when
                test="descendant::node()/@role = 'external' or descendant::node()/@otherprops = 'external'">
                <fo:list-block space-before.optimum="4pt" space-before.minimum="2pt"
                    space-before.maximum="8pt" space-after.optimum="4pt" space-after.minimum="2pt"
                    space-after.maximum="8pt" provisional-label-separation="0.2em"
                    provisional-distance-between-starts="1.0em">
                    <xsl:apply-templates mode="revisionhistory"/>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block space-before.optimum="4pt" space-before.minimum="2pt"
                    space-before.maximum="8pt" space-after.optimum="4pt" space-after.minimum="2pt"
                    space-after.maximum="8pt" provisional-label-separation="0.2em"
                    provisional-distance-between-starts="1.0em">
                    <xsl:apply-templates mode="revisionhistory"/>
                </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ul" mode="revhistory-passthrough">
        <fo:list-block space-before.optimum="4pt" space-before.minimum="2pt"
            space-before.maximum="8pt" space-after.optimum="4pt" space-after.minimum="2pt"
            space-after.maximum="8pt" provisional-label-separation="0.2em"
            provisional-distance-between-starts="1.0em">
            <xsl:apply-templates mode="revhistory-passthrough"/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="li" mode="revisionhistory">
        <xsl:choose>
            <xsl:when test="@role = 'external' or @otherprops = 'external'">
                <fo:list-item space-before.optimum="0pt" space-before.minimum="0pt"
                    space-before.maximum="0pt" space-after.optimum="0pt" space-after.minimum="0pt"
                    space-after.maximum="0pt">
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>•</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:when>
            <xsl:when
                test="descendant::node()/@role = 'external' or descendant::node()/@otherprops = 'external'">
                <fo:list-item space-before.optimum="0pt" space-before.minimum="0pt"
                    space-before.maximum="0pt" space-after.optimum="0pt" space-after.minimum="0pt"
                    space-after.maximum="0pt">
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>•</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates mode="revisionhistory"/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="li" mode="revhistory-passthrough">
        <fo:list-item space-before.optimum="4pt" space-before.minimum="2pt"
            space-before.maximum="6pt">
            <fo:list-item-label end-indent="label-end()">
                <fo:block>•</fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="p" mode="revisionhistory">
        <xsl:if test="@otherprops = 'external'">
            <fo:block>
                <xsl:apply-templates/>
            </fo:block>
        </xsl:if>
    </xsl:template>

    <xsl:template match="p" mode="revhistory-passthrough">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="p[ancestor::pmc_iso]">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!-- The following sections should strip any parts of the revision history that are designated "internal" -->

    <xsl:template match="pmc_revdescription" mode="revisionhistory-strip-internal">
        <xsl:choose>
            <xsl:when test="@role = 'internal' or @otherprops = 'internal'"/>
            <xsl:when
                test="descendant::node()/@role = 'internal' or descendant::node()/@otherprops = 'internal'">
                <xsl:apply-templates mode="revisionhistory-strip-internal"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ul" mode="revisionhistory-strip-internal">
        <xsl:choose>
            <xsl:when test="@role = 'internal' or @otherprops = 'internal'"/>
            <xsl:when
                test="descendant::node()/@role = 'internal' or descendant::node()/@otherprops = 'internal'">
                <fo:list-block space-before.optimum="4pt" space-before.minimum="2pt"
                    space-before.maximum="8pt" space-after.optimum="4pt" space-after.minimum="2pt"
                    space-after.maximum="8pt" provisional-label-separation="0.2em"
                    provisional-distance-between-starts="1.0em">
                    <xsl:apply-templates mode="revisionhistory-strip-internal"/>
                </fo:list-block>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-block space-before.optimum="4pt" space-before.minimum="2pt"
                    space-before.maximum="8pt" space-after.optimum="4pt" space-after.minimum="2pt"
                    space-after.maximum="8pt" provisional-label-separation="0.2em"
                    provisional-distance-between-starts="1.0em">
                    <xsl:apply-templates/>
                </fo:list-block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="li" mode="revisionhistory-strip-internal">
        <xsl:choose>
            <xsl:when test="@role = 'internal' or @otherprops = 'internal'"/>
            <xsl:when
                test="descendant::node()/@role = 'internal' or descendant::node()/@otherprops = 'internal'">
                <fo:list-item space-before.optimum="0pt" space-before.minimum="0pt"
                    space-before.maximum="0pt" space-after.optimum="0pt" space-after.minimum="0pt"
                    space-after.maximum="0pt">
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>•</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates mode="revisionhistory-strip-internal"/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:when>
            <xsl:otherwise>
                <fo:list-item space-before.optimum="0pt" space-before.minimum="0pt"
                    space-before.maximum="0pt" space-after.optimum="0pt" space-after.minimum="0pt"
                    space-after.maximum="0pt">
                    <fo:list-item-label end-indent="label-end()">
                        <fo:block>•</fo:block>
                    </fo:list-item-label>
                    <fo:list-item-body start-indent="body-start()">
                        <fo:block>
                            <xsl:apply-templates mode="revisionhistory-strip-internal"/>
                        </fo:block>
                    </fo:list-item-body>
                </fo:list-item>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="p" mode="revisionhistory-strip-internal">
        <xsl:choose>
            <xsl:when test="@otherprops = 'internal' or @role = 'internal'"/>
            <xsl:otherwise>
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="tokenize">
        <xsl:param name="string"/>
        <xsl:param name="separator" select="' '"/>
        <xsl:choose>
            <xsl:when test="contains($string, $separator)">
                <token>
                    <xsl:value-of select="substring-before($string, $separator)"/>
                </token>
                <xsl:call-template name="tokenize">
                    <xsl:with-param name="string" select="substring-after($string, $separator)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <token>
                    <xsl:value-of select="$string"/>
                </token>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

<?xml version='1.0'?>

<!-- 
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

<!-- Elements for steps have been relocated to task-elements.xsl -->
<!-- Templates for <dl> are in tables.xsl -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <xsl:template
        match="*[contains(@class, ' topic/linklist ')]/*[contains(@class, ' topic/title ')]">
        <fo:block xsl:use-attribute-sets="linklist.title">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!--Lists-->
    <xsl:template match="*[contains(@class, ' topic/ul ')]">
        <fo:list-block xsl:use-attribute-sets="ul">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/ol ')]">
        <fo:list-block xsl:use-attribute-sets="ol">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]">
        <xsl:variable name="depth" select="count(ancestor::*[contains(@class, ' topic/ul ')])"/>
        <fo:list-item xsl:use-attribute-sets="ul.li">
            <fo:list-item-label xsl:use-attribute-sets="ul.li__label">
                <fo:block xsl:use-attribute-sets="ul.li__label__content">
                    <fo:inline>
                        <xsl:call-template name="commonattributes"/>
                    </fo:inline>
                    <xsl:choose>
                        <xsl:when test="$depth = 1">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'bulletL1'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="$depth = 2">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'bulletL2'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="$depth = 3">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'bulletL3'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="$depth = 4">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'bulletL1'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="$depth = 5">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'bulletL2'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:when test="$depth = 6">
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID" select="'bulletL3'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="insertVariable">
                                <xsl:with-param name="theVariableID"
                                    select="'Unordered List bullet'"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:list-item-label>

            <fo:list-item-body xsl:use-attribute-sets="ul.li__body">
                <fo:block xsl:use-attribute-sets="ul.li__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>

        </fo:list-item>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/ol ')]/*[contains(@class, ' topic/li ')]">
        <xsl:variable name="depth" select="count(ancestor::*[contains(@class, ' topic/ol ')])"/>
        <fo:list-item xsl:use-attribute-sets="ol.li">
            <fo:list-item-label xsl:use-attribute-sets="ol.li__label">
                <fo:block xsl:use-attribute-sets="ol.li__label__content">
                    <fo:inline>
                        <xsl:call-template name="commonattributes"/>
                    </fo:inline>
                    <xsl:call-template name="insertVariable">
                        <xsl:with-param name="theVariableID" select="'Ordered List Number'"/>
                        <xsl:with-param name="theParameters">
                            <number>
                                <xsl:choose>
                                    <xsl:when test="$depth = 2">
                                        <xsl:number format="a"/>
                                    </xsl:when>
                                    <xsl:when test="$depth = 3">
                                        <xsl:number format="i"/>
                                    </xsl:when>
                                    <xsl:when test="$depth = 4">
                                        <xsl:number format="A"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:variable name="tnumber">
                                            <xsl:number/>
                                        </xsl:variable>
                                        <xsl:variable name="preceding-count">
                                            <xsl:choose>
                                                <xsl:when
                                                  test="parent::*[contains(@class, ' topic/ol ')][contains(@otherprops, 'continue-numbering')]">
                                                  <xsl:call-template name="preceding-count">
                                                  <xsl:with-param name="preceding-ol"
                                                  select="count(parent::*[contains(@class, ' topic/ol ')]/preceding-sibling::*[contains(@class, ' topic/ol ')])"
                                                  />
                                                  </xsl:call-template>
                                                </xsl:when>
                                                <xsl:otherwise>0</xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>
                                        <xsl:value-of
                                            select="number($tnumber) + number($preceding-count)"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </number>
                        </xsl:with-param>
                    </xsl:call-template>                
                </fo:block>
            </fo:list-item-label>

            <fo:list-item-body xsl:use-attribute-sets="ol.li__body">
                <fo:block xsl:use-attribute-sets="ol.li__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>

        </fo:list-item>
    </xsl:template>

    <xsl:template name="preceding-count">
        <xsl:param name="preceding-ol"/>
        <xsl:param name="current-ol-count" select="1"/>
        <xsl:param name="current-li-count" select="0"/>
        <xsl:choose>
            <xsl:when
                test="parent::*[contains(@class, ' topic/ol ')]/
                preceding-sibling::*[contains(@class, ' topic/ol ')]
                [number($current-ol-count)][contains(@otherprops, 'continue-numbering')]">
                <xsl:variable name="temp-ol"
                    select="count(parent::*[contains(@class, ' topic/ol ')]/
                    preceding-sibling::*[contains(@class, ' topic/ol ')][$current-ol-count]/*[contains(@class, ' topic/li ')])"/>
                <xsl:call-template name="preceding-count">
                    <xsl:with-param name="current-ol-count" select="number($current-ol-count) + 1"/>
                    <xsl:with-param name="current-li-count" select="number($current-li-count) + number($temp-ol)"/>
                </xsl:call-template>
            </xsl:when>
           <xsl:when test="parent::*[contains(@class, ' topic/ol ')]/
                preceding-sibling::*[contains(@class, ' topic/ol ')]
                [number($current-ol-count)][contains(@otherprops, 'start-numbering')]">
                <xsl:variable name="temp-ol"
                    select="count(parent::*[contains(@class, ' topic/ol ')]/preceding-sibling::*[contains(@class, ' topic/ol ')]
                    [$current-ol-count]/child::*[contains(@class, ' topic/li ')])"/>
                <xsl:value-of select="number($current-li-count) + number($temp-ol)"/>
            </xsl:when>           
            <xsl:otherwise>
                <xsl:value-of select="$current-li-count"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/li ')]/*[contains(@class, ' topic/itemgroup ')]">
        <fo:block xsl:use-attribute-sets="li.itemgroup">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/sl ')]">
        <fo:list-block xsl:use-attribute-sets="sl">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/sl ')]/*[contains(@class, ' topic/sli ')]">
        <fo:list-item xsl:use-attribute-sets="sl.sli">
            <fo:list-item-label xsl:use-attribute-sets="sl.sli__label">
                <fo:block xsl:use-attribute-sets="sl.sli__label__content">
                    <fo:inline>
                        <xsl:call-template name="commonattributes"/>
                    </fo:inline>
                </fo:block>
            </fo:list-item-label>

            <fo:list-item-body xsl:use-attribute-sets="sl.sli__body">
                <fo:block xsl:use-attribute-sets="sl.sli__content">
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>

        </fo:list-item>
    </xsl:template>

</xsl:stylesheet>

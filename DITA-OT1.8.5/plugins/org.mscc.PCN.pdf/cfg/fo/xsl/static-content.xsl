<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

   <xsl:param name="SHOWBORDERS">0</xsl:param>

   <xsl:template name="insertBodyStaticContents">
      <xsl:call-template name="insertBodyFootnoteSeparator"/>
      <xsl:call-template name="insertBodyOddFooter"/>
      <xsl:if test="$mirror-page-margins">
         <xsl:call-template name="insertBodyEvenFooter"/>
      </xsl:if>
      <xsl:call-template name="insertBodyOddHeader"/>
      <xsl:if test="$mirror-page-margins">
         <xsl:call-template name="insertBodyEvenHeader"/>
      </xsl:if>
      <xsl:call-template name="insertBodyFirstHeader"/>
      <xsl:call-template name="insertBodyFirstFooter"/>
      <xsl:call-template name="insertBodyLastHeader"/>
      <xsl:call-template name="insertBodyLastFooter"/>
   </xsl:template>

   <xsl:template name="articleHeader">
      <xsl:param name="caller">nothing</xsl:param>
      <xsl:if test="$SHOWBORDERS = 1">
         <xsl:attribute name="border-color">green</xsl:attribute>
         <xsl:attribute name="border-style">dotted</xsl:attribute>
         <xsl:attribute name="border-width">3pt</xsl:attribute>
      </xsl:if>
      <fo:table width="175cm" display-align="before" margin-top="0mm" margin-left="0cm"
         space-before="0mm" space-after="0mm" margin-right="0mm">
         <xsl:if test="$SHOWBORDERS = 1">
            <xsl:attribute name="border-color">blue</xsl:attribute>
            <xsl:attribute name="border-style">solid</xsl:attribute>
            <xsl:attribute name="border-width">1pt</xsl:attribute>
         </xsl:if>
         <fo:table-column column-number="1" column-width="130mm"/>
         <fo:table-column column-number="2"/>
         <fo:table-body id="">
            <fo:table-row id="">
               <fo:table-cell text-align="left" vertical-align="bottom">
                 <fo:block> </fo:block>                    
               </fo:table-cell>
               <fo:table-cell text-align="left" padding-top="0mm">
                  <xsl:if test="$SHOWBORDERS = 1">
                     <xsl:attribute name="border-color">blue</xsl:attribute>
                     <xsl:attribute name="border-style">dotted</xsl:attribute>
                     <xsl:attribute name="border-width">1pt</xsl:attribute>
                  </xsl:if>
                  <fo:block>
                     <fo:block>                     
                        <fo:external-graphic
                           src="url({concat($customizationDir.url, 'Branding/Microchip/Horizontal_logo_w_tagline.png')})"
                           height="13mm" content-width="scale-to-fit" content-height="scale-to-fit"/>
                     </fo:block>
                  </fo:block>
               </fo:table-cell>
            </fo:table-row>
         </fo:table-body>
      </fo:table>
   </xsl:template>

   <xsl:template name="genericHeader">
      <xsl:param name="caller">nothing</xsl:param>
      <xsl:if test="$SHOWBORDERS = 1">
         <xsl:attribute name="border-color">red</xsl:attribute>
         <xsl:attribute name="border-style">dotted</xsl:attribute>
         <xsl:attribute name="border-width">1pt</xsl:attribute>
      </xsl:if>
      <xsl:if test="$showcallers = 1">
         <fo:block>Caller: <xsl:value-of select="$caller"/></fo:block>
      </xsl:if>
      <fo:table width="175cm" display-align="before" margin-top="0mm" margin-left="0cm"
         space-before="0mm" space-after="0mm" margin-right="0mm">
         <xsl:if test="$SHOWBORDERS = 1">
            <xsl:attribute name="border-color">blue</xsl:attribute>
            <xsl:attribute name="border-style">solid</xsl:attribute>
            <xsl:attribute name="border-width">1pt</xsl:attribute>
         </xsl:if>
         <fo:table-column column-number="1" column-width="130mm"/>
         <fo:table-column column-number="2"/>
         <fo:table-body id="">
            <fo:table-row id="">
               <fo:table-cell text-align="left" padding-top="0mm" margin-top="0mm" margin-left="0cm"
                  space-before="0mm" space-after="0mm" margin-right="0mm" vertical-align="top">
                  <fo:block font-family="{$header.font.family}" font-size="{$header.font.size}"
                     color="{$header.font.color}" padding-before="0mm" vertical-align="top"
                     padding-top="0mm" margin-top="0mm" margin-left="0cm" space-before="0mm"
                     space-after="0mm" margin-right="0mm">
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">green</xsl:attribute>
                        <xsl:attribute name="border-style">dotted</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:retrieve-marker retrieve-class-name="current-header"/>
                  </fo:block>
               </fo:table-cell>
               <fo:table-cell text-align="left" padding-top="0mm">
                  <xsl:if test="$SHOWBORDERS = 1">
                     <xsl:attribute name="border-color">blue</xsl:attribute>
                     <xsl:attribute name="border-style">dotted</xsl:attribute>
                     <xsl:attribute name="border-width">1pt</xsl:attribute>
                  </xsl:if>
                  <fo:block>
                     <fo:block>                     
                        <fo:external-graphic
                           src="url({concat($customizationDir.url, 'Branding/Microchip/Horizontal_logo_w_tagline.png')})"
                           height="13mm" content-width="scale-to-fit" content-height="scale-to-fit"/>
                     </fo:block>
                  </fo:block>
               </fo:table-cell>
            </fo:table-row>
         </fo:table-body>
      </fo:table>
   </xsl:template>


   <xsl:template name="insertBodyOddHeader">
      <fo:static-content flow-name="odd-body-header">
         <fo:block xsl:use-attribute-sets="__body__odd__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertBodyOddHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBodyEvenHeader">
      <fo:static-content flow-name="even-body-header">
         <fo:block xsl:use-attribute-sets="__body__even__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertBodyEvenHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBodyFirstHeader">
      <xsl:variable name="chapters"
         select="/bookmap/descendant::notices | /bookmap/descendant::preface  | /bookmap/descendant::chapter"/>
      <xsl:choose>
         <xsl:when test="$chapters[1]/@id = self::*/@id">
            <fo:static-content flow-name="first-body-header">
               <fo:block xsl:use-attribute-sets="__body__article__header">
                  <xsl:call-template name="articleHeader">
                     <xsl:with-param name="caller">insertBodyFirstHeader</xsl:with-param>
                  </xsl:call-template>
               </fo:block>
            </fo:static-content>
         </xsl:when>
         <xsl:otherwise>
            <fo:static-content flow-name="first-body-header">
               <fo:block xsl:use-attribute-sets="__body__first__header">
                  <xsl:call-template name="genericHeader">
                     <xsl:with-param name="caller">insertBodyFirstHeader</xsl:with-param>
                  </xsl:call-template>
               </fo:block>
            </fo:static-content>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="insertBodyLastHeader">
      <fo:static-content flow-name="last-body-header">
         <fo:block xsl:use-attribute-sets="__body__first__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertBodyLastHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertFrontMatterOddHeader">
      <fo:static-content flow-name="odd-frontmatter-header">
         <fo:block xsl:use-attribute-sets="__body__odd__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertFrontMatterOddHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertFrontMatterEvenHeader">
      <fo:static-content flow-name="even-frontmatter-header">
         <fo:block xsl:use-attribute-sets="__body__even__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertFrontMatterEvenHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertLegalStaticContents">
      <xsl:call-template name="insertLegalOddFooter">
         <xsl:with-param name="caller">odd:insertLegalStaticContents</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$mirror-page-margins">
         <xsl:call-template name="insertLegalEvenFooter">
            <xsl:with-param name="caller">even:insertLegalStaticContents</xsl:with-param>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>

   <xsl:template name="insertTocOddHeader">
      <fo:static-content flow-name="odd-toc-header">
         <fo:block xsl:use-attribute-sets="__toc__odd__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertTocOddHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertTocEvenHeader">
      <fo:static-content flow-name="even-toc-header">
         <fo:block xsl:use-attribute-sets="__toc__even__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertTocEvenHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertIndexOddHeader">
      <fo:static-content flow-name="odd-index-header">
         <fo:block xsl:use-attribute-sets="__index__odd__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertIndexOddHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertIndexEvenHeader">
      <fo:static-content flow-name="even-index-header">
         <fo:block xsl:use-attribute-sets="__index__even__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertIndexEvenHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertPrefaceOddHeader">
      <fo:static-content flow-name="odd-body-header">
         <fo:block xsl:use-attribute-sets="__body__odd__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertPrefaceOddHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertPrefaceEvenHeader">
      <fo:static-content flow-name="even-body-header">
         <fo:block xsl:use-attribute-sets="__body__even__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertPrefaceEvenHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertPrefaceFirstHeader">
      <fo:static-content flow-name="first-body-header">
         <fo:block xsl:use-attribute-sets="__body__first__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertPrefaceFirstHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBackCoverOddHeader">
      <fo:static-content flow-name="odd-back-cover-header">
         <fo:block xsl:use-attribute-sets="__body__odd__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertBackCoverOddHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBackCoverEvenHeader">
      <fo:static-content flow-name="even-back-cover-header">
         <fo:block xsl:use-attribute-sets="__body__even__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertBackCoverEvenHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertGlossaryOddHeader">
      <fo:static-content flow-name="odd-glossary-header">
         <fo:block xsl:use-attribute-sets="__glossary__odd__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertGlossaryOddHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertGlossaryEvenHeader">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="even-glossary-header">
         <fo:block xsl:use-attribute-sets="__glossary__even__header">
            <xsl:call-template name="genericHeader">
               <xsl:with-param name="caller">insertGlossaryEvenHeader</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertCoverPageHeader">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="coverpage-header">
         <fo:block xsl:use-attribute-sets="__coverpage__header"> </fo:block>
      </fo:static-content>
   </xsl:template>

   <!-- footers -->

   <xsl:template name="insertCoverPageFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="coverpage-footer">
         <fo:block xsl:use-attribute-sets="__coverpage__footer">
            <xsl:call-template name="coverFooter">
               <xsl:with-param name="caller">insertCoverPageFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertLegalPageFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="legalpage-footer">
         <fo:block xsl:use-attribute-sets="__coverpage__footer">
            <xsl:call-template name="legalFooter">
               <xsl:with-param name="caller">insertLegalPageFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertFrontMatterLastFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="last-frontmatter-footer">
         <fo:block xsl:use-attribute-sets="__body__last__footer">
            <xsl:call-template name="lastFooter">
               <xsl:with-param name="caller">insertFrontMatterLastFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertCoverStaticContents">
      <xsl:param name="caller">none</xsl:param>
      <xsl:call-template name="insertCoverPageFooter">
         <xsl:with-param name="caller">insertCoverStaticContents</xsl:with-param>
      </xsl:call-template>
   </xsl:template>

   <xsl:template name="coverFooter">
      <xsl:param name="caller">none</xsl:param>
      <xsl:if test="$SHOWBORDERS = 1">
         <xsl:attribute name="border-color">red</xsl:attribute>
         <xsl:attribute name="border-style">dotted</xsl:attribute>
         <xsl:attribute name="border-width">3pt</xsl:attribute>
      </xsl:if>
      <xsl:if test="$showcallers = 1">
         <fo:block>Caller: <xsl:value-of select="$caller"/></fo:block>
      </xsl:if>
      <fo:block text-align="end" margin-left="0cm" margin-right=".5cm" margin-bottom="3.5cm"
         space-before="0mm" space-after="0mm">
         <fo:external-graphic
            src="url({concat($customizationDir.url, 'Branding/Microchip/Horizontal_logo_w_tagline.png')})"
            height="2cm" content-width="scale-to-fit" content-height="scale-to-fit"/>
      </fo:block>
   </xsl:template>

   <xsl:template name="genericFooter">
      <xsl:param name="caller">none</xsl:param>
      <xsl:if test="$SHOWBORDERS = 1">
         <xsl:attribute name="border-color">green</xsl:attribute>
         <xsl:attribute name="border-style">dotted</xsl:attribute>
         <xsl:attribute name="border-width">3pt</xsl:attribute>
      </xsl:if>
      <xsl:if test="$showcallers = 1">
         <fo:block>Caller: <xsl:value-of select="$caller"/></fo:block>
      </xsl:if>
      <fo:block text-align="end" margin-left="-.5cm" space-before="0mm" space-after="0mm"
         margin-right="0mm">
         <fo:table width="17.5cm" display-align="before"
            border-top-color="{$title.border.font.color}" border-top-style="solid"
            border-top-width="1pt">
            <xsl:if test="$SHOWBORDERS = 1">
               <xsl:attribute name="border-color">yellow</xsl:attribute>
               <xsl:attribute name="border-style">dashed</xsl:attribute>
               <xsl:attribute name="border-width">1pt</xsl:attribute>
            </xsl:if>
            <fo:table-column column-width="2cm"/>
            <fo:table-column column-width="13.5cm"/>
            <fo:table-column column-width="2cm"/>
            <fo:table-body>
               <fo:table-row>
                  <fo:table-cell>
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">red</xsl:attribute>
                        <xsl:attribute name="border-style">solid</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:block/>
                  </fo:table-cell>
                  <fo:table-cell text-align="center" padding-before="3mm" padding-after="8mm">
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">blue</xsl:attribute>
                        <xsl:attribute name="border-style">solid</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:block font-family="{$header.font.family}" font-size="{$footer.font.size}"
                        color="{$header.font.color}" hyphenate="false">
                        <xsl:choose>
                           <xsl:when test="//pmc_iso[1]/pmc_footertext">
                              <xsl:value-of select="//pmc_iso[1]/pmc_footertext"/>
                              <xsl:text> </xsl:text>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:call-template name="insertVariable">
                                 <xsl:with-param name="theVariableID" select="'PMCInternalFooter'"/>
                              </xsl:call-template>
                           </xsl:otherwise>
                        </xsl:choose>
                        <xsl:if test="//pmc_iso[1]/pmc_productnumber">
                           <xsl:text>  </xsl:text>
                           <xsl:value-of select="//pmc_iso[1]/pmc_productnumber"/>
                           <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:if test="//pmc_iso[1]/agile_part_number">
                           <xsl:text>  </xsl:text>
                           <xsl:value-of select="//pmc_iso[1]/agile_part_number"/>
                           <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:if test="//pmc_iso[1]/pmc_doc_type">
                           <xsl:text>  </xsl:text>
                           <xsl:value-of select="//pmc_iso[1]/pmc_doc_type"/>
                           <xsl:text> </xsl:text>
                        </xsl:if>
                        <xsl:if test="//pmc_iso[1]/issuenum | //pmc_iso[1]/pmc_issuenum">
                           <xsl:text> </xsl:text>
                           <fo:inline hyphenate="false" wrap-option="no-wrap">
                              <xsl:call-template name="insertVariable">
                                 <xsl:with-param name="theVariableID" select="'PMCIssueNumber'"/>
                              </xsl:call-template>
                              <xsl:text> </xsl:text>
                              <xsl:value-of
                                 select="//pmc_iso[1]/issuenum | //pmc_iso[1]/pmc_issuenum"/>
                           </fo:inline>
                        </xsl:if>
                     </fo:block>
                  </fo:table-cell>
                  <fo:table-cell text-align="end" margin-left="0cm" space-before="0mm"
                     space-after="0mm" margin-right="0mm">
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">green</xsl:attribute>
                        <xsl:attribute name="border-style">solid</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:block text-align="right" margin-left="0cm" space-before="0mm"
                        space-after="0mm" margin-right="0mm" padding-before="3mm"
                        padding-after="8mm">
                        <fo:page-number/>
                     </fo:block>
                  </fo:table-cell>
               </fo:table-row>
            </fo:table-body>
         </fo:table>
      </fo:block>
   </xsl:template>

   <xsl:template name="lastFooter">
      <xsl:param name="caller">none</xsl:param>
      <xsl:if test="$SHOWBORDERS = 1">
         <xsl:attribute name="border-color">yellow</xsl:attribute>
         <xsl:attribute name="border-style">dotted</xsl:attribute>
         <xsl:attribute name="border-width">3pt</xsl:attribute>
      </xsl:if>
      <xsl:if test="$showcallers = 1">
         <fo:block>Caller: <xsl:value-of select="$caller"/></fo:block>
      </xsl:if>
      <fo:block text-align="end" margin-left="-.5cm" space-before="0mm" space-after="0mm"
         margin-right="0mm">
         <fo:table width="17.5cm" display-align="before"
            border-top-color="{$title.border.font.color}" border-top-style="solid"
            border-top-width="1pt">
            <xsl:if test="$SHOWBORDERS = 1">
               <xsl:attribute name="border-color">yellow</xsl:attribute>
               <xsl:attribute name="border-style">dashed</xsl:attribute>
               <xsl:attribute name="border-width">1pt</xsl:attribute>
            </xsl:if>
            <fo:table-column column-width="2cm"/>
            <fo:table-column column-width="13.5cm"/>
            <fo:table-column column-width="2cm"/>
            <fo:table-body>
               <fo:table-row>
                  <fo:table-cell>
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">red</xsl:attribute>
                        <xsl:attribute name="border-style">solid</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:block/>
                  </fo:table-cell>
                  <fo:table-cell text-align="center" padding-before="3mm" padding-after="8mm">
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">blue</xsl:attribute>
                        <xsl:attribute name="border-style">solid</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:block font-family="{$header.font.family}" font-size="{$footer.font.size}"
                        color="{$header.font.color}" hyphenate="false">
                        <fo:inline>
                           <xsl:choose>
                              <xsl:when
                                 test="string-length(normalize-space(//pmc_iso[1]/pmc_footertext[1]))  &gt; 0 ">
                                 <xsl:value-of select="//pmc_iso[1]/pmc_footertext[1]"/>
                              </xsl:when>
                              <xsl:otherwise>
                                 <xsl:call-template name="insertVariable">
                                    <xsl:with-param name="theVariableID"
                                       select="'PMCInternalFooter'"/>
                                 </xsl:call-template>
                              </xsl:otherwise>
                           </xsl:choose>
                           <xsl:if
                              test="string-length(normalize-space(//pmc_iso[1]/pmc_document_id[1])) &gt; 0">
                              <xsl:text>  </xsl:text>
                              <xsl:call-template name="insertVariable">
                                 <xsl:with-param name="theVariableID" select="'PMCDocumentNumber'"/>
                              </xsl:call-template>
                              <xsl:value-of select="//pmc_iso[1]/pmc_document_id[1]"/>
                           </xsl:if>
                           <xsl:if
                              test="(string-length(normalize-space(//pmc_iso[1]/issuenum[1])) &gt; 0) or (string-length(normalize-space(//pmc_iso[1]/pmc_issuenum[1])) &gt; 0)"
                              > , <xsl:call-template name="insertVariable">
                                 <xsl:with-param name="theVariableID" select="'PMCIssueNumber'"/>
                              </xsl:call-template><xsl:text> </xsl:text><xsl:value-of
                                 select="//pmc_iso[1]/issuenum[1] | //pmc_iso[1]/pmc_issuenum[1]"/>
                           </xsl:if>
                        </fo:inline>
                     </fo:block>
                  </fo:table-cell>
                  <fo:table-cell text-align="end" margin-left="0cm" space-before="0mm"
                     space-after="0mm" margin-right="0mm">
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">green</xsl:attribute>
                        <xsl:attribute name="border-style">solid</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:block text-align="right" margin-left="0cm" space-before="0mm"
                        space-after="0mm" margin-right="0mm" padding-before="3mm"
                        padding-after="8mm">
                        <fo:page-number/>
                     </fo:block>
                  </fo:table-cell>
               </fo:table-row>
            </fo:table-body>
         </fo:table>
      </fo:block>
   </xsl:template>



   <xsl:template name="legalFooter">
      <xsl:param name="caller">none</xsl:param>
      <xsl:if test="$SHOWBORDERS = 1">
         <xsl:attribute name="border-color">blue</xsl:attribute>
         <xsl:attribute name="border-style">dotted</xsl:attribute>
         <xsl:attribute name="border-width">3pt</xsl:attribute>
      </xsl:if>
      <xsl:if test="$showcallers = 1">
         <fo:block>Caller: <xsl:value-of select="$caller"/></fo:block>
      </xsl:if>
      <fo:block text-align="end" margin-left="-.5cm" space-before="0mm" space-after="0mm"
         margin-right="0mm">
         <fo:table display-align="before" width="17cm">
            <xsl:if test="$SHOWBORDERS = 1">
               <xsl:attribute name="border-color">yellow</xsl:attribute>
               <xsl:attribute name="border-style">dashed</xsl:attribute>
               <xsl:attribute name="border-width">1pt</xsl:attribute>
            </xsl:if>
            <fo:table-column column-width="2cm"/>
            <fo:table-column column-width="15cm"/>
            <fo:table-body>
               <fo:table-row>
                  <fo:table-cell text-align="right" padding-before="3mm" padding-after="8mm">
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">blue</xsl:attribute>
                        <xsl:attribute name="border-style">solid</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:block font-family="{$header.font.family}" font-size="{$footer.font.size}"
                        color="{$header.font.color}" hyphenate="false"> </fo:block>
                  </fo:table-cell>
                  <fo:table-cell text-align="end" margin-left="0cm" space-before="0mm"
                     space-after="0mm" margin-right="0mm">
                     <xsl:if test="$SHOWBORDERS = 1">
                        <xsl:attribute name="border-color">green</xsl:attribute>
                        <xsl:attribute name="border-style">solid</xsl:attribute>
                        <xsl:attribute name="border-width">1pt</xsl:attribute>
                     </xsl:if>
                     <fo:block text-align="right" margin-left="0cm" space-before="0mm"
                        space-after="0mm" margin-right="0mm" padding-before="3mm"
                        padding-after="8mm">
                        <fo:block font-family="{$header.font.family}"
                           font-size="{$footer.font.size}" color="{$header.font.color}"
                           hyphenate="false">
                           <fo:inline>
                              <xsl:choose>
                                 <xsl:when
                                    test="string-length(normalize-space(//pmc_iso[1]/pmc_footertext[1]))  &gt; 0 ">
                                    <xsl:value-of select="//pmc_iso[1]/pmc_footertext[1]"/>
                                 </xsl:when>
                                 <xsl:otherwise>
                                    <xsl:call-template name="insertVariable">
                                       <xsl:with-param name="theVariableID"
                                          select="'PMCInternalFooter'"/>
                                    </xsl:call-template>
                                 </xsl:otherwise>
                              </xsl:choose>
                              <xsl:if
                                 test="string-length(normalize-space(//pmc_iso[1]/pmc_document_id[1])) &gt; 0">
                                 <xsl:text>  </xsl:text>
                                 <xsl:call-template name="insertVariable">
                                    <xsl:with-param name="theVariableID"
                                       select="'PMCDocumentNumber'"/>
                                 </xsl:call-template>
                                 <xsl:value-of select="//pmc_iso[1]/pmc_document_id[1]"/>
                              </xsl:if>
                              <xsl:if
                                 test="(string-length(normalize-space(//pmc_iso[1]/issuenum[1])) &gt; 0) or (string-length(normalize-space(//pmc_iso[1]/pmc_issuenum[1])) &gt; 0)"
                                 > , <xsl:call-template name="insertVariable">
                                    <xsl:with-param name="theVariableID" select="'PMCIssueNumber'"/>
                                 </xsl:call-template><xsl:text> </xsl:text><xsl:value-of
                                    select="//pmc_iso[1]/issuenum[1] | //pmc_iso[1]/pmc_issuenum[1]"
                                 />
                              </xsl:if>
                           </fo:inline>
                        </fo:block>
                     </fo:block>
                  </fo:table-cell>
               </fo:table-row>
            </fo:table-body>
         </fo:table>
      </fo:block>
   </xsl:template>

   <xsl:template name="insertLegalOddFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="odd-legal-footer">
         <fo:block xsl:use-attribute-sets="__body__odd__footer">
            <xsl:call-template name="legalFooter">
               <xsl:with-param name="caller">insertLegalOddFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertFrontMatterOddFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="odd-frontmatter-footer">
         <fo:block xsl:use-attribute-sets="__body__odd__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertFrontMatterOddFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertFrontMatterEvenFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="even-frontmatter-footer">
         <fo:block xsl:use-attribute-sets="__body__even__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertFrontMatterEvenFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertLegalEvenFooter">
      <xsl:param name="caller">nothing</xsl:param>
      <fo:static-content flow-name="even-legal-footer">
         <fo:block xsl:use-attribute-sets="__body__even__footer">
            <xsl:call-template name="legalFooter">
               <xsl:with-param name="caller"
                  >insertLegalEvenFooter&gt;insertLegalEvenFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBodyFirstFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="first-body-footer">
         <fo:block xsl:use-attribute-sets="__body__first__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBodyLastFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="last-body-footer">
         <fo:block xsl:use-attribute-sets="__body__last__footer">
            <xsl:call-template name="lastFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBodyOddFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="odd-body-footer">
         <fo:block xsl:use-attribute-sets="__body__odd__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBodyEvenFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="even-body-footer">
         <fo:block xsl:use-attribute-sets="__body__even__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertTocOddFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="odd-toc-footer">
         <fo:block xsl:use-attribute-sets="__toc__odd__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertTocEvenFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="even-toc-footer">
         <fo:block xsl:use-attribute-sets="__toc__even__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertIndexOddFooter">
      <fo:static-content flow-name="odd-index-footer">
         <fo:block xsl:use-attribute-sets="__index__odd__footer">
            <xsl:call-template name="genericFooter"/>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertIndexEvenFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="even-index-footer">
         <fo:block xsl:use-attribute-sets="__index__even__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertPrefaceFirstFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="first-body-footer">
         <fo:block xsl:use-attribute-sets="__body__first__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertPrefaceLastFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="last-body-footer">
         <fo:block xsl:use-attribute-sets="__body__last__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertPrefaceOddFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="odd-body-footer">
         <fo:block xsl:use-attribute-sets="__body__odd__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertPrefaceEvenFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="even-body-footer">
         <fo:block xsl:use-attribute-sets="__body__even__footer">
            <!--<xsl:call-template name="getVariable">
               <xsl:with-param name="id" select="'Preface even footer'"/>
               <xsl:with-param name="params">
                  <heading>
                     <fo:inline xsl:use-attribute-sets="__body__even__footer__heading">
                        <fo:retrieve-marker retrieve-class-name="current-header"/>
                     </fo:inline>
                  </heading>
                  <pagenum>
                     <fo:inline xsl:use-attribute-sets="__body__even__footer__pagenum">
                        <fo:page-number/>
                     </fo:inline>
                  </pagenum>
               </xsl:with-param>
            </xsl:call-template>-->
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBackCoverOddFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="odd-back-cover-footer">
         <fo:block xsl:use-attribute-sets="__body__odd__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertBackCoverEvenFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="even-back-cover-footer">
         <fo:block xsl:use-attribute-sets="__body__even__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertGlossaryOddFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="odd-glossary-footer">
         <fo:block xsl:use-attribute-sets="__glossary__odd__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

   <xsl:template name="insertGlossaryEvenFooter">
      <xsl:param name="caller">none</xsl:param>
      <fo:static-content flow-name="even-glossary-footer">
         <fo:block xsl:use-attribute-sets="__glossary__even__footer">
            <xsl:call-template name="genericFooter">
               <xsl:with-param name="caller">insertBodyFirstFooter</xsl:with-param>
            </xsl:call-template>
         </fo:block>
      </fo:static-content>
   </xsl:template>

</xsl:stylesheet>

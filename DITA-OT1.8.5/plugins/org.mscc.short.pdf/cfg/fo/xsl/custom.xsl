<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:import href="../layout-masters.xsl"/>

    <xsl:import href="toc.xsl"/>
    
    <xsl:import href="bookmarks.xsl"/>

    <xsl:import href="flag-rules.xsl"/>

    <xsl:import href="lot-lof.xsl"/>

    <xsl:import href="pr-domain.xsl"/>

    <xsl:import href="preface.xsl"/>

    <xsl:import href="comments-processing.xsl"/>

    <xsl:import href="crs-reg-processing.xsl"/>

    <xsl:import href="commons.xsl"/>

    <xsl:import href="pagebreak-processing.xsl"/>

    <xsl:import href="tables.xsl"/>

    <xsl:import href="hyphenate-table-entries.xsl"/>

    <xsl:import href="resize-type.xsl"/>

    <xsl:import href="color-table-backgrounds.xsl"/>

    <xsl:import href="rotate-table-entries.xsl"/>

    <xsl:import href="root-processing.xsl"/>

    <xsl:import href="frontmatter.xsl"/>

    <xsl:import href="static-content.xsl"/>

    <xsl:import href="lists.xsl"/>

    <xsl:import href="revision-history.xsl"/>

    <xsl:template name="createLegal">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="12cm"
            margin-left="-2.5cm" space-before.optimum="1em" space-before.maximum="2em"
            space-after.minimum="0.5em" space-after.optimum="1em" space-after.maximum="2em"
            keep-together.within-column="always" break-before="page" hyphenate="false">

            <fo:table xmlns:fo="http://www.w3.org/1999/XSL/Format"
                border-before-width.conditionality="retain" border-collapse="collapse"
                table-layout="fixed">
                <fo:table-column column-number="1" column-width="5.5cm"/>
                <fo:table-column column-number="2" column-width="12cm"/>
                <fo:table-body end-indent="0pt" start-indent="0pt">
                    <fo:table-row keep-with-next.within-column="always">
                        <fo:table-cell padding-left="0mm" padding-right="3mm" padding-top="0mm"
                            padding-bottom="0mm" text-align="justify" vertical-align="top"
                            number-rows-spanned="2" border-right-style="solid"
                            border-right-color="{$title.font.color}" border-right-width=".5pt">
                            <fo:block text-align="center" margin-bottom="5mm">
                                <fo:external-graphic
                                    src="url({concat($customizationDir.url, 'Branding/Microchip/Horizontal_logo_w_tagline.png')})"
                                    width="5cm" content-width="scale-to-fit"
                                    content-height="scale-to-fit"/>
                            </fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always"
                                font-weight="bold">Microsemi Corporate Headquarters</fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">One
                                Enterprise, Aliso Viejo,</fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">CA 92656
                                USA</fo:block>

                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always"
                                padding-top="4mm">Within the USA: +1 (800) 713-4113 </fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">Outside
                                the USA: +1 (949) 380-6100</fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">Fax: +1
                                (949) 215-4996</fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">Email:
                                    <fo:inline color="{$title.font.color}"
                                    >sales.support@microsemi.com</fo:inline></fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">
                                <fo:inline color="{$title.font.color}">www.microsemi.com</fo:inline>
                            </fo:block>

                            <fo:block space-before.optimum="1em" space-before.minimum="0.8em"
                                space-before.maximum="1.2em" font-size="8pt"
                                font-family="{$legal.font.family}">© <xsl:choose><xsl:when
                                        test="//pmc_copyright_year[1]"><xsl:value-of
                                            select="//pmc_copyright_year[1]"
                                            /></xsl:when><xsl:otherwise><xsl:call-template
                                            name="getDateYear"/></xsl:otherwise></xsl:choose>
                                Microsemi Corporation. All rights reserved. Microsemi and the
                                Microsemi logo are trademarks of Microsemi Corporation. All other
                                trademarks and service marks are the property of their respective
                                owners.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="3mm" padding-right="0mm" padding-top="0mm"
                            padding-bottom="3mm" border-bottom-width="0.5pt"
                            border-bottom-style="solid" border-bottom-color="{$title.font.color}"
                            vertical-align="top">
                            <fo:block text-align="justify" font-size="8.5pt"
                                font-family="{$legal.font.family}"> Microsemi makes no warranty,
                                representation, or guarantee regarding the information contained
                                herein or the suitability of its products and services for any
                                particular purpose, nor does Microsemi assume any liability
                                whatsoever arising out of the application or use of any product or
                                circuit. The products sold hereunder and any other products sold by
                                Microsemi have been subject to limited testing and should not be
                                used in conjunction with mission-critical equipment or applications.
                                Any performance specifications are believed to be reliable but are
                                not verified, and Buyer must conduct and complete all performance
                                and other testing of the products, alone and together with, or
                                installed in, any end-products. Buyer shall not rely on any data and
                                performance specifications or parameters provided by Microsemi. It
                                is the Buyer's responsibility to independently determine suitability
                                of any products and to test and verify the same. The information
                                provided by Microsemi hereunder is provided "as is, where is" and
                                with all faults, and the entire risk associated with such
                                information is entirely with the Buyer. Microsemi does not grant,
                                explicitly or implicitly, to any party any patent rights, licenses,
                                or any other IP rights, whether with regard to such information
                                itself or anything described by such information. Information
                                provided in this document is proprietary to Microsemi, and Microsemi
                                reserves the right to make any changes to the information in this
                                document or to any products and services at any time without
                                notice.</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding-left="3mm" padding-right="0mm" padding-top="3mm"
                            padding-bottom="0mm" vertical-align="top">

                            <fo:block text-align="justify" font-size="10pt"
                                font-family="{$legal.font.family}"> Microsemi Corporation (Nasdaq:
                                MSCC) offers a comprehensive portfolio of semiconductor and system
                                solutions for aerospace &amp; defense, communications, data center
                                and industrial markets. Products include high-performance and
                                radiation-hardened analog mixed-signal integrated circuits, FPGAs,
                                SoCs and ASICs; power management products; timing and
                                synchronization devices and precise time solutions, setting the
                                world's standard for time; voice processing devices; RF solutions;
                                discrete components; enterprise storage and communication solutions;
                                security technologies and scalable anti-tamper products; Ethernet
                                solutions; Power-over-Ethernet ICs and midspans; as well as custom
                                design capabilities and services. Microsemi is headquartered in
                                Aliso Viejo, California, and has approximately 4,800 employees
                                globally. Learn more at <fo:inline font-weight="bold"
                                    >www.microsemi.com</fo:inline>.</fo:block>
                            <fo:block text-align="right" font-size="8.5pt"
                                font-family="{$legal.font.family}">
                                <xsl:value-of select="$pmc_iso[1]/pmc_document_id"/>
                            </fo:block>

                            <xsl:choose>
                                <xsl:when test="//bookmeta[1]/pmc_iso[1]/pmc_patents/p">
                                    <xsl:for-each select="//bookmeta[1]/pmc_iso[1]/pmc_patents/p">
                                        <fo:block space-before.optimum="1em"
                                            space-before.minimum="0.8em"
                                            space-before.maximum="1.2em" text-align="left"
                                            keep-with-next.within-page="always"
                                            font-size="{$legal.font.size}"
                                            font-family="{$legal.font.family}">
                                            <xsl:apply-templates/>
                                        </fo:block>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise> </xsl:otherwise>
                            </xsl:choose>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class,' topic/ph ')][@text_color]">
        <fo:inline>
            <xsl:attribute name="color" select="@text_color"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template name="insertBookTitle">
        <xsl:variable name="chapters"
            select="/bookmap/descendant::notices | /bookmap/descendant::preface  | /bookmap/descendant::chapter"/>
        <xsl:choose>
            <xsl:when test="$chapters[1]/@id = self::*/@id">
                <xsl:choose>
                    <xsl:when
                        test="string-length(normalize-space($pmc_iso[1]/pmc_subtitle[1]/text())) &gt; 1">
                        <fo:block xsl:use-attribute-sets="book-title-header-w-subtitle">
                            <xsl:value-of select="$pmc_iso[1]/pmc_title[1]/text()"/>
                        </fo:block>
                        <fo:block xsl:use-attribute-sets="book-subtitle-header">
                            <xsl:value-of select="$pmc_iso[1]/pmc_subtitle[1]/text()"/>
                        </fo:block>
                    </xsl:when>
                    <xsl:otherwise>
                        <fo:block xsl:use-attribute-sets="book-title-header">
                            <xsl:value-of select="$pmc_iso[1]/pmc_title[1]/text()"/>
                        </fo:block>
                    </xsl:otherwise>
                </xsl:choose>

            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>

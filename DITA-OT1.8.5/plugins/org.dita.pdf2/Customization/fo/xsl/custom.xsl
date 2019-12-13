<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:opentopic="http://www.idiominc.com/opentopic" xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">

    <xsl:import href="../layout-masters.xsl"/>

    <xsl:import href="toc.xsl"/>

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

    <xsl:import href="links.xsl"/>

    <xsl:import href="revision-history.xsl"/>

    <xsl:import href="excel3/testexcel.xsl"/>

    <!--  make it possible to prevent a word from hyphenating -->

    <xsl:template match="*[contains(@class, ' topic/ph ')][@otherprops = 'no_break']">
        <fo:inline hyphenate="false" keep-together.within-line="always">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>


    <xsl:template name="createLegal">
        <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" margin-top="11.5cm"
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
                                font-weight="bold">Microsemi</fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">2355 W.
                                Chandler Blvd.</fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">Chandler,
                                AZ</fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">Chandler,
                                AZ 85224 USA </fo:block>

                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always"
                                padding-top="4mm">Within the USA: +1 (480) 792-7200</fo:block>
                            <fo:block font-size="{$legal.font.size}" text-align="left"
                                font-family="{$legal.font.family}" keep-together="always">Fax: +1
                                (480) 792-7277</fo:block>
                            
                            <fo:block space-before.optimum="1em" space-before.minimum="0.8em"
                                space-before.maximum="1.2em" font-size="8pt"
                                font-family="{$legal.font.family}">
                                www.microsemi.com © <xsl:choose><xsl:when
                                    test="//pmc_copyright_year[1]"><xsl:value-of
                                        select="//pmc_copyright_year[1]"
                                    /></xsl:when><xsl:otherwise><xsl:call-template
                                        name="getDateYear"/></xsl:otherwise></xsl:choose> Microsemi and its corporate affiliates. All
                                rights reserved. Microsemi and the Microsemi logo are trademarks of
                                Microsemi Corporation and its corporate affiliates. All other
                                trademarks and service marks are the property of their respective
                                owners.</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding-left="3mm" padding-right="0mm" padding-top="0mm"
                            padding-bottom="3mm" border-bottom-width="0.5pt"
                            border-bottom-style="solid" border-bottom-color="{$title.font.color}"
                            vertical-align="top">
                            <fo:block text-align="justify" font-size="8pt"
                                font-family="{$legal.font.family}"> Microsemi's product warranty is
                                set forth in Microsemi's Sales Order Terms and Conditions.
                                Information contained in this publication is provided for the sole
                                purpose of designing with and using Microsemi products. Information
                                regarding device applications and the like is provided only for your
                                convenience and may be superseded by updates. Buyer shall not rely
                                on any data and performance specifications or parameters provided by
                                Microsemi. It is your responsibility to ensure that your application
                                meets with your specifications. THIS INFORMATION IS PROVIDED "AS
                                IS." MICROSEMI MAKES NO REPRESENTATIONS OR WARRANTIES OF ANY KIND
                                WHETHER EXPRESS OR IMPLIED, WRITTEN OR ORAL, STATUTORY OR OTHERWISE,
                                RELATED TO THE INFORMATION, INCLUDING BUT NOT LIMITED TO ITS
                                CONDITION, QUALITY, PERFORMANCE, NON-INFRINGEMENT, MERCHANTABILITY
                                OR FITNESS FOR A PARTICULAR PURPOSE. IN NO EVENT WILL MICROSEMI BE
                                LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, INCIDENTAL OR
                                CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE WHATSOEVER RELATED TO
                                THIS INFORMATION OR ITS USE, HOWEVER CAUSED, EVEN IF MICROSEMI HAS
                                BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO
                                THE FULLEST EXTENT ALLOWED BY LAW, MICROSEMI’S TOTAL LIABILITY ON
                                ALL CLAIMS IN RELATED TO THIS INFORMATION OR ITS USE WILL NOT EXCEED
                                THE AMOUNT OF FEES, IF ANY, YOU PAID DIRECTLY TO MICROSEMI FOR THIS
                                INFORMATION. Use of Microsemi devices in life support,
                                mission-critical equipment or applications, and/or safety
                                applications is entirely at the buyer’s risk, and the buyer agrees
                                to defend and indemnify Microsemi from any and all damages, claims,
                                suits, or expenses resulting from such use. No licenses are
                                conveyed, implicitly or otherwise, under any Microsemi intellectual
                                property rights unless otherwise stated.</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row>
                        <fo:table-cell padding-left="3mm" padding-right="0mm" padding-top="3mm"
                            padding-bottom="0mm" vertical-align="top">

                            <fo:block text-align="justify" font-size="10pt"
                                font-family="{$legal.font.family}"> Microsemi Corporation, a
                                subsidiary of Microchip Technology Inc. (Nasdaq: MCHP), and its
                                corporate affiliates are leading providers of smart, connected and
                                secure embedded control solutions. Their easy-to-use development
                                tools and comprehensive product portfolio enable customers to create
                                optimal designs which reduce risk while lowering total system cost
                                and time to market. These solutions serve more than 120,000
                                customers across the industrial, automotive, consumer, aerospace and
                                defense, communications and computing markets. Headquartered in
                                Chandler, Arizona, the company offers outstanding technical support
                                along with dependable delivery and quality. Learn more at <fo:inline
                                    font-weight="bold">www.microsemi.com</fo:inline>.</fo:block>
                            <fo:block text-align="right" font-size="8.5pt"
                                font-family="{$legal.font.family}">
                                <xsl:value-of select="$pmc_iso[1]/pmc_document_id[1]"/>
                            </fo:block>

                            <!--<xsl:choose>
                                <xsl:when test="//bookmeta[1]/pmc_iso[1]/pmc_patents/p">
                                    <xsl:for-each select="//bookmeta[1]/pmc_iso[1]/pmc_patents/p">
                                        <fo:block space-before.optimum="1em" space-before.minimum="0.8em" space-before.maximum="1.2em" text-align="left" keep-with-next.within-page="always" font-size="{$legal.font.size}" font-family="{$legal.font.family}">
                                            <xsl:apply-templates/>
                                        </fo:block>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>                                  
                                </xsl:otherwise>
                            </xsl:choose>-->
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/ph ')][@text_color]">
        <fo:inline>
            <xsl:attribute name="color" select="@text_color"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <!-- Adaptations for csr-reg elements -->

    <xsl:template match="*[contains(@class, ' csrreg-d/csrreg-instances ')]">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' csrreg-d/instance-start ')]">
        <fo:inline>[ <xsl:value-of select="."/> : </fo:inline>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' csrreg-d/instance-stop ')]">
        <fo:inline><xsl:value-of select="."/> ]</fo:inline>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' csrreg-d/csrreg-offset ')]">
        <fo:inline>_<xsl:value-of select="."/></fo:inline>
    </xsl:template>


    <!-- m-software-d changes -->

    <xsl:template
        match="*[contains(@class, ' topic/tbody ')]/*[contains(@class, ' m-software-d/register-reference ')]">
        <fo:table-row xsl:use-attribute-sets="tbody.row">
            <xsl:call-template name="commonattributes"/>
            <xsl:if test="descendant::*[contains(@class, ' m-software-d/address-prefix ')]">
                <xsl:attribute name="background-color">#87CEFA</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </fo:table-row>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' m-software-d/address-prefix ')]">
        <fo:inline xsl:use-attribute-sets="b">Prefix: </fo:inline>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' m-software-d/instances ')]">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' m-software-d/instance ')]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template
        match="*[contains(@class, ' topic/tbody ')]/*[contains(@class, ' m-software-d/field ')]/*[contains(@class, ' m-software-d/field-type ')]">
        <fo:table-cell xsl:use-attribute-sets="tbody.row.entry">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="rotate_entry"/>
            <xsl:call-template name="applySpansAttrs"/>
            <xsl:call-template name="applyAlignAttrs"/>
            <xsl:call-template name="generateTableEntryBorder"/>
            <xsl:call-template name="findBackgroundColor"/>
            <fo:block xsl:use-attribute-sets="tbody.row.entry__content">
                <xsl:call-template name="processEntryContent"/>
                <xsl:if test="@sticky = 'yes'">
                    <fo:block xsl:use-attribute-sets="b">STICKY</fo:block>
                </xsl:if>
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <!--saratoga specification handling-->

    <xsl:template match="*[contains(@class, ' pr-d/apiname ')][@specification]">
        <fo:inline xsl:use-attribute-sets="apiname-generic">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' pr-d/apiname ')][@specification = 'PCIe_Base_Spec']">
        <fo:inline xsl:use-attribute-sets="apiname-PCIe_Base_Spec_4">
            <xsl:call-template name="commonattributes"/>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <!-- attributes -->

    <xsl:attribute-set name="apiname-PCIe_Base_Spec_4">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * .9"/>pt </xsl:attribute>
        <xsl:attribute name="color">#b642f4</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="apiname-generic">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * .9"/>pt </xsl:attribute>
        <xsl:attribute name="color">#41cdf4</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>

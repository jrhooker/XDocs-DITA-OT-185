<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
    xmlns:dita2html="http://dita-ot.sourceforge.net/ns/200801/dita2html"
    xmlns:ditamsg="http://dita-ot.sourceforge.net/ns/200704/ditamsg"
    xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="dita-ot dita2html ditamsg exsl">

    <xsl:template match="*[contains(@class, ' firmware-d/reg-address ')]/text()">
        <div class="reg-address">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' firmware-d/reg-size ')]/text()">
        <div class="reg-size">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' firmware-d/reg-name ')]/text()">
        <div class="reg-name">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' struct-d/msg-name-main ')]/text()">
        <div class="msg-name-main">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' struct-d/value ')]/text()">
        <div class="value">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' struct-d/double ')]/text()">
        <div class="double">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' struct-d/single ')]/text()">
        <div class="single">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' m-software-d/field-type ')]/text()">
        <div class="field-type">
            <xsl:value-of select="." />
            <xsl:if test="parent::*[contains(@class, ' m-software-d/field-type ')]/@sticky = 'yes'"><sup>STICKY</sup></xsl:if>
        </div>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' m-software-d/address ')]/text()">
        <div class="address">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
   
    <!-- Adaptations for csr-reg elements -->

    <xsl:template match="*[contains(@class, ' csrreg-d/csrreg-instances ')]">
        <div class="csrreg-instances">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' csrreg-d/instance-start ')]">
        <span class="instance-start">[ <xsl:value-of select="."/> : </span>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' csrreg-d/instance-stop ')]">
        <span class="instance-stop"><xsl:value-of select="."/> ]</span>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' csrreg-d/csrreg-offset ')]">
        <span class="csrreg-offset">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <xsl:template match="*[contains(@class,' struct-d/msb ')]">
        <span class="msb">
            <xsl:apply-templates/>
        </span>
        <span>
            <xsl:text>:</xsl:text>
        </span>
    </xsl:template>

    <xsl:template match="*[contains(@class,' struct-d/lsb ')]">
        <span class="lsb">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="*[contains(@class,' m-software-d/desc-title ')]">
        <div class="desc-title">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="*[contains(@class,' m-software-d/field-enum-name ')]">
        <span class="bracket">
            <xsl:text> [  </xsl:text>
        </span>
        <span class="field-enum-name">
            <xsl:call-template name="commonattributes"/>
            <xsl:attribute name="font-size">8pt</xsl:attribute>
            <xsl:apply-templates/>
        </span>
        <span class="bracket">
            <xsl:text>  ] </xsl:text>
        </span>
    </xsl:template>

</xsl:stylesheet>

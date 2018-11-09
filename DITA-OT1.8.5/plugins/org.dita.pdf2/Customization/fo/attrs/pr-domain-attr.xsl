<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">


    <xsl:attribute-set name="codeph">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="pre">
        <xsl:attribute name="border-color">white</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">0pt</xsl:attribute>
        <xsl:attribute name="space-before">1.2em</xsl:attribute>
        <xsl:attribute name="space-after">0.8em</xsl:attribute>
        <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
        <xsl:attribute name="white-space-collapse">false</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
        <xsl:attribute name="background-color">#ffffff</xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="line-height">106%</xsl:attribute>
        <xsl:attribute name="color">#000000</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"
            />pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>

    </xsl:attribute-set>
    <xsl:attribute-set name="codeblock__top">
        <xsl:attribute name="leader-pattern">rule</xsl:attribute>
        <xsl:attribute name="leader-length">100%</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="codeblock__bottom">
        <xsl:attribute name="leader-pattern">rule</xsl:attribute>
        <xsl:attribute name="leader-length">100%</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="option"> </xsl:attribute-set>

    <xsl:attribute-set name="var">
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="parmname">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"
            />pt</xsl:attribute>
        <xsl:attribute name="color">#000000</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="synph"> </xsl:attribute-set>

    <xsl:attribute-set name="oper">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="delim">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="sep">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="apiname">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="parml"> </xsl:attribute-set>

    <xsl:attribute-set name="plentry">
       
    </xsl:attribute-set>

    <xsl:attribute-set name="plentry-line-above">
        <xsl:attribute name="border-top-width">1px</xsl:attribute>
        <xsl:attribute name="border-top-color">
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="padding-top">3pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="plentry-even">
        <xsl:attribute name="background-color"/>
        <xsl:attribute name="padding-top">5pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="plentry-first"> </xsl:attribute-set>


    <xsl:attribute-set name="pt">
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * 1.1"
            />pt</xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-indent">0em</xsl:attribute>
        <xsl:attribute name="end-indent">24pt</xsl:attribute>
        
    </xsl:attribute-set>

    <xsl:attribute-set name="pt__content">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="pd">
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
        <xsl:attribute name="space-before">1mm</xsl:attribute>
        <xsl:attribute name="space-after">1mm</xsl:attribute>
        <xsl:attribute name="start-indent">0mm</xsl:attribute>
        <xsl:attribute name="end-indent">0mm</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="synblk"> </xsl:attribute-set>

    <xsl:attribute-set name="synnoteref">
        <xsl:attribute name="baseline-shift">super</xsl:attribute>
        <xsl:attribute name="font-size">75%</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="synnote">
        <xsl:attribute name="baseline-shift">super</xsl:attribute>
        <xsl:attribute name="font-size">75%</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="syntaxdiagram"> </xsl:attribute-set>

    <xsl:attribute-set name="fragment"> </xsl:attribute-set>

    <xsl:attribute-set name="syntaxdiagram.title">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="kwd">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="kwd__default">
        <xsl:attribute name="text-decoration">underline</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="fragref">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>

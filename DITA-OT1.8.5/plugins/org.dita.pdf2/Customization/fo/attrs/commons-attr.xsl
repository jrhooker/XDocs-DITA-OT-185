<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    version="2.0">
    
    <xsl:attribute-set name="section.title">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <!-- Bluestream 19-Nov-2007 : remove heavy border under title name. Note that this not only
             removes the border under the chapter name but also every topic title in the document,
             e.g. Preface, Abstract, etc.-->
        <xsl:attribute name="border-bottom">none</xsl:attribute>       
        <xsl:attribute name="background-color">transparent</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="number($body.font.master) * number(1)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.2)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="number($body.font.master) * number(0.5)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of select="number($body.font.master) * number(.8)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.4)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.optimum">
            <xsl:value-of select="number($body.font.master) * number(1.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.maximum">
            <xsl:value-of select="number($body.font.master) * number(3.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
            <xsl:attribute name="padding-top">
            <xsl:value-of select="number($body.font.master) * number(0.3)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="padding-bottom">
            <xsl:value-of select="number($body.font.master) * number(0.3)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
            <xsl:attribute name="padding-left">
            <xsl:value-of select="number($body.font.master) * number(0.3)"/>
            <xsl:text>pt</xsl:text>
            </xsl:attribute>        
    </xsl:attribute-set>

    <xsl:attribute-set name="example.title">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <!-- Bluestream 19-Nov-2007 : remove heavy border under title name. Note that this not only
             removes the border under the chapter name but also every topic title in the document,
             e.g. Preface, Abstract, etc.-->
        <xsl:attribute name="border-bottom">none</xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$minor.title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.2)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="number($body.font.master) * number(0.2)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of select="number($body.font.master) * number(0.5)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.4)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.optimum">
            <xsl:value-of select="number($body.font.master) * number(1.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.maximum">
            <xsl:value-of select="number($body.font.master) * number(3.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="revision.title">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <!-- Bluestream 19-Nov-2007 : remove heavy border under title name. Note that this not only
             removes the border under the chapter name but also every topic title in the document,
             e.g. Preface, Abstract, etc.-->
        <xsl:attribute name="border-bottom">none</xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$minor.title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.5"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.2)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="number($body.font.master) * number(0.2)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of select="number($body.font.master) * number(0.5)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.4)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.optimum">
            <xsl:value-of select="number($body.font.master) * number(1.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.maximum">
            <xsl:value-of select="number($body.font.master) * number(3.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
    </xsl:attribute-set>
    
    
    
    <xsl:attribute-set name="desc-title">
        <xsl:attribute name="text-indent">0em</xsl:attribute>
        <xsl:attribute name="space-before">0em</xsl:attribute>
        <xsl:attribute name="space-after">0em</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .8"/>pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="p.tables">
        <xsl:attribute name="text-indent">0em</xsl:attribute>
        <xsl:attribute name="space-before">0em</xsl:attribute>
        <xsl:attribute name="space-after">0em</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .8"/>pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">3pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="p.tables.font">
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .8"/>pt</xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$body.font.master * 1"/>pt</xsl:attribute>
        <xsl:attribute name="space-before">0em</xsl:attribute>
        <xsl:attribute name="space-after"><xsl:value-of select="$body.font.master * .2"/>pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="fig">
        <!-- Bluestream 19-Nov-2007 : for centering figures and their titles -->
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
    </xsl:attribute-set>

   <xsl:attribute-set name="fig.title">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$default-font-size"/>
        </xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$minor.title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">5pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__force__page__count">
        <xsl:attribute name="force-page-count">
            <xsl:choose>
                <xsl:when test="name(/*) = 'bookmap'">
                    <xsl:value-of select="'no-force'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'no-force'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:attribute-set> 
    
    <xsl:attribute-set name="navtitle">
        <xsl:attribute name="font-family"><xsl:value-of select="$title.font.family"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="navtitle__label">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="searchtitle">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="searchtitle__label">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="body__toplevel">
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="body__secondLevel">
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="body">
        <xsl:attribute name="margin-left"><xsl:value-of select="$side-col-width"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="section">
        <xsl:attribute name="line-height">12pt</xsl:attribute>
        <xsl:attribute name="space-before">0.6em</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="example">
        <xsl:attribute name="line-height">12pt</xsl:attribute>
        <xsl:attribute name="space-before">0.6em</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="margin-left">0.5in</xsl:attribute>
        <xsl:attribute name="margin-right">0.5in</xsl:attribute>
        <xsl:attribute name="border">thin solid black</xsl:attribute>
        <xsl:attribute name="padding">5pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="desc">
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="prolog">
        <xsl:attribute name="start-indent">72pt</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="p">
        <!--        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>-->       
        <xsl:attribute name="text-indent">0em</xsl:attribute>
        <xsl:attribute name="space-before">0.6em</xsl:attribute>
        <xsl:attribute name="space-after">0.6em</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="lq">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
        <xsl:attribute name="padding-left">6pt</xsl:attribute>
        <xsl:attribute name="start-indent">92pt</xsl:attribute>
        <xsl:attribute name="end-indent">92pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
        <xsl:attribute name="border-width">thin</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="lq_simple">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="space-before">10pt</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
        <xsl:attribute name="padding-left">6pt</xsl:attribute>
        <xsl:attribute name="start-indent">92pt</xsl:attribute>
        <xsl:attribute name="end-indent">92pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
        <xsl:attribute name="border-width">thin</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="lq_link">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
        <xsl:attribute name="end-indent">92pt</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="color">blue</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="lq_title">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
        <xsl:attribute name="end-indent">92pt</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="font-style">italic</xsl:attribute>
    </xsl:attribute-set>
    
  <!-- -->
    
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
        <xsl:attribute name="line-height">105%</xsl:attribute>
        <xsl:attribute name="color">#000000</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="codeblock">
        <xsl:attribute name="border-color">
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">0pt</xsl:attribute>
        <xsl:attribute name="space-before">3mm</xsl:attribute>
        <xsl:attribute name="space-after">3mm</xsl:attribute>
        <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
        <xsl:attribute name="white-space-collapse">false</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$monospace.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="line-height">105%</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .8"/>pt</xsl:attribute>        
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note">
        <xsl:attribute name="space-before">3pt</xsl:attribute>
        <xsl:attribute name="space-after">3pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__table">
        <xsl:attribute name="space-before">0.3em</xsl:attribute>
        <xsl:attribute name="space-after">0em</xsl:attribute>
        <xsl:attribute name="padding-right">24pt</xsl:attribute>
        <xsl:attribute name="margin-right">24pt</xsl:attribute>       
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__image__column">
        <xsl:attribute name="column-number">1</xsl:attribute>
        <xsl:attribute name="column-width">24pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__text__column">
        <xsl:attribute name="column-number">2</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__image__entry">
        <xsl:attribute name="padding-right">5pt</xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__text__entry">
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label">
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
      
    <!-- -->  
    
    <xsl:attribute-set name="__border__all">
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
        <xsl:attribute name="border-width">thin</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="lines">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="space-before">0.8em</xsl:attribute>
        <xsl:attribute name="space-after">0.8em</xsl:attribute>
        <!--        <xsl:attribute name="white-space-treatment">ignore-if-after-linefeed</xsl:attribute>-->
        <xsl:attribute name="white-space-collapse">true</xsl:attribute>
        <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="draft-comment">
        <xsl:attribute name="background-color">#FF99FF</xsl:attribute>
        <xsl:attribute name="color">#CC3333</xsl:attribute>
        <xsl:attribute name="border-style">solid</xsl:attribute>
        <xsl:attribute name="border-color">black</xsl:attribute>
        <xsl:attribute name="border-width">thin</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="fn__body">
        <xsl:attribute name="provisional-distance-between-starts">8mm</xsl:attribute>
        <xsl:attribute name="provisional-label-separation">2mm</xsl:attribute>
        <xsl:attribute name="line-height">1.2</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="start-indent">0pt</xsl:attribute>
    </xsl:attribute-set>
    
    
    <xsl:attribute-set name="__fo__root">
        <xsl:attribute name="font-family"><xsl:value-of select="$body.font.family"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="xml:lang" select="translate($locale, '_', '-')"/>
        <xsl:attribute name="writing-mode" select="$writing-mode"/>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.frontmatter" use-attribute-sets="__force__page__count">
        <xsl:attribute name="format">i</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.cover" use-attribute-sets="__force__page__count">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.legal" use-attribute-sets="__force__page__count">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.notice" use-attribute-sets="__force__page__count">
        <xsl:attribute name="format">i</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.preface" use-attribute-sets="__force__page__count">
        <xsl:attribute name="format">i</xsl:attribute>  
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.toc" use-attribute-sets="__force__page__count">
        <xsl:attribute name="format">i</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.lot" use-attribute-sets="page-sequence.toc">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.lof" use-attribute-sets="page-sequence.toc">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.body" use-attribute-sets="__force__page__count">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.part" use-attribute-sets="__force__page__count">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.appendix" use-attribute-sets="__force__page__count">
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.glossary" use-attribute-sets="__force__page__count">
        <xsl:attribute name="format">i</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="page-sequence.index" use-attribute-sets="__force__page__count">
    </xsl:attribute-set>
    
</xsl:stylesheet>
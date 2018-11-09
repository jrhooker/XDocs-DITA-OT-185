<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    
    <xsl:attribute-set name="topic.title">
        
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        
        <xsl:attribute name="margin-left">-2cm</xsl:attribute>
        <xsl:attribute name="margin-top">0mm</xsl:attribute>       
        <xsl:attribute name="margin-bottom">7pt</xsl:attribute>
        <xsl:attribute name="padding-top">6pt</xsl:attribute>
        <xsl:attribute name="padding-bottom">5pt</xsl:attribute>
        
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$title.border.font.color"/></xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">1pt</xsl:attribute>
        <xsl:attribute name="border-top-color">#ffffff</xsl:attribute>
        
        <xsl:attribute name="color">
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.6"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before">0pt</xsl:attribute>
        <xsl:attribute name="space-after.minimum">0pt</xsl:attribute>
        <xsl:attribute name="space-after.optimum">0pt</xsl:attribute>
        <xsl:attribute name="space-after.maximum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.9)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.optimum">
            <xsl:value-of select="number($body.font.master) * number(1.8)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.maximum">80pt</xsl:attribute>
        
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.title__content">
        <xsl:attribute name="margin-left">2cm</xsl:attribute>
        <xsl:attribute name="line-height">50%</xsl:attribute>
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>        
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="topic.topic.title">
        <xsl:attribute name="text-indent">0cm</xsl:attribute>
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <!-- remove the stock border-->
        <xsl:attribute name="border-bottom">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-color">#ffffff</xsl:attribute>
        <xsl:attribute name="border-bottom-width">0pt</xsl:attribute>
        <!-- border removed. -->
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <xsl:attribute name="color">
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.4"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0pt</xsl:attribute> 
        <xsl:attribute name="padding-top">5mm</xsl:attribute>        
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.title__content">
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>        
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.title">
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
            <xsl:value-of select="$title.font.color"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="font-size">
            <xsl:value-of select="$body.font.master * 1.2"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0pt</xsl:attribute> 
        <xsl:attribute name="padding-top">4mm</xsl:attribute>      
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.title__content"/>

    <xsl:attribute-set name="topic.topic.topic.topic.title">
        <xsl:attribute name="margin-top">4pt</xsl:attribute>
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
            <xsl:value-of select="$body.font.master * 1.1"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0pt</xsl:attribute> 
        <xsl:attribute name="padding-top">4mm</xsl:attribute>      
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.title__content"> </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.title">
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
            <xsl:value-of select="$body.font.master * 1.1"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.minimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-before.minimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0pt</xsl:attribute> 
        <xsl:attribute name="padding-top">4mm</xsl:attribute>      
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.title__content"> </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title">
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
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.optimum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="space-after.maximum">
            <xsl:value-of select="number($body.font.master) * number(0.0)"/>
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
        <xsl:attribute name="space-before.minimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0pt</xsl:attribute> 
        <xsl:attribute name="padding-top">4mm</xsl:attribute> 
    </xsl:attribute-set>

    <xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title__content"> </xsl:attribute-set>

    <xsl:attribute-set name="section.title">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$title.font.family"/>
        </xsl:attribute>
        <!-- Bluestream 19-Nov-2007 : remove heavy border under title name. Note that this not only
             removes the border under the chapter name but also every topic title in the document,
             e.g. Preface, Abstract, etc.-->
        <xsl:attribute name="border-bottom">none</xsl:attribute>       
        <xsl:attribute name="background-color">#d3e7ed</xsl:attribute>
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
        <xsl:attribute name="padding-bottom">
            <xsl:value-of select="number($body.font.master) * number(0.3)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute>
        <xsl:attribute name="padding-left">
            <xsl:value-of select="number($body.font.master) * number(0.3)"/>
            <xsl:text>pt</xsl:text>
        </xsl:attribute> 
               
        <xsl:attribute name="margin-top">0mm</xsl:attribute>
        <xsl:attribute name="space-before.minimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0pt</xsl:attribute> 
        <xsl:attribute name="padding-top">5mm</xsl:attribute> 
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
        <xsl:attribute name="space-before.minimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.optimum">0pt</xsl:attribute>
        <xsl:attribute name="space-before.maximum">0pt</xsl:attribute> 
        <xsl:attribute name="padding-top">4mm</xsl:attribute>      
    </xsl:attribute-set>

    <xsl:attribute-set name="p.tables">
        <xsl:attribute name="text-indent">0em</xsl:attribute>
        <xsl:attribute name="space-before">0em</xsl:attribute>
        <xsl:attribute name="space-after">0em</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="p.tables.font">
        <xsl:attribute name="font-size"><xsl:value-of select="$body.font.master * .9"/>pt</xsl:attribute>
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
        <!--<xsl:attribute name="color">
            <xsl:value-of select="$minor.title.font.color"/>
        </xsl:attribute>-->
        <xsl:attribute name="color">#000000</xsl:attribute>
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
        <xsl:attribute name="font-weight">bold</xsl:attribute>
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

    <xsl:attribute-set name="note__label__note"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__tip"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__fastpath"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__restriction"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__important"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__remember"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__attention"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__caution"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__danger"> </xsl:attribute-set>
    
    <xsl:attribute-set name="note__label__warning"> </xsl:attribute-set>

    <xsl:attribute-set name="note__label__other"> </xsl:attribute-set>

    <xsl:attribute-set name="p">
        <xsl:attribute name="text-indent">0em</xsl:attribute>
        <xsl:attribute name="space-before">.5em</xsl:attribute>
        <xsl:attribute name="space-after">.5em</xsl:attribute>   
        <xsl:attribute name="line-height">115%</xsl:attribute>
    </xsl:attribute-set>
    
   <xsl:attribute-set name="section">
        <xsl:attribute name="line-height">10pt</xsl:attribute>
        <xsl:attribute name="space-before">0.3em</xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="ph">
        <xsl:attribute name="border-left-width">0pt</xsl:attribute>
        <xsl:attribute name="border-right-width">0pt</xsl:attribute>
        <xsl:attribute name="wrap-option">wrap</xsl:attribute>       
    </xsl:attribute-set>

    <xsl:attribute-set name="image__inline">
        <xsl:attribute name="space-before.minimum">1px</xsl:attribute>
        <xsl:attribute name="space-before.maximum">30px</xsl:attribute>
        <xsl:attribute name="space-before.optimum">5px</xsl:attribute>
        <xsl:attribute name="space-after.minimum">1px</xsl:attribute>
        <xsl:attribute name="space-after.maximum">30px</xsl:attribute>
        <xsl:attribute name="space-after.optimum">5px</xsl:attribute>
    </xsl:attribute-set>
</xsl:stylesheet>
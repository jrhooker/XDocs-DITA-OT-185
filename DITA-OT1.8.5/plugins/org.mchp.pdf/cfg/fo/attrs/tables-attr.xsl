<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">  
 
   <xsl:attribute-set name="table.title">
        <xsl:attribute name="font-family"><xsl:value-of select="$title.font.family"/></xsl:attribute>
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
       <xsl:attribute name="color"><xsl:value-of select="$title.font.color"/></xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-before">5pt</xsl:attribute>
        <xsl:attribute name="space-after">5pt</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__tableframe__none"/>

    <xsl:attribute-set name="__tableframe__top">       
        <xsl:attribute name="border-top-width">thin</xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-color"><xsl:value-of select="$table.frame.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__tableframe__bottom">
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.frame.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-after-width.conditionality">retain</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="thead__tableframe__bottom">
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__tableframe__left">
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">thin</xsl:attribute>
        <xsl:attribute name="border-left-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="__tableframe__right">
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">thin</xsl:attribute>
        <xsl:attribute name="border-right-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table">
        <!--It is a table container -->
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="border-collapse">collapse</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table.tgroup">
        <!--It is a table-->
        <xsl:attribute name="table-layout">fixed</xsl:attribute>
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="space-before">5pt</xsl:attribute>
        <xsl:attribute name="space-after">5pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__all">       
        <xsl:attribute name="border-top-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">thin</xsl:attribute>
        <xsl:attribute name="border-left-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">thin</xsl:attribute>
        <xsl:attribute name="border-right-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">thin</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__topbot">        
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-width">thin</xsl:attribute>
        <xsl:attribute name="border-top-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__top">       
        <xsl:attribute name="border-top-width">thin</xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__bottom">
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="table__tableframe__sides">
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">thin</xsl:attribute>
        <xsl:attribute name="border-left-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">thin</xsl:attribute>
        <xsl:attribute name="border-right-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="tgroup.tbody">
        <!--Table body-->
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="tgroup.thead">
        <!--Table head-->
        <xsl:attribute name="hyphenate">true</xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="tgroup.tfoot">
        <!--Table footer-->
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="thead.row">
        <!--Head row-->
        <xsl:attribute name="hyphenate">true</xsl:attribute>        
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="tfoot.row">
        <!--Table footer-->
        <xsl:attribute name="hyphenate">true</xsl:attribute>        
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="tbody.row">
        <!--Table body row-->
        <xsl:attribute name="hyphenate">true</xsl:attribute>        
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="tbody.row.1">
        <!--Table body row-->
        <xsl:attribute name="hyphenate">true</xsl:attribute>        
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
        <xsl:attribute name="background-color"><xsl:value-of select="$table.row.color.1"/></xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="tbody.row.2">
        <!--Table body row-->
        <xsl:attribute name="hyphenate">true</xsl:attribute>        
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-width">thin</xsl:attribute>
        <xsl:attribute name="border-bottom-color"><xsl:value-of select="$table.rule.color"/></xsl:attribute>
        <xsl:attribute name="background-color"><xsl:value-of select="$table.row.color.2"/></xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="thead.row.entry">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="color"><xsl:value-of select="$table.head.font.color"/></xsl:attribute>
        <!--head cell-->
        <xsl:attribute name="background-color"><xsl:value-of select="$table.header.background.color"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>        
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">thin</xsl:attribute>
        <xsl:attribute name="border-left-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">thin</xsl:attribute>
        <xsl:attribute name="border-right-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
        
    </xsl:attribute-set>

    <xsl:attribute-set name="thead.row.entry__content">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <!--head cell contents-->
        <xsl:attribute name="margin">3pt 3pt 0pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>      
    </xsl:attribute-set>

    <xsl:attribute-set name="tfoot.row.entry">
        <!--footer cell-->
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>        
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">thin</xsl:attribute>
        <xsl:attribute name="border-left-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">thin</xsl:attribute>
        <xsl:attribute name="border-right-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>        
    </xsl:attribute-set>

    <xsl:attribute-set name="tfoot.row.entry__content">
        <!--footer cell contents-->
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="margin">3pt 3pt 0pt 3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="tbody.row.entry">
        <!--body cell-->
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>        
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-width">thin</xsl:attribute>
        <xsl:attribute name="border-left-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-width">thin</xsl:attribute>
        <xsl:attribute name="border-right-color"><xsl:value-of select="$table.vertical.rule.color"/></xsl:attribute>        
    </xsl:attribute-set>

    <xsl:attribute-set name="tbody.row.entry__content">
        <!--body cell contents-->
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="margin">3pt 3pt 0pt 3pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dl">
        <!--DL is a table-->
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="space-before">5pt</xsl:attribute>
        <xsl:attribute name="space-after">5pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dl-table">
        <!--DL is a table-->
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="space-before">2pt</xsl:attribute>
        <xsl:attribute name="space-after">2pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dl__body">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dl.dlhead">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlentry">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlentry.dt">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlentry.dt-table">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="relative-align">baseline</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlentry.dt__content">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">normal</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlentry.dd">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlentry.dd__content">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dl.dlhead__row">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlhead.dthd__cell">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlhead.dthd__content">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlhead.ddhd__cell">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="dlhead.ddhd__content">
        <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
        <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

	<xsl:attribute-set name="simpletable">
		<!--It is a table container -->
        <xsl:attribute name="width">100%</xsl:attribute>
	    <xsl:attribute name="font-size"><xsl:value-of select="$default-table-font-size"/></xsl:attribute>
	    <xsl:attribute name="line-height"><xsl:value-of select="$default-table-line-height"/></xsl:attribute>
		<xsl:attribute name="space-before">8pt</xsl:attribute>
	    <xsl:attribute name="space-after">10pt</xsl:attribute>
	    <xsl:attribute name="hyphenate">true</xsl:attribute> 
	    </xsl:attribute-set>

    <xsl:attribute-set name="simpletable__body">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="sthead">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="sthead__row">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="strow">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="sthead.stentry">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="sthead.stentry__content">
	    <xsl:attribute name="margin-top">0pt</xsl:attribute>
	    <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
	    <xsl:attribute name="margin-left">3pt</xsl:attribute>
	    <xsl:attribute name="margin-right">3pt</xsl:attribute>
	    <xsl:attribute name="font-weight">bold</xsl:attribute>
	    <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="sthead.stentry__keycol-content">
	    <xsl:attribute name="margin-top">0pt</xsl:attribute>
	    <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
	    <xsl:attribute name="margin-left">3pt</xsl:attribute>
	    <xsl:attribute name="margin-right">3pt</xsl:attribute>
	    <xsl:attribute name="font-weight">bold</xsl:attribute>
	    <xsl:attribute name="background-color">antiquewhite</xsl:attribute>
	    <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="strow.stentry__content">
	    <xsl:attribute name="margin-top">0pt</xsl:attribute>
	    <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
	    <xsl:attribute name="margin-left">3pt</xsl:attribute>
	    <xsl:attribute name="margin-right">3pt</xsl:attribute>
	    <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="strow.stentry__keycol-content">
	    <xsl:attribute name="margin-top">0pt</xsl:attribute>
	    <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
	    <xsl:attribute name="margin-left">3pt</xsl:attribute>
	    <xsl:attribute name="margin-right">3pt</xsl:attribute>
	    <xsl:attribute name="font-weight">bold</xsl:attribute>
	    <xsl:attribute name="background-color">antiquewhite</xsl:attribute>
	    <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="strow.stentry">
	</xsl:attribute-set>

    <xsl:attribute-set name="properties">
        <!--It is a table container -->
        <xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
        <xsl:attribute name="width">100%</xsl:attribute>
        <xsl:attribute name="space-before">8pt</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="properties__body">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="property">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="property.entry">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="property.entry__keycol-content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="background-color">antiquewhite</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="property.entry__content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="prophead">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="prophead__row">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="prophead.entry">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="prophead.entry__keycol-content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="background-color">antiquewhite</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="prophead.entry__content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>

	<xsl:attribute-set name="choicetable">
		<!--It is a table container -->
        <xsl:attribute name="width">100%</xsl:attribute>
		<xsl:attribute name="font-size"><xsl:value-of select="$default-font-size"/></xsl:attribute>
	    <xsl:attribute name="space-after">0pt</xsl:attribute>
	    <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="choicetable__body">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead__row">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead.choptionhd">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead.choptionhd__content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead.chdeschd">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chhead.chdeschd__content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.choption">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.choption__keycol-content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.choption__content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.chdesc">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.chdesc__keycol-content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:attribute-set name="chrow.chdesc__content">
        <xsl:attribute name="margin-top">0pt</xsl:attribute>
        <xsl:attribute name="margin-bottom">0pt</xsl:attribute>
        <xsl:attribute name="margin-left">3pt</xsl:attribute>
        <xsl:attribute name="margin-right">3pt</xsl:attribute>
        <xsl:attribute name="hyphenate">true</xsl:attribute>
    </xsl:attribute-set>
    

    <xsl:attribute-set name="reltable">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="reltable__title">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="relheader">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="relcolspec">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="relcell">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>

    <xsl:attribute-set name="relrow">
        <xsl:attribute name="hyphenate">true</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
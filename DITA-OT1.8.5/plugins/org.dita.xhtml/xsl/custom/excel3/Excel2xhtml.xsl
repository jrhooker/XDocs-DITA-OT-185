<?xml version="1.0" encoding="UTF-8"?>
<!-- This is a stylesheet for converting Microsoft's XML 2003 format to XSL FO 
     tabular structures. Most all of the commonly used styling in Excel are supported.
     It can read the Excel XML document and it extracts the Print Area set. It supports
     using the Print Titles in Excel for repeating table header rows. 

     It is called simply by passing the Excel spreadsheet as a parameters in your XSL:
     
     <xsl:template match="spreadsheet">
         <xsl:variable name="excel" select="document(@src)"/>
         <xsl:call-template name="process.spreadsheet">
             <xsl:with-param name="sheet" select="$excel"/>
         </xsl:call-template>
     </xsl:template>
     
     This template was developed by Kevin Brown and Karl Stubsjoen from RenderX, Inc. Feel
     free to use it as you will as in is part of our "Cool Tools". If you have any changes
     just email them to us at RenderX:
     
     kevin@renderx.com
     stubsjoen@renderx.com
     
     http://www.renderx.com
-->
<xsl:stylesheet xmlns:excel="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:o="urn:schemas-microsoft-com:office:office"
    xmlns:x="urn:schemas-microsoft-com:office:excel"
    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
    xmlns:html="http://www.w3.org/TR/REC-html40" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" version="2.0">

    <xsl:key name="key_styles" match="ss:Style" use="@ss:ID"/>

    <xsl:variable name="style-map">
        <style name="Decimal">
            <format>#.00</format>
        </style>
        <style name="Fixed">
            <format>#.00</format>
        </style>
        <style name="Standard">
            <format>#,###.00</format>
        </style>
        <style name="Comma">
            <format>#,###.00</format>
        </style>
        <style name="Currency">
            <format>$ ###,###.00</format>
        </style>
        <style name="Accounting">
            <format>$ ###,###.00</format>
        </style>
        <style name="Percent">
            <format>##%</format>
        </style>
    </xsl:variable>

    <xsl:template name="process.spreadsheet">
        <xsl:param name="sheet" tunnel="yes"/>
        <xsl:param name="content"/>
        <xsl:apply-templates select="$content" mode="excel"/>
    </xsl:template>

    <xsl:template match="ss:Worksheet" mode="excel">
        <xsl:param name="sheet" tunnel="yes"/>
        <xsl:choose>
            <xsl:when test="@ss:Name = $sheet">
                <xsl:apply-templates mode="excel"/>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ss:Table[child::ss:Row/child::ss:Cell/ss:NamedCell/@ss:Name='Print_Area']" mode="excel">
        <div class="tablenoborder" >
            <table border="1" cellpadding="4" cellspacing="0" class="table" frame="border"
                rules="all">
                <xsl:for-each select="ss:Column">
                    <col>
                        <xsl:attribute name="width">
                            <xsl:value-of select="@ss:Width"/>
                        </xsl:attribute>
                    </col>
                </xsl:for-each>
                <!-- TODO: Implement Table Header -->
                <xsl:if test="ss:Row/ss:Cell/ss:NamedCell/@ss:Name='Print_Titles'">
                    <thead align="left" class="thead">
                        <xsl:apply-templates
                            select="
                            ss:Row[child::ss:Cell/ss:NamedCell/@ss:Name='Print_Titles'] | 
                            ss:Row[ss:Cell/ss:NamedCell/@ss:Name='Print_Area'][following-sibling::ss:Row[child::ss:Cell/ss:NamedCell/@ss:Name='Print_Titles']]"
                            mode="excel"/>
                    </thead>
                </xsl:if>
                <tbody class="tbody">
                    <xsl:apply-templates
                        select="ss:Row[ss:Cell/ss:NamedCell/@ss:Name='Print_Area'][not(following-sibling::ss:Row[child::ss:Cell/ss:NamedCell/@ss:Name='Print_Titles'])]
                        [not(self::ss:Row[child::ss:Cell/ss:NamedCell/@ss:Name='Print_Titles'])]"
                        mode="excel"/>
                </tbody>
            </table>
        </div>
    </xsl:template>

    <!-- Ignore Tables not set as the Print Area -->
    <xsl:template match="ss:Table" mode="excel"/>

    <!-- Only output Rows where child Cell has a NamedCell ss:Name="Print_Area and not Print_Titles -->
    <xsl:template match="ss:Row[child::ss:Cell/ss:NamedCell/@ss:Name='Print_Area']" mode="excel">
        <xsl:choose>
            <xsl:when
                test="following-sibling::ss:Row[child::ss:Cell/ss:NamedCell/@ss:Name='Print_Titles']">
                <tr style="background-color:#cccccc;align:middle">
                    <xsl:apply-templates mode="excel-header"/>
                </tr>
            </xsl:when>
            <xsl:when test="ss:Cell/ss:NamedCell/@ss:Name='Print_Titles'"/>
            <xsl:otherwise>
                <tr class="row">
                    <xsl:apply-templates mode="excel"/>
                </tr>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="ss:Row[child::ss:Cell/ss:NamedCell/@ss:Name='Print_Titles']" mode="excel"
        priority="100">
        <tr style="background-color:#cccccc;align:middle">
            <xsl:apply-templates mode="excel-header"/>
        </tr>
    </xsl:template>

    <!-- Ignore Rows not in the Print Area, but grab the rows in front of the Print Titles row -->
    <xsl:template match="ss:Row" mode="excel">
        <xsl:if
            test="following-sibling::ss:Row[child::ss:Cell/ss:NamedCell/@ss:Name='Print_Titles']">
            <tr style="background-color:#cccccc;align:middle">>
                <xsl:apply-templates mode="excel-header"/>
            </tr>
        </xsl:if>
    </xsl:template>

    <xsl:template match="ss:Cell" mode="excel-header">
        <th class="entry" valign="top" >
            <xsl:call-template name="select.style.header">
                <xsl:with-param name="styleid">
                    <xsl:value-of select="@ss:StyleID"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:if test="@ss:MergeAcross">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="@ss:MergeAcross + 1"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@ss:MergeDown">
                <xsl:attribute name="rowspan">
                    <xsl:value-of select="@ss:MergeDown + 1"/>
                </xsl:attribute>
            </xsl:if>
            <!-- Add a block container (for rotated blocks) -->
            <div>
                <p>
                    <xsl:call-template name="select.style.header">
                        <xsl:with-param name="styleid">
                            <xsl:value-of select="@ss:StyleID"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:apply-templates mode="excel"/>
                </p>
            </div>
        </th>
    </xsl:template>

    <xsl:template match="ss:Cell" mode="excel">
        <td class="entry" valign="top">
            <xsl:call-template name="select.style">
                <xsl:with-param name="styleid">
                    <xsl:value-of select="@ss:StyleID"/>
                </xsl:with-param>
            </xsl:call-template>
            <xsl:if test="@ss:MergeAcross">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="@ss:MergeAcross + 1"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@ss:MergeDown">
                <xsl:attribute name="rowspan">
                    <xsl:value-of select="@ss:MergeDown + 1"/>
                </xsl:attribute>
            </xsl:if>
            <!-- Add a block container (for rotated blocks) -->
            <div>
                <p>
                    <xsl:call-template name="select.style">
                        <xsl:with-param name="styleid">
                            <xsl:value-of select="@ss:StyleID"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:apply-templates mode="excel"/>
                </p>
            </div>
        </td>
    </xsl:template>

    <xsl:template match="html:Sub | *:Sub" mode="excel">
        <sub>
            <xsl:apply-templates mode="excel"/>
        </sub>
    </xsl:template>

    <xsl:template match="html:Sup | *:Sup" mode="excel">
        <sup>
            <xsl:apply-templates mode="excel"/>
        </sup>
    </xsl:template>

    <xsl:template match="ss:Font | *:Font" mode="excel">
        <xsl:apply-templates mode="excel"/>
    </xsl:template>

    <xsl:template match="ss:Data" mode="excel">
        <!-- check for a URL template and set a link if needed -->
        <p>
            <xsl:choose>
                <xsl:when test="parent::ss:Cell/@ss:HRef">
                    <a>
                        <xsl:attribute name="href">                            
                            <xsl:value-of select="parent::ss:Cell/@ss:HRef"/>
                        </xsl:attribute>
                       <xsl:value-of select="."/>
                        <!-- <xsl:call-template name="format-data"/> -->
                    </a>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates mode="excel"/>
                </xsl:otherwise>
            </xsl:choose>
        </p>
    </xsl:template>

    <xsl:template name="format-data">
        <!-- apply number formatting -->
        <xsl:choose>
            <xsl:when
                test="key('key_styles', ancestor::ss:Cell/@ss:StyleID)/ss:NumberFormat or key('key_styles', key('key_styles', ancestor::ss:Cell/@ss:StyleID)/@ss:Parent)/ss:NumberFormat">
                <xsl:call-template name="format-number">
                    <xsl:with-param name="style"
                        select="key('key_styles', ancestor::ss:Cell/@ss:StyleID) | key('key_styles', key('key_styles', ancestor::ss:Cell/@ss:StyleID)/@ss:Parent)"/>
                    <xsl:with-param name="value" select="."/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="format-number">
        <xsl:param name="style"/>
        <xsl:param name="value"/>
        <!-- Try using the actual template -->
        <xsl:variable name="template" select="$style/ss:NumberFormat/@ss:Format"/>
        <!-- Strip unwanted number formatting information in a set of recursive templates -->
        <!-- Need to remove "_(", "_)", "*", "\" before "(" or ")", and "&quot;" -->
        <xsl:variable name="step1">
            <xsl:call-template name="stripChars">
                <xsl:with-param name="stringIn" select="string($template)"/>
                <xsl:with-param name="charsIn" select="'_('"/>
                <xsl:with-param name="charsOut" select="''"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="step2">
            <xsl:call-template name="stripChars">
                <xsl:with-param name="stringIn" select="string($step1)"/>
                <xsl:with-param name="charsIn" select="'_)'"/>
                <xsl:with-param name="charsOut" select="''"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="step3">
            <xsl:call-template name="stripChars">
                <xsl:with-param name="stringIn" select="string($step2)"/>
                <xsl:with-param name="charsIn" select="'*'"/>
                <xsl:with-param name="charsOut" select="''"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="step4">
            <xsl:call-template name="stripChars">
                <xsl:with-param name="stringIn" select="string($step3)"/>
                <xsl:with-param name="charsIn" select="'\('"/>
                <xsl:with-param name="charsOut" select="'('"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="step5">
            <xsl:call-template name="stripChars">
                <xsl:with-param name="stringIn" select="string($step4)"/>
                <xsl:with-param name="charsIn" select="'\)'"/>
                <xsl:with-param name="charsOut" select="')'"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="step6">
            <xsl:call-template name="stripChars">
                <xsl:with-param name="stringIn" select="string($step5)"/>
                <xsl:with-param name="charsIn" select="'&quot;'"/>
                <xsl:with-param name="charsOut" select="''"/>
            </xsl:call-template>
        </xsl:variable>

        <!-- Change the separator bewteen the second and third item from a ";" to a "," -->
        <xsl:variable name="xsltemplate">
            <xsl:call-template name="splitstring">
                <xsl:with-param name="formatstring" select="string($step6)"/>
            </xsl:call-template>
        </xsl:variable>
        
        <xsl:variable name="style-map" select="document('')/*/xsl:variable[@name='style-map']/style"/>
        
        <xsl:choose>
            <xsl:when test="$style-map[@name = $xsltemplate]">
                <xsl:value-of select="format-number($value, $style-map[@name = $template]/format)"/>
            </xsl:when>
            <xsl:when test="$style-map[@name = $xsltemplate]">
                <xsl:value-of
                    select="format-number($value, $style-map[@name = $style[2]/@ss:Name]/format)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="format-number($value,$xsltemplate)"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="select.style">
        <xsl:param name="styleid"/>
        <xsl:variable name="style" select="/ss:Workbook/ss:Styles/ss:Style[@ss:ID=$styleid]"/>
        <xsl:call-template name="process.style">
            <xsl:with-param name="style" select="$style"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="select.style.header">
        <xsl:param name="styleid"/>
        <xsl:variable name="style" select="/ss:Workbook/ss:Styles/ss:Style[@ss:ID=$styleid]"/>
        <xsl:call-template name="process.style.header">
            <xsl:with-param name="style" select="$style"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="process.style">
        <xsl:param name="style"/>
        <!-- If the Style has a Parent, process it first -->
        <xsl:if test="$style/@ss:Parent">
            <xsl:call-template name="process.style">
                <xsl:with-param name="style"
                    select="/ss:Workbook/ss:Styles/ss:Style[@ss:ID=$style/@ss:Parent]"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="$style/ss:Interior[@ss:Color]">
            <xsl:attribute name="background-color">
                <xsl:value-of select="$style/ss:Interior/@ss:Color"/>
            </xsl:attribute>
        </xsl:if>
        <!-- Right align numbers by default -->
        <xsl:if test="$style/ss:Font/@ss:Size &lt; 8">
            <xsl:attribute name="font-size">
                <xsl:value-of select="$style/ss:Font/@ss:Size"/>
                <xsl:text>pt</xsl:text>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="$style/ss:NumberFormat">
            <xsl:attribute name="align">right</xsl:attribute>
        </xsl:if>
        <xsl:if test="$style/ss:Alignment[@ss:Horizontal]">
            <xsl:attribute name="align">
                <xsl:if test="$style/ss:Alignment/@ss:Horizontal='Center'">
                    <xsl:text>center</xsl:text>
                </xsl:if>
                <xsl:if test="$style/ss:Alignment/@ss:Horizontal='Right'">
                    <xsl:text>right</xsl:text>
                </xsl:if>
                <xsl:if test="$style/ss:Alignment/@ss:Horizontal='Left'">
                    <xsl:text>left</xsl:text>
                </xsl:if>
            </xsl:attribute>
        </xsl:if>      
    </xsl:template>
    
    <xsl:template name="process.style.header">
        <xsl:param name="style"/>
        <!-- If the Style has a Parent, process it first -->
        <xsl:if test="$style/@ss:Parent">
            <xsl:call-template name="process.style">
                <xsl:with-param name="style"
                    select="/ss:Workbook/ss:Styles/ss:Style[@ss:ID=$style/@ss:Parent]"/>
            </xsl:call-template>
        </xsl:if>
        <!--<xsl:if test="$style/ss:Interior[@ss:Color]">
            <xsl:attribute name="background-color">
                <xsl:value-of select="$style/ss:Interior/@ss:Color"/>
            </xsl:attribute>
        </xsl:if>-->
        <!-- Right align numbers by default -->
        <xsl:if test="$style/ss:Font/@ss:Size &lt; 8">
            <xsl:attribute name="font-size">
                <xsl:value-of select="$style/ss:Font/@ss:Size"/>
                <xsl:text>pt</xsl:text>
            </xsl:attribute>
        </xsl:if>
        <xsl:if test="$style/ss:NumberFormat">
            <xsl:attribute name="align">right</xsl:attribute>
        </xsl:if>
        <xsl:if test="$style/ss:Alignment[@ss:Horizontal]">
            <xsl:attribute name="align">
                <xsl:if test="$style/ss:Alignment/@ss:Horizontal='Center'">
                    <xsl:text>center</xsl:text>
                </xsl:if>
                <xsl:if test="$style/ss:Alignment/@ss:Horizontal='Right'">
                    <xsl:text>right</xsl:text>
                </xsl:if>
                <xsl:if test="$style/ss:Alignment/@ss:Horizontal='Left'">
                    <xsl:text>left</xsl:text>
                </xsl:if>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <xsl:template match="*" mode="excel">
        <xsl:apply-templates mode="excel"/>
    </xsl:template>

    <xsl:template match="text()" mode="excel">
        <xsl:if test="ancestor-or-self::ss:Cell/ss:NamedCell/@ss:Name='Print_Area'">
           <xsl:value-of disable-output-escaping="yes" select="."/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="stripChars">
        <xsl:param name="stringIn"/>
        <xsl:param name="charsIn"/>
        <xsl:param name="charsOut"/>
        <xsl:choose>
            <xsl:when test="contains($stringIn,$charsIn)">
                <xsl:value-of select="concat(substring-before($stringIn,$charsIn),$charsOut)"/>
                <xsl:call-template name="stripChars">
                    <xsl:with-param name="stringIn" select="substring-after($stringIn,$charsIn)"/>
                    <xsl:with-param name="charsIn" select="$charsIn"/>
                    <xsl:with-param name="charsOut" select="$charsOut"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$stringIn"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="splitstring">
        <xsl:param name="formatstring"/>
        <xsl:param name="count" select="1"/>
        <xsl:variable name="first" select="substring-before($formatstring, ';')"/>
        <xsl:variable name="remaining" select="substring-after($formatstring, ';')"/>
        <xsl:choose>
            <xsl:when test="$first">
                <xsl:choose>
                    <xsl:when test="$count = 2">
                        <xsl:value-of select="$first"/>
                        <xsl:text>,</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$first"/>
                        <xsl:text>;</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$formatstring"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$remaining">
            <xsl:call-template name="splitstring">
                <xsl:with-param name="formatstring" select="$remaining"/>
                <xsl:with-param name="count" select="$count+1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

 </xsl:stylesheet>

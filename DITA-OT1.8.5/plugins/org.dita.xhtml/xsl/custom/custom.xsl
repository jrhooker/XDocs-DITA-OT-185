<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:svg="http://www.w3.org/2000/svg" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    exclude-result-prefixes="xs" version="2.0">

<xsl:import href="revision-history.xsl"/>
<xsl:import href="excel3/testexcel.xsl"/>

    <xsl:param name="text-encoding" as="xs:string" select="'iso-8859-1'"/>
    <xsl:param name="BASEDIR"/>
    <xsl:param name="BASEDIR2" select="translate($BASEDIR, '\', '/')"/>
    <xsl:param name="OUTPUTDIR"/>
    <xsl:param name="OUTPUTDIR2" select="translate($OUTPUTDIR, '\', '/')"/>
    <xsl:param name="DITATEMPDIR"/>
    <xsl:param name="CSSPATH"/>
    <xsl:param name="CSS"/>
    <xsl:param name="DITATEMPDIR2" select="translate($DITATEMPDIR, '\', '/')"/>
    <xsl:param name="text-uri" as="xs:string"
        select="concat('file:///', $DITATEMPDIR2, '/fullditatopic.list')"/>
    <xsl:param name="TRANSTYPE" select="'xhtml'"/>
   
 <xsl:template match="*[contains(@class, ' topic/table ')]" mode="table-fmt"> 
        
        <!-- This template is deprecated in DITA-OT 1.7. Processing will moved into the main element rule. -->
        <xsl:value-of select="$newline"/>
        <!-- special case for IE & NS for frame & no rules - needs to be a double table -->
        <xsl:variable name="colsep">
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' topic/tgroup ')]/@colsep">
                    <xsl:value-of select="*[contains(@class, ' topic/tgroup ')]/@colsep"/>
                </xsl:when>
                <xsl:when test="@colsep">
                    <xsl:value-of select="@colsep"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="rowsep">
            <xsl:choose>
                <xsl:when test="*[contains(@class, ' topic/tgroup ')]/@rowsep">
                    <xsl:value-of select="*[contains(@class, ' topic/tgroup ')]/@rowsep"/>
                </xsl:when>
                <xsl:when test="@rowsep">
                    <xsl:value-of select="@rowsep"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>       
            <!-- The following condition has been added in order to have the excel links to table processed correctly.  -->
            <xsl:when test="xref">
                <xsl:call-template name="place-tbl-lbl"/>
                <xsl:apply-templates select="xref"/>
            </xsl:when>
            <!-- Modification ends. -->
            <xsl:when test="@frame = 'all' and $colsep = '0' and $rowsep = '0'">
                <table cellpadding="4" cellspacing="0" border="1" class="tableborder">
                    <tr>
                        <td>
                            <xsl:value-of select="$newline"/>
                            <xsl:call-template name="dotable"/>
                        </td>
                    </tr>
                </table>
            </xsl:when>
            <xsl:when test="@frame = 'top' and $colsep = '0' and $rowsep = '0'">
                <hr />
                <xsl:value-of select="$newline"/>
                <xsl:call-template name="dotable"/>
            </xsl:when>
            <xsl:when test="@frame = 'bot' and $colsep = '0' and $rowsep = '0'">
                <xsl:call-template name="dotable"/>
                <hr />
                <xsl:value-of select="$newline"/>
            </xsl:when>
            <xsl:when test="@frame = 'topbot' and $colsep = '0' and $rowsep = '0'">
                <hr />
                <xsl:value-of select="$newline"/>
                <xsl:call-template name="dotable"/>
                <hr />
                <xsl:value-of select="$newline"/>
            </xsl:when>
            <xsl:when test="not(@frame) and $colsep = '0' and $rowsep = '0'">
                <table cellpadding="4" cellspacing="0" border="1" class="tableborder">
                    <tr>
                        <td>
                            <xsl:value-of select="$newline"/>
                            <xsl:call-template name="dotable"/>
                        </td>
                    </tr>
                </table>
            </xsl:when>
            <xsl:otherwise>
                <div class="tablenoborder">
                    <xsl:call-template name="dotable"/>
                </div>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$newline"/>
    </xsl:template>

 <!-- paragraphs -->

    <xsl:template match="*[contains(@class, ' topic/ph ')]" name="topic.ph">
        <xsl:choose>
            <xsl:when test="@keyref">
                <xsl:apply-templates select="." mode="turning-to-link">
                    <xsl:with-param name="keys" select="@keyref"/>
                    <xsl:with-param name="type" select="'ph'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setidaname"/>
                    <xsl:if test="@text_color">
                        <xsl:attribute name="style">color:<xsl:value-of select="@text_color"
                            />;</xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="add-br-for-empty-cmd"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/p ')][@otherprops = 'figure-list']">
        <xsl:choose>
            <xsl:when test="@keyref">
                <xsl:apply-templates select="." mode="turning-to-link">
                    <xsl:with-param name="keys" select="@keyref"/>
                    <xsl:with-param name="type" select="'ph'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setidaname"/>
                    <xsl:choose>
                        <xsl:when test="unparsed-text-available($text-uri, $text-encoding)">
                            <xsl:call-template name="text2xml">
                                <xsl:with-param name="format">figure</xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="error">
                                <xsl:text>Error reading "</xsl:text>
                                <xsl:value-of select="$text-uri"/>
                                <xsl:text>" (encoding "</xsl:text>
                                <xsl:value-of select="$text-encoding"/>
                                <xsl:text>").</xsl:text>
                            </xsl:variable>
                            <xsl:message>
                                <xsl:value-of select="$error"/>
                            </xsl:message>
                            <xsl:value-of select="$error"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="add-br-for-empty-cmd"/>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/p ')][@otherprops = 'table-list']">
        <xsl:choose>
            <xsl:when test="@keyref">
                <xsl:apply-templates select="." mode="turning-to-link">
                    <xsl:with-param name="keys" select="@keyref"/>
                    <xsl:with-param name="type" select="'ph'"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <span>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:call-template name="setidaname"/>
                    <xsl:choose>
                        <xsl:when test="unparsed-text-available($text-uri, $text-encoding)">
                            <xsl:call-template name="text2xml">
                                <xsl:with-param name="format">table</xsl:with-param>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="error">
                                <xsl:text>Error reading "</xsl:text>
                                <xsl:value-of select="$text-uri"/>
                                <xsl:text>" (encoding "</xsl:text>
                                <xsl:value-of select="$text-encoding"/>
                                <xsl:text>").</xsl:text>
                            </xsl:variable>
                            <xsl:message>
                                <xsl:value-of select="$error"/>
                            </xsl:message>
                            <xsl:value-of select="$error"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </span>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:call-template name="add-br-for-empty-cmd"/>
    </xsl:template>

    <xsl:template name="text2xml">
        <xsl:param name="format"/>
        <xsl:variable name="text" select="unparsed-text($text-uri, $text-encoding)"/>
        <xsl:analyze-string select="$text" regex="(.*)\n">
            <xsl:matching-substring>
                <xsl:choose>
                    <xsl:when test="$format = 'table'">
                        <xsl:call-template name="process-tables-from-topics">
                            <xsl:with-param name="topic">
                                <xsl:value-of select="normalize-space(regex-group(1))"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:when test="$format = 'figure'">
                        <xsl:call-template name="process-figures-from-topics">
                            <xsl:with-param name="topic">
                                <xsl:value-of select="normalize-space(regex-group(1))"/>
                            </xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>
                </xsl:choose>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template name="process-figures-from-topics">
        <xsl:param name="topic"/>
        <xsl:variable name="content"
            select="document(concat('file:///', $DITATEMPDIR2, '/', $topic))"/>
        <xsl:for-each select="$content//*[contains(@class, ' topic/fig ')]">
            <p>
                <xsl:value-of
                    select="ancestor::*[contains(@class, ' topic/topic ' )]/*[contains(@class, ' topic/title ' )]"/>
                <xsl:text>: </xsl:text>
                <xsl:element name="a">                   
                    <xsl:choose>
                        <xsl:when test="contains($topic, '.xml')">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(substring-before($topic, '.xml'), '.html')"
                                />#<xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/topic ' )]/@id"
                                />__<xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="contains($topic, '.dita')">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(substring-before($topic, '.dita'), '.html')"
                                />#<xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/topic ' )]/@id"
                                />__<xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:when>
                    </xsl:choose>                  
                    <xsl:value-of select="*[contains(@class, ' topic/title ' )]"/>
                </xsl:element>
            </p>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="process-tables-from-topics">
        <xsl:param name="topic"/>
        <xsl:variable name="content"
            select="document(concat('file:///', $DITATEMPDIR2, '/', $topic))"/>
        <xsl:for-each
            select="$content//*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]]">
            <p>
                <xsl:value-of
                    select="ancestor::*[contains(@class, ' topic/topic ' )]/*[contains(@class, ' topic/title ' )]"/>
                <xsl:text>: </xsl:text>
                <xsl:element name="a">
                    <xsl:choose>
                        <xsl:when test="contains($topic, '.xml')">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(substring-before($topic, '.xml'), '.html')"
                                />#<xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/topic ' )]/@id"
                                />__<xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:when test="contains($topic, '.dita')">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat(substring-before($topic, '.dita'), '.html')"
                                />#<xsl:value-of
                                    select="ancestor::*[contains(@class, ' topic/topic ' )]/@id"
                                />__<xsl:value-of select="@id"/>
                            </xsl:attribute>
                        </xsl:when>
                    </xsl:choose>            
                    <xsl:value-of select="*[contains(@class, ' topic/title ' )]"/>
                </xsl:element>
            </p>
        </xsl:for-each>
    </xsl:template>
    
    
    <!-- create footer for javahelp -->
    
    <xsl:template name="Javahelp-footer">
      
        <xsl:variable name="ditatempdir-cleaned" select="translate($DITATEMPDIR, '\', '/')"/>
        <xsl:variable name="argsinput-cleaned" select="translate($ARGS.INPUT, '\', '/')"/>
      
        <xsl:variable name="temp1" select="translate(concat('file:///',$BASEDIR, '/', $ARGS.INPUT), '\', '\')"/>
        <xsl:variable name="temp2" select="translate($ARGS.INPUT, '\', '/')"/>        
        
        <xsl:variable name="ditamap">
            <xsl:call-template name="substring-after-last-javahelp">
                <xsl:with-param name="input" select="$argsinput-cleaned"/>
                <xsl:with-param name="substr">/</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
       
       <xsl:variable name="ditamap-concat" select="concat('file:///', $ditatempdir-cleaned, '/', $ditamap)"/>
       
        <xsl:variable name="ditamapISO" select="document($ditamap-concat)"/>
        <xsl:variable name="pmc_title" select="$ditamapISO//pmc_iso[1]/pmc_title"/>
        <xsl:variable name="pmc_document_id" select="$ditamapISO//pmc_iso[1]/pmc_document_id"/>
        <xsl:variable name="pmc_issuenum" select="$ditamapISO//pmc_iso[1]/pmc_issuenum"/>
        <xsl:variable name="pmc_issue_date" select="$ditamapISO//pmc_iso[1]/pmc_issue_date"/>
        <xsl:variable name="pmc_footertext" select="$ditamapISO//pmc_iso[1]/pmc_footertext"/>
        <xsl:variable name="pmc_copyright_year" select="$ditamapISO//pmc_iso[1]/pmc_copyright_year"/>        
           
        <div style="font-family:Arial; font-size: 9pt; color: 999999;line-height: 7pt;margin-top: 12px;">         
            <b>
                <xsl:value-of select="$pmc_title"/>
            </b>
            <br/>
            <xsl:text>Document No. </xsl:text>
            <xsl:value-of select="$pmc_document_id"/>
            <xsl:text>, </xsl:text>
            <xsl:text>Issue </xsl:text>
            <xsl:value-of select="$pmc_issuenum"/>
            <xsl:text>, </xsl:text>
                <xsl:value-of select="$pmc_issue_date"/>
            <br/> 
            <xsl:if test="number($WATERMARKING) = 1"> UNENCRYPTED_REPLACEMENT_WATERMARKING_STRING </xsl:if><br/>          
            
            <xsl:choose>
                <xsl:when test="string-length($pmc_footertext) &gt; 2">
                    <xsl:if test="$pmc_copyright_year"> © <xsl:value-of select="$pmc_copyright_year"/></xsl:if>
                    <xsl:text> </xsl:text>
                    <xsl:apply-templates select="$pmc_footertext" mode="pmc_footer"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="$pmc_copyright_year"> © <xsl:value-of select="$pmc_copyright_year"/></xsl:if>
                    <xsl:text> CONFIDENTIAL </xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <br/>
        </div>
        <br/>        
    </xsl:template>
    
    <xsl:template name="substring-before-last-javahelp">
        <xsl:param name="input" />
        <xsl:param name="substr" />
        <xsl:if test="$substr and contains($input, $substr)">
            <xsl:variable name="temp" select="substring-after($input, $substr)" />
            <xsl:value-of select="substring-before($input, $substr)" />
            <xsl:if test="contains($temp, $substr)">
                <xsl:value-of select="$substr" />
                <xsl:call-template name="substring-before-last-javahelp">
                    <xsl:with-param name="input" select="$temp" />
                    <xsl:with-param name="substr" select="$substr" />
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="substring-after-last-javahelp">
        <xsl:param name="input"/>
        <xsl:param name="substr"/>
        
        <!-- Extract the string which comes after the first occurence -->
        <xsl:variable name="temp" select="substring-after($input,$substr)"/>
        
        <xsl:choose>
            <!-- If it still contains the search string the recursively process -->
            <xsl:when test="$substr and contains($temp,$substr)">
                <xsl:call-template name="substring-after-last-javahelp">
                    <xsl:with-param name="input" select="$temp"/>
                    <xsl:with-param name="substr" select="$substr"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$temp"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!--extract dimensions from SVG; these templates are used by the xhtml scripts to extract the native size values from SVGs-->
    
    <xsl:template match="svg:svg" mode="height">
        <xsl:value-of select="@height"/>
        <xsl:apply-templates mode="height"></xsl:apply-templates>        
    </xsl:template>
    
    <xsl:template match="svg:svg" mode="width">
        <xsl:value-of select="@width"/>
        <xsl:apply-templates mode="width"></xsl:apply-templates>        
    </xsl:template>
    
    <xsl:template match="node()" mode="svg height width">
        <xsl:apply-templates mode="svg"></xsl:apply-templates>        
    </xsl:template>
    
    <!-- Writing the javascript for active tables -->
    
    <xsl:template name="create-script-table-footer">
        <xsl:variable name="topicID" select="ancestor-or-self::*[contains(@class, ' topic/topic ')]/@id"/>
        <xsl:variable name="tables" select="ancestor-or-self::*[contains(@class, ' topic/topic ')]/descendant::*[contains(@class, ' topic/table ')]"></xsl:variable> 
        <script type="text/javascript" class="init">
            $(document).ready(function() {
        <xsl:for-each select="$tables">   
            <xsl:choose>
                <xsl:when test="@id">$('#<xsl:value-of select="$topicID"/>__<xsl:value-of select="@id"/>').DataTable({
                    "paging":   false,
                    dom: 'Bfrtip',
                    buttons: [
                    'print',
                    'copyHtml5',
                    'excelHtml5',
                    {
                    text: 'Copy W/Format',
                    action: function ( e, dt, node, config ) {
                    selectElementContents( document.getElementById('<xsl:value-of select="$topicID"/>__<xsl:value-of select="@id"/>') );
                    }
                    },
                    'colvis'
                    ]});</xsl:when>        
                <xsl:otherwise>
                    $('#<xsl:value-of select="$topicID"/>__<xsl:value-of select="generate-id()"/>').DataTable({
                    "paging":   false,
                    dom: 'Bfrtip',
                    buttons: [
                    'print',
                    'copyHtml5',
                    'excelHtml5',
                    {
                    text: 'Copy W/Format',
                    action: function ( e, dt, node, config ) {
                    selectElementContents( document.getElementById('<xsl:value-of select="$topicID"/>__<xsl:value-of select="generate-id()"/>') );
                    }
                    },
                    'colvis'
                    ]});
                </xsl:otherwise>
            </xsl:choose>
            
        </xsl:for-each>
            } );
            
            
            
        </script>      
    </xsl:template>
    
    <!-- Set ID only 
    by default, resources without IDs are left IDless in the output, but this means that tables and svgs without IDs cannot be activated by the javascript code
    designed to add features to them, so is they have no native ID we add one.-->
    <xsl:template name="setid">
        <xsl:choose>
            <xsl:when test="@id and $TRANSTYPE = 'javahelp'">
                <xsl:call-template name="setidattr-javahelp">
                    <xsl:with-param name="idvalue" select="@id"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:when test="@id">
                <xsl:call-template name="setidattr">
                    <xsl:with-param name="idvalue" select="@id"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="tempID"><xsl:value-of select="generate-id()"/></xsl:variable>
                <xsl:call-template name="setidattr">
                    <xsl:with-param name="idvalue" select="$tempID"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>      
    </xsl:template>
    
    <!-- Set the ID attr for javahelp -->
    <xsl:template name="setidattr-javahelp">
        <xsl:param name="idvalue"/>
        <xsl:attribute name="id">         
            <xsl:value-of select="$idvalue"/>
        </xsl:attribute>
    </xsl:template>
    
    <xsl:template name="rename-svg">
        <xsl:param name="href"/>
        <xsl:choose>
            <xsl:when test="contains($href, '.svg')">
                <xsl:value-of select="replace($href, '.svg', '_svg')"/>
            </xsl:when>
            <xsl:when test="contains($href, '.SVG')">
                <xsl:value-of select="replace($href, '.SVG', '_svg')"/>
            </xsl:when>
            <xsl:when test="contains($href, '.Svg')">
                <xsl:value-of select="replace($href, '.Svg', '_svg')"/>
            </xsl:when>            
        </xsl:choose>        
    </xsl:template>
    

</xsl:stylesheet>

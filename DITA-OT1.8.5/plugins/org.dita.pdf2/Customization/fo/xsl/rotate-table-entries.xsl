<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">
    
    <!-- Overridden templates -->
    
    <xsl:template match="*[contains(@class, ' topic/thead ')]/*[contains(@class, ' topic/row ')]/*[contains(@class, ' topic/entry ')]">
        <fo:table-cell xsl:use-attribute-sets="thead.row.entry">
            <xsl:call-template name="commonattributes"/>
            <xsl:call-template name="rotate_entry"/>
            <xsl:call-template name="applySpansAttrs"/>
            <xsl:call-template name="applyAlignAttrs"/>
            <xsl:call-template name="generateTableEntryBorder"/>
            <xsl:call-template name="findBackgroundColor"/>
            <fo:block xsl:use-attribute-sets="thead.row.entry__content">
                <xsl:call-template name="processEntryContent"/>
            </fo:block>
        </fo:table-cell>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/tbody ')]/*[contains(@class, ' topic/row ')]/*[contains(@class, ' topic/entry ')]">
        <fo:table-cell xsl:use-attribute-sets="tbody.row.entry">
            <xsl:call-template name="commonattributes"/>   
            <xsl:call-template name="rotate_entry"/>
            <xsl:call-template name="applySpansAttrs"/>
            <xsl:call-template name="applyAlignAttrs"/>
            <xsl:call-template name="generateTableEntryBorder"/>
            <xsl:call-template name="findBackgroundColor"/>
            <fo:block xsl:use-attribute-sets="tbody.row.entry__content">
                <xsl:call-template name="processEntryContent"/>    
                
            </fo:block>
        </fo:table-cell>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/p ')][1][parent::*[contains(@class, ' topic/entry ')]]" priority="10">
        <!-- Added rotation to the bag o tricks for handling bit tables -->
        <xsl:choose>
            <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')][@orientation]">
                <fo:block-container>
                    <xsl:choose>
                        <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]/@width">
                            <xsl:attribute name="width" select="ancestor::*[contains(@class, ' topic/entry ')]/@width"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="width">1in</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="reference-orientation" select="ancestor::*[contains(@class, ' topic/entry ')]/@orientation"/>
                    <fo:block xsl:use-attribute-sets="p.tables">
                        <xsl:call-template name="resize_font"/>
                        <xsl:call-template name="commonattributes"/>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:block-container>
            </xsl:when>
            <xsl:otherwise>
                <fo:block reference-orientation="90" xsl:use-attribute-sets="p.tables">
                    <xsl:call-template name="resize_font"/>
                    <xsl:call-template name="commonattributes"/>
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/p ')][parent::*[contains(@class, ' topic/entry ')][not[1]]]" priority="5">       
        <xsl:choose>
            <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')][@orientation]">
                <fo:block-container vertical-align="middle">
                    <xsl:choose>
                        <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]/@width">
                            <xsl:attribute name="width" select="ancestor::*[contains(@class, ' topic/entry ')]/@width"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="width">1in</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="reference-orientation" select="ancestor::*[contains(@class, ' topic/entry ')]/@orientation"/>
                    <fo:block reference-orientation="90" xsl:use-attribute-sets="p.tables">
                        <xsl:call-template name="resize_font"/>
                        <xsl:call-template name="commonattributes"/>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:block-container>
            </xsl:when>
            <xsl:otherwise>
                <fo:block-container>
                    <xsl:call-template name="rotate_table_entry"/>
                    <fo:block xsl:use-attribute-sets="p.tables">
                        <xsl:call-template name="rotate_p"/>
                        <xsl:call-template name="resize_font"/>
                        <xsl:call-template name="commonattributes"/>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:block-container>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- End of overridden templates -->
    
    <!-- Allow rotation of table entries. This just takes care of the alignment of the contents. The actual rotation is taken care of in the block-container element within the entry -->
    <xsl:template name="rotate_table_entry">
        <xsl:variable name="rotate_value"><xsl:call-template name="findRotateValue"/></xsl:variable>
        <xsl:if test="contains($rotate_value,  'rotate')">
            <xsl:attribute name="reference-orientation">90</xsl:attribute>
            <xsl:attribute name="vertical-align">middle</xsl:attribute>
            <xsl:attribute name="width">100px</xsl:attribute>
        </xsl:if>      
    </xsl:template>    
    
    <xsl:template name="rotate_p">
        <xsl:variable name="rotate_value"><xsl:call-template name="findRotateValue"/></xsl:variable>
        <xsl:if test="contains($rotate_value,  'rotate')">
            <xsl:attribute name="reference-orientation">90</xsl:attribute>
            <xsl:attribute name="text-align">center</xsl:attribute>
            <xsl:attribute name="display-align">center</xsl:attribute>
        </xsl:if>      
    </xsl:template>
    
    <xsl:template name="findRotateValue">
        <xsl:choose>
            <xsl:when test="contains(@otherprops, 'rotate_text')">
                <xsl:text>rotate</xsl:text>
            </xsl:when>
            <xsl:when test="ancestor::*[contains(@class, ' topic/row ')][contains(@otherprops, 'rotate_text')]">
                <xsl:text>rotate</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="parent::*[@namest]">
                        <xsl:variable name="namest" select="parent::*[@namest]"/>
                        <xsl:if test="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][@colname = $namest][contains(@otherprops, 'rotate_text')]">
                            <xsl:text>rotate</xsl:text>
                        </xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="current_cell">
                            <xsl:call-template name="determine-current-cell">
                                <xsl:with-param name="dataset" select="parent::*/preceding-sibling::*[contains(@class, ' topic/entry ')]"/>
                            </xsl:call-template>
                        </xsl:variable>
                        <xsl:if test="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][number($current_cell)][contains(@otherprops, 'rotate_text')]">
                            <xsl:text>rotate</xsl:text>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="determine-current-cell">
        <!-- A template to determine the correct colspec element that an individual cell refers too -->
        <xsl:param name="dataset"/>
        <xsl:param name="running_count" select="0"/>
        <xsl:param name="position" select="1"/>
        <xsl:choose>
            <xsl:when test="$position &lt;= count($dataset)">
                <xsl:choose>
                    <xsl:when test="$dataset[$position][@namest]">
                        <xsl:variable name="namest" select="$dataset[$position]/@namest"/>
                        <xsl:variable name="nameend" select="$dataset[$position]/@nameend"/>
                        <xsl:variable name="starting_colpec" select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][1][@colname = $namest]/position()"/>
                        <xsl:variable name="ending_colspec" select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][1][@colname = $nameend]/position()"/>
                        <xsl:call-template name="determine-current-cell">
                            <xsl:with-param name="dataset" select="$dataset"/>
                            <xsl:with-param name="running_count" select="$running_count + ($ending_colspec - $starting_colpec) + 1"/>
                            <xsl:with-param name="position" select="$position + 1"/>
                        </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:call-template name="determine-current-cell">
                            <xsl:with-param name="dataset" select="$dataset"/>
                            <xsl:with-param name="running_count" select="$running_count + 1"/>
                            <xsl:with-param name="position" select="$position + 1"/>
                        </xsl:call-template>
                    </xsl:otherwise>                    
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <!-- This whole exercise has been to determine how many cells preceed the current one, so add one more to bring us up to the present. -->
                <xsl:value-of select="$running_count + 1"/>
            </xsl:otherwise>
        </xsl:choose>        
    </xsl:template>
    
    
    <!-- Allow rotation of table entries. This just takes care of the alignment of the contents. The actual rotation is taken care of in the block-container element within the entry -->
    <xsl:template name="rotate_entry">
        <xsl:if test="@orientation">
            <xsl:attribute name="text-align">center</xsl:attribute>
            <xsl:attribute name="display-align">center</xsl:attribute>
        </xsl:if>
        <xsl:if test="contains(@otherprops, 'type_size') or ancestor::*[contains(@class, ' topic/table ')][contains(@otherprops, 'type_size')]">
            <xsl:variable name="type_size">
                <xsl:choose>
                    <xsl:when test="contains(@otherprops, 'type_size')">
                        <xsl:call-template name="define-type-size"><xsl:with-param name="string" select="@otherprops"/></xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="temp" select="ancestor::*[contains(@class, ' topic/table ')][contains(@otherprops, 'type_size')]/@otherprops"/>
                        <xsl:call-template name="define-type-size"><xsl:with-param name="string" select="$temp[1]"/></xsl:call-template>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:attribute name="font-size"><xsl:value-of select="$type_size"/>pt</xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/p ')][1][ancestor::*[contains(@class, ' topic/entry ')]]" priority="10">
        <!-- Added rotation to the bag o tricks for handling bit tables -->
        <xsl:choose>
            <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')][@orientation]">
                <fo:block-container>
                    <xsl:choose>
                        <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]/@width">
                            <xsl:attribute name="width" select="ancestor::*[contains(@class, ' topic/entry ')]/@width"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="width">1in</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="reference-orientation" select="ancestor::*[contains(@class, ' topic/entry ')]/@orientation"/>
                    <fo:block xsl:use-attribute-sets="p.tables">
                        <xsl:call-template name="resize_font"/>
                        <xsl:call-template name="commonattributes"/>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:block-container>
            </xsl:when>
            <xsl:otherwise>
                <fo:block reference-orientation="90" xsl:use-attribute-sets="p.tables">
                    <xsl:call-template name="resize_font"/>
                    <xsl:call-template name="commonattributes"/> 
                    <xsl:apply-templates/>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*[contains(@class, ' topic/p ')][ancestor::*[contains(@class, ' topic/entry ')]]" priority="20">
        <!-- Added rotation to the bag o tricks for handling bit tables -->
        <xsl:choose>
            <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')][@orientation]">
                <fo:block-container vertical-align="middle">
                    <xsl:choose>
                        <xsl:when test="ancestor::*[contains(@class, ' topic/entry ')]/@width">
                            <xsl:attribute name="width" select="ancestor::*[contains(@class, ' topic/entry ')]/@width"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="width">1in</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name="reference-orientation" select="ancestor::*[contains(@class, ' topic/entry ')]/@orientation"/>
                    <fo:block reference-orientation="90" xsl:use-attribute-sets="p.tables">
                        <xsl:call-template name="resize_font"/>
                        <xsl:call-template name="commonattributes"/>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:block-container>
            </xsl:when>
            <xsl:otherwise>
                <fo:block-container>
                    <xsl:call-template name="rotate_table_entry"/>
                    <fo:block xsl:use-attribute-sets="p.tables">
                        <xsl:call-template name="rotate_p"/>
                        <xsl:call-template name="resize_font"/>
                        <xsl:call-template name="commonattributes"/><xsl:apply-templates/>
                    </fo:block>
                </fo:block-container>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
</xsl:stylesheet>

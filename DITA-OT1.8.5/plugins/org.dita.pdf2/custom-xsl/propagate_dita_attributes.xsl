<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:deltaxml="http://www.deltaxml.com/ns/well-formed-delta-v1" xmlns:dxx="http://www.deltaxml.com/ns/xml-namespaced-attribute" xmlns:dxa="http://www.deltaxml.com/ns/non-namespaced-attribute" xmlns:pi="http://www.deltaxml.com/ns/processing-instructions" xmlns:svg="http://www.w3.org/2000/svg" xmlns:ot-placeholder="http://suite-sol.com/namespaces/ot-placeholder" xmlns:opentopic="http://www.idiominc.com/opentopic" version="2.0">

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="processing-instruction()">
        <xsl:copy/>
    </xsl:template>

    <xsl:template match="processing-instruction('xxe-serial-numbers')">
        <xsl:copy/>
    </xsl:template>

    <xsl:template match="svg:*">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*[contains(@class, ' topic/body ')]">
        <!-- Add an entry for every attribute that needs propagation from the top level -->        
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">status</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">rev</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">product</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">audience</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">component</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">pmc_phy</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">pmc_switch</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">pmc_package</xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">media</xsl:with-param>                
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">ddr-width</xsl:with-param>                
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">pcie-drive-ports</xsl:with-param>                
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">pcie-host-ports</xsl:with-param>                
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">raid-support</xsl:with-param>                
            </xsl:call-template>
            <xsl:call-template name="propagate_attributes">
                <xsl:with-param name="attribute">sas-ports</xsl:with-param>                
            </xsl:call-template>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <!-- This template should detect any ancestor-or-self nodes in the opentopic-map area that have values that need to be pushed down to the topic body level -->
    <xsl:template name="propagate_attributes">
        <xsl:param name="attribute"/>
        <xsl:variable name="ID" select="parent::*[@class, ' topic/topic ']/@id"/>
        <xsl:if test="//opentopic:map//node()[@id = $ID]/ancestor-or-self::node()[@*[name() = $attribute]] or ancestor::*[@*[name() = $attribute]]">
            <xsl:variable name="currentatts" select="@*[name() = $attribute]"/>
            <xsl:variable name="varsets" select="//opentopic:map//node()[@id = $ID]/ancestor-or-self::node()[@*[name() = $attribute]] | ancestor::*[@*[name() = $attribute]]"/>
            <xsl:attribute name="{$attribute}">
                <xsl:call-template name="manage_ancestors">
                    <!-- the current value of the current attribute, if there is one -->
                    <xsl:with-param name="currentAttString">
                        <xsl:value-of select="$currentatts"/>
                    </xsl:with-param>
                    <!-- the nodeset of values in the opentopic:map section that have one or more values of the current type -->
                    <xsl:with-param name="ancestorVarsets" select="$varsets"/>
                    <!-- the name of the attribute currently being processed. -->
                    <xsl:with-param name="currentAttName">
                        <xsl:value-of select="$attribute"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <!-- This template should take the nodeset of ancestor nodes with values and process them one at a time -->
    <xsl:template name="manage_ancestors">
        <xsl:param name="currentAttString"/>
        <xsl:param name="ancestorVarsets"/>
        <xsl:param name="currentAttName"/>
        <!-- count is used to track the number of nodes processed so far. -->
        <xsl:param name="count" select="1"/>
        <xsl:variable name="nodeCount" select="count($ancestorVarsets)"/>
        <xsl:choose>
            <xsl:when test="$count &lt;= $nodeCount">
                <xsl:call-template name="process_ancestor_attributes">
                    <xsl:with-param name="currentAncestor">
                        <xsl:value-of select="string($ancestorVarsets[$count]/@*[name() = $currentAttName])"/>
                    </xsl:with-param>
                    <xsl:with-param name="currentAttString">
                        <xsl:value-of select="$currentAttString"/>
                    </xsl:with-param>
                    <xsl:with-param name="currentAttName">
                        <xsl:value-of select="$currentAttName"/>
                    </xsl:with-param>
                    <xsl:with-param name="ancestorVarsets" select="$ancestorVarsets"/>
                    <xsl:with-param name="count" select="$count"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$currentAttString"/><xsl:text> </xsl:text>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="process_ancestor_attributes">
        <xsl:param name="currentAttString"/>
        <xsl:param name="currentAttName"/>
        <xsl:param name="currentAncestor"/>
        <xsl:param name="ancestorVarsets"/>
        <xsl:param name="count"/>
        <!-- localCount is used to track the number of attribute values processed from the current ancestor's attribute set -->
        <xsl:param name="localCount" select="1"/>
        <xsl:variable name="currentAncestorAttSet" select="tokenize(string($currentAncestor), ' ')"/>
        <xsl:variable name="attCount" select="count($currentAncestorAttSet)"/>
        <xsl:choose>
            <xsl:when test="$localCount &lt;= $attCount">
                <xsl:choose>
                    <!-- the existing attribute on the target node already contains the value -->
                    <xsl:when test="contains($currentAttString, $currentAncestorAttSet[$localCount])">
                        <xsl:call-template name="process_ancestor_attributes">
                            <xsl:with-param name="currentAttString" select="$currentAttString"/>
                            <xsl:with-param name="currentAttName" select="$currentAttName"/>
                            <xsl:with-param name="currentAncestor" select="$currentAncestor"/>
                            <xsl:with-param name="ancestorVarsets" select="$ancestorVarsets"/>
                            <xsl:with-param name="count" select="$count"/>
                            <xsl:with-param name="localCount" select="$localCount + 1"/>
                        </xsl:call-template>
                    </xsl:when>
                    <!-- the existing attribute on the target node does not contain the value, so add it. -->
                    <xsl:otherwise>
                        <xsl:call-template name="process_ancestor_attributes">
                            <xsl:with-param name="currentAttString" select="concat($currentAttString, concat(' ', $currentAncestorAttSet[$localCount]))"/>
                            <xsl:with-param name="currentAttName" select="$currentAttName"/>
                            <xsl:with-param name="currentAncestor" select="$currentAncestor"/>
                            <xsl:with-param name="ancestorVarsets" select="$ancestorVarsets"/>
                            <xsl:with-param name="count" select="$count"/>
                            <xsl:with-param name="localCount" select="$localCount + 1"/>                            
                        </xsl:call-template>
                        <xsl:message> adding <xsl:value-of select="$currentAttName"/>:<xsl:value-of select="$currentAttString"/></xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <!-- processed all the attribute values for the current ancestor. return to the previous template and increment the count -->
            <xsl:otherwise>
                <xsl:call-template name="manage_ancestors">
                    <xsl:with-param name="currentAttString" select="$currentAttString"/>
                    <xsl:with-param name="currentAttName" select="$currentAttName"/>
                    <xsl:with-param name="ancestorVarsets" select="$ancestorVarsets"/>
                    <xsl:with-param name="count" select="number($count + 1)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Propogate filtering values from the colspec to the entries 

    <xsl:template match="*[contains(@class, ' topic/entry ')]">
        <xsl:variable name="colspec_number"><xsl:call-template name="determine-current-cell">
            <xsl:with-param name="dataset" select="preceding-sibling::*[contains(@class, ' topic/entry ')]"/>
        </xsl:call-template></xsl:variable>
       
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:call-template name="propagate_colspec_attributes">
                <xsl:with-param name="attribute">product</xsl:with-param>
                <xsl:with-param name="colspec_number" select="$colspec_number"/>
            </xsl:call-template>
            <xsl:call-template name="propagate_colspec_attributes">
                <xsl:with-param name="attribute">audience</xsl:with-param>
                <xsl:with-param name="colspec_number" select="$colspec_number"/>
            </xsl:call-template>
            <xsl:call-template name="propagate_colspec_attributes">
                <xsl:with-param name="attribute">component</xsl:with-param>
                <xsl:with-param name="colspec_number" select="$colspec_number"/>
            </xsl:call-template>
            <xsl:call-template name="propagate_colspec_attributes">
                <xsl:with-param name="attribute">media</xsl:with-param>
                <xsl:with-param name="colspec_number" select="$colspec_number"/>
            </xsl:call-template>            
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

     This template should detect any ancestor-or-self nodes in the opentopic-map area that have values that need to be pushed down to the topic body level 
    <xsl:template name="propagate_colspec_attributes">
        <xsl:param name="attribute"/>
        <xsl:param name="colspec_number"/>
        <xsl:if test="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][position() = $colspec_number][@*[name() = $attribute]]">
            <xsl:variable name="currentatts" select="@*[name() = $attribute]"/>
            <xsl:variable name="varsets" select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][position() = $colspec_number][@*[name() = $attribute]]"/>
            <xsl:attribute name="{$attribute}">
                <xsl:call-template name="manage_ancestors">
                    the current value of the current attribute, if there is one 
                    <xsl:with-param name="currentAttString">
                        <xsl:value-of select="$currentatts"/>
                    </xsl:with-param>
                    the nodeset of values in the opentopic:map section that have one or more values of the current type 
                    <xsl:with-param name="ancestorVarsets" select="$varsets"/>
                     the name of the attribute currently being processed. 
                    <xsl:with-param name="currentAttName">
                        <xsl:value-of select="$attribute"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:attribute>
        </xsl:if>
    </xsl:template>

    <xsl:template name="determine-current-cell">
         A template to determine the correct colspec element that an individual cell refers too 
        <xsl:param name="dataset"/>
        <xsl:param name="running_count" select="0"/>
        <xsl:param name="position" select="1"/>
        <xsl:choose>
            <xsl:when test="$position &lt;= count($dataset)">
                <xsl:choose>
                    <xsl:when test="$dataset[$position][@namest]">
                        <xsl:variable name="namest" select="$dataset[$position]/@namest"/>
                        <xsl:variable name="nameend" select="$dataset[$position]/@nameend"/>
                        <xsl:variable name="starting_colpec" select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][@colname = $namest]/position()"/>
                        <xsl:variable name="ending_colspec" select="ancestor::*[contains(@class, ' topic/tgroup ')]/*[contains(@class, ' topic/colspec ')][@colname = $nameend]/position()"/>
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
                 This whole exercise has been to determine how many cells preceed the current one, so add one more to bring us up to the present. 
                <xsl:value-of select="$running_count + 1"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template> -->


</xsl:stylesheet>
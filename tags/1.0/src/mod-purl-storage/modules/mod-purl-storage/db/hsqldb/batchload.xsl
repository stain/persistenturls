<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="purls">
        <batch>
            <xsl:apply-templates/>
        </batch>
    </xsl:template>
    
    <xsl:template match="purl">       
        <sql>
            INSERT INTO purls VALUES( null, '<xsl:value-of select="@id"/>', '<xsl:value-of select="@type"/>', '<xsl:value-of select="*/@url"/>', NOW, NOW, 1, 'false');
        </sql>
        
        <sql>
        	INSERT INTO purlhistory VALUES(null, IDENTITY(), @@CURRENTUSER@@, 0, '<xsl:value-of select="@type"/>', '<xsl:value-of select="*/@url"/>', NOW);
        </sql>        
        <xsl:for-each select="maintainers/maintainer">
            <sql>
                INSERT INTO purlmaintainers VALUES(null, 0, @@MAINTAINER-<xsl:value-of select="@id"/>@@, 0);
            </sql>
            <sql>
            	UPDATE purlmaintainers set "p_id" = (select "z_id" from purls where "p_id" = '<xsl:value-of select="../../@id"/>') where "z_id" = IDENTITY();
            </sql>
        </xsl:for-each>
        <xsl:apply-templates/>
    </xsl:template>  
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" 
    
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template name="Work">
<nav>
                    <ul> Navigate section
                        <li><a href="#general">General</a></li>
                        <li><a href="#description">Description</a></li>
                        <li><a href="#relations">Relations</a></li>
                        
                    </ul>
                   
                </nav>
                <section id="general">
                    <h1>
                        <xsl:if test="//t:titleStmt/t:author">
                           <a href="#{@corresp}"> <xsl:value-of select="//t:titleStmt/t:author"/></a>
                        </xsl:if>
                        <xsl:text>, </xsl:text>
                       <i> <xsl:if test="//t:titleStmt/t:title">
                            <xsl:value-of select="//t:titleStmt/t:title[@xml:id='t1']"/>
                        </xsl:if></i>
                    </h1>
                    <p>Edited by <xsl:apply-templates
                        select="//t:titleStmt/t:editor[not(@role = 'generalEditor')]/@key"/> <xsl:if test="//t:publicationStmt/t:date">on
                            <xsl:value-of
                            select="format-date(//t:publicationStmt/t:date, '[D].[M].[Y]')"
                        /></xsl:if></p></section>
                
        <section  id="description">
                    <h2>General description</h2>
                    <p><xsl:apply-templates select="//t:abstract"/></p>
                    
                    <h2>Date</h2> 
                    <p><xsl:apply-templates select="//t:creation"/> <xsl:if test="//t:creation/@evidence">(<xsl:value-of select="//t:creation/@evidence"/>)</xsl:if></p>
                    
                    <h2>Witnesses</h2>
                    <p>This edition is based on the following manuscripts</p>
            <ul>
                <xsl:for-each select="//t:witness">
                    <li><a href="{@corresp}"><xsl:choose>
                        <xsl:when test="text()"><xsl:value-of select="text()"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="substring-after(@corresp,'#')"/></xsl:otherwise>
                    </xsl:choose></a><xsl:if test="@type"> (<xsl:value-of select="@type"/>)</xsl:if></li>
                </xsl:for-each>
            </ul>
                    <h2>Bibliography</h2>
                    <xsl:apply-templates select="//t:listBibl"/>
                    
                </section>
                
                
                
                <section id="relations">
                
                
                <table>
                    <caption>Relations of this Entity with other entities</caption>
                    <thead>
                        <tr>
                            <th>Subject</th>
                            <th>Relation</th>
                            <th>Object</th>
                        </tr>
                    </thead>
                    <xsl:apply-templates mode="reltable" select="//t:listBibl[@type = 'relations']"
                    />
                </table>
                    <xsl:apply-templates select="//t:listBibl[@type = 'relations']" mode="graph"/>
        </section>
                <footer id="footer">
                <h2>Authors</h2>
                <ul>
                   <xsl:apply-templates select="//t:revisionDesc"/>
                                   </ul></footer>
    </xsl:template>
</xsl:stylesheet>
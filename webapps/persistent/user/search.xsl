<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sparql="http://www.w3.org/2005/sparql-results#">
	<xsl:output method="xml" encoding="UTF-8"/>
	<xsl:import href="../search.xsl"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>User Search Results</title>
			</head>
			<body class="user search">
				<h1>User Search Results</h1>
				<form action="/" method="get" class="search">
					<input type="hidden" class="profile" name="user" />
					<input type="text" id="q" name="q" value="" />
					<img class="submit" src="/persistent/images/search-button.png" alt="Search" title="Click to search" />
				</form>
				<ul id="results">
					<xsl:apply-templates />
					<xsl:if test="count(/sparql:sparql/sparql:results/sparql:result)=0">
						<p>No results found.</p>
					</xsl:if>
				</ul>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="sparql:result">
		<li>
			<a href="{sparql:binding[@name='uri']/sparql:uri}?view">
				<xsl:apply-templates select="sparql:binding[@name='label']/*" />
			</a>
			<xsl:text> [</xsl:text>
			<a href="{sparql:binding[@name='uri']/sparql:uri}?edit">edit</a>
			<xsl:text>] </xsl:text>
		</li>
	</xsl:template>
</xsl:stylesheet>

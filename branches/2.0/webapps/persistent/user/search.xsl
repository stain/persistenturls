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
				<form action="" method="get" class="search">
					<input name="user" type="hidden" />
					<label for="q">Search again:</label>
					<input type="text" id="q" name="q" value="" />
					<button type="image" src="/persistent/images/search.png"></button>
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
</xsl:stylesheet>
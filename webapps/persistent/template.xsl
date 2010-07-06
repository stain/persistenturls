<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="xslt" select="'/persistent/template.xsl'" />
	<xsl:param name="mode" />
	<xsl:variable name="origin" select="substring-before($xslt, '/persistent')" />
	<xsl:variable name="callimachus" select="concat($origin, '/callimachus')" />
	<xsl:variable name="persistent" select="concat($origin, '/persistent')" />
	<xsl:variable name="server" select="concat($origin, '/persistent/server')" />
	<xsl:variable name="user" select="concat($origin, '/persistent/user')" />
	<xsl:variable name="images" select="concat($origin, '/persistent/images')" />
	<xsl:variable name="section" select="/html/body/@class" />
	<xsl:template match="*">
		<xsl:copy>
			<xsl:apply-templates select="@*|*|comment()|text()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@*">
		<xsl:attribute name="{name()}">
			<xsl:choose>
				<xsl:when test="starts-with(., '/')">
					<xsl:value-of select="$origin"/>
					<xsl:value-of select="." />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="." />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="comment()">
		<xsl:copy />
	</xsl:template>
	<xsl:template match="head">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<style type="text/css">@import url("<xsl:value-of select="$persistent"/>/style.css");</style>
			<script type="text/javascript" src="{$callimachus}/jquery.js">
			</script>
			<script type="text/javascript" src="{$callimachus}/jquery-ui.js">
			</script>
			<script type="text/javascript" src="{$callimachus}/jquery.qtip.js">
			</script>
			<script type="text/javascript" src="{$callimachus}/jquery.rdfquery.rdfa.js">
			</script>
			<script type="text/javascript" src="{$callimachus}/status.js">
			</script>
			<script type="text/javascript" src="{$callimachus}/elements.js">
			</script>
			<script type="text/javascript" src="{$callimachus}/diverted.js">
			</script>
			<script type="text/javascript" src="{$persistent}/base.js">
			</script>
			<script type="text/javascript" src="{$persistent}/ui.js">
			</script>
			<xsl:if test="contains($mode, 'copy')">
				<script type="text/javascript" src="{$callimachus}/copy.js">
				</script>
			</xsl:if>
			<xsl:if test="contains($mode, 'edit')">
				<script type="text/javascript" src="{$callimachus}/edit.js">
				</script>
			</xsl:if>
			<xsl:if test="contains($mode, 'delete')">
				<script type="text/javascript" src="{$callimachus}/delete.js">
				</script>
				<script type="text/javascript" src="{$persistent}/delete.js">
				</script>
			</xsl:if>
			<xsl:if test="starts-with($mode, 'pre-')">
				<script>
					// <![CDATA[
					onload = function() {
						$("a[href]").each(function() {
							var href = this.href
							var q = href.indexOf('?')
							if (q >= 0 && href.substring(q) == "?edit") {
								this.href = href.substring(0, q) + "?pre-edit"
							} else if (q >= 0 && href.substring(q) == "?view") {
								this.href = href.substring(0, q) + "?pre-view"
							} else if (q < 0) {
								this.href = href + "?pre-view"
							} else {
								$(this).attr("target", "_blank")
							}
						})
					}
					// ]]>
				</script>
			</xsl:if>
			<xsl:apply-templates select="*|text()|comment()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="body">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:if test="not(starts-with($mode, 'pre-'))">
				<div id="home">
					<a href="{$origin}/">
						<img src="{$images}/web-color-sm.png" alt="PURLz logo"/>
					</a>
				</div>
				<div id="header">
					<ul id="actions" class="{$mode}">
						<li class="view">
							<xsl:choose>
								<xsl:when test="$mode='view'">
									<span class="current">View</span>
								</xsl:when>
								<xsl:otherwise>
									<a class="diverted" title="View this item" href="?view">View</a>
								</xsl:otherwise>
							</xsl:choose>
						</li>
						<li class="edit">
							<xsl:choose>
								<xsl:when test="$mode='edit' or $mode='delete'">
									<span class="current">Edit</span>
								</xsl:when>
								<xsl:otherwise>
									<a class="diverted" title="Edit this item" href="?edit">Edit</a>
								</xsl:otherwise>
							</xsl:choose>
						</li>
						<li class="history">
							<xsl:choose>
								<xsl:when test="$mode='review'">
									<span class="current">History</span>
								</xsl:when>
								<xsl:otherwise>
									<a class="diverted" title="See this item's history" href="?review">History</a>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</ul>
					<div id="account">
						<strong><a id="username" href="{$origin}/persistent/authority?credential"></a></strong>
						<a id="login" href="{$origin}/persistent/authority?login">Login</a>
						<span class="logout">&#160;&#183;&#160;</span>
						<a class="logout" href="{$origin}/persistent/authority?logout">Logout</a>
					</div>
					<div class="clear">&#160;</div>
				</div>

				<ul id="menu">
					<li>
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="contains($section, 'purl')">
									<xsl:text>active</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>inactive</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<a href="{$origin}/?purl">PURLs</a>
						<form action="{$origin}/" method="get" title="Search PURL maintainers and curators" class="search">
							<input name="purl" type="hidden" class="profile" />
							<input id="purl_menu_q" name="q" type="text" value="" />
							<img class="submit" src="{$origin}/persistent/images/search-button.png" alt="Search" title="Click to search" />
						</form>
					</li>
					<li>
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="contains($section, 'user')">
									<xsl:text>active</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>inactive</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<a href="{$origin}/?user">Users</a>
						<form action="{$origin}/" method="get" title="Search usernames" class="search">
							<input name="user" type="hidden" class="profile" />
							<input id="user_menu_q" name="q" type="text" />
							<img class="submit" src="{$origin}/persistent/images/search-button.png" alt="Search" title="Click to search" />
						</form>
					</li>
					<li>
						<xsl:attribute name="class">
							<xsl:choose>
								<xsl:when test="contains($section, 'domain')">
									<xsl:text>active</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>inactive</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<a href="{$origin}/?domain">Domains</a>
						<form action="{$origin}/" method="get" title="Search maintainers and curators" class="search">
							<input name="domain" type="hidden" class="profile" />
							<input id="domain_form_q" name="q" type="text" />
							<img class="submit" src="{$origin}/persistent/images/search-button.png" alt="Search" title="Click to search" />
						</form>
					</li>
					<li class="inactive">
						<a href="{$origin}/docs/help.html#{$section}">Help</a>
					</li>
				</ul>
			</xsl:if>

			<div id="content">
				<ul id="breadcrumbs">
					<li class="home"><a href="{$origin}/">Home</a></li>
					<xsl:choose>
						<xsl:when test="contains($section, 'user')">
							<li><span>Users</span></li>
						</xsl:when>
						<xsl:when test="contains($section, 'domain') and not(contains($section, 'search'))">
							<li><a rel="purl:domainOf" href="?origin" class="diverted"><span property="rdfs:label"/> (Origin)</a></li>
							<li><span>Domains</span></li>
						</xsl:when>
						<xsl:when test="contains($section, 'purl') and not(contains($section, 'search'))">
							<li><span rev="purl:partOf" resource="?domain"><a rel="purl:domainOf" href="?origin" class="diverted"><span property="rdfs:label"/> (Origin)</a></span></li>
							<li><a rev="purl:partOf" href="?domain" class="diverted"><span property="rdfs:label"/> (Domain)</a></li>
							<li><span>PURLs</span></li>
						</xsl:when>
						<xsl:when test="contains($section, 'search')">
							<li><span>Search</span></li>
						</xsl:when>
					</xsl:choose>
				</ul>
				<div id="message-container">
					<p id="message" />
				</div>
				<xsl:apply-templates select="*|comment()|text()" />
				<div class="clear">&#160;</div>
			</div>

			<xsl:if test="not(starts-with($mode, 'pre-'))">
				<div class="clear">&#160;</div>
				<div id="footer">
					<a href="http://zepheira.com/" title="Zepheira">
						<img src="{$images}/zepheiralogo.png" alt="Zepheira logo" />
					</a>
				</div>
			</xsl:if>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>

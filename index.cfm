<cfscript>
/**
* 
* This file is part of MuraSocial
*
* Copyright 2015 John Sieber
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
</cfscript>
<style type="text/css">
	#bodyWrap h3{padding-top:1em;}
	#bodyWrap ul{padding:0 0.75em;margin:0 0.75em;}
</style>
<cfsavecontent variable="body"><cfoutput>
<div id="bodyWrap">
	<h1>#HTMLEditFormat(pluginConfig.getName())#</h1>
	<p>This is a starter plugin to jumpstart your next Mura CMS plugin.</p>

	<!---
	<h3>pluginConfig</h3>
	<cfdump var="#pluginConfig#" label="pluginConfig" />
	--->

	<h3>Tested With</h3>
	<ul>
		<li>Mura CMS Core Version <strong>6.1+</strong></li>
		<li>Adobe ColdFusion <strong>10.0.0</strong></li>
		<li>Lucee <strong>4.5.0</strong></li>
	</ul>

	<h3>Need help?</h3>
	<p>If you're running into an issue, please let me know at <a href="https://github.com/stevewithington/#HTMLEditFormat(pluginConfig.getPackage())#/issues">https://github.com/stevewithington/#HTMLEditFormat(pluginConfig.getPackage())#/issues</a> and I'll try to address it as soon as I can.</p>
	
	<p>Thanks!<br />
	<a href="http://john-sieber.com">John Sieber</a></p>
</div>
</cfoutput></cfsavecontent>
<cfoutput>
	#$.getBean('pluginManager').renderAdminTemplate(
		body = body
		, pageTitle = ''
		, jsLib = 'jquery'
		, jsLibLoaded = false
	)#
</cfoutput>
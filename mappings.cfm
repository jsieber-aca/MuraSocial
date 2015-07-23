<!--- Do Not Edit --->
<cfif not isDefined('this.name')>
<cfoutput>Access Restricted.</cfoutput>
<cfabort>
</cfif>
<cfset pluginDir=getDirectoryFromPath(getCurrentTemplatePath())/>
<cfset this.mappings["/plugins"] = pluginDir>
<cfset this.mappings["/Hoth"] = pluginDir & "Hoth">
<cfset this.mappings["/MuraFW1"] = pluginDir & "MuraFW1">
<cfset this.mappings["/MuraMeta"] = pluginDir & "MuraMeta">
<cfset this.mappings["/MuraSocial"] = pluginDir & "MuraSocial">
<cfset this.mappings["/MuraStrava"] = pluginDir & "MuraStrava">

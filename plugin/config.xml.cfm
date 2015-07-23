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
	include 'settings.cfm';
</cfscript>
<cfoutput>
	<plugin>

		<name>#variables.settings.pluginName#</name>
		<package>#variables.settings.package#</package>
		<directoryFormat>packageOnly</directoryFormat>
		<loadPriority>#variables.settings.loadPriority#</loadPriority>
		<version>#variables.settings.version#</version>
		<provider>#variables.settings.provider#</provider>
		<providerURL>#variables.settings.providerURL#</providerURL>
		<category>#variables.settings.category#</category>
		
		<settings>
			<setting>
				<name>facebookPageAccessToken</name>
				<label>Facebook Page Access Token</label>
				<hint>Follow instructions in the Readme file to create a Page Access Token that will not expire. You can override this setting on the Site Settings Extended Attribute Tab</hint>
				<type>text</type>
				<required>true</required>
				<validation>none</validation>
				<regex></regex>
				<message></message>
				<defaultvalue></defaultvalue>
				<optionlist></optionlist>
				<optionlabellist></optionlabellist>
			</setting>
            
            <setting>
				<name>facebookPageId</name>
				<label>Facebook Page ID</label>
				<hint>Facebook Page ID can be found on the Page Info section of the About tab.</hint>
				<type>text</type>
				<required>true</required>
				<validation>none</validation>
				<regex></regex>
				<message></message>
				<defaultvalue></defaultvalue>
				<optionlist></optionlist>
				<optionlabellist></optionlabellist>
			</setting>

		</settings>

		<!-- Event Handlers -->
		<eventHandlers>
			<!-- only need to register the eventHandler.cfc via onApplicationLoad() -->
			<eventHandler 
				event="onApplicationLoad" 
				component="extensions.eventHandler" 
				persist="false" />
		</eventHandlers>

		<!--
			Display Objects :
			Allows developers to provide widgets that end users can apply to a
			content node's display region(s) when editing a page. They'll be
			listed under the Layout & Objects tab. The 'persist' attribute
			for CFC-based objects determine whether they are cached or instantiated
			on a per-request basis.
		-->
		<displayobjects location="global">


		</displayobjects>

		<extensions>
            <extension type="Site">
                <attributeset name="MuraSocial Options" container="Default">
                    <attribute
                        name="pageAccessToken"
                        label="Facebook Page Access Token"
                        hint="Follow instruction in plugin readme file to create a non expiring Facebook Page Access Token"
                        type="text"
                        defaultvalue=""
                        required="false"
                        validation=""
                        regex=""
                        message=""
                        optionList=""
                        optionLabelList="" />
                    
                    <attribute
                        name="pageID"
                        label="Facebook Page ID"
                        hint="Facebook Page ID can be found on the Page Info section of the About tab."
                        type="text"
                        defaultvalue=""
                        required="false"
                        validation=""
                        regex=""
                        message=""
                        optionList=""
                        optionLabelList="" />
                </attributeset>
            </extension>
			<extension type="Page" subType="Default">
				<attributeset name="Mura Social" container="Publishing">
					<attribute 
						name="postToFacebook"
						label="Post to Facebook"
						hint="Will post page content to Facebook Page when published."
						type="radioGroup"
						defaultValue="0"
						required="false"
						validation=""
						regex=""
						message=""
						optionList="1^0"
						optionLabelList="Yes^No" />
				</attributeset>
			</extension>
			
		</extensions>

	</plugin>
</cfoutput>
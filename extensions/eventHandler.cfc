/**
* 
* This file is part of MuraSocial
*
* Copyright 2015 John Sieber
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component accessors=true extends='mura.plugin.pluginGenericEventHandler' output=false {

	property name='$' hint='mura scope';
    property name='fbSocialManager';
    property name='fbSocialGateway';

	include '../plugin/settings.cfm';

	public any function onApplicationLoad(required struct $) {
		// Register all event handlers/listeners of this .cfc with Mura CMS
		variables.pluginConfig.addEventHandler(this);

		// Makes any methods of the object accessible via application.yourPluginPackageName
		lock scope='application' type='exclusive' timeout=10 {
			application[variables.settings.package] = new contentRenderer(arguments.$);
		}
        var tp = arguments.$.initTracePoint('MuraSocial.extensions.eventHandler.onApplicationLoad');
        arguments.$.commitTracePoint(tp);
		set$(arguments.$);
	}

	public any function onSiteRequestStart(required struct $) {
		var tp = arguments.$.initTracePoint('MuraSocial.extensions.eventHandler.onBeforePageDefaultSave');
        // Makes any methods of the object accessible via $.yourPluginPackageName
		var contentRenderer = new contentRenderer(arguments.$);
		var fbSocialManager = getfbSocialManager(arguments.$);
		arguments.$.setCustomMuraScopeKey(variables.settings.package, contentRenderer);
        arguments.$.setCustomMuraScopeKey('fbSocialManager', fbSocialManager);
        arguments.$.setCustomMuraScopeKey('fbSocialEventHandler', this);
		


        arguments.$.commitTracePoint(tp);
        set$(arguments.$);
	}
    

    public any function onBeforePageDefaultSave(required struct $) {
		var tp = arguments.$.initTracePoint('MuraSocial.extensions.eventHandler.onBeforePageDefaultSave');
        var fbSocialManager = getfbSocialManager(arguments.$);
		var errors = {};
		var error = '';
		var debug = arguments.$.globalConfig('debuggingenabled') == true ? true : false;
		var newBean = arguments.$.event('newBean');
		var oldBean = arguments.$.event('contentBean');
        var post = '';
        var postTime = '';
		var cleanSummary = '';
		var contentLink = '';
		
        // writeDump(var="#$.content().getAllValues()#", top=1, abort=true);
        
        // $.content('postToFacebook') Class extension for setting up content to be posted values are 0 or 1

        if($.content('postToFacebook')){
            // set postToFacebook back to no.
            
            $.content('postToFacebook', '0');
            // content is set to display immediately and has been approved.
			if($.content('display') eq 1 && $.content('approved')) {
                postTime = dateAdd("n", 15, now());
				writeLog(file="MuraSocial", text="Display Value - #$.content('display')# Approved Value - #$.content('approved')# Post Time - #postTime#");
            }else if($.content('display') eq 2 && $.content('approved')){
				if(dateCompare($.content('displayStart'), now()) == 1){
					// dispaly date is in the future due to scheduled mura content - setup scheduled Facebook post.
					postTime = dateAdd("n", 15, $.content('displayStart'));
					writeLog(file="MuraSocial", text="Display Value - #$.content('display')# Approved Value - #$.content('approved')# Post Time - #postTime#");
				}else{
					// content that was previously scheduled, but is now live. Schedule in ten minutes
					postTime = dateAdd("n", 15, now());
					writeLog(file="MuraSocial", text="Display Value - #$.content('display')# Approved Value - #$.content('approved')# Post Time - #postTime#");
				}
			}
			// post to Facebook
			contentLink = (len($.content('postToFacebookLink'))) ? $.content('postToFacebookLink') : $.content().getURL(complete='true');
			postTimeUTC = fbSocialManager.getfbSocialGateway().dateToUTC(postTime);
			cleanSummary = event.getContentRenderer().stripHTML($.content('summary'));
			post = fbSocialManager.getfbSocialGateway().postToFacebookPage(message="#$.content('title')#"
                                                        , link="#contentLink#"
                                                        , description="#cleanSummary#"
                                                        , name=""
                                                        , picture="#$.getURLForImage(fileid=$.content('fileid'), size='large', complete=true)#"
                                                        , published="false"
                                                        , scheduled_publish_time="#postTimeUTC#");
                                                        
         	response = deserializeJSON(post.filecontent);
			// writeDump(var="#response#", abort=true);  
				
            if( isStruct(post) && ! fbSocialManager.isValidResponse(post)){
                StructAppend($.content('errors'), {
						'#StructCount($.content('errors'))+1#' = '#post.Statuscode# - #response.error.message# Schedule publish time must be within 10 minutes to 6 months from the time of publish.'
					});
            }else{
				writeLog(file="MuraSocial", text="#$.content('lastUpdateBy')# has posted to Facebook. Post id: #response.id#")
			}
          	
        }
		
	}


    // --------------------------------------------------------------------------------------
	//	HELPERS

    public any function getfbSocialManager($=get$()) {
		var tp = arguments.$.initTracePoint('MuraSocial.extensions.eventHandler.getMuraSocialManager');
		var pageId = Len(arguments.$.siteConfig('facebookPageId')) 
			? arguments.$.siteConfig('facebookPageId') 
			: pluginConfig.getSetting('facebookPageId');

		var token = Len(arguments.$.siteConfig('facebookPageAccessToken')) 
			? arguments.$.siteConfig('facebookPageAccessToken') 
			: pluginConfig.getSetting('facebookPageAccessToken');

		var fbSocialGateway = new lib.facebook.fbSocialGateway(apiPageId=pageId, apiAccessToken=token);
		var fbSocialManager = new lib.facebook.fbSocialManager(fbSocialGateway);
		arguments.$.commitTracePoint(tp);
		return fbSocialManager;
	}


}
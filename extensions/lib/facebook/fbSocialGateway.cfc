/**
* 
* This file is part of MuraSocial
*
* Copyright 2015 John Sieber
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
component output="false" accessors="true"{

    property name='apiPageId';
    property name='apiAccessToken';
    property name='apiUrl';

    public fbSocialGateway function init(required string apiPageId, required string apiAccessToken, string apiUrl='https://graph.facebook.com'){
        setApiPageId(arguments.apiPageId);
        setApiAccessToken(arguments.apiAccessToken);
        setApiUrl(arguments.apiUrl);
        return this;
    }

    // --------------------------------------------------------------------------------------
    // FACEBOOK POST MURA CONTENT TO FACEBOOK PAGE

    public any function postToFacebookPage(required string message='', required string link='', required string description='', string name='', string caption='', string picture='', boolean published=false, string scheduled_publish_time='') {
        
        var endpoint = getApiUrl() & '/' & getApiPageId() & '/feed';
        var params = {
                 'access_token' = getApiAccessToken() 
                , 'message' = arguments.message
                , 'link' = arguments.link 
                , 'description' = arguments.description 
                , 'name' = arguments.name 
                , 'caption' = arguments.caption 
                , 'picture' = arguments.picture 
                , 'published' = toBoolean(arguments.published) 
                , 'scheduled_publish_time' = arguments.scheduled_publish_time 
        };
        return ping(endpoint=endpoint, method='POST', params=params);
    }


    // --------------------------------------------------------------------------------------
	//	FACEBOOK API STATUS

	public boolean function isConnected() {
		var isConnected = false;
		var endpoint = 'https://www.facebook.com/feeds/api_status.php';
		var response = ping(endpoint=endpoint, method='GET');
		try {
			var result = DeserializeJSON(response.filecontent);
			if ( StructKeyExists(result, 'status') && result.status == 'good' ) {
				isConnected = true;
			}
		} catch(any e) {}
		return isConnected;
	}


    // --------------------------------------------------------------------------------------
	//	HELPERS

	public any function ping(required string endpoint, string method='GET', struct params={}) {
		var response = {};
		var paramtype = '';
		var paramkey = '';
		var httpService = new http();

		httpService.setCharset('utf-8')
			.setMethod(arguments.method)
			.setURL(arguments.endpoint);
		if ( !StructIsEmpty(arguments.params) ) {
			for (paramkey in arguments.params) {
					httpService.addParam(type="formfield",name=paramkey,value=arguments.params[paramkey]);
            }
		}
		return httpService.send().getPrefix();
	}

    public boolean function toBoolean(any arg='') {
		return IsBoolean(arg) && arg ? true : false;
	}
	
	public any function dateToUTC(required any date){
		return dateDiff("s", dateConvert("utc2Local", "January 1 1970 00:00"), arguments.date);
	}
	
	public any function UTCToDate(required any utcdate){
		return dateAdd("s", arguments.utcDate, dateConvert("utc2Local", "January 1 1970 00:00"));
	}

}
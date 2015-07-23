/**
* 
* This file is part of MuraSocial
*
* Copyright 2015 John Sieber
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/

component output="false" accessors="true" {

    property name='fbSocialGateway';
    
    public fbSocialManager function init(required fbSocialGateway) {
        setfbSocialGateway(arguments.fbSocialGateway);
        return this;
    }

    public boolean function isValidResponse(required any response) {
		var resp = arguments.response;
		var isValid = false;

		try {
			switch (resp.Responseheader.Status_Code) {
				case 200 : // OK ... post or read successful etc.
					isValid = true;
					break;
				default : // unknown status code
					break;
			}
		} catch(any e) {
			// any other errors probably means user is not connected to Internet, or the response is an empty string
		}

		return isValid;
	}
}
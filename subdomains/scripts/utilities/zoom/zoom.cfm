<cfset local.api_key="KXsHBU89R9mh7sIMGaCvqw" />
<cfset local.api_secret="dJHZEJyleW6McpQB1yY3Pv2sJvJn8nMsfbn2" />
<cfset local.api_url="https://api.zoom.us/v2/users" />

<cfscript>
    local.date = now();
    local.utcDate = dateConvert('local2utc', local.date);

    payload = {};
    payload['iss'] = local.api_key;
    payload['exp'] = local.date.getTime();

   local.client = new lib.JsonWebTokens().createClient( "HS256", local.api_secret );
   local.JWTObj = local.client.encode(payload,"HS256",local.api_key);
   local.DecodeJWTObj = local.client.decode(local.JWTObj);
 
</cfscript>

<h3>Users</h3>
<cfhttp method="get" url="#local.api_url#" result="userDetails">
    <cfhttpparam type="URL" name="access_token"  value="#local.JWTObj#" />
</cfhttp>

<!--- CFDUMP: Debugging by rdiveley --->
<cfdump var="#deserializeJSON(userDetails.fileContent)#" abort="true" format="html" output="" >


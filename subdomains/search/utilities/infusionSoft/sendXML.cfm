<cfsilent>
<!---
    Wrapper for CFX_HTTP5 (c) 2004-2006 Adiabata, Inc.
    Modify for your purposes, as needed
--->
<cfparam name="attributes.headers" default="">
<cfparam name="attributes.url" default="">
<cfparam name="attributes.out" default="">
<cfif thisTag.HasEndTag EQ false>
   <cfset caller.status="ER">
   <cfset caller.msg="Tag cf_sendXML must have closing tag">
   <cfset caller.errn=1>
<cfelseif trim(thisTag.generatedContent) EQ "">
   <cfset caller.status="ER">
   <cfset caller.msg="Tag cf_sendXML does not have generated content">
   <cfset caller.errn=2>
<cfelse>
   <cfset input=trim(thisTag.generatedContent)>
   <cfset thisTag.generatedContent="">
	<cfset input=ReReplace(input, "#Chr(13)##Chr(10)#[ ]*", "", "ALL")>
   <cfif Len(input) EQ 0>
	   <cfset caller.status="ER">
      <cfset caller.msg="No XML to send">
      <cfset caller.errn=5>
   <cfelseif Len(attributes.url) EQ 0>
      <cfset caller.status="ER">
      <cfset caller.msg="URL attribute was not defined">
      <cfset caller.errn=3>
	<cfelseif Len(attributes.out) EQ 0>
      <cfset caller.status="ER">
      <cfset caller.msg="OUT attribute was not defined">
      <cfset caller.errn=4>
   <cfelse>
      <cfset headers="Content-Type: text/xml; charset=UTF-8#Chr(13)##Chr(10)##attributes.headers#">
      <cfx_http5 url=#attributes.url# method="POST" body=#input# out="caller.#attributes.out#" headers=#headers#>
      <cfset caller.status=status>
      <cfif status EQ "ER">
         <cfset caller.errn=errn>
         <cfset caller.msg=msg>
      </cfif>
   </cfif>
</cfif>
</cfsilent>
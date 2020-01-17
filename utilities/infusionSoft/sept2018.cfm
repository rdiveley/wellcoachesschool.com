<!---     Start Sept 2018             --->
            <!-- AS LONG AS 9781 is in place  [Core 18-Week Teleclass [Jul2018 Fwd] -->
            <cfif  listFindNoCase(attributes.tagList,9921) >
                <!-- THEN 9559 can be applied [Core Jul2018 Mod 1 Habits Surveys Complete]
                    AS WELL AS 9769 which delivers the Certificate of Attendance [Core Jul2018 Mod 1 ALL Surveys Complete] -->

                <!-- 9559 can be applied [Core Jul2018 Mod 1 Habits Surveys Complete]  -->
                <cfset myArray = ArrayNew(1)>
                <cfset myArray[1]="ContactService.addToGroup">
                <cfset myArray[2]="fb7d1fc8a4aab143f6246c090a135a41">
                <cfset myArray[3]="(int)#attributes.memberID#">
                <cfset myArray[4]="(int)9893">

                <cfinvoke component="utilities/XML-RPC"
                    method="CFML2XMLRPC"
                    data="#myArray#"
                    returnvariable="myPackage">

                <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult">
                    <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
                </cfhttp>
            </cfif>
    <!---     End July2018             --->  
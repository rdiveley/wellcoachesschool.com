<style>

div.scroll
{
	background-color:#FFFFFF;
	width:820px;
	height:375px;
	overflow-y:scroll;
	overflow-x: hidden
}
table {
	font: 11px/24px Verdana, Arial, Helvetica, sans-serif;
	border-collapse: collapse;
	width: 800px;
	}

th {
	padding: 0 0.5em;
	text-align: left;
	}

tr.yellow td {
	border-top: 1px solid #FB7A31;
	border-bottom: 1px solid #FB7A31;
	background: #FFC;
	}

td {
	border-bottom: 1px solid #CCC;
	padding: 0 0.5em;
	}

td:first-child {
	width: 150px;
	}

td+td {
	border-left: 1px solid #CCC;
	text-align: left;
	}
	
h2{
	color:#0080ff;
	border-top:1px dotted #0080ff;
	border-bottom:1px dotted #0080ff;
	padding:3px;
	width:100%
}
</style>
<cfinclude template="cfLib/ArrayOfStructsSort.cfc"/>

<cfset key = "74e097c5980ebb52ebfae71b0e575154">

<cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["GroupName"]='HWCT%2013%'><!---tag ID--->
        
        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "GroupName">
     
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="DataService.query"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='ContactGroup'>
        <cfset myArray[4]='(int)1000'>
        <cfset myArray[5]='(int)0'>
        <cfset myArray[6]=selectedFieldStruct>
        <cfset myArray[7]=selectedFieldsArray>
         
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">
        
        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult3">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
        
          <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData">
           

		<cfoutput>
        <cfset hideClass = ['HWCT Suspension Mar 2013'
							,'HWCT Request to Transfer to Nov2013'
							,'HWCT Request to Transfer to Sep2013'
							,'HWCT Request to Transfer to Jul2013'
							,'HWCT Jul 2013 - Complimentary'
							,'HWCT Jul 2013 Membership Q&A Registered'
							,'HWCT May 2013 Membership Q&A Registered'
							] 
		/>
        
        <cfparam name="FORM.tag_list" default="">
        <form method="post">
        	Please select a class to view roster:<br/>
            <select name="tag_list" onChange="submit()">
            <option value="" >--Please select a class --</option>
            <cfloop array="#theData.Params[1]#" index="class">
            	<cfif !arrayFindNoCase(hideClass,class['GroupName'])>
                	<option value="#class['GroupName']#" <cfif class['GroupName'] EQ FORM.tag_list>selected</cfif>>#class['GroupName']#</option>
            	</cfif>
            </cfloop>
            </select>
        </form>
        </cfoutput>

	<cfif structKeyExists(form,'tag_list') and len(FORM.tag_list)>
        <cfset selectedFieldStruct =structNew()>
        <cfset selectedFieldStruct["ContactGroup"]='#FORM.tag_list#'><!---tag ID--->
        
        <cfset selectedFieldsArray = ArrayNew(1)>
        <cfset selectedFieldsArray[1] = "Contact.Email">
        <cfset selectedFieldsArray[2] = "Contact.FirstName">
        <cfset selectedFieldsArray[3] = "Contact.LastName">
        <cfset selectedFieldsArray[4] = "Contact.Nickname">
        
        <cfset myArray = ArrayNew(1)>
        <cfset myArray[1]="DataService.query"><!---Service.method always first param--->
        <cfset myArray[2]=key>
        <cfset myArray[3]='ContactGroupAssign'>
        <cfset myArray[4]='(int)100'>
        <cfset myArray[5]='(int)0'>
        <cfset myArray[6]=selectedFieldStruct>
        <cfset myArray[7]=selectedFieldsArray>
         
        <cfinvoke component="utilities/XML-RPC"
            method="CFML2XMLRPC"
            data="#myArray#"
            returnvariable="myPackage">
        
        <cfhttp method="post" url="https://my982.infusionsoft.com/api/xmlrpc" result="myResult3">
            <cfhttpparam type="XML" value="#myPackage.Trim()#"/>
        </cfhttp>
        
          <cfinvoke component="utilities/XML-RPC"
            method="XMLRPC2CFML"
            data="#myResult3.Filecontent#"
            returnvariable="theData3">
           
		   <cfset sortedStruct = arrayOfStructsSort(theData3.Params[1],'Contact.FirstName') />
        
		<cfoutput>
        	<h2>#FORM.tag_list#</h2>
            <div class="scroll">
            <table id="myTable" class="tablesorter" style="width:800px">
                <thead>
                	<tr class="yellow">
                        <td>First Name</td>
                        <td>Last Name</td>
                        <td>Nick Name</td>
                        <td>Email</td>
                    </tr>
                    <tbody>
                    <cfloop array="#sortedStruct#" index="idx">
                    <tr>
                        <td>#idx['Contact.FirstName']#</td>
                        <td>#idx['Contact.LastName']#</td>
                        <td><cfif structKeyExists(idx,'Contact.NickName')>#idx['Contact.NickName']#</cfif></td>
                        <td><a href="mailto:#idx['Contact.Email']#">#idx['Contact.Email']#</a>
                   </td>
                   </cfloop>
                   </tbody>
                </thead>
           </table>
           </div>
        </cfoutput>
   </cfif>    
   
       
      
     
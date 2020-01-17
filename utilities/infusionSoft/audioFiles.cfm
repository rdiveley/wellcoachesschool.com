
<cfoutput>
<cfajaxproxy cfc="audioFileSubmit" jsclassname="myForm" /> 
<script src="http://code.jquery.com/jquery-1.8.3.js"></script>    
<script src="http://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript" src="js/audio.js"></script>
<link rel="stylesheet" type="text/css" href="css/audio.css"/>
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css"/>

<cfparam name="URL.email" default="">
<cfset admins = "Erika@wellcoaches.com,rdiveley@wellcoaches.com,ldiaz@wellcoaches.com">

<cfif structkeyExists(form,'AddNew')>

 <cfquery name="insertMemberClasses" datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
        	insert into memberClasses
            (
             category
            ,cceh
            ,class_title
            ,download_link
            ,facilitator
            ,handout_link
            ,listen_link
            ,class_date
            ,cip
            ,wcm
            ) 
            values
            (
            	<cfqueryparam value="#form.add_category#" cfsqltype="cf_sql_varchar" />,
                <cfqueryparam value="#form.add_cceh#" cfsqltype="cf_sql_varchar" />,
                <cfqueryparam value="#form.add_class_title#" cfsqltype="cf_sql_varchar" />,
                <cfqueryparam value="#form.add_download_link#" cfsqltype="cf_sql_varchar" />,
               <cfqueryparam value="#form.add_facilitator#" cfsqltype="cf_sql_varchar" />,
                <cfqueryparam value="#form.add_handout_link#" cfsqltype="cf_sql_varchar" />,
                <cfqueryparam value="#form.add_listen_link#" cfsqltype="cf_sql_varchar" />,
                <cfqueryparam value="#form.add_class_date#" cfsqltype="cf_sql_date" />,
                <cfif structkeyExists(form,'add_cip')>
                	1,
                <cfelse>
                	0,    
                </cfif>
                <cfif structkeyExists(form,'add_wcm')>
                	1
                <cfelse>
                	0    
                </cfif>
            )
        </cfquery>
        <cflocation url="#cgi.SCRIPT_NAME#?email=#url.email#">
</cfif>
<cfif NOT structkeyExists(form,'query')>
    <cfquery name="listFiles" datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
        select 
            category
            ,cceh
            ,class_title
            ,download_link
            ,facilitator
            ,handout_link
            ,id
            ,listen_link
            ,class_date
            ,cip
            ,wcm
            ,max(id) as maxID
        FROM memberClasses
            group by id,category, cceh
            ,class_title
            ,download_link
            ,facilitator
            ,handout_link
            ,class_date
            ,id
            ,listen_link
            ,cip
            ,wcm
           
    </cfquery> 
<cfelse>
	<cfif (structkeyExists(form,'dateQuery') AND len(FORM.dateQuery) AND len(FORM.query) EQ 0)>
        <cfquery name="listFiles" datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
            select 
                *
            FROM memberClasses
                where class_date = '#FORM.dateQuery#'    
        </cfquery>
    <cfelse>
    	 <cfquery name="listFiles" datasource="wellcoachesschool" username="#application.DSNuName#" password="#application.dsnpword#" >
            select 
                *
            FROM memberClasses
                where category like '%#form.query#%'
                OR class_title like '%#form.query#%'
                OR facilitator like '%#form.query#%'
                OR handout_link like '%#form.query#%'
                OR listen_link like '%#form.query#%'
                OR download_link like '%#form.query#%'
                OR cceh like '%#form.query#%'
                <cfif structkeyExists(form,'dateQuery') AND len(FORM.dateQuery)>
                    OR class_date = '#FORM.dateQuery#'    
                </cfif>
            
        </cfquery>
    </cfif>    
    
</cfif>

 <div class="datagrid">
<form name="WellcoachesMemberClasses" action="#cgi.SCRIPT_NAME#?email=#url.email#" id="WCMC" method="post">
<p align="right">
Date:<input type="text" class="datePicker" name="dateQuery" />
Text:<input type="text" name="query"></input>
<input class="button" type="submit" value="Search" name="hbtn"></input></p>

<!---<input type="submit" name="submitMeHidden" style="display:none" />--->
 <table >

    
     <thead>
        <tr>
            <th>Category</th>
            <th>Member Class Title</th>
            <th>Facilitator/ Author</th>
            <th>Handout(s) Link</th>
            <th>Listen Link</th>
            <th>Download Link</th>
            <th>CCEH</th>
            <th>Date</th>
            <cfif listFind(admins,URL.email)>
                <th>WCM/WIP</th>
                <th>&nbsp;</th>
            </cfif>
           
        </tr> 
     </thead>   
  <tbody>
        <cfloop query="listFiles"> 
            <tr id="show_row_#id#" bgcolor="###iif(currentrow MOD 2,DE('ffffff'),DE('efefef'))#">
                <td><span id="show_category_#id#">#category#</span></td>
                <td><span id="show_class_title_#id#">#class_title#</span></td>
                <td><span id="show_facilitator_#id#">#facilitator#</span></td>
                <td><span id="show_handout_link_#id#">#handout_link#</span></td>
                <td><span id="show_listen_link_#id#">#listen_link#</span></td>
                <td><span id="show_download_link#id#">#download_link#</span></td>
                <td><span id="show_cceh_#id#">#cceh#</span></td>
                <td><span id="show_class_date_#id#">#DateFormat(class_date,'mm/dd/yyyy')#</span></td>
                <cfif listFind(admins,URL.email)>
                    <td>
                         <span id="show_cip_#id#"><cfif cip EQ 1>CIP</cfif></span><br />
                         <span id="show_wcm_#id#"><cfif wcm EQ 1>WCM </cfif></span>
                    </td>
                    <td nowrap="nowrap">
                        <input class="button" type="button" id="edit_#id#" name="edit" value="Edit" />
                        <input class="button" type="button" id="delete_#id#" name="delete" value="Delete" />
                    </td>
                </cfif>
              
            </tr> 
            
            <tr id="edit_row_#id#" style="display:none">
                    <td>
                        <input size="10" type="text" name="category_#id#" id="category_#id#" value="#category#" /><br />
                        <span id="edit_category_#id#"></span>
                    </td>
                    <td><input type="text" name="class_title" id="classTitle_#id#" value="#class_title#" /></td>
                    <td><input type="text" name="facilitator_#id#" id="facilitator_#id#" value="#facilitator#" /></td>
                    <td><textarea cols="15" rows="5" name="handout_link_#id#" id="handoutLink_#id#"  />#handout_link#</textarea></td>
                    <td><textarea cols="15" rows="5" name="listen_link_#id#" id="listenLink_#id#"  />#listen_link#</textarea></td>
                    <td><textarea cols="15" rows="5" name="download_link_#id#" id="downloadLink_#id#"  />#download_link#</textarea></td>
                    <td><input size="5" type="text" name="cceh_#id#" value="#cceh#"  id="cceh_#id#" /></td>
                    <td><input type="text" class="datepicker" name="class_date" id="classDate_#id#" value="#dateFormat(class_date,'mm/dd/yyyy')#" /></td>
                    <td>
                        <input size="5" type="checkbox" value="1" id="cip_#id#" name="CIP_#id#" <cfif cip EQ 1>checked</cfif> /> CIP<br />
                        <input size="5" type="checkbox" value="1" id="wcm_#id#" name="WCM_#id#" <cfif wcm EQ 1>checked</cfif> /> WCM
                    </td>
                    
                    <td nowrap="nowrap">
                        <input class="button" type="button" id="save_#id#" name="save" value="Save" />
                        <input class="button" type="button" id="cancel_#id#" name="cancel" value="Cancel" />
                    </td>
            </tr> 
       </cfloop>
   </tbody>
   </table>
  </div>
   <br />
   <cfif listFind(admins,URL.email)>
           <div class="datagrid">
           <table >
             <thead>
                <tr>
                    <th>Category</th>
                    <th>Member Class Title</th>
                    <th>Facilitator/ Author</th>
                    <th>Handout(s) Link</th>
                    <th>Listen Link</th>
                    <th>Download Link</th>
                    <th>CCEH</th>
                    <th>Date</th>
                    <th>WCM/WIP</th>
                    <th>&nbsp;</th>
                </tr> 
             </thead>   
          <tbody>
                <tr id="add_row" >
                    <td valign="top">
                        <input type="text" name="add_category" id="add_category" /><br />
                        <span id="add_category_error"></span>
                    </td>
                    <td valign="top">
                        <input type="text" name="add_class_title" id="add_class_title" /><br />
                        <span id="add_class_title_error"></span>
                    </td>
                      <td valign="top"><input type="text" name="add_facilitator" id="add_facilitator" /></td>
                      <td valign="top"><textarea cols="15" rows="5" name="add_handout_link" id="add_handout_link" /></textarea></td>
                      <td valign="top"><textarea cols="15" rows="5" name="add_listen_link" id="add_listen_link"/></textarea></td>
                      <td valign="top"><textarea cols="15" rows="5" name="add_download_link" id="add_download_link" /></textarea></td>
                      <td valign="top"><input size="5" type="text" name="add_cceh"  id="add_cceh"  /></td>
                      <td valign="top"><input type="text" class="datepicker" name="add_class_date" id="add_classDate" /></td>
                      <td nowrap="nowrap">
                        <input size="5" type="checkbox" name="add_cip" value="1"  id="add_cip" /> CIP<br />
                        <input size="5" type="checkbox" name="add_wcm" value="1"  id="add_wcm" /> WCM
                      </td>
                     
                      <td><input  class="button" type="submit" id="AddNew" name="AddNew" value="Add New" /></td>
                </tr> 
           </table>
        </div>
     </cfif>   
</form>

</cfoutput>



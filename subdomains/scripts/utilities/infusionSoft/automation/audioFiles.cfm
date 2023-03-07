
<cfoutput>
<!---    need to make changes to audio.js to update database and audioFilesSubmit  --->
<!---<cfajaxproxy cfc="automation.audioFileSubmit" jsclassname="myForm" /> --->
<script src="https://code.jquery.com/jquery-1.8.3.js"></script>
<script src="https://code.jquery.com/ui/1.9.2/jquery-ui.js"></script>
<script type="text/javascript" src="/utilities/infusionsoft/automation/js/audio.js"></script>
<link rel="stylesheet" type="text/css" href="css/audio.css"/>
<link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.9.2/themes/base/jquery-ui.css"/>

<cfparam name="URL.email" default="">
<cfset admins = "Erika@wellcoaches.com,rdiveley@wellcoaches.com,ldiaz@wellcoaches.com,jcummings@wellcoaches.com">

<cfif structkeyExists(form,'AddNew')>

 <cfquery name="insertMemberClasses" result="results" datasource="wellcoachesschool" >
        	insert into memberClasses
            (
             category
           
            ,class_title
            ,ce_requirements
            ,download_link
            ,course_description
            ,facilitator
            ,handout_link
            <!--- ,listen_link --->
            ,class_date
            ,nbhwc_expiration
            ,cip
            ,wcm
			,nchec
			,ace
			,acsm
			,boc
			,cdr
            ,ichwc
            )
            values
            (
            	<cfqueryparam value="#form.add_category#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.add_category))#" />,
               
                <cfqueryparam value="#form.add_class_title#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.add_class_title))#" />,
                <cfqueryparam value="#form.add_ce_requirements#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.add_ce_requirements))#" />,
                <cfqueryparam value="#form.add_download_link#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.add_download_link))#" />,
                <cfqueryparam value="#form.add_course_description#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.add_course_description))#" />,
                <cfqueryparam value="#form.add_facilitator#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.add_facilitator))#" />,
                <cfqueryparam value="#form.add_handout_link#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.add_handout_link))#" />,
               <!---  <cfqueryparam value="#form.add_listen_link#" cfsqltype="cf_sql_varchar" null="#NOT len(trim(form.add_listen_link))#" />, --->
                <cfqueryparam value="#form.add_class_date#" cfsqltype="cf_sql_date" null="#NOT len(trim(form.add_class_date))#" />,
                <cfqueryparam value="#form.add_nbhwc_expiration#" cfsqltype="cf_sql_date" null="#NOT len(trim(form.add_nbhwc_expiration))#" />,
                <cfif structkeyExists(form,'add_cip')>
                	1,
                <cfelse>
                	0,
                </cfif>
                <cfif structkeyExists(form,'add_wcm')>
                	1,
                <cfelse>
                	0,
                </cfif>
				<cfif structkeyExists(form,'add_nchec')>
                	1,
                <cfelse>
                	0,
                </cfif>
				<cfif structkeyExists(form,'add_ace')>
                	1,
                <cfelse>
                	0,
                </cfif>
				<cfif structkeyExists(form,'add_acsm')>
                	1,
                <cfelse>
                	0,
                </cfif>
				<cfif structkeyExists(form,'add_boc')>
                	1,
                <cfelse>
                	0,
                </cfif>
				<cfif structkeyExists(form,'add_cdr')>
                	1,
                <cfelse>
                	0,
                </cfif>
                <cfif structkeyExists(form,'add_ichwc')>
                	1
                <cfelse>
                	0
                </cfif>
            )
        </cfquery>

        <cflocation url="#cgi.SCRIPT_NAME#?email=#url.email#">
</cfif>
<cfif NOT structkeyExists(form,'query')>
    <cfquery name="listFiles" datasource="wellcoachesschool" >
        select
            category
            ,cceh
            ,class_title
            ,ce_requirements
            ,download_link
            ,course_description
            ,facilitator
            ,handout_link
            ,id
           <!---  ,listen_link --->
            ,class_date
            ,nbhwc_expiration
            ,cip
            ,wcm
			,nchec
			,ace
			,acsm
			,boc
			,cdr
            ,ichwc
            ,max(id) as maxID
        FROM memberClasses
        WHERE 1=1 and (archive IS NULL or archive = 0)
        <cfif StructKeyExists(URL,'wcm')>
           	AND wcm = 1
        </cfif>
            group by id,category, cceh
            ,class_title
            ,ce_requirements
            ,download_link
            ,facilitator
            ,handout_link
            ,class_date
            ,nbhwc_expiration
            ,id
           <!---  ,listen_link --->
            ,cip
            ,wcm
			,nchec
			,ace
			,acsm
			,boc
			,cdr
            ,ichwc
            ,course_description
            order by class_date desc, class_title asc
    </cfquery>
<cfelse>
	<cfif (structkeyExists(form,'dateQuery') AND len(FORM.dateQuery) AND len(FORM.query) EQ 0)>
        <cfquery name="listFiles" datasource="wellcoachesschool"  >
            select
                *
            FROM memberClasses
                where class_date = '#FORM.dateQuery#'
        </cfquery>
    <cfelse>

    	 <cfquery name="listFiles" datasource="wellcoachesschool" >
            select
                *
            FROM memberClasses
                where category like '%#form.query#%'
                OR class_title like '%#form.query#%'
                OR facilitator like '%#form.query#%'
                OR handout_link like '%#form.query#%'
                OR ce_requirements like '%#form.query#%' 
                OR download_link like '%#form.query#%'
                OR cceh like '%#form.query#%'
				<cfif structKeyExists(form,'query') and form.query EQ 'nchec'>
					OR nchec = 1
				</cfif>
				<cfif structKeyExists(form,'query') and form.query EQ 'ace'>
					OR ace = 1
				</cfif>
				<cfif structKeyExists(form,'query') and form.query EQ 'acsm'>
					OR acsm = 1
				</cfif>
				<cfif structKeyExists(form,'query') and form.query EQ 'boc'>
					OR boc = 1
				</cfif>
				<cfif structKeyExists(form,'query') and form.query EQ 'cdr'>
					OR cdr = 1
                </cfif>
                <cfif structKeyExists(form,'query') and form.query EQ 'ichwc'>
					OR ichwc = 1
				</cfif>

                <cfif structkeyExists(form,'dateQuery') AND len(FORM.dateQuery)>
                    OR class_date = '#FORM.dateQuery#'
                </cfif>
            order by class_date desc, class_title asc
        </cfquery>


    </cfif>

</cfif>
<p style="color:black;font-size:16px;font-family: Arial, Helvetica, sans-serif;">
    1. Wellcoaches will accept all class on this page for credit towards recertification.  Each class is worth 1 CEU<br />
    2. Current year class recordings are approved by a few outside organizations.  Please look under the "Approved courses by CE providers column" to see which organizations approves each class<br />
    3. All classes are worth 1 CEU<br />
    4. Please complete all requirements for the class to receive CE’s (requirements listed in the “requirements for CE’s” column).  
    </p>

<div class="datagrid"  >
    
<cfif structKeyExists(url,'wcm')>
	<cfset action= '#cgi.SCRIPT_NAME#?email=#url.email#&wcm=1'>
<cfelseif  structKeyExists(url,'cip')>
	<cfset action= '#cgi.SCRIPT_NAME#?email=#url.email#&cip=1'>
<cfelse>
	<cfset action = '#cgi.SCRIPT_NAME#?email=#url.email#'>
</cfif>

<form name="WellcoachesMemberClasses" action="#action#" id="WCMC" method="post">
<p align="right">
Date:<input type="text" class="datePicker" name="dateQuery" />
Text:<input type="text" name="query"></input>
<input class="button" type="submit" value="Search" name="hbtn"></input></p>
</form>
</div>
<div class="datagrid"  style="overflow:scroll;height:500px;overflow-x:scroll" >

<form name="WellcoachesMemberClasses" action="#action#" id="WCMC" method="post">
<input type="submit" name="submitMeHidden" style="display:none" />

 <table style="padding:20px">
	<thead>
        <tr>
            <th>Class Dates</th>
            <th width="50">Member<br/>Class Title</th>
            <th width="200">Facilitator/<br/> Author</th>
            <th width="250">Approved course by these continuing education providers</th>
            <th width="250">Requirements for CE's</th>
            <th width="200">Handout(s)<br/> Link</th>
            <th width="200">Download Link</th>
            <th width="200">Course Description</th>
            <th width="5">Category</th>
            
                  
            <th>&nbsp;</th>
        </tr>
     </thead>
  <tbody>
        <cfloop query="listFiles">
            <tr id="show_row_#id#" bgcolor="###iif(currentrow MOD 2,DE('ffffff'),DE('efefef'))#" >
                <td ><span id="show_class_date_#id#">#DateFormat(class_date,'m/dd/yyyy')#</span></td>
                <td ><span id="show_class_title_#id#">#class_title#</span></td>
                <td ><span id="show_facilitator_#id#">#facilitator#</span></td>
                <td >
					<span id="show_nchec_#id#"><cfif NCHEC EQ 1>NCHEC<br /></cfif> </span>
                    <!--- <span id="show_ace_#id#"><cfif ACE EQ 1>ACE</cfif></span> --->
					<span id="show_acsm_#id#"><cfif ACSM EQ 1>ACSM<br /></cfif></span>
					<span id="show_boc_#id#"><cfif BOC EQ 1>BOC<br /></cfif></span>
                    <span id="show_cdr_#id#"><cfif CDR EQ 1>CDR<br /></cfif></span>
                    <span id="show_ichwc_#id#"><cfif ICHWC EQ 1>NBHWC <cfif len(listfiles.nbhwc_expiration)>(Expire date:#dateformat(nbhwc_expiration,'mm/dd/yyy')#)</cfif><br /></cfif></span>
                </td>
                <td><span id="show_ce_requirements#id#">#replaceNoCase(ce_requirements,"</a>","</a><br /><br />","ALLs")#</span><br /></td>
                <td ><span id="show_handout_link_#id#">#handout_link#</span></td>
                <td ><span id="show_download_link#id#">#download_link#</span></td>
                <td ><span id="show_course_description#id#"><a href="javascript:void(0)" title="#htmlEditFormat(course_description)#"  style="color:##000000;text-decoration:none">#left(course_description,50)#</a><cfif len(course_description) GT 50>...</cfif></span></td>
                <td ><span id="show_category_#id#">#category#</span></td>
                
				<cfif listFind(admins,URL.email)>
                    <td nowrap="nowrap">
                        <input class="button" type="button" id="edit_#id#" name="edit" value="Edit" />
                        <input class="button" type="button" id="delete_#id#" name="delete" value="Delete" />
                    </td>
                </cfif>

            </tr>
            <!--- edit row --->
            <tr id="edit_row_#id#" style="display:none">
                    <td><input type="text" class="datepicker" name="class_date" id="classDate_#id#" value="#dateFormat(class_date,'mm/dd/yyyy')#" /></td>
                    <td><input type="text" name="class_title" id="classTitle_#id#" value="#class_title#" /></td>
                    <td><input type="text" name="facilitator_#id#" id="facilitator_#id#" value="#facilitator#" /></td>
                    <td>
                        <input size="5" type="checkbox" value="1" id="nchec_#id#" name="nchec_#id#" <cfif NCHEC EQ 1>checked</cfif> /> NCHEC<br />
                        <!--- <input size="5" type="checkbox" value="1" id="ace_#id#" name="ace_#id#" <cfif ACE EQ 1>checked</cfif> />ACE<br /> --->
						<input size="5" type="checkbox" value="1" id="acsm_#id#" name="acsm_#id#" <cfif ACSM EQ 1>checked</cfif> />ACSM<br />
						<input size="5" type="checkbox" value="1" id="boc_#id#" name="boc_#id#" <cfif BOC EQ 1>checked</cfif> />BOC<br />
                        <input size="5" type="checkbox" value="1" id="cdr_#id#" name="cdr_#id#" <cfif CDR EQ 1>checked</cfif> />CDR<br />
                        <input size="5" type="checkbox" value="1" id="ichwc_#id#" name="ichwc_#id#" <cfif ICHWC EQ 1>checked</cfif> />NBHWC<br />
                        <input type="text" class="datepicker" value="#dateformat(nbhwc_expiration,'mm/dd/yyyy')#" id="nbhwc_expiration_#id#" name="nbhwc_expiration_#id#"  /><br />NBHWC Expire Date
                    </td>
                    <td><textarea cols="15" rows="5" name="ce_requirements_#id#" id="ce_requirements_#id#"  />#ce_requirements#</textarea></td>
                    <td><textarea cols="15" rows="5" name="handout_link_#id#" id="handoutLink_#id#"  />#handout_link#</textarea></td>
                    <td><textarea cols="15" rows="5" name="download_link_#id#" id="downloadLink_#id#"  />#download_link#</textarea></td>
                    <td><textarea cols="15" rows="5" name="course_description_#id#" id="course_description_#id#"  />#course_description#</textarea></td>
                    <td>
						<input type="hidden" name="id" value="#id#">
                        <input size="10" type="text" name="category_#id#" id="category_#id#" value="#category#" /><br />
                        <span id="edit_category_#id#"></span>
                    </td>
                
                    <td nowrap="nowrap">
                        <input class="button" type="button" id="save_#id#" name="save" value="Save" />
                        <input class="button" type="button" id="cancel_#id#" name="cancel" value="Cancel" />
                    </td>
            </tr>
       </cfloop>
   </tbody>
   </table>
   </form>
  </div>
   <br />
   <cfif listFind(admins,URL.email)>
   <form name="WellcoachesMemberClasses" action="#cgi.SCRIPT_NAME#?email=#url.email#" id="WCMC" method="post">
           <div class="datagrid">
           <table >
             <thead>
                <tr>
                    <th>Category</th>
                    <th>Member Class Title</th>
                    <th>Facilitator/ Author</th>
                    <th>Handout(s) Link</th>
                    <th>Requirements for CE's</th>
                    <th>Download Link</th>
                    <th>Course Description</th>
                    <th>Date</th>
                    <th>CCEH Approved</th>
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
                      <td valign="top"><textarea cols="15" rows="5" name="add_ce_requirements" id="add_ce_requirements"/></textarea></td> 
                      <td valign="top"><textarea cols="15" rows="5" name="add_download_link" id="add_download_link" /></textarea></td>
                      <td valign="top"><textarea cols="15" rows="5" name="add_course_description" id="add_course_description" /></textarea></td>
                      <td valign="top">
                        Class Date:<br />
                        <input type="text" class="datepicker" name="add_class_date" id="add_classDate" /><br />
                        NBHWC Expiration: <br/>
                        <input type="text" class="datepicker" name="add_nbhwc_expiration" id="add_nbhwc_expiration" />
                    </td>
                      <td nowrap="nowrap">
                        <input size="5" type="checkbox" name="add_nchec" value="1"  id="add_nchec" /> NCHEC<br />
                        <!--- <input size="5" type="checkbox" name="add_ace" value="1"  id="add_ace" /> ACE<br /> --->
						<input size="5" type="checkbox" name="add_acsm" value="1"  id="add_acsm" /> ACSM<br />
						<input size="5" type="checkbox" name="add_boc" value="1"  id="add_boc" /> BOC<br />
                        <input size="5" type="checkbox" name="add_cdr" value="1"  id="add_cdr" /> CDR<br />
                        <input size="5" type="checkbox" name="add_ichwc" value="1"  id="add_ichwc" /> NBHWC<br />
                      </td>

                      <td><input  class="button" type="submit" id="AddNew" name="AddNew" value="Add New" /></td>
                </tr>
           </table>
        </div>
     </cfif>
</form>

</cfoutput>



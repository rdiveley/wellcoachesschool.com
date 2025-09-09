<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wellcoaches Member Classes - Audio Library</title>
    
    <!--- Bootstrap 5 CSS --->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    
    <!--- jQuery UI CSS --->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/ui-lightness/jquery-ui.css">
    
    <!--- Font Awesome --->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!--- Custom Styles --->
    <link rel="stylesheet" type="text/css" href="css/audio.css"/>
    <!--- JavaScript Dependencies --->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

    <!--- Custom JavaScript --->
    <script type="text/javascript" src="js/audio.js"></script>
</head>
<body>
    <cfoutput>
        <!--- ColdFusion Parameters --->
        <cfparam name="URL.email" default="">
        <cfparam name="URL.archive" default="0">

        <cfset admins = "amillerbarton@wellcoaches.com,erika@wellcoaches.com,rdiveley@wellcoaches.com,ldiaz@wellcoaches.com,jcummings@wellcoaches.com">

       <!--- Process Form Submissions --->
        <cfif structkeyExists(form,'AddNew') AND structkeyExists(form,'add_category')>
            <!--- This is the ADD NEW form with actual data --->
            <cfquery name="insertMemberClasses" result="results" datasource="wellcoachesschool" >
                insert into memberClasses
                (
                category, class_title, ce_requirements, download_link, course_description,
                facilitator, handout_link, class_date, nbhwc_expiration, cip, wcm,
                nchec, ace, acsm, boc, cdr, ichwc
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
                    <cfqueryparam value="#form.add_class_date#" cfsqltype="cf_sql_date" null="#NOT len(trim(form.add_class_date))#" />,
                    <cfqueryparam value="#form.add_nbhwc_expiration#" cfsqltype="cf_sql_date" null="#NOT len(trim(form.add_nbhwc_expiration))#" />,
                    <cfif structkeyExists(form,'add_cip')>1,<cfelse>0,</cfif>
                    <cfif structkeyExists(form,'add_wcm')>1,<cfelse>0,</cfif>
                    <cfif structkeyExists(form,'add_nchec')>1,<cfelse>0,</cfif>
                    <cfif structkeyExists(form,'add_ace')>1,<cfelse>0,</cfif>
                    <cfif structkeyExists(form,'add_acsm')>1,<cfelse>0,</cfif>
                    <cfif structkeyExists(form,'add_boc')>1,<cfelse>0,</cfif>
                    <cfif structkeyExists(form,'add_cdr')>1,<cfelse>0,</cfif>
                    <cfif structkeyExists(form,'add_ichwc')>1<cfelse>0</cfif>
                )
            </cfquery>
            <cflocation url="#cgi.SCRIPT_NAME#?email=#URLEncodedFormat(url.email)#">
        </cfif>

        <!--- Data Queries --->
        <cfif NOT structkeyExists(form,'query')>
            <cfquery name="listFiles" datasource="wellcoachesschool" >
                select category, cceh, class_title, ce_requirements, download_link, course_description,
                       facilitator, handout_link, id, class_date, nbhwc_expiration, cip, wcm,
                       nchec, ace, acsm, boc, cdr, ichwc, archive, max(id) as maxID
                FROM memberClasses
                WHERE 1=1 
                <cfif url.archive EQ "1">
                    AND archive = 1
                <cfelse>
                    AND (archive IS NULL or archive = 0)
                </cfif>
                <cfif StructKeyExists(URL,'wcm')>
                    AND wcm = 1
                </cfif>
                group by id,category, cceh, class_title, ce_requirements, download_link, facilitator,
                        handout_link, class_date, nbhwc_expiration, id, cip, wcm, nchec, ace, acsm,
                        boc, cdr, ichwc, archive, course_description
                order by class_date desc, class_title asc
            </cfquery>
        <cfelse>
            <cfif (structkeyExists(form,'dateQuery') AND len(FORM.dateQuery) AND len(FORM.query) EQ 0)>
                <cfquery name="listFiles" datasource="wellcoachesschool"  >
                    select * FROM memberClasses
                    where class_date = '#FORM.dateQuery#'
                    <cfif url.archive EQ "1">
                        AND archive = 1
                    <cfelse>
                        AND (archive IS NULL or archive = 0)
                    </cfif>
                </cfquery>
            <cfelse>
                <cfquery name="listFiles" datasource="wellcoachesschool" >
                    select * FROM memberClasses
                    where (category like '%#form.query#%'
                    OR class_title like '%#form.query#%'
                    OR facilitator like '%#form.query#%'
                    OR handout_link like '%#form.query#%'
                    OR ce_requirements like '%#form.query#%' 
                    OR download_link like '%#form.query#%'
                    OR cceh like '%#form.query#%'
                    <cfif structKeyExists(form,'query') and form.query EQ 'nchec'>OR nchec = 1</cfif>
                    <cfif structKeyExists(form,'query') and form.query EQ 'ace'>OR ace = 1</cfif>
                    <cfif structKeyExists(form,'query') and form.query EQ 'acsm'>OR acsm = 1</cfif>
                    <cfif structKeyExists(form,'query') and form.query EQ 'boc'>OR boc = 1</cfif>
                    <cfif structKeyExists(form,'query') and form.query EQ 'cdr'>OR cdr = 1</cfif>
                    <cfif structKeyExists(form,'query') and form.query EQ 'ichwc'>OR ichwc = 1</cfif>
                    <cfif structKeyExists(form,'query') and form.query EQ 'nbhwc'>OR ichwc = 1</cfif>
                    <cfif structkeyExists(form,'dateQuery') AND len(FORM.dateQuery)>OR class_date = '#FORM.dateQuery#'</cfif>)
                    <cfif url.archive EQ "1">
                        AND archive = 1
                    <cfelse>
                        AND (archive IS NULL or archive = 0)
                    </cfif>
                    order by class_date desc, class_title asc
                </cfquery>
            </cfif>
        </cfif>

        <!--- Build Action URL --->
        <cfset action = "#cgi.SCRIPT_NAME#?email=#URLEncodedFormat(url.email)#">
        <cfif structKeyExists(url,'wcm')>
            <cfset action = action & "&wcm=1">
        </cfif>
        <cfif structKeyExists(url,'cip')>
            <cfset action = action & "&cip=1">
        </cfif>
        <cfif len(url.archive)>
            <cfset action = action & "&archive=#url.archive#">
        </cfif>
    </cfoutput>

    <!--- Page Header --->
    <header class="page-header">
        <div class="container-fluid">
            <div class="header-content">
                <div class="header-title">
                    <h1 class="page-title">
                        <i class="fas fa-graduation-cap me-3"></i>
                        Wellcoaches Member Classes
                    </h1>
                    <p class="page-subtitle">Professional Development & Continuing Education</p>
                </div>
                <cfoutput>
                <div class="header-stats" id="stats">
                    <div class="stat-card">
                        <div class="stat-number">#listFiles.recordCount#</div>
                        <div class="stat-label">
                            <cfif url.archive>Archived<cfelse>Active</cfif> Classes
                        </div>
                    </div>
                </div>
                </cfoutput>
            </div>
        </div>
    </header>

    <main class="main-content">
        <div class="container-fluid">
            <cfoutput>
            <!--- Admin Navigation Card --->
            <cfif listFind(admins,URL.email)>
                <div class="admin-control-panel">
                    <div class="control-header">
                        <h2 class="control-title">
                            <i class="fas fa-cogs me-2"></i>Administration Panel
                        </h2>
                        <div class="view-toggle">
                            <cfif url.archive>
                                <span class="current-view">
                                    <i class="fas fa-archive me-1"></i>Viewing Archived Classes
                                </span>
                                <a href="#cgi.SCRIPT_NAME#?email=#URLEncodedFormat(url.email)#<cfif StructKeyExists(URL,'wcm')>&wcm=1</cfif><cfif StructKeyExists(URL,'cip')>&cip=1</cfif>" 
                                   class="btn btn-success">
                                   <i class="fas fa-eye me-1"></i>Switch to Active Classes
                                </a>
                            <cfelse>
                                <span class="current-view">
                                    <i class="fas fa-play-circle me-1"></i>Viewing Active Classes
                                </span>
                                <a href="#cgi.SCRIPT_NAME#?email=#URLEncodedFormat(url.email)#&archive=1<cfif StructKeyExists(URL,'wcm')>&wcm=1</cfif><cfif StructKeyExists(URL,'cip')>&cip=1</cfif>" 
                                   class="btn btn-outline-secondary">
                                   <i class="fas fa-archive me-1"></i>Switch to Archived Classes
                                </a>
                            </cfif>
                        </div>
                    </div>
                </div>
            </cfif>
            </cfoutput>

            <!--- Information Guidelines --->
            <!--- Information Guidelines --->
<div class="info-guidelines">
    <div class="guideline-header">
        <h3><i class="fas fa-info-circle me-2"></i>CE Credit Guidelines</h3>
    </div>
    <div class="guidelines-grid">
        <div class="guideline-item">
            <div class="guideline-icon">
                <i class="fas fa-certificate"></i>
            </div>
            <div class="guideline-content">
                <h4>Wellcoaches Credit</h4>
                <p>Wellcoaches accepts all classes on this page for credit towards recertification. Each class is worth 1 CEU.</p>
            </div>
        </div>
        <div class="guideline-item">
            <div class="guideline-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="guideline-content">
                <h4>External Approvals</h4>
                <p>Current year class recordings are approved by select outside organizations. Check the "CE Providers" column to see which organizations approve each class.</p>
            </div>
        </div>
        <div class="guideline-item">
            <div class="guideline-icon">
                <i class="fas fa-tasks"></i>
            </div>
            <div class="guideline-content">
                <h4>Requirements</h4>
                <p>Please complete all requirements listed in the "Requirements for CE's" column to receive CE credit.</p>
            </div>
        </div>
        <div class="guideline-item">
            <div class="guideline-icon">
                <i class="fas fa-award"></i>
            </div>
            <div class="guideline-content">
                <h4>Standard Value</h4>
                <p>All classes are worth 1 CEU for continuing education purposes.</p>
            </div>
        </div>
    </div>
</div>

            <!--- Search and Filter Section --->
            <div class="search-filter-section">
                <cfoutput>
                <form name="WellcoachesMemberClasses" action="#action#" id="WCMC" method="post" class="search-form">
                   
                    <div class="search-header">
                        <h3><i class="fas fa-search me-2"></i>Search & Filter Classes</h3>
                    </div>
                    <div class="search-controls">
                        <div class="search-group">
                            <label for="dateQuery" class="search-label">
                                <i class="fas fa-calendar me-1"></i>Filter by Date
                            </label>
                            <input type="text" class="form-control datePicker" name="dateQuery" id="dateQuery" 
                                   placeholder="Select date..." />
                        </div>
                        <div class="search-group">
                            <label for="query" class="search-label">
                                <i class="fas fa-search me-1"></i>Search Text
                            </label>
                            <input type="text" class="form-control" name="query" id="query" 
                                   placeholder="Search titles, facilitators, categories..." />
                        </div>
                        <div class="search-group">
                            <button class="btn btn-primary search-btn" type="submit" name="hbtn">
                                <i class="fas fa-search me-1"></i>Search Classes
                            </button>
                        </div>
                    </div>
                </form>
                </cfoutput>
            </div>

            <!--- Main Classes Table --->
            <div class="classes-table-section" id="results">
                <div class="table-header">
                    <h3><i class="fas fa-list me-2"></i>Classes Overview</h3>
                </div>
                
                <div class="table-wrapper">
                    <div class="table-container">
                        <cfoutput>
                        <form name="WellcoachesMemberClassesMain" action="#action#" id="WCMCMain" method="post">
                            <input type="submit" name="submitMeHidden" style="display:none" />
                            
                            <table class="classes-table">
                                <thead>
                                    <tr>
                                        <th class="col-date">
                                            <i class="fas fa-calendar me-1"></i>Class Date
                                        </th>
                                        <th class="col-title">
                                            <i class="fas fa-book me-1"></i>Class Title
                                        </th>
                                        <th class="col-facilitator">
                                            <i class="fas fa-user me-1"></i>Facilitator/<br />Author
                                        </th>
                                        <cfif !URL.archive>
                                            <th class="col-providers">
                                                <i class="fas fa-award me-1"></i>Approved course by <br />these CE providers
                                            </th>
                                            <th class="col-requirements">
                                                <i class="fas fa-clipboard-list me-1"></i>Requirements for CE's
                                            </th>
                                        </cfif>
                                        <th class="col-resources">
                                            <i class="fas fa-download me-1"></i>Resources
                                        </th>
                                        <cfif !URL.archive>
                                            <th class="col-description">
                                                <i class="fas fa-info me-1"></i>Description
                                            </th>
                                            <th class="col-category">
                                                <i class="fas fa-tag me-1"></i>Category
                                            </th>
                                        </cfif>
                                        <cfif listFind(admins,URL.email)>
                                            <th class="col-actions">
                                                <i class="fas fa-cog me-1"></i>Actions
                                            </th>
                                        </cfif>
                                    </tr>
                                </thead>
                                <tbody>
                                    <cfloop query="listFiles">
                                        <!--- Display Row --->
                                        <tr id="show_row_#id#" class="class-row">
                                            <td class="date-cell">
                                                <div class="date-display">
                                                    <span id="show_class_date_#id#" class="date-text">
                                                        #DateFormat(class_date,'mmm dd, yyyy')#
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="title-cell">
                                                <div class="title-content">
                                                    <span id="show_class_title_#id#" class="class-title">
                                                        #class_title#
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="facilitator-cell">
                                                <div class="facilitator-info">
                                                    <span id="show_facilitator_#id#" class="facilitator-name">
                                                        #facilitator#
                                                    </span>
                                                </div>
                                            </td>
                                            <cfif !URL.archive>
                                                <td class="providers-cell">
                                                    <div class="ce-providers">
                                                        <cfif NCHEC EQ 1>
                                                            <span class="ce-badge nchec">NCHEC</span>
                                                        </cfif>
                                                        <cfif ACSM EQ 1>
                                                            <span class="ce-badge acsm">ACSM</span>
                                                        </cfif>
                                                        <cfif BOC EQ 1>
                                                            <span class="ce-badge boc">BOC</span>
                                                        </cfif>
                                                        <cfif CDR EQ 1>
                                                            <span class="ce-badge cdr">CDR</span>
                                                        </cfif>
                                                        <cfif ICHWC EQ 1>
                                                            <span class="ce-badge nbhwc">
                                                                NBHWC
                                                                <cfif len(listfiles.nbhwc_expiration)>
                                                                    <small class="expiry-date">
                                                                        Exp: #dateformat(nbhwc_expiration,'mm/dd/yy')#
                                                                    </small>
                                                                </cfif>
                                                            </span>
                                                        </cfif>
                                                    </div>
                                                </td>
                                                <td class="requirements-cell">
                                                    <div class="requirements-content">
                                                        <span id="show_ce_requirements#id#">
                                                            #replaceNoCase(ce_requirements,"</a>","</a><br />","ALL")#
                                                        </span>
                                                    </div>
                                                </td>
                                            </cfif>
                                            <td class="resources-cell">
                                                <div class="resource-links">
                                                    <cfif len(trim(handout_link))>
                                                        <div class="resource-item">
                                                            <i class="fas fa-file-pdf me-1"></i>
                                                            <span id="show_handout_link_#id#">
                                                                #handout_link#
                                                            </span>
                                                        </div>
                                                    </cfif>
                                                    <cfif len(trim(download_link))>
                                                        <div class="resource-item">
                                                            <i class="fas fa-download me-1"></i>
                                                            <span id="show_download_link#id#">
                                                                #download_link#
                                                            </span>
                                                        </div>
                                                    </cfif>
                                                </div>
                                            </td>
                                            <cfif !URL.archive>
                                                <td class="description-cell">
                                                    <div class="description-content">
                                                        <cfif len(trim(course_description))>
                                                            <span id="show_course_description#id#">
                                                                <a class="description-link" 
                                                                data-description="#htmlEditFormat(course_description)#" 
                                                                href="javascript:void(0)" 
                                                                title="Click to view full description">
                                                                    <i class="fas fa-eye me-1"></i>
                                                                    #left(course_description,200)#<cfif len(course_description) GT 40>...</cfif>
                                                                </a>
                                                            </span>
                                                        <cfelse>
                                                            <span id="show_course_description#id#">
                                                                &nbsp;
                                                            </span>
                                                        </cfif>
                                                    </div>
                                                </td>
                                                <td class="category-cell">
                                                    <span id="show_category_#id#" class="category-badge">
                                                        #category#
                                                    </span>
                                                </td>
                                            </cfif>
                                            <cfif listFind(admins,URL.email)>
                                                <td class="actions-cell">
                                                    <div class="action-controls">
                                                        <div class="action-buttons">
                                                            <input class="btn btn-edit" type="button" id="edit_#id#" 
                                                                   name="edit" value="Edit" title="Edit this class" />
                                                            <input class="btn btn-delete" type="button" id="delete_#id#" 
                                                                   name="delete" value="Delete" title="Delete this class" />
                                                        </div>
                                                        <div class="archive-control">
                                                            <div class="form-check form-switch">
                                                                <input class="form-check-input" type="checkbox" 
                                                                       name="archive" id="archive_#id#" value="1" 
                                                                       <cfif archive EQ 1>checked</cfif> />
                                                                <label class="form-check-label" for="archive_#id#">
                                                                    <cfif archive EQ 1>Unarchive<cfelse>Archive</cfif>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </cfif>
                                        </tr>

                                        <!--- Edit Row --->
                                        <tr id="edit_row_#id#" style="display:none" class="edit-row">
                                            <td colspan="<cfif !URL.archive AND listFind(admins,URL.email)>9<cfelseif !URL.archive>8<cfelseif listFind(admins,URL.email)>4<cfelse>3</cfif>">
                                                <div class="edit-form-container">
                                                    <div class="edit-form-header">
                                                        <h4><i class="fas fa-edit me-2"></i>Edit Class: #class_title#</h4>
                                                    </div>
                                                    <div class="edit-form-grid">
                                                        <div class="form-group">
                                                            <label class="form-label">
                                                                <i class="fas fa-calendar me-1"></i>Class Date
                                                            </label>
                                                            <input type="text" class="form-control datepicker" 
                                                                   name="class_date" id="classDate_#id#" 
                                                                   value="#dateFormat(class_date,'mm/dd/yyyy')#" />
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="form-label">
                                                                <i class="fas fa-book me-1"></i>Class Title
                                                            </label>
                                                            <input type="text" class="form-control" 
                                                                   name="class_title" id="classTitle_#id#" 
                                                                   value="#class_title#" />
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="form-label">
                                                                <i class="fas fa-user me-1"></i>Facilitator
                                                            </label>
                                                            <input type="text" class="form-control" 
                                                                   name="facilitator_#id#" id="facilitator_#id#" 
                                                                   value="#facilitator#" />
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="form-label">
                                                                <i class="fas fa-tag me-1"></i>Category
                                                            </label>
                                                            <input type="hidden" name="id" value="#id#">
                                                            <input type="text" class="form-control" 
                                                                   name="category_#id#" id="category_#id#" value="#category#" />
                                                            <span id="edit_category_#id#" class="error-message"></span>
                                                        </div>
                                                        <div class="form-group form-group-wide">
                                                            <label class="form-label">
                                                                <i class="fas fa-clipboard-list me-1"></i>CE Requirements
                                                            </label>
                                                            <textarea class="form-control" rows="3" 
                                                                      name="ce_requirements_#id#" id="ce_requirements_#id#">#ce_requirements#</textarea>
                                                        </div>
                                                        <div class="form-group form-group-wide">
                                                            <label class="form-label">
                                                                <i class="fas fa-file-pdf me-1"></i>Handout Links
                                                            </label>
                                                            <textarea class="form-control" rows="3" 
                                                                      name="handout_link_#id#" id="handoutLink_#id#">#handout_link#</textarea>
                                                        </div>
                                                        <div class="form-group form-group-wide">
                                                            <label class="form-label">
                                                                <i class="fas fa-download me-1"></i>Download Links
                                                            </label>
                                                            <textarea class="form-control" rows="3" 
                                                                      name="download_link_#id#" id="downloadLink_#id#">#download_link#</textarea>
                                                        </div>
                                                        <div class="form-group form-group-full">
                                                            <label class="form-label">
                                                                <i class="fas fa-align-left me-1"></i>Course Description
                                                            </label>
                                                            <textarea class="form-control" rows="4" 
                                                                      name="course_description_#id#" id="course_description_#id#">#course_description#</textarea>
                                                        </div>
                                                        <div class="form-group ce-providers-group">
                                                            <label class="form-label">
                                                                <i class="fas fa-award me-1"></i>CE Providers
                                                            </label>
                                                            <div class="ce-checkboxes">
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" value="1" 
                                                                           id="nchec_#id#" name="nchec_#id#" <cfif NCHEC EQ 1>checked</cfif> />
                                                                    <label class="form-check-label" for="nchec_#id#">NCHEC</label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" value="1" 
                                                                           id="acsm_#id#" name="acsm_#id#" <cfif ACSM EQ 1>checked</cfif> />
                                                                    <label class="form-check-label" for="acsm_#id#">ACSM</label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" value="1" 
                                                                           id="boc_#id#" name="boc_#id#" <cfif BOC EQ 1>checked</cfif> />
                                                                    <label class="form-check-label" for="boc_#id#">BOC</label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" value="1" 
                                                                           id="cdr_#id#" name="cdr_#id#" <cfif CDR EQ 1>checked</cfif> />
                                                                    <label class="form-check-label" for="cdr_#id#">CDR</label>
                                                                </div>
                                                                <div class="form-check">
                                                                    <input class="form-check-input" type="checkbox" value="1" 
                                                                           id="ichwc_#id#" name="ichwc_#id#" <cfif ICHWC EQ 1>checked</cfif> />
                                                                    <label class="form-check-label" for="ichwc_#id#">NBHWC</label>
                                                                </div>
                                                            </div>
                                                            <div class="nbhwc-expiration mt-2">
                                                                <label class="form-label small">NBHWC Expiration Date</label>
                                                                <input type="text" class="form-control datepicker" 
                                                                       placeholder="NBHWC Expire Date"
                                                                       value="#dateformat(nbhwc_expiration,'mm/dd/yyyy')#" 
                                                                       id="nbhwc_expiration_#id#" name="nbhwc_expiration_#id#" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="edit-form-actions">
                                                        <input class="btn btn-save" type="button" id="save_#id#" 
                                                               name="save" value="Save Changes" />
                                                        <input class="btn btn-cancel" type="button" id="cancel_#id#" 
                                                               name="cancel" value="Cancel" />
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </cfloop>
                                </tbody>
                            </table>
                        </form>
                        </cfoutput>
                    </div>
                </div>
            </div>

            <!--- Add New Class Section (Admin Only) --->
            <cfoutput>
            <cfif listFind(admins,URL.email)>
                <div class="add-class-section">
                    <div class="add-class-header">
                        <h3><i class="fas fa-plus me-2"></i>Add New Class</h3>
                        <p class="add-class-subtitle">Create a new class entry for the member library</p>
                    </div>
                    
                    <form name="WellcoachesMemberClassesAdd" action="#action#" method="post" class="add-class-form">
                        <input type="hidden" name="AddNew" value="1" />
                        <div class="add-form-grid">
                            <div class="form-group">
                                <label for="add_category" class="form-label required">
                                    <i class="fas fa-tag me-1"></i>Category
                                </label>
                                <input type="text" class="form-control" 
                                       name="add_category" id="add_category" 
                                       placeholder="e.g., Leadership, Wellness, etc." required />
                                <span id="add_category_error" class="error-message"></span>
                            </div>
                            
                            <div class="form-group">
                                <label for="add_class_title" class="form-label required">
                                    <i class="fas fa-book me-1"></i>Class Title
                                </label>
                                <input type="text" class="form-control" 
                                       name="add_class_title" id="add_class_title" 
                                       placeholder="Enter the full class title" required />
                                <span id="add_class_title_error" class="error-message"></span>
                            </div>
                            
                            <div class="form-group">
                                <label for="add_facilitator" class="form-label">
                                    <i class="fas fa-user me-1"></i>Facilitator/Author
                                </label>
                                <input type="text" class="form-control" 
                                       name="add_facilitator" id="add_facilitator" 
                                       placeholder="Facilitator or author name" />
                            </div>
                            
                            <div class="form-group">
                                <label for="add_classDate" class="form-label">
                                    <i class="fas fa-calendar me-1"></i>Class Date
                                </label>
                                <input type="text" class="form-control datepicker" 
                                       name="add_class_date" id="add_classDate" 
                                       placeholder="Select class date" />
                            </div>
                            
                            <div class="form-group form-group-wide">
                                <label for="add_course_description" class="form-label">
                                    <i class="fas fa-align-left me-1"></i>Course Description
                                </label>
                                <textarea class="form-control" rows="4" 
                                          name="add_course_description" id="add_course_description" 
                                          placeholder="Detailed description of the course content and objectives"></textarea>
                            </div>
                            
                            <div class="form-group form-group-wide">
                                <label for="add_ce_requirements" class="form-label">
                                    <i class="fas fa-clipboard-list me-1"></i>CE Requirements
                                </label>
                                <textarea class="form-control" rows="3" 
                                          name="add_ce_requirements" id="add_ce_requirements"
                                          placeholder="List any requirements needed to earn CE credit"></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="add_handout_link" class="form-label">
                                    <i class="fas fa-file-pdf me-1"></i>Handout Links
                                </label>
                                <textarea class="form-control" rows="3" 
                                          name="add_handout_link" id="add_handout_link" 
                                          placeholder="Links to handouts, materials, etc."></textarea>
                            </div>
                            
                            <div class="form-group">
                                <label for="add_download_link" class="form-label">
                                    <i class="fas fa-download me-1"></i>Download Links
                                </label>
                                <textarea class="form-control" rows="3" 
                                          name="add_download_link" id="add_download_link" 
                                          placeholder="Audio files, recordings, additional resources"></textarea>
                            </div>
                            
                            <div class="form-group ce-providers-section">
                                <label class="form-label">
                                    <i class="fas fa-award me-1"></i>CE Providers
                                </label>
                                <div class="ce-provider-grid">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="add_nchec" value="1" id="add_nchec" />
                                        <label class="form-check-label" for="add_nchec">
                                            <span class="provider-badge nchec">NCHEC</span>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="add_acsm" value="1" id="add_acsm" />
                                        <label class="form-check-label" for="add_acsm">
                                            <span class="provider-badge acsm">ACSM</span>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="add_boc" value="1" id="add_boc" />
                                        <label class="form-check-label" for="add_boc">
                                            <span class="provider-badge boc">BOC</span>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="add_cdr" value="1" id="add_cdr" />
                                        <label class="form-check-label" for="add_cdr">
                                            <span class="provider-badge cdr">CDR</span>
                                        </label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" name="add_ichwc" value="1" id="add_ichwc" />
                                        <label class="form-check-label" for="add_ichwc">
                                            <span class="provider-badge nbhwc">NBHWC</span>
                                        </label>
                                    </div>
                                </div>
                                <div class="nbhwc-expiration-section mt-3">
                                    <label for="add_nbhwc_expiration" class="form-label small">
                                        NBHWC Expiration Date
                                    </label>
                                    <input type="text" class="form-control datepicker" 
                                           name="add_nbhwc_expiration" id="add_nbhwc_expiration"
                                           placeholder="Select NBHWC expiration date" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="add-form-actions">
                            <input class="btn btn-primary btn-add" type="submit" id="AddNew" name="AddNew" value="Add New Class" />
                            <button type="button" class="btn btn-outline-secondary" onclick="document.querySelector('.add-class-form').reset();">
                                <i class="fas fa-undo me-1"></i>Clear Form
                            </button>
                        </div>
                    </form>
                </div>
            </cfif>
            </cfoutput>
        </div>
    </main>

    <!--- Course Description Modal --->
    <div class="modal fade" id="courseModal" tabindex="-1" aria-labelledby="courseModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="courseModalLabel">
                        <i class="fas fa-book-open me-2"></i>Course Description
                    </h5>
                    <button type="button" class="btn btn-sm btn-outline-secondary" data-bs-dismiss="modal" aria-label="Close">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="description-content">
                        <!--- Description content will be populated by JavaScript --->
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-1"></i>Close
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!--- Legacy Modal Support --->
    <div class="modal fade" id="myModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Course Description</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!--- Content populated by JavaScript --->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    

</body>
</html>
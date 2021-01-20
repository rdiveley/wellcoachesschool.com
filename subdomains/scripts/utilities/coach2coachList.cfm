<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Coach 2 Coach List</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css" />

<link rel="stylesheet" href="https://drvic10k.github.io/bootstrap-sortable/Contents/bootstrap-sortable.css" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.19.1/moment.js"></script>

<script src="https://drvic10k.github.io/bootstrap-sortable/Scripts/bootstrap-sortable.js"></script>

<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">


<cfparam name="url.tz" default="1" />
<cfparam name="url.email" default="" />
<cfparam name="local.dsn" default="wellcoachesschool" />

<style>
    .bs-example{
        margin: 20px;        
    }
    .optin {
        left:50px;
        top: 20px;
    }
    
</style>
</head>
<body>
<cfoutput>
    <cfset local.sort = 'asc' />
    <cfif url.tz lt 1>
        <cfset local.sort = 'desc' />
   </cfif>

<cfquery name="checkexisting" datasource="#local.dsn#">
    select * 
    from coach2coach
    where email = <CFQUERYPARAM VALUE="#url.email#" CFSQLType="CF_SQL_VARCHAR">
    and clientAgree =  <CFQUERYPARAM VALUE="1" CFSQLType="CF_SQL_BIT"> 
    and coachAgree = <CFQUERYPARAM VALUE="1" CFSQLType="CF_SQL_BIT"> 
</cfquery>
<cfset local.showBtn = TRUE />


<cfquery name="getcoaches" datasource="#local.dsn#">
    select * 
    from coach2coach
    where (client <> <CFQUERYPARAM VALUE="#url.email#" CFSQLType="CF_SQL_VARCHAR">  OR client IS NULL)
    and email != <CFQUERYPARAM VALUE="#url.email#" CFSQLType="CF_SQL_VARCHAR">
    order by ABS(timezone - (#url.tz#)) #local.sort#, email
</cfquery>


<div class="container bs-example  >
    <div class="col-md-6">
    <cfif checkexisting.recordcount>
        <cfset local.showBtn = FALSE />
        <div class="alert alert-success" role="alert">
            You have been matched with client/volunteer: #checkexisting.client#<br />
        </div>
    </cfif>
    <cfif structKeyExists(url, 'message') AND url.message EQ 1>
        <div class="alert alert-success" role="alert">
            You have opted to receive emails 
        </div>
    </cfif>
    <cfif structKeyExists(url, 'message') AND url.message EQ 2>
        <div class="alert alert-danger" role="alert">
            You must be either be a coach or a client, please select again.
        </div>
    </cfif>

    <cfif getcoaches.recordcount>
        <form method="post" action="coach2coachEmail.cfm" >
            <!---  coach expressing interest --->
            <input type="hidden" name="email" value="#url.email#" />
            <input type="hidden" name="tz" value="#url.tz#" />
            <input type="hidden" name="coach" value="#url.email#" />
            <table class="table table-bordered sortable">
            <thead>
            <tr>
                <th scope="col"></th>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Phone</th>
                <th scope="col">Preference</th>
                <th scope="col">Timezone</th>
                <cfif local.showBtn>
                    <th>Select Client</th>
                </cfif>
            </tr>
            </thead>
            <tbody>
                <cfloop query="getcoaches">
                    <tr <cfif getcoaches.email EQ url.email >style="background:yellow"</cfif>>
                        <th scope="row">#currentrow#</th>
                        <td>#getcoaches.name#</td>
                        <td>#getcoaches.email#</td>
                        <td>#getcoaches.phone#</td>
                        <td>
                            Location: #listLast(getcoaches.location,')')#<br />
                            Availability: #getcoaches.preference# #getcoaches.availability# 
                        </td>
                        <td>#getcoaches.location#</td>
                        <!--- proposed coach --->
                        <cfif local.showBtn>
                            <td><input type="radio" name="client" class="selectcoachclient" data-client="#getcoaches.email#" value="#getcoaches.email#" required></td>
                        </cfif>
                    </tr>
                </cfloop>
                
            </tbody>
           
        </table>
        <cfif local.showBtn>
            <button type="submit" class="btn btn-primary" name="sendEmail">Confirm</button> 
            <button type="button" class="btn btn-secondary reset" name="clear">Clear</button> 
        </cfif>
        </form>
    <cfelse>
        <cfif structKeyExists(url, 'message') AND url.message EQ 1>
            <div class="alert alert-success" role="alert">
                You will be notified via email when new coaches register.
            </div> 
        <cfelse>
            <div class="alert alert-danger" role="alert">
                There are no coaches that currently match your criteria
            </div> 

        </cfif>
    </cfif>
</div>

<cfquery name="checkexisting" datasource="#local.dsn#">
    select * 
    from coach2coach
    where email = <CFQUERYPARAM VALUE="#url.email#" CFSQLType="CF_SQL_VARCHAR">
    
</cfquery>

<div class="col-md-6">
    <cfif checkexisting.optin NEQ 1>
        <form class="bs-example">
            <input type="hidden" name="email" id="coachemail" value="#url.email#">
            <input type="hidden" name="tz" id="coachtz" value="#url.tz#">
            
                <table>
                    <tr>&nbsp;</tr>
                    <tr>
                        <td>If you wish to be notified when new coaches register, please 'opt-In' and confirm.</td>
                    </tr>
                    <tr>
                        <td> <input type="checkbox" class="radioOptIn" value="1" name="optin" <cfif checkexisting.optin EQ 1>checked</cfif>> Opt-In (to receive notifications) </td>
                    </tr>
                    
                    <tr>
                        <td>
                            <button type="button" class="btn btn-primary confirmoptin" name="sendEmail">Confirm</button> 
                        </td>
                    </tr>
                    
                </table>
            
        </form>
    </cfif>
</div>    
</div>

    

</cfoutput>

<script>
$( document ).ready(function() {

    $(".radioOptIn").on('click', function(event){
        var email = $("#coachemail").val();
        var tz = $("#coachtz").val();
        if($('.radioOptIn').prop('checked') == true){
            var optin = 1;
        }else{
            var optin = 0;
        }
        
        $.ajax({
                url: "/utilities/coach2coachOptin.cfm?email="+email+"&tz="+tz+"&optin="+optin
                , type: 'post'
                , cache: false
            })
    });

    $(".confirmoptin").on('click', function(event){
        $(this).attr('disabled',true);
        var email = $("#coachemail").val();
        var tz = $("#coachtz").val();
        if($('.radioOptIn').prop('checked') == true){
            var optin = 1;
        }else{
            var optin = 0;
        }
        
        $.ajax({
                url: "/utilities/coach2coachSendEmailNotification.cfm?email="+email+"&tz="+tz+"&optin="+optin
                , type: 'post'
                , cache: false
            })
            
    });


    $(".selectcoachclient").on('click', function(event){
        $('.selectcoachclient').removeAttr('disabled');
        var email = $(this).val();
        if($(this).attr('name') == 'coach'){
            $('[data-client="'+email+'"]').attr('disabled',true);
            $('[data-client="'+email+'"]').prop('checked',false);
        }else{
            $('[data-coach="'+email+'"]').attr('disabled',true);
            $('[data-coach="'+email+'"]').prop('checked',false);
        }
    });
    
    $(".reset").click(function() {
        $('input[name="coach"]').prop('checked', false);
        $('input[name="client"]').prop('checked', false);
    });
   
    
});    
</script>
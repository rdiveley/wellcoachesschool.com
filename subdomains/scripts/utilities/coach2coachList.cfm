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

<cfquery name="checkexisting" datasource="wellcoachesschool">
    select * 
    from coach2coach
    where email = '#url.email#'
</cfquery>
<cfset local.showBtn = TRUE />


<cfquery name="getcoaches" datasource="wellcoachesschool">
    select * 
    from coach2coach
    where coach IS NULL
    order by ABS(timezone - (#url.tz#)) #local.sort#, email
</cfquery>


<div class="container bs-example col-md-6" >
    <cfif LEN(checkexisting.coach)>
        <cfset local.showBtn = FALSE />
        <h3 style="color:red">You have been matched with #checkexisting.coach# please notify your concierge if you would like to make a change.</h3>
    </cfif>

    <cfif getcoaches.recordcount gte 2>
        <form method="post" action="coach2coachEmail.cfm" >
            <!---  coach expressing interest --->
            <input type="hidden" name="email" value="#url.email#" />
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
                    <th>Select Coach</th>
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
                            <td><input type="radio" name="coach" class="selectcoachclient"   data-coach="#getcoaches.email#" value="#getcoaches.email#" required></td>
                            <td><input type="radio" name="client" class="selectcoachclient" data-client="#getcoaches.email#" value="#getcoaches.email#" required></td>
                        </cfif>
                    </tr>
                </cfloop>
                
            </tbody>
           
        </table>
        <cfif local.showBtn>
            <button type="submit" class="btn btn-primary" name="sendEmail">Send Email</button> 
            <button type="button" class="btn btn-secondary reset" name="clear">Clear</button> 
        </cfif>
        </form>
    <cfelse>
        <cfif structKeyExists(url, 'message') AND url.message EQ 1>
            <h3>You will be notified via email when new coaches register.</h3>   
        <cfelse>
            <h3>There are no coaches that currently match your criteria</h3>   

        </cfif>
    </cfif>

</div>    



<form action="coach2coachOptin.cfm" method="post" class="bs-example">
    <input type="hidden" name="email" value="#url.email#">
    <input type="hidden" name="tz" value="#url.tz#">
    
        <table>
            <tr>&nbsp;</tr>
            <tr>
                <td>If you wish to be notified when new coaches register, please 'opt-In'</td>
            </tr>
            <tr>
                <td> <input type="radio" class="radioOptIn" value="1" name="optin" <cfif checkexisting.optin EQ 1>checked</cfif>> Opt-In (to receive notifications)
                    <br />
                    <input type="radio" class="radioOptIn" value="0" name="optin" <cfif checkexisting.optin EQ 0>checked</cfif>> Opt-Out (do not wish to receive notifications)
                </td>
            </tr>
            <tr>
                <td> <button type="submit" class="btn btn-secondary" name="sendEmail">Submit</button> </td>
            </tr>
        </table>
    
</form>

</cfoutput>

<script>
$( document ).ready(function() {
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
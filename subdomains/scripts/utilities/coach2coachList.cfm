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


<style>
    .bs-example{
        margin: 20px;        
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
    select coach 
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


<div class="bs-example">
    <cfif LEN(checkexisting.coach)>
        <cfset local.showBtn = FALSE />
        <h3 style="color:red">You have been matched with #checkexisting.coach# please notify your concierge if you would like to make a change.</h3>
      </cfif>
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
    </cfif>
    </form>
</div>    



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
});    
</script>
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
<cfquery name="getcoaches" datasource="wellcoachesschool">
    select * 
    from coach2coach
    where email <> '#url.email#'
    order by ABS(timezone - 10) #local.sort#, email
</cfquery>



<div class="bs-example">
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
            <th scope="col">Timezone</th>
            <th>Select Coach</th>
        </tr>
        </thead>
        <tbody>
            <cfloop query="getcoaches">
                <tr>
                    <th scope="row">#currentrow#</th>
                    <td>#getcoaches.name#</td>
                    <td>#getcoaches.email#</td>
                    <td>#getcoaches.phone#</td>
                    <td>#getcoaches.location#</td>
                    <!--- proposed coach --->
                    <td><input type="radio" name="coach" value="#getcoaches.email#" required></td>
                </tr>
            </cfloop>
        
        </tbody>
    </table>
    <button type="submit" class="btn btn-primary" name="sendEmail">Send Email</button> 
    </form>
</div>    



</cfoutput>
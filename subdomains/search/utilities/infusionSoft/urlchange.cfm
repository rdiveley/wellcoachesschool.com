<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN"
    "http://www.w3.org/TR/html4/strict.dtd"
    >
<html lang="en">
<head>
    <title><!-- Insert your title here --></title>
<script type="text/javascript"
 src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
<script type="text/javascript">
  $(document).ready(function() {

    $('#from').keyup(function(event) {
		$('#to').text($('#from').val().replace(/[^a-z0-9\s]/gi, '_').replace(/ /g,'_').replace(/__/g,'_'));
		
    });

  });
</script>
</head>
<body>
<input type="text" id="from" size="300"></textarea>
<br>
oneCPD.info/<span id="to" ></span>
</body>
</html>
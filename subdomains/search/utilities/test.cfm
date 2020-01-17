<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(document).ready(function(){
		$('li.headlink').hover(
			function() { $('ul', this).css('display', 'block'); },
			function() { $('ul', this).css('display', 'none'); });
	});
	
</script>


<ul id="cssdropdown">
<li class="headlink">
	<a href="mine.html?search_engines">Coach Training</a>
	 <ul>
	  <li><a href="http://google.com/">Learn more about our Core </a></li>
	  <li><a href="http://yahoo.com/">Health and Wellness</a></li>
	  <li><a href="http://live.com/">Training and Professional</a></li>
       <li><a href="http://live.com/">Coach Training programs</a></li>
	 </ul>
	 </li>
	  <li class="headlink">
	  <a href="mine.html?shopping">Shopping</a>
         <ul>
	  <li><a href="http://amazon.com/">Amazon</a></li>
	  <li><a href="http://ebay.com/">eBay</a></li>
	  <li><a href="http://craigslist.com/">CraigsList</a></li>
	 </ul>
 </li>
</ul>

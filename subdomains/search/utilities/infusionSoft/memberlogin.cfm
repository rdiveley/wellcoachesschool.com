<script src="js/jquery-latest.js"></script>

<script>
	function showLogin(frm_val){
		if(frm_val == 0){
			$('#beforeSept').show();
			$('#afterSept').hide();	
		}else{
			$('#beforeSept').hide();
			$('#afterSept').show();
			
		}
	}
	
	function goToCustomerHub(uName,pWord){
		var pwd = $('#CHPWD').val().trim();
		var email =$('#CHUser').val().trim();
		if(pwd == ""){
			$('#error_pwd').show().html('Please provide a password').css('color','#F00');
			$('#CHPWD').focus();
			return false;
		}
		window.location.href = 'https://wellcoaches.customerhub.net/web_services/auto_login?email='+email+'&amp;password='+pwd+'&amp;to=my-account'; 
	}
	
	function goTOWC(theURL){
		var pwd = $('#pword').val().trim();
		var email =$('#uname').val().trim();
		if(pwd == ""){
			$('#error_pwd1').show().html('Please provide a password').css('color','#F00');
			$('#pword').focus();
			return false;
		}
		window.location.href = theURL; 
	
	}
</script>
<cfoutput>
<cfset t =  "1,0,0,0,0,0,0,0,0,0,0">
<CF_AHEX mode=TO in="#t#" crypt> 
<cfset t = #CF_AHEX.out#>
<form method="post"  name="memberloginform">

<table >
	<tbody>
		<tr>
			<td valign="top" width="200"><img src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcRvoubXevSkEww-6DoSjTK72AAm180FYI8hxwYFghFeua_b2enstA" style="height: 151px; width: 145px; margin-left: 10px; margin-right: 10px; margin-top:10px" /></td>
			<td valign="top" width="543">
				<h2><span style="color:##00aeef;">Wellcoaches Coach Trainee or Member Site</span></h2>

				<p><span style="color: rgb(135, 139, 142);">1. Scroll down to login to our Web Coaching Platform</span></p>

				<p><span style="color:##878b8e;">2. Select your login type, then enter your Username (email address) and Password</span>
                <br/>
                
                         <div id="afterSept" style="color:##878b8e">
                           <table width="350px">
                                <tr>
                                <td valign="top" class=formtext>
                                <P>
                                  <div style="width:150px">User Name </div> <input id="CHUser" name="uName" size=25 maxlength=45 class=inputsize><br />
                                  <div style="width:150px">Password </div><input type="password" id="CHPWD" name="pWord2" size=25 maxlength=45 class=inputsize><br />
                                   <label id="error_pwd" style="display:none">&nbsp;</label><br /><br />
                                   <input type="button" value="Next" name="B1" onclick="goToCustomerHub()" class=buttons>
                                 </P>
                                  </td></tr>
                            </table>
                         </div>  
                </p>
			</td>
		</tr>
	</tbody>
</table>
</form>
<div class="divider" style="background-color: rgb(0,174,239);position:relative;left:-2px"></div>
<form name="memberloginform" method="post" />
<table >
	<tbody>
		<tr>
			<td valign="top" width="200"><br />
				<img alt="Corporate Wellness Programs" src="http://vectorwellness.com/portals/0/Images/Home/VW_CircleGraphic_x4-01.jpg" style="font-family: Arial, sans-serif; font-size: 12px; font-style: normal; font-variant: normal; line-height: 14.3999996185303px; height: 142px; width: 145px; margin-left: 10px; margin-right: 10px;" /></td>
			<td valign="top" width="543">
				<h2><span style="color:##00aeef;">Wellcoaches Web Coaching Platform</span></h2>

				<p><span style="color:##878b8e;">1.&nbsp;New Vector Wellness Coaching Platform: <a href="http://www.wellnessbyvector.com/wellport/wellcoaches" target="_blank">LOGIN</a></span><br />
					<br />
					<span style="color:##878b8e;">2. Our &quot;legacy&quot; Wellness Coaching platform&nbsp;will be available until December 31, 2014. Login below:
                    	<br /><br />
                        <input type="hidden" name="t" value="#t#"> 
                       	<input type="radio" name="loginToSite" <!---onclick="showLogin(0)"---> value="http://www.wellcoaches.com/coaching/loginlogic.cfm" />Web Platform - for the Coach<br />
                        <input type="radio" checked="checked" name="loginToSite"<!--- onclick="showLogin(0)"---> value="http://www.wellcoaches.com/clienting/loginlogic.cfm" />Web Platform - for the Client<br />
                    </span>           
                         <div id="beforeSept" style="color:##878b8e">
                            <table width="350px">
                               <tr>
                                <td valign="top" class=formtext>
                                <P>
                                    <div style="width:150px">User Name </div><input id="uname" name="uName" size=25 maxlength=45 class=inputsize><br />
                                    <div style="width:150px">Password </div><input id="pword" type="password" name="pWord" size=25 maxlength=250 class=inputsize><br />
                                    <label id="error_pwd1" style="display:none">&nbsp;</label><br /><br />
                                    <input type="submit" value="Next" name="B1" onclick="return goTOWC(this.form.action=$('input[name=loginToSite]:checked').val())">
                                  </P>
                                  </td>
                                </tr>
                            </table>
                		</div>
                    </p>

				<p>&nbsp;</p>
			</td>
		</tr>
	</tbody>
</table>
</form>

</cfoutput>










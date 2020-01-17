<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>


<script>

  var key = CryptoJS.enc.Hex.parse('NxPm87S7DPv27ZVrMevne8cah94qq6GJ');
  var iv  = CryptoJS.enc.Hex.parse('gM5xaReZ3KJTzBdB');

  var fname = $('#fname').val();
  var lname =  $('#lname').val();
  var emailaddress =  $('#emailaddress').val();
  var timestamp = new Date();

   var userInfo = {
            "id": emailaddress,
            "fistname": fname,
            "lastname": lname,
     		"timestamp": timestamp
	};

  var message = JSON.stringify(userInfo);

  var encrypted = CryptoJS.AES.encrypt(
    			message,
    			key,
    			{
                  keySize: 256,
                  iv:iv,
                  mode: CryptoJS.mode.CBC,
                  padding: CryptoJS.pad.Pkcs7
    			}
 );

// Decription. Works ok with "encrypted" parameter
	var decrypted = CryptoJS.AES.decrypt(
        encrypted,
      	key,
        {
          	keySize: 256,
            iv: iv,
            mode: CryptoJS.mode.CBC,
            padding: CryptoJS.pad.Pkcs7
        }
    );

$("#sendLogin").click(function(){
  $.ajax({
    type: "POST",
    url: "https://mywell.site/wellcoacheshabits/networkpartners/wellcoaches/SignOn.aspx",
    dataType: 'json',
    async: false,
    data: encrypted.toString(),
    success: function(){
    	alert("Thanks!");
    }
  })
});

 document.getElementById('demo1').innerHTML = encrypted.toString();
 document.getElementById('demo2').innerHTML = decrypted.toString(CryptoJS.enc.Utf8)

</script>



<p><input id="fname" type="text" value="Ray" /></p>
<p><input id="lname" type="text" value="Diveley" /></p>
<p><input id="emailaddress" type="text" value="rdiveley@hotmail.com" /></p>
<p>encrypted:</p>
<div id="demo1">&nbsp;</div>
<p>decrypted:</p>
<div id="demo2">&nbsp; {{ Contact.Password }} &nbsp;</div>
<p><input id="sendLogin" type="button" value="Send Data" /></p>
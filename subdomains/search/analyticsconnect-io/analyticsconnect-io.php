<?php
ini_set('display_errors',true);  error_reporting(E_ALL);
/*
AnalyticsConnect.io - Google Analytics Ecommerce for Infusionsoft
PHP Plugin Version 2.1.1
http://analyticsconnect.io/kb/php.php

License: GPL v3

Copyright (C) 2011-2014, AnalyticsConnect.io - admin@analyticsconnect.io

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/



/*
========================================================================
Start Configuration
========================================================================
*/



require 'config.php';

define('ANALYTICS_CONNECT_IO_SOFTWARE_VERSION', '2.1.1');  //  Use same as listed above
define('ANALYTICS_CONNECT_IO_APP_DISPLAY_NAME', 'AnalyticsConnect.io');  //  Used for display to users
define('ANALYTICS_CONNECT_IO_POST_URL', 'https://analyticsconnect.io/app/request/index.php');  //  Main Servers: Processing URL
define('ANALYTICS_CONNECT_IO_SECRET_KEY', $analyticsconnectioSecretKey);  //  Secret Key (Done this way to maintain pairity with the WordPress version of this software)



/*
========================================================================
Start Functions
========================================================================
*/



//  Get the user's Google Cookie ID
function analyticsconnectio_get_user_ga_cookie_id() {
  if (isset($_COOKIE['_ga'])){  //  Get the GA cookie
    $cookiePieces = explode('.', $_COOKIE['_ga']);
    $version = $cookiePieces[0];
	$domainDepth = $cookiePieces[1];
	$cid1 = $cookiePieces[2];
	$cid2 = $cookiePieces[3];
	$cid = $cid1 . '.' . $cid2;
    return $cid;
  } else {
    return FALSE;
  }
}



//  Generate UUID v4 (If the user doesn't have a Google Cookie we need to create something to send with the data to GA Measurement Protocol)
function analyticsconnectio_gen_uuid() {

  return sprintf( '%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
    // 32 bits for "time_low"
    mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ),
  
    // 16 bits for "time_mid"
    mt_rand( 0, 0xffff ),
  
    // 16 bits for "time_hi_and_version",
    // four most significant bits holds version number 4
    mt_rand( 0, 0x0fff ) | 0x4000,
  
    // 16 bits, 8 bits for "clk_seq_hi_res",
    // 8 bits for "clk_seq_low",
    // two most significant bits holds zero and one for variant DCE1.1
    mt_rand( 0, 0x3fff ) | 0x8000,
  
    // 48 bits for "node"
    mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff ), mt_rand( 0, 0xffff )
  );
  
}



//  This one does all the work
function analyticsconnect_io() {
	ini_set('display_errors',true);  error_reporting(E_ALL);
	$orderId = FALSE;
	
	//  Let's see if we can pull an OrderID
	
	if (isset($_POST)) {  //  Look for OrderID as a POST var (used by developers of other plugins)
		foreach ($_POST as $var => $value) {
			if (strtolower($var)=='orderid') {
				$orderId = $value;
			}
		}
	}
	if (isset($_GET)) {  //  Look for OrderID as a GET var
		foreach ($_GET as $var => $value) {
			if (strtolower($var)=='orderid') {
				$orderId = $value;
			}
		}
	}
	if ($orderId == FALSE) {  //  No OrderID found
		return '<!-- ' . ANALYTICS_CONNECT_IO_APP_DISPLAY_NAME . ' - ERROR (local): No OrderID available! -->';  //  Just give up
	} else {  //  We have an OrderID
		
		$options['secret_key'] = ANALYTICS_CONNECT_IO_SECRET_KEY;  //  Done this way to maintain pairity with the WordPress version of this software
		
		if (preg_match('/^[a-z0-9]{24}$/i', $options['secret_key'])) {  //  Only run if Secret Key has a valid format
		
			//  Get the user's Google Cookie ID, if not available generate a UUID we can use
			$cid = analyticsconnectio_get_user_ga_cookie_id();
			if ($cid == FALSE) { $cid = analyticsconnectio_gen_uuid(); }
			
			$curlPostData = array(
				'secretkey' => $options['secret_key'],
				'orderid' => $orderId,
				'cid' => $cid
			);
			
			//  API
			if (defined('ANALYTICS_CONNECT_IO_GAUA')) { $curlPostData['api'] = 'true'; $curlPostData['gaua'] = ANALYTICS_CONNECT_IO_GAUA; }
			if (defined('ANALYTICS_CONNECT_IO_AWCONID')) { $curlPostData['api'] = 'true'; $curlPostData['awconid'] =  ANALYTICS_CONNECT_IO_AWCONID; }
			if (defined('ANALYTICS_CONNECT_IO_AWCONLABEL')) { $curlPostData['api'] = 'true'; $curlPostData['awconlabel'] =  ANALYTICS_CONNECT_IO_AWCONLABEL; }
			if (defined('ANALYTICS_CONNECT_IO_FBCONPIXELID')) { $curlPostData['api'] = 'true'; $curlPostData['fbconpixelid'] =  ANALYTICS_CONNECT_IO_FBCONPIXELID; }
			
			$curlPostBody = http_build_query($curlPostData);
			$curl = curl_init();
			curl_setopt_array($curl, array(
				CURLOPT_RETURNTRANSFER => 1,
				CURLOPT_URL => ANALYTICS_CONNECT_IO_POST_URL,
				CURLOPT_USERAGENT => ANALYTICS_CONNECT_IO_APP_DISPLAY_NAME . ' PHP Plugin v' . ANALYTICS_CONNECT_IO_SOFTWARE_VERSION,
				CURLOPT_POST => 1,
				CURLOPT_CONNECTTIMEOUT => 10,
				CURLOPT_POSTFIELDS => $curlPostBody
			));
			$result = curl_exec($curl);
			curl_close($curl);
			$data = json_decode($result, true);
			
			//  Process the result data
			
			if ($data['error'] == '') {  //  No errors reported back from the servers
				
				$htmlCode = '
				
	<!-- ' . ANALYTICS_CONNECT_IO_APP_DISPLAY_NAME . ' PHP Plugin v' . ANALYTICS_CONNECT_IO_SOFTWARE_VERSION . ' -->
	' . $data['googleanalytics'] . '
	' . $data['adwords'] . '
	' . $data['facebook'] . '
	';
				return $htmlCode;
				
			} else {  //  Something went wrong
			
				return $data['error'];
				
			}
			
		} else {  //  Invalid Secret Key format
		
			return '<!-- ' . ANALYTICS_CONNECT_IO_APP_DISPLAY_NAME . ' - ERROR (local): Your Secret Key is invalid! -->';
			
		}

	}

}


/*
========================================================================
Start Main Program
========================================================================
*/



echo analyticsconnect_io();



?>
<?php
//this file is called call_ga.php
require_once 'curl.php';
$url = $_REQUEST["url"];
$token = $_REQUEST["token"];
 
$curl2 = curl_init();
curl_setopt($curl2, CURLOPT_SSL_VERIFYPEER, FALSE);
curl_setopt($curl2, CURLOPT_HEADER, "0");
curl_setopt($curl2, CURLOPT_RETURNTRANSFER, TRUE);
curl_setopt($curl2, CURLOPT_URL, $url);
 
curl_setopt($curl2, CURLOPT_HTTPHEADER, array('Authorization: GoogleLogin auth=' . $token));
$response2 = curl_exec($curl2);
echo ($response2);

function getResponse() {
	
	 return $response2;
}
?>
<root>
	<response> <?php $vars =getResponse(); echo $vars ?></response>
</root>
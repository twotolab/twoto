
<?php

$user = $_REQUEST[user];
$pass = $_REQUEST[pass];

require_once 'curl.php';

function google_login($mail, $pwd, $service, $source) {
    	
$curl = new Curl;
$response = $curl->post('https://www.google.com/accounts/ClientLogin', array(accountType => "GOOGLE",  Email => $mail, Passwd => $pwd, service => $service, source => $source ));
$tempArray = explode("Auth=", $response);
return $tempArray;
     
}



?>
<root>
	<token><?php $googlevars = google_login($user,$pass,"analytics", "twoto-explore-1.0"); echo $googlevars ?></token>
</root>

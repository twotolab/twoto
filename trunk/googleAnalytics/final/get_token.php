
<?php

$user = $_REQUEST[user];
$pass = $_REQUEST[pass];

function google_login($mail, $pwd, $service, $source) {
    $postdata = "accountType=HOSTED_OR_GOOGLE&Email=".$mail."&Passwd=".$pwd."&service=".$service."&source=".$source;
    
    $sslsock = @fsockopen("ssl://www.google.com", 443, $errno, $errstr, 30);
    if(is_resource($sslsock)) {
        fputs($sslsock, "POST /accounts/ClientLogin HTTP/1.0\r\n");
        fputs($sslsock, "Host: www.google.com\r\n");
        fputs($sslsock, "Content-type: application/x-www-form-urlencoded\r\n");
        fputs($sslsock, "Content-Length: ".strlen($postdata)."\r\n");
        fputs($sslsock, "Connection: close\r\n\r\n");
        fputs($sslsock, $postdata);
        $res = "";
        while(!feof($sslsock)) {
            $res .= @fgets($sslsock, 2048);
        }
        fclose($sslsock);
        return $res;
    }
    else {
        return false;
    }    
}

function parse_google_login_response($response) {
    if($response !== false && eregi("HTTP/1.0 200 OK",$response)) {
		
		$Auth = explode("Auth=", $response);
		$AuthFinal = $Auth[1];
		
		 return $AuthFinal;
		
    }
    return false;
}


?>
<root>
	<token><?php $googlevars = parse_google_login_response(google_login($user,$pass,"analytics", "twoto-explore-1.0")); echo $googlevars ?></token>
</root>
